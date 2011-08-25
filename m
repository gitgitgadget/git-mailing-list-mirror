From: Junio C Hamano <gitster@pobox.com>
Subject: Re* git clean --exclude broken?
Date: Thu, 25 Aug 2011 11:29:57 -0700
Message-ID: <7vpqjtl4yi.fsf_-_@alter.siamese.dyndns.org>
References: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net>
 <7vliuio65w.fsf@alter.siamese.dyndns.org>
 <7vfwkqmfsh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Todd Rinaldo <toddr@cpanel.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 20:30:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwegq-0003j5-Pj
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 20:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069Ab1HYSaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 14:30:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754474Ab1HYSaA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 14:30:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42BFB4B51;
	Thu, 25 Aug 2011 14:29:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QSxr5ZiElX4xoNsYi3Oev5Bkw7E=; b=ZSgsPL
	VUBkRJfCcG3YEtwHEG2W9lLKfRL6A3c0tZOeyR4+hi1AQ997elEbe7MGLgFLKJBR
	4mKHRJb34ZNnMEC4gtZR6vIKcFlmw1MVfckLSa5CoYJqHkrOu7qjM9LP2yPPcSuk
	4cv1COFTPAsZ4fDGgD5gFjjPvvt3ImVM2qG6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qr+A921r1fV62W++mfydzYFXUsRXnfQg
	n17KPiS35VeldanF2iGzB/zdCuKs3hfvpX1zIy3DUXRQEEwHOY7TlPpydqI4XlB6
	KGdC2cXf3DIhHRiaHyYZZd5QcTsI4NefTuP/OOPRljLhg/7UribfzMsy6X4vQ9bT
	ClLybP0ouq4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B51F4B50;
	Thu, 25 Aug 2011 14:29:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABFEF4B4F; Thu, 25 Aug 2011
 14:29:58 -0400 (EDT)
In-Reply-To: <7vfwkqmfsh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 24 Aug 2011 18:38:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CE1EAC0-CF48-11E0-978A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180096>

Junio C Hamano <gitster@pobox.com> writes:

> The documentation and the implementation of "git clean" is quite confused.
> ...

So here is a patch to fix the confusion.

It does not add a new "--except=C" I alluded to, but at least it should
be the right first step to make the document clearly describe what the
existing option does.

-- >8 --
Subject: [PATCH] Documentation: clarify "git clean -e <pattern>"

The current explanation of -e can be misread as allowing the user to say

    I know 'git clean -XYZ' (substitute -XYZ with any option and/or
    parameter) will remove paths A, B, and C, and I want them all removed
    except for paths matching this pattern by adding '-e C' to the same
    command line, i.e. 'git clean -e C -XYZ'.

But that is not what this option does. It augments the set of ignore rules
from the command line, just like the same "-e <pattern>" argument does
with the "ls-files" command (the user could probably pass "-e \!C" to tell
the command to clean everything the command would normally remove, except
for C).

It also fixes small style nit in the parameter to add_exclude() call. The
current code only works because EXC_CMDL happens to be defined as 0.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clean.txt |    6 +++---
 builtin/clean.c             |    5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 974e04e..a7a18e3 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -47,9 +47,9 @@ OPTIONS
 
 -e <pattern>::
 --exclude=<pattern>::
-	Specify special exceptions to not be cleaned.  Each <pattern> is
-	the same form as in $GIT_DIR/info/excludes and this option can be
-	given multiple times.
+	In addition to what are found in .gitignore (per directory) and
+	$GIT_DIR/info/exclude, also consider these patterns to be in the
+	set of the ignore rules in effect.
 
 -x::
 	Don't use the ignore rules.  This allows removing all untracked
diff --git a/builtin/clean.c b/builtin/clean.c
index 75697f7..3782718 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -76,6 +76,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
+	if (ignored && exclude_list.nr)
+		die(_("adding exclude with -e and ignoring it with -x is crazy"));
 
 	if (!show_only && !force) {
 		if (config_set)
@@ -98,7 +100,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		setup_standard_excludes(&dir);
 
 	for (i = 0; i < exclude_list.nr; i++)
-		add_exclude(exclude_list.items[i].string, "", 0, dir.exclude_list);
+		add_exclude(exclude_list.items[i].string, "", 0,
+			    &dir.exclude_list[EXC_CMDL]);
 
 	pathspec = get_pathspec(prefix, argv);
 
