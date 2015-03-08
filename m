From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 2/4] git-credential-store: support XDG_CONFIG_HOME
Date: Sun,  8 Mar 2015 15:58:50 +0800
Message-ID: <1425801532-8483-3-git-send-email-pyokagan@gmail.com>
References: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 08:59:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUW7H-0000iO-4e
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 08:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbbCHH7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 03:59:07 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44866 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbbCHH7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 03:59:03 -0400
Received: by padet14 with SMTP id et14so40160979pad.11
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 23:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IKCvU9c/LXHpVTjADovDnpMfkg5vVOoFdxRTswf0hbE=;
        b=UDiroKcqKPT0MZJ1q9YqmA9xMfgiBppJJmFrV7BemNmhsMd7B8P/eYbJfGl8uB9i2E
         inQI+VXG5ilSmoU8dwvC2jVhMrx7b6AwR8ktXjcNT6A7Pygqc3L/5VtfhBWVE8s6pebx
         orA5KJUk+29Dx5a1SaTk2aTMgkR1LbmQ1pKhAkXIgFm1mCxa68prkVlafmCN0w57Ll0L
         VB1RVmgkZP+2OrHfHYbWtUPO2FTjtLQxa+pKTFi7IP3V8tErnew4lONEt6Mm8P2/yYt4
         3S+KaRfq0QyjVfYeP71rK43vqitKWLl9iMYPBZF/d2HHI6cD3fcg37Ea+TuQrLnnvXdg
         zlug==
X-Received: by 10.68.164.3 with SMTP id ym3mr40474702pbb.100.1425801542355;
        Sat, 07 Mar 2015 23:59:02 -0800 (PST)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id zs9sm14099665pbc.43.2015.03.07.23.58.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2015 23:59:00 -0800 (PST)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YUW6z-0002Dz-DH; Sun, 08 Mar 2015 15:58:57 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265040>

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
 credential-store.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index 3455d7a..7b22a3a 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -162,11 +162,16 @@ int main(int argc, char **argv)
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
@@ -177,7 +182,7 @@ int main(int argc, char **argv)
 	else if (!strcmp(op, "erase"))
 		remove_credential(&fns, &c);
 	else if (!strcmp(op, "store"))
-		store_credential(&fns, &c, fns.nr - 1);
+		store_credential(&fns, &c, 0);
 	else
 		; /* Ignore unknown operation. */
 
-- 
2.1.4
