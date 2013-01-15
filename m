From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH 2/8 v3] git_remote_helpers: fix input when running under
 Python 3
Date: Tue, 15 Jan 2013 22:40:49 +0000
Message-ID: <20130115224049.GZ4574@serenity.lan>
References: <cover.1358018078.git.john@keeping.me.uk>
 <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk>
 <50F2296F.8030909@alum.mit.edu>
 <20130113161724.GK4574@serenity.lan>
 <50F38E12.6090207@alum.mit.edu>
 <20130114094721.GQ4574@serenity.lan>
 <20130115194809.GU4574@serenity.lan>
 <7vbocq2mri.fsf@alter.siamese.dyndns.org>
 <20130115215412.GX4574@serenity.lan>
 <7vy5fu14sy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 23:41:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvFCE-0006AI-Ig
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 23:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758584Ab3AOWlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 17:41:07 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:39926 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757885Ab3AOWlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 17:41:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 0D94D606529;
	Tue, 15 Jan 2013 22:41:03 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IAZ2I9Qimnlu; Tue, 15 Jan 2013 22:41:02 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 98EF96064B7;
	Tue, 15 Jan 2013 22:41:01 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 84F01161E577;
	Tue, 15 Jan 2013 22:41:01 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id veegXD3gcBmD; Tue, 15 Jan 2013 22:41:01 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 3C401161E557;
	Tue, 15 Jan 2013 22:40:51 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vy5fu14sy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213682>

Although 2to3 will fix most issues in Python 2 code to make it run under
Python 3, it does not handle the new strict separation between byte
strings and unicode strings.  There is one instance in
git_remote_helpers where we are caught by this, which is when reading
refs from "git for-each-ref".

Fix this by operating on the returned string as a byte string rather
than a unicode string.  As this method is currently only used internally
by the class this does not affect code anywhere else.

Note that we cannot use byte strings in the source as the 'b' prefix is
not supported before Python 2.7 so in order to maintain compatibility
with the maximum range of Python versions we use an explicit call to
encode().

Signed-off-by: John Keeping <john@keeping.me.uk>
---

On Tue, Jan 15, 2013 at 02:04:29PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
>>> That really feels wrong.  Displaying is a separate issue and it is
>>> the _right_ thing to punt the problem at the lower-level machinery
>>> level.
>>
>> But the display will require decoding the ref name to a Unicode string,
>> which depends on the encoding of the underlying ref name, so it feels
>> like it should be decoded where it's read (see [1]).
> 
> If you botch the decoding in a way you cannot recover the original
> byte string, you cannot create a ref whose name is the original byte
> string, no?  Keeping the original byte string internally (this
> includes where you use it to create new refs or update existing
> refs), and attempting to convert it to Unicode when you choose to
> show that string as a part of a message to the user (and falling
> back to replacing some bytes to '?' if you cannot, but do so only in
> the message), you won't have that problem.

Actually, this method is currently only used internally so I don't think
my argument holds.

This is what keeping the refs as byte strings looks like.


 git_remote_helpers/git/importer.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
index e28cc8f..c54846c 100644
--- a/git_remote_helpers/git/importer.py
+++ b/git_remote_helpers/git/importer.py
@@ -18,13 +18,16 @@ class GitImporter(object):
 
     def get_refs(self, gitdir):
         """Returns a dictionary with refs.
+
+        Note that the keys in the returned dictionary are byte strings as
+        read from git.
         """
         args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
-        lines = check_output(args).strip().split('\n')
+        lines = check_output(args).strip().split('\n'.encode('utf-8'))
         refs = {}
         for line in lines:
-            value, name = line.split(' ')
-            name = name.strip('commit\t')
+            value, name = line.split(' '.encode('utf-8'))
+            name = name.strip('commit\t'.encode('utf-8'))
             refs[name] = value
         return refs
 
-- 
1.8.1
