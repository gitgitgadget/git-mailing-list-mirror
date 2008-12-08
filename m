From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH] Use separate column for zero in output of stg series -e.
Date: Mon, 08 Dec 2008 14:57:32 +0100
Message-ID: <20081208135648.22274.71945.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mandolaerik@gmail.com, gustav@virtutech.com
To: catalin.marinas@gmail.com, kha@treskal.com
X-From: git-owner@vger.kernel.org Mon Dec 08 14:58:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9gdS-0007oA-8i
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 14:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbYLHN5g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2008 08:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbYLHN5g
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 08:57:36 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:45721 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbYLHN5f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 08:57:35 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 2094140002;
	Mon,  8 Dec 2008 14:57:29 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 1432140008; Mon,  8 Dec 2008 14:57:29 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from krank (unknown [87.96.142.108])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 427C640002;
	Mon,  8 Dec 2008 14:57:28 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id A7351DC259;
	Mon,  8 Dec 2008 14:57:32 +0100 (CET)
User-Agent: StGIT/0.14.3.278.g6f7d
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102545>

This will make the output more regular and easier to parse. It no longe=
r
overwrites the +/-/! status flag with a zero for empty patches, and
instead puts the zero before it.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

This is a fix for https://gna.org/bugs/index.php?12718

 stgit/commands/series.py |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index 95196d3..b93abc4 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -79,13 +79,16 @@ def __get_author(stack, patch):
     cd =3D stack.patches.get(patch).commit.data
     return cd.author.name
=20
-def __print_patch(stack, patch, branch_str, prefix, empty_prefix, leng=
th, options):
+def __print_patch(stack, patch, branch_str, prefix, length, options):
     """Print a patch name, description and various markers.
     """
     if options.noprefix:
         prefix =3D ''
-    elif options.empty and stack.patches.get(patch).is_empty():
-        prefix =3D empty_prefix
+    elif options.empty:
+        if stack.patches.get(patch).is_empty():
+            prefix =3D '0' + prefix
+        else:
+            prefix =3D ' ' + prefix
=20
     patch_str =3D branch_str + patch
=20
@@ -180,12 +183,12 @@ def func(parser, options, args):
=20
     if applied:
         for p in applied[:-1]:
-            __print_patch(stack, p, branch_str, '+ ', '0 ', max_len, o=
ptions)
-        __print_patch(stack, applied[-1], branch_str, '> ', '0>', max_=
len,
+            __print_patch(stack, p, branch_str, '+ ', max_len, options=
)
+        __print_patch(stack, applied[-1], branch_str, '> ', max_len,
                       options)
=20
     for p in unapplied:
-        __print_patch(stack, p, branch_str, '- ', '0 ', max_len, optio=
ns)
+        __print_patch(stack, p, branch_str, '- ', max_len, options)
=20
     for p in hidden:
-        __print_patch(stack, p, branch_str, '! ', '! ', max_len, optio=
ns)
+        __print_patch(stack, p, branch_str, '! ', max_len, options)
