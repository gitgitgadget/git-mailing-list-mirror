From: Junio C Hamano <gitster@pobox.com>
Subject: [StGit PATCH] Parse commit object header correctly
Date: Tue, 07 Feb 2012 23:33:33 -0800
Message-ID: <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org>
References: <4F3120D4.1050604@warmcat.com>
 <7vvcni1r5u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?QW5keSBHcmVlbiAoGyRCTlMwQlcvGyhCKQ==?= 
	<andy@warmcat.com>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 08:33:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv22A-0005cm-Rq
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 08:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab2BHHdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 02:33:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158Ab2BHHdh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 02:33:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23F874243;
	Wed,  8 Feb 2012 02:33:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kWzDql31uNe1637PZoMRaxuezjo=; b=fHG+3l
	JfM5eIqYvGT47D6ZPjaKhT8Res17yTWL5vIgiE+zi8GH1JmRoKIAbdnQizBjvaAi
	BaaiA76JM5F//38J7INTmig+POvqeQh91um8XLErAElxz2AUEqQ1+m1G/jE1N2X0
	zcABvO5KdexhmQ+Wr7Xs7Ulcv4yWZ/iWbSzq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iYF0SkZQtvbJgUdJvwWPby5wwM4xhBl8
	Jd/EHvXBLb6kZxA5i+tKOW5dNgxDaNuBBeQkxUMwXxIRka7V++PVAmVxWjHcd0kR
	j3ygkIimqXEALhHF6Z+HrOjVVw2fnTuVKJin/xtw8q7UszZcK4iPUhB45y5uDEQj
	n8T25g+xfg0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A5294242;
	Wed,  8 Feb 2012 02:33:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 749214241; Wed,  8 Feb 2012
 02:33:35 -0500 (EST)
In-Reply-To: <7vvcni1r5u.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 07 Feb 2012 09:37:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35A2D10E-5227-11E1-94B4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190225>

To allow parsing the header produced by versions of Git newer than the
code written to parse it, all commit parsers are expected to skip unknown
header lines, so that newer types of header lines can be added safely.
The only three things that are promised are:

 (1) the header ends with an empty line (just an LF, not "a blank line"),
 (2) unknown lines can be skipped, and
 (3) a header "field" begins with the field name, followed by a single SP
     followed by the value.

The parser used by StGit, introduced by commit cbe4567 (New StGit core
infrastructure: repository operations, 2007-12-19), was accidentally a bit
too loose to lose information, and a bit too strict to raise exception
when dealing with a line it does not understand.

 - It used "strip()" to lose whitespaces from both ends, risking a line
   with only whitespaces to be mistaken as the end of the header.

 - It used "k, v = line.split(None, 1)", blindly assuming that all header
   lines (including the ones that the version of StGit may not understand)
   can safely be split without raising an exception, which is not true if
   there is no SP on the line.

This patch changes the parsing logic so that it:

 (1) detects end of the hedaer correctly by treating only an empty line as
     such;
 (2) handles multi-line fields (a header line that begins with a single SP
     is appended to the previous line after removing that leading SP but
     retaining the LF between the line and the previous line) correctly;
 (3) splits a line at the first SP to find the field name, but only does
     so when there actually is SP on the line; and
 (4) ignores lines that cannot be understood without barfing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Earlier I sent a minimum parser fix that ignores multi-line fields, as
   the fields StGit cares about are all single line.  This patch also
   teaches multi-line fields to the parser, so that later versions of
   StGit can parse and use them if they choose to.

   Python is not my primary language, so please take this with a grain of
   salt.

   Thanks.

 stgit/lib/git.py |   41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 56287f6..f19371b 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -390,21 +390,34 @@ class CommitData(Immutable, Repr):
         @return: A new L{CommitData} object
         @rtype: L{CommitData}"""
         cd = cls(parents = [])
-        lines = list(s.splitlines(True))
+        raw_lines = list(s.splitlines(True))
+        lines = []
+        # Collapse multi-line header lines
+        for i in xrange(len(raw_lines)):
+            line = raw_lines[i]
+            if line == '\n':
+                cd.set_message(''.join(raw_lines[i+1:]))
+                break
+            if line[0] == ' ':
+                # continuation line
+                lines[-1] += '\n' + line[1:]
+            else:
+                lines.append(line)
         for i in xrange(len(lines)):
-            line = lines[i].strip()
-            if not line:
-                return cd.set_message(''.join(lines[i+1:]))
-            key, value = line.split(None, 1)
-            if key == 'tree':
-                cd = cd.set_tree(repository.get_tree(value))
-            elif key == 'parent':
-                cd = cd.add_parent(repository.get_commit(value))
-            elif key == 'author':
-                cd = cd.set_author(Person.parse(value))
-            elif key == 'committer':
-                cd = cd.set_committer(Person.parse(value))
-        assert False
+            line = lines[i].rstrip('\n')
+            ix = line.find(' ')
+            if 0 <= ix:
+                key, value = line[0:ix], line[ix+1:]
+                if key == 'tree':
+                    cd = cd.set_tree(repository.get_tree(value))
+                elif key == 'parent':
+                    cd = cd.add_parent(repository.get_commit(value))
+                elif key == 'author':
+                    cd = cd.set_author(Person.parse(value))
+                elif key == 'committer':
+                    cd = cd.set_committer(Person.parse(value))
+        return cd
+
 
 class Commit(GitObject):
     """Represents a git commit object. All the actual data contents of the
