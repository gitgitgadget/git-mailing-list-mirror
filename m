From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] symbolic-ref: check format of given reference
Date: Sun, 17 Jun 2012 22:26:37 +0200
Message-ID: <4FDE3D7D.4090502@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 17 22:37:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgME4-00031f-IH
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 22:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594Ab2FQUgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 16:36:47 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:37657 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754178Ab2FQUgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 16:36:46 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jun 2012 16:36:46 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 6F2A3DE7E3
	for <git@vger.kernel.org>; Sun, 17 Jun 2012 22:28:32 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gjqIsHNvohR3 for <git@vger.kernel.org>;
	Sun, 17 Jun 2012 22:28:32 +0200 (CEST)
Received: from [192.168.1.5] (g226053070.adsl.alicedsl.de [92.226.53.70])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 3B3D3DE7E0
	for <git@vger.kernel.org>; Sun, 17 Jun 2012 22:28:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120616 Thunderbird/13.0.1
X-Enigmail-Version: 1.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200129>

Currently, it's possible to update HEAD with a nonsense reference since
no strict validation is performed. Example:

	$ git symbolic-ref HEAD 'refs/heads/master
    >
    >
    > '

Fix this by checking the given reference with check_refname_format().

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---

This was discussed earlier this year:

http://thread.gmane.org/gmane.comp.version-control.git/189715

What about pointing at non-existing references? Should this
still be allowed?

Additionally, I had to reindent two lines to make git-am happy
(indent with spaces).

 builtin/symbolic-ref.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 801d62e..22362e0 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -43,16 +43,18 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options,
-			     git_symbolic_ref_usage, 0);
-	if (msg &&!*msg)
+				git_symbolic_ref_usage, 0);
+	if (msg && !*msg)
 		die("Refusing to perform update with empty message");
 	switch (argc) {
 	case 1:
 		check_symref(argv[0], quiet);
 		break;
 	case 2:
+		if (check_refname_format(argv[1], 0))
+			die("No valid reference format: '%s'", argv[1]);
 		if (!strcmp(argv[0], "HEAD") &&
-		    prefixcmp(argv[1], "refs/"))
+			prefixcmp(argv[1], "refs/"))
 			die("Refusing to point HEAD outside of refs/");
 		create_symref(argv[0], argv[1], msg);
 		break;
-- 
1.7.11.rc3.11.g7dba3f7.dirty
