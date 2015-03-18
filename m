From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 2/4] git-credential-store: support XDG_CONFIG_HOME
Date: Wed, 18 Mar 2015 15:04:34 +0800
Message-ID: <1426662276-8728-2-git-send-email-pyokagan@gmail.com>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 08:05:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY82u-0004Cx-Ee
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 08:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbbCRHF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 03:05:29 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33739 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbbCRHF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 03:05:27 -0400
Received: by pdnc3 with SMTP id c3so34418189pdn.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UkZ1ESHMllAWEOUelUH31+5wKjLnfJbwAWLr/hNgyaM=;
        b=DuPLj1+bcetsR/PgBKw7vfxh39ppTMAjH1Rfz8haNc9nEnF7nfJmrt/zdpd5bNLFvr
         Lfl/1D5OFguVI2zNe3p6ivXoz6tmeTQCdRzg67tTGZvf8Q6kcLudEmD/IorLU+Zj3LeC
         xf0tFuPPieVNHmYUrOiHC8/Kn6RFh9wnB7+BDeFJfL9gNn11HoJ2fxmXkBEzN1N2lsWF
         Mlr2Ykq1LIs0cL6acd5f+G9TGWXDmpXeUx/sQwAR5QA1IUnfqh7QURcIHTUIEUh1lEH0
         dztfklQJ7BjjEnx2+mKj+enPZHA9qr+MrWyXAU/IfJD+nYuyVxEWXcYDMtXQLsD8p4tl
         GOZw==
X-Received: by 10.70.53.196 with SMTP id d4mr3041709pdp.6.1426662326677;
        Wed, 18 Mar 2015 00:05:26 -0700 (PDT)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id qj3sm25815436pac.31.2015.03.18.00.05.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 00:05:24 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YY82b-0002MF-Ud; Wed, 18 Mar 2015 15:05:21 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265686>

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

The previous version can be found at [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/265305/focus=265308

There are no changes in this version.

 credential-store.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index 8dad479..d805df7 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -163,11 +163,16 @@ int main(int argc, char **argv)
 		usage_with_options(usage, options);
 	op = argv[0];
 
-	if (!file)
-		file = expand_user_path("~/.git-credentials");
-	if (file)
+	if (file) {
 		string_list_append(&fns, file);
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
