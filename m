From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 2/3] git-credential-store: support XDG_CONFIG_HOME
Date: Tue, 24 Mar 2015 13:20:28 +0800
Message-ID: <1427174429-5876-2-git-send-email-pyokagan@gmail.com>
References: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 06:22:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaHHt-0002u6-1A
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 06:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbbCXFVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 01:21:54 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33019 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbbCXFVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 01:21:53 -0400
Received: by pdnc3 with SMTP id c3so210218143pdn.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 22:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L4Qkuwi0KxQJiN4EMrTX9HPc8MXQwrpJnRz2i/H6Fds=;
        b=NZB8TkD2z2EjZcM4c74B/+V8bzus55+fJvcQa/eai7kFda/lfZ7lMlpUtWnFEHeEsd
         kT/l1f+2LL/TxD/DCRGKdAWVSRvBWZEJVO1w+a83VQT3/lgiC5GsqAuBLHtH4wfRYk3O
         4oh8bhSV3QZoiBBkmAysyHVlxsCfntMSwAE7eIsDKWgrumlMp3kNY16jEMTct6y4OeCx
         e7cm2Z2zDBzNovIuI4E6stgBnCKRa8nQgi4xMg0tOiCmTtVLOgOb3KIGY2O1aUsFMYzV
         yXsiC7ASAvs+SNaCdXBKP7aATGI8P+9+qGaUE8MvXSC52aWhhqYjBQSSBtfrER9cydF4
         CYaA==
X-Received: by 10.66.55.104 with SMTP id r8mr4279214pap.75.1427174512718;
        Mon, 23 Mar 2015 22:21:52 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.172.217])
        by mx.google.com with ESMTPSA id pb2sm2753854pdb.33.2015.03.23.22.21.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2015 22:21:51 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YaHHg-0001dy-DP; Tue, 24 Mar 2015 13:21:48 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266176>

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

To make this precedence explicit in docs/git-credential-store, add a new
section FILES that lists out the credential file paths in their order of
precedence, and explain how the ordering affects the lookup, storage and
erase operations.

Also, update the documentation for --file to briefly explain the
operations on multiple files if the --file option is not provided.

Since the xdg file will not be used unless it actually exists, to
prevent the situation where some credentials are present in the xdg file
while some are present in the home file, users are recommended to not
create the xdg file if they require compatibility with old versions of
git or outdated tools. Note, though, that "erase" can be used to
explicitly erase matching credentials from all files.

Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

This patch is a combination of 2 patches [1][2].

[1] http://thread.gmane.org/gmane.comp.version-control.git/265683/focus=265686

[2] http://thread.gmane.org/gmane.comp.version-control.git/265683/focus=265685

The changes are as follows:

* s/per default/by default/ in the documentation. Thanks Matthieu.

 Documentation/git-credential-store.txt | 35 ++++++++++++++++++++++++++++++++--
 credential-store.c                     | 13 +++++++++----
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index bc97071..e3c8f27 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -31,10 +31,41 @@ OPTIONS
 
 --file=<path>::
 
-	Use `<path>` to store credentials. The file will have its
+	Use `<path>` to lookup and store credentials. The file will have its
 	filesystem permissions set to prevent other users on the system
 	from reading it, but will not be encrypted or otherwise
-	protected. Defaults to `~/.git-credentials`.
+	protected. If not specified, credentials will be searched for from
+	`~/.git-credentials` and `$XDG_CONFIG_HOME/git/credentials`, and
+	credentials will be written to `~/.git-credentials` if it exists, or
+	`$XDG_CONFIG_HOME/git/credentials` if it exists and the former does
+	not. See also <<FILES>>.
+
+[[FILES]]
+FILES
+-----
+
+If not set explicitly with '--file', there are two files where
+git-credential-store will search for credentials in order of precedence:
+
+~/.git-credentials::
+	User-specific credentials file.
+
+$XDG_CONFIG_HOME/git/credentials::
+	Second user-specific credentials file. If '$XDG_CONFIG_HOME' is not set
+	or empty, `$HOME/.config/git/credentials` will be used. Any credentials
+	stored in this file will not be used if `~/.git-credentials` has a
+	matching credential as well. It is a good idea not to create this file
+	if you sometimes use older versions of Git that do not support it.
+
+For credential lookups, the files are read in the order given above, with the
+first matching credential found taking precedence over credentials found in
+files further down the list.
+
+Credential storage will by default write to the first existing file in the
+list. If none of these files exist, `~/.git-credentials` will be created and
+written to.
+
+When erasing credentials, matching credentials will be erased from all files.
 
 EXAMPLES
 --------
diff --git a/credential-store.c b/credential-store.c
index d700a93..8b22251 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -165,11 +165,16 @@ int main(int argc, char **argv)
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
