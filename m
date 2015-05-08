From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] bundle: verify arguments more strictly
Date: Fri,  8 May 2015 10:02:00 +0200
Message-ID: <1431072120-24245-1-git-send-email-ps@pks.im>
References: <1431071341-23363-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 10:02:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqdEv-0003Up-4q
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 10:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbbEHIC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 04:02:27 -0400
Received: from sender1.zohomail.com ([74.201.84.162]:28884 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbEHICZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 04:02:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=HHs1bdYenmnbLPIND+WquZEdntj+r/G/4B7vQeqFo78aua72POhnDA+OE5Z7oMbtvdQMoV8j9XVd
    Epw2kmjvhBZjysa9QtAuT2WoQTpY8ortZxhcSHW5TJKTpfo7pUALDEnd1GG2Tx6Ybp4au1kJcDXB
    kBxlw5HlWDAMvPC6+eg=  
Received: from localhost (x5ce10939.dyn.telefonica.de [92.225.9.57]) by mx.zohomail.com
	with SMTPS id 143107214393742.47905325413342; Fri, 8 May 2015 01:02:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431071341-23363-1-git-send-email-ps@pks.im>
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT  SGR3_0_16045_3
X-ZohoMail-Owner: <1431072120-24245-1-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 92.225.9.57
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268606>

The `verify` and `create` subcommands of the bundle builtin do
not properly verify the command line arguments that have been
passed in. While the `verify` subcommand accepts an arbitrary
amount of ignored arguments the `create` subcommand does not
complain about being passed too few arguments, resulting in a
bogus call to `git rev-list`. Fix these errors by verifying that
the correct amount of arguments has been passed in.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Added missing Signed-off-by.

 builtin/bundle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 92a8a60..4883a43 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -42,6 +42,10 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 
 	if (!strcmp(cmd, "verify")) {
 		close(bundle_fd);
+		if (argc != 1) {
+			usage(builtin_bundle_usage);
+			return 1;
+		}
 		if (verify_bundle(&header, 1))
 			return 1;
 		fprintf(stderr, _("%s is okay\n"), bundle_file);
@@ -52,6 +56,10 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 		return !!list_bundle_refs(&header, argc, argv);
 	}
 	if (!strcmp(cmd, "create")) {
+		if (argc < 2) {
+			usage(builtin_bundle_usage);
+			return 1;
+		}
 		if (!startup_info->have_repository)
 			die(_("Need a repository to create a bundle."));
 		return !!create_bundle(&header, bundle_file, argc, argv);
-- 
2.4.0
