From: Luis Ressel <aranea@aixah.de>
Subject: [PATCH] Add XDG support to the credential-store helper
Date: Thu, 5 Mar 2015 21:53:06 +0100
Message-ID: <20150305215306.65aab57c@gentp.lnet>
References: <20150305215146.394caa71@gentp.lnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 22:09:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTd1Y-0008VS-Pl
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 22:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbbCEVJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 16:09:35 -0500
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:40792 "EHLO
	wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754478AbbCEVJd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 16:09:33 -0500
Received: from hsi-kbw-046-005-229-078.hsi8.kabel-badenwuerttemberg.de ([46.5.229.78] helo=gentp.lnet); authenticated
	by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1YTclX-0000uT-9Y; Thu, 05 Mar 2015 21:53:07 +0100
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
	by gentp.lnet (Postfix) with ESMTP id CDE60260166
	for <git@vger.kernel.org>; Thu,  5 Mar 2015 21:53:06 +0100 (CET)
In-Reply-To: <20150305215146.394caa71@gentp.lnet>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1425589773;2694c48a;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264869>

credential-store will use ${XDG_CONFIG_HOME}/credentials to store
credentials if this file already exists and no --file option is given.
Otherwise it'll fall back to ~/.git-credentials (status quo).

Signed-off-by: Luis Ressel <aranea@aixah.de>
---
 Documentation/git-credential-store.txt | 4 +++-
 credential-store.c                     | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential-store.txt
b/Documentation/git-credential-store.txt index bc97071..cab8f72 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -34,7 +34,9 @@ OPTIONS
 	Use `<path>` to store credentials. The file will have its
 	filesystem permissions set to prevent other users on the system
 	from reading it, but will not be encrypted or otherwise
-	protected. Defaults to `~/.git-credentials`.
+	protected. Defaults to `~/.git-credentials` or
+	`$XDG_CONFIG_HOME/git/credentials` if the latter exists
+	($XDG_CONFIG_HOME defaults to ~/.config).
 
 EXAMPLES
 --------
diff --git a/credential-store.c b/credential-store.c
index 925d3f4..9720b42 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -138,6 +138,8 @@ int main(int argc, char **argv)
 	op = argv[0];
 
 	if (!file)
+		home_config_paths(NULL, &file, "credentials");
+	if (!file || access(file, R_OK|W_OK))
 		file = expand_user_path("~/.git-credentials");
 	if (!file)
 		die("unable to set up default path; use --file");
-- 
2.3.1
