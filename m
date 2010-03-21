From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 1/2] Move setup_reference to after writing the config file
Date: Sun, 21 Mar 2010 21:19:48 +0100
Message-ID: <1269202789-8833-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Waitz <tali@admingilde.org>,
	"Junio C Hamano" <gitst
X-From: git-owner@vger.kernel.org Sun Mar 21 21:20:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtRd8-0003C3-1Q
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 21:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308Ab0CUUUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 16:20:06 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:34801 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab0CUUUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 16:20:05 -0400
Received: by ey-out-2122.google.com with SMTP id d26so410713eyd.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 13:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PnHdCV+ncMCq4NTKxLncRdVKTvllxiE4ARX7n+Bn0PI=;
        b=Dt0/mpJtki2dsEewpV0xB0wiVQYcUNet2MOSRxS681k7fH+UIWTlOvyd2YMmo5gBaE
         KkKDO+EQb0Do3lk0jeUhOO/O9TaVtXxhcaTmW6CG0LBKDRvlGxqgAXP43vFuJB11EN7m
         2zetSDZrIZPqezGRvaEoXipyMAkVwEFiy+t58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SAlLzbzh6FytGNtExhkEp+hFlc7q1tQ5abMTHVHYD27Btr/S8ImtT3FXz+6Y8kqgUQ
         WawBuzBBPkyuYTqVj/SkZU05HpysvTYeh+PVd0N1j5/2IreWbsHEDW90c+2ZtQAuMKvM
         iBViQ41YYEho8S2U+GHAUIkklIMdodUu8ppRY=
Received: by 10.213.80.10 with SMTP id r10mr2827406ebk.56.1269202802285;
        Sun, 21 Mar 2010 13:20:02 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 16sm1300202ewy.3.2010.03.21.13.20.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 13:20:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.325.g634e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142857>

Currently setup_reference calls remote_get before the remote is
added to the config file. This will result in an improperly
configured remote (in memory) if later on remote_get is called
with an argument that is not equal to the initial remote_get call
in setup_reference. Fix this by delaying the remote_get call until
after the remote has been added to the config file.
---

  It is also possible to split setup_reference so that the part that
  calls remote_get is where the entire setup_referene call is moved
  to now, this also works, and results in a far simpler patch.

  This change is required for the next patch.

 builtin/clone.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 05f8fb4..f878563 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -470,9 +470,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	 */
 	unsetenv(CONFIG_ENVIRONMENT);
 
-	if (option_reference)
-		setup_reference(git_dir);
-
 	git_config(git_default_config, NULL);
 
 	if (option_bare) {
@@ -504,6 +501,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&key);
 	}
 
+	if (option_reference)
+		setup_reference(git_dir);
+
 	fetch_pattern = value.buf;
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
 
-- 
1.7.0.2.325.g634e5
