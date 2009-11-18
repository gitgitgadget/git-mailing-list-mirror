From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 03/12] Use a function to determine whether a remote is valid
Date: Wed, 18 Nov 2009 02:42:23 +0100
Message-ID: <1258508552-20752-4-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:44:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZao-0000vW-Ip
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756819AbZKRBn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756721AbZKRBn2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:28 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:17370 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407AbZKRBn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:26 -0500
Received: by ey-out-2122.google.com with SMTP id 25so5797eya.19
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fpYSW7DZMjARyCsS4cFEGa3LVBmI6d7jpMCjQvqImOc=;
        b=MBLr7FssnBGasI3wEPUwB79+K7/DBHAQE4+Yq4vEvlFE/NC4JGnn9eZtZUntKmsYGy
         vM0/7AVAR2kdwJU+c0wMfYNBLwQnWWZgbxadZhIVT4tqHjOQG9VfHa2rza9e5UvdmQ7F
         X0yk9Act1Lfcc5/DtEiC8Gcx14YXUeNk8jih0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vTazre6X0GkDb2dzstUQNZCi730TViDQO9QZc7kXryGt1H2xXRvgUiOe/AZ2K+7uwy
         i+YFVU7gI2GRmR4LmLGsXeGS5I4Mpz/ZEbarpASGPHxfOa8EdSzUhS2eSITfW022j3Zb
         ij1zTZ+n+O7FZv6MaqGb3eIaIHvQfk6WYA9jg=
Received: by 10.213.109.156 with SMTP id j28mr2962364ebp.79.1258508612032;
        Tue, 17 Nov 2009 17:43:32 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:31 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133127>

From: Daniel Barkalow <barkalow@iabervon.org>

Currently, it only checks url, but it will allow other things in the future.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

	Unchanged.

 remote.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 73d33f2..15c9cec 100644
--- a/remote.c
+++ b/remote.c
@@ -52,6 +52,11 @@ static struct rewrites rewrites_push;
 #define BUF_SIZE (2048)
 static char buffer[BUF_SIZE];
 
+static int valid_remote(const struct remote *remote)
+{
+	return !!remote->url;
+}
+
 static const char *alias_url(const char *url, struct rewrites *r)
 {
 	int i, j;
@@ -688,14 +693,14 @@ struct remote *remote_get(const char *name)
 
 	ret = make_remote(name, 0);
 	if (valid_remote_nick(name)) {
-		if (!ret->url)
+		if (!valid_remote(ret))
 			read_remotes_file(ret);
-		if (!ret->url)
+		if (!valid_remote(ret))
 			read_branches_file(ret);
 	}
-	if (name_given && !ret->url)
+	if (name_given && !valid_remote(ret))
 		add_url_alias(ret, name);
-	if (!ret->url)
+	if (!valid_remote(ret))
 		return NULL;
 	ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr, ret->fetch_refspec);
 	ret->push = parse_push_refspec(ret->push_refspec_nr, ret->push_refspec);
-- 
1.6.5.3.164.g07b0c
