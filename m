From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 2/4] git-credential-store: support XDG_CONFIG_HOME
Date: Wed, 11 Mar 2015 14:49:11 +0800
Message-ID: <1426056553-9364-3-git-send-email-pyokagan@gmail.com>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 07:50:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVaTk-0007mc-2B
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 07:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbbCKGui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 02:50:38 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37842 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbCKGuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 02:50:35 -0400
Received: by paceu11 with SMTP id eu11so8949185pac.4
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 23:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X0dVW304zwB9QXEvRT5shD3zHCUu3dTDlpihtQ3DmqM=;
        b=Idku35DOD1Z0vPLkamPS3/zBse0+7FIpDvBfquoh/TNVI+1BR1hkKBhIywAOWpOimv
         6MCtgZrYgfX9kZMqWcvbzjDYkBWgv+6mdoVvZHj656LWh5E7dtKWTORgZucudc9Z0FES
         6amUy3oqoG7mIFLDJXclbtj5Pf0acNWjwHi/1JGVasQpp6UxuqjcZ23vBWmGdpGfGb5+
         CXBm526PRh8E6Ne9rTpXxTAx66uQhHdl3FQLFCsWLgNJdRRhyYpZtVSBVtOj8OrN6+KX
         cd/ZO8rk7+S6TtX9TvDSOgxxFrtIlHCqK9F1SNnfGVazI7A+hZ9Rltl9xodAssZqmlPW
         l2lA==
X-Received: by 10.66.181.144 with SMTP id dw16mr76336187pac.100.1426056634627;
        Tue, 10 Mar 2015 23:50:34 -0700 (PDT)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id rw10sm4213477pab.39.2015.03.10.23.50.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2015 23:50:32 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YVaTN-0002ea-Ub; Wed, 11 Mar 2015 14:50:29 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265308>

Add $XDG_CONFIG_HOME/git/credentials to the default credential search
path of git-credential-store. This allows git-credential-store to
support user-specific configuration files in accordance with the XDG
base directory specification[1].

[1] http://standards.freedesktop.org/basedir-spec/basedir-spec-0.7.html

~/.git-credentials has a higher precedence than
$XDG_CONFIG_HOME/git/credentials when looking up credentials.  This
means that if any duplicate matching credentials are found in the xdg
file (due to ~/.git-credentials being updated by old versions of git or
outdated tools), they will not be used at all. This is to give the user
some leeway in switching to old versions of git while keeping the xdg
directory. This is consistent with the behavior of git-config.

However, the higher precedence of ~/.git-credentials means that as long
as ~/.git-credentials exist, all credentials will be written to the
~/.git-credentials file even if the user has an xdg file as having a
~/.git-credentials file indicates that the user wants to preserve
backwards-compatibility. This is also consistent with the behavior of
git-config.

Since the xdg file will not be used unless it actually exists, to
prevent the situation where some credentials are present in the xdg file
while some are present in the home file, users are recommended to not
create the xdg file if they require compatibility with old versions of
git or outdated tools. Note, though, that "erase" can be used to
explicitly erase matching credentials from all files.

Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 credential-store.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index 803bed2..b00f80f 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -163,11 +163,16 @@ int main(int argc, char **argv)
 		usage_with_options(usage, options);
 	op = argv[0];
 
-	if (!file)
-		file = expand_user_path("~/.git-credentials");
-	if (file)
+	if (file) {
 		string_list_append_nodup(&fns, file);
-	else
+	} else {
+		if ((file = expand_user_path("~/.git-credentials")))
+			string_list_append_nodup(&fns, file);
+		home_config_paths(NULL, &file, "credentials");
+		if (file)
+			string_list_append_nodup(&fns, file);
+	}
+	if (!fns.nr)
 		die("unable to set up default path; use --file");
 
 	if (credential_read(&c, stdin) < 0)
-- 
2.1.4
