From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 1/7] clone: pass the remote name to remote_get
Date: Mon, 29 Mar 2010 11:48:23 -0500
Message-ID: <1269881309-19690-2-git-send-email-srabbelier@gmail.com>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jonathan Niede
X-From: git-owner@vger.kernel.org Mon Mar 29 18:48:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwI8x-0007Vo-79
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab0C2Qsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:48:45 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40760 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585Ab0C2Qsn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:48:43 -0400
Received: by gwaa18 with SMTP id a18so4135768gwa.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yTe5B5ZjuQ5lkyUmSiLVsL2NpaGStEE1MSKYl8t3l9k=;
        b=LKnqH/3WB/qgjZZjnLEtNyVwGFUKLny2mo5M+/FMbnEBtZAcETLV03+VtZATw1ViDJ
         2srgZFP52AiMGvESUVpee1azRpc255Ynk0S6VXAiO01mqpHONv3Us3V2YXVR4eQOPadR
         As1AHdFJF++g8vR3n9FnLLncihCgBSmvMhik0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mYgwhHJHK7e7238I1mkcaCYvXwcZfoiGmepvMFs6eg9EqrK9QCp64mC4UvJAb/lhNi
         R8YSAMITDqCtliArk30nmYORrFuG5R7m/m34rYaTPIPz21XDfRekr2VYOJ7sSHLA9IOM
         9IFL8zGBSv1LlV6+bIZRycBGB921EOt1kueNk=
Received: by 10.114.188.3 with SMTP id l3mr207077waf.150.1269881322551;
        Mon, 29 Mar 2010 09:48:42 -0700 (PDT)
Received: from localhost.localdomain (97-114-181-145.frgo.qwest.net [97.114.181.145])
        by mx.google.com with ESMTPS id 23sm4102040iwn.10.2010.03.29.09.48.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 09:48:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.317.gbb04ec
In-Reply-To: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143492>

Currently when using a remote helper to clone a repository, the
remote helper will be passed the url of the target repository as
first argument (which represents the name of the remote). This name
is extracted from transport->remote->name, which is set by
builtin/clone.c when it calls remote_get with argv[0] as argument.

Fix this by passing the name remote will be set up as instead.

However, setup_reference calls remote_get before the remote is
added to the config file. This will result in an improperly
configured remote (in memory) if later on remote_get is called
with an argument that is not equal to the initial remote_get call
in setup_reference. Fix this by delaying the remote_get call until
after the remote has been added to the config file.
---

	This is a combination of the earlier two-patch fix I sent.

 builtin/clone.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 05f8fb4..068d61f 100644
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
 
@@ -513,7 +513,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		refs = clone_local(path, git_dir);
 		mapped_refs = wanted_peer_refs(refs, refspec);
 	} else {
-		struct remote *remote = remote_get(argv[0]);
+		struct remote *remote = remote_get(option_origin);
 		transport = transport_get(remote, remote->url[0]);
 
 		if (!transport->get_refs_list || !transport->fetch)
-- 
1.7.0.3.317.gbb04ec
