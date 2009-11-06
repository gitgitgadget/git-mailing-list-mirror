From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 03/12] Use a function to determine whether a remote is valid
Date: Fri,  6 Nov 2009 23:52:37 +0100
Message-ID: <1257547966-14603-4-git-send-email-srabbelier@gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-2-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-3-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Xgo-000813-1z
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 23:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760132AbZKFWxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 17:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbZKFWxf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 17:53:35 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:48718 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292AbZKFWxa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 17:53:30 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so1557918ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 14:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GTNdmslG3lLw04sSRdm5At1gjRNpY9eseVkwHG+N6po=;
        b=XQ/k8XTdvArn46u/D8tW4ItZP5wqF+AQFmHjwUPrk0rYS1fT4ru+559A07s90nyhrs
         TPwnGXxDQLEMaEaHoCuwVxWrdpJUsY7mfTGQbOAJXvfAWv/hXU0Ea3rlE1qJQDE8JsVF
         cGiYLrYtSjwQtCYgZ3uvdlHuVxDYMiIa0tcE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mIExBaFCCuAlQ0b1tvDUvXlNjzvimfwlEyU6JAWL2zZqVmHD94AP4srrZ9vavK3KaL
         xb3QPa27kLZr0GbtlPIvOhkF4gbtNIojFhQdzOf2LIH5T275cUU2jibKywy6yI62vHmE
         HFquYJNn1UBZIlmw1rXo/1dydoVuffszV2P0Y=
Received: by 10.213.0.131 with SMTP id 3mr5166ebb.68.1257548015731;
        Fri, 06 Nov 2009 14:53:35 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 7sm1501175eyb.40.2009.11.06.14.53.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 14:53:34 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.158.g6dacb
In-Reply-To: <1257547966-14603-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132331>

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
1.6.5.2.158.g6dacb
