From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/6] connect: move error check to caller of parse_connect_url
Date: Wed, 29 Jul 2015 17:51:14 +0200
Message-ID: <1438185076-28870-5-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438185076-28870-1-git-send-email-ps@pks.im>
Cc: peff@peff.net, pclouds@gmail.com, gitster@pobox.com,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTdr-000115-DF
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbbG2Pvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:51:36 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60064 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752461AbbG2Pv0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2015 11:51:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5A7B420E20
	for <git@vger.kernel.org>; Wed, 29 Jul 2015 11:51:26 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 29 Jul 2015 11:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=+m9K
	D9mZ31YTeznEXpoVqPcJOZk=; b=LtlrG9UnZfUAoKlRn4wu+SlJTyR3sYKvyZNf
	Z4vU8bBt6ky/E7RIJMsvUvYJTCbh1Wo7oDTUIcPVPWupY+ssOTG/0ZycDfckynh+
	3k8eDVjMIFSGJSoKARYRT7ML29A/TzzRnIJyL6oAbw8zw0gJ7ZfoIEDSWy1x//sd
	4Qr1ANs=
X-Sasl-enc: ZCCFjdrliACgFpSBjwTjbyUGcYsNxt9b9WL+SktM0yn4 1438185085
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id E1733C00012;
	Wed, 29 Jul 2015 11:51:25 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438185076-28870-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274906>

parse_connect_url() checks if the path component of the URL is
empty and if so causes the program to die. As the function is to
be used at other call sites which do not require this check, move
up the error checking to the existing caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 connect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index bdbcee4..e8b813d 100644
--- a/connect.c
+++ b/connect.c
@@ -613,9 +613,6 @@ enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	else
 		path = strchr(end, separator);
 
-	if (!path || !*path)
-		die("No path specified. See 'man git-pull' for valid url syntax");
-
 	/*
 	 * null-terminate hostname and point path to ~ for URL's like this:
 	 *    ssh://host.xz/~user/repo
@@ -665,6 +662,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 	signal(SIGCHLD, SIG_DFL);
 
 	protocol = parse_connect_url(url, &hostandport, &path);
+	if (!path || !*path)
+		die("No path specified. See 'man git-pull' for valid url syntax");
+
 	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
-- 
2.5.0
