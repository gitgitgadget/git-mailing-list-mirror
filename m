From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Make clients ask for "git program" over ssh and local
 transport
Date: Wed, 25 Jun 2008 15:55:11 -0700
Message-ID: <7vvdzxw2eo.fsf_-_@gitster.siamese.dyndns.org>
References: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
 <20080625120832.6117@nanako3.lavabit.com>
 <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
 <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org>
 <20080625034538.GW11793@spearce.org>
 <7vk5ge6soc.fsf@gitster.siamese.dyndns.org>
 <20080625044409.GE11793@spearce.org>
 <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org>
 <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org>
 <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
 <20080625053848.GJ11793@spearce.org>
 <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>, Miklos Vajna <vmiklos@frugalware.org>,
	pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 00:56:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBdug-0008Lu-3w
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 00:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbYFYWza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 18:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbYFYWza
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 18:55:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbYFYWz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 18:55:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DA4E9A825;
	Wed, 25 Jun 2008 18:55:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 961C3A824; Wed, 25 Jun 2008 18:55:19 -0400 (EDT)
In-Reply-To: <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 25 Jun 2008 15:47:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CDE0D122-4309-11DD-862C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86362>

This will allow server side programs such as upload-pack to be installed
outside $PATH.  Connections to git-daemon still ask for "git-program" to
retain backward compatibility for daemons before 1.5.6.1 and 1.6.0.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is essentially your patch.  This can be in 1.6.0 clients and it
   should also be in 1.5.6.1 as people might keep ancient clients to talk
   to new servers that won't have anything but "git" on $PATH.

 builtin-clone.c      |    2 +-
 builtin-fetch-pack.c |    2 +-
 connect.c            |   10 ++++++++--
 git-parse-remote.sh  |    4 ++--
 transport.c          |    4 ++--
 5 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 7190952..2f3e9c9 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -36,7 +36,7 @@ static int option_quiet, option_no_checkout, option_bare;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
-static char *option_upload_pack = "git-upload-pack";
+static char *option_upload_pack = "git upload-pack";
 
 static struct option builtin_clone_options[] = {
 	OPT__QUIET(&option_quiet),
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index de1e8d1..a5f21f9 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -14,7 +14,7 @@ static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
 static int unpack_limit = 100;
 static struct fetch_pack_args args = {
-	/* .uploadpack = */ "git-upload-pack",
+	/* .uploadpack = */ "git upload-pack",
 };
 
 static const char fetch_pack_usage[] =
diff --git a/connect.c b/connect.c
index e92af29..4a32ba4 100644
--- a/connect.c
+++ b/connect.c
@@ -567,6 +567,8 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		 * cannot connect.
 		 */
 		char *target_host = xstrdup(host);
+		const char *program_prefix = "";
+
 		if (git_use_proxy(host))
 			git_proxy_connect(fd, host);
 		else
@@ -575,9 +577,13 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		 * Separate original protocol components prog and path
 		 * from extended components with a NUL byte.
 		 */
+		if (!prefixcmp(prog, "git ")) {
+			program_prefix = "git-";
+			prog += 4;
+		}
 		packet_write(fd[1],
-			     "%s %s%chost=%s%c",
-			     prog, path, 0,
+			     "%s%s %s%chost=%s%c",
+			     program_prefix, prog, path, 0,
 			     target_host, 0);
 		free(target_host);
 		free(url);
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 695a409..0f82a93 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -255,10 +255,10 @@ get_uploadpack () {
 	case "$data_source" in
 	config)
 		uplp=$(git config --get "remote.$1.uploadpack")
-		echo ${uplp:-git-upload-pack}
+		echo ${uplp:-git upload-pack}
 		;;
 	*)
-		echo "git-upload-pack"
+		echo "git upload-pack"
 		;;
 	esac
 }
diff --git a/transport.c b/transport.c
index 3ff8519..351b7f5 100644
--- a/transport.c
+++ b/transport.c
@@ -762,10 +762,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 		data->thin = 1;
 		data->conn = NULL;
-		data->uploadpack = "git-upload-pack";
+		data->uploadpack = "git upload-pack";
 		if (remote && remote->uploadpack)
 			data->uploadpack = remote->uploadpack;
-		data->receivepack = "git-receive-pack";
+		data->receivepack = "git receive-pack";
 		if (remote && remote->receivepack)
 			data->receivepack = remote->receivepack;
 	}
-- 
1.5.6.86.ge2da6
