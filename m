From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 03/13] Use a function to determine whether a remote is valid
Date: Wed,  4 Nov 2009 20:48:08 +0100
Message-ID: <1257364098-1685-4-git-send-email-srabbelier@gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrf-0000NL-Bg
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758082AbZKDTtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758038AbZKDTtH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:07 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55343 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758033AbZKDTtD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:03 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3490482ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9SHegXjtW5IZvuAsw+8MXG9Yn0bsSsvtMtqsr9WmtXo=;
        b=FxzfVyn6Ly2eKVYakG28YbN48r4A1No2JPRQ4PVd7+6N5u7ub9xrfzkzIoyOMcIRtq
         O1sWCFpFL34SrIgIUSKg5YFgEFgMaGxFCyxBU751xq21hWcJIIALrJKZY3abz5F1VjEM
         LTFo7LY0HzWtwK2H3fOZOkO4cNYmyhqhxZvhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UL2qay6/1bk//Pp8xU+AYdlUV6MahYDzkfatcpHUw4a3b2wdJzuM5hkao4CQgajgg6
         bNLkVOf+eBLj/OkjGid4PvNZ5/pV9sJK6E8p6cHn0uUhoAa/l/h+yWjg/EBuTbq16fYE
         7cO6ZVfGois7BB5Q86IUvS8v/2cPBO2iJsgnw=
Received: by 10.213.2.73 with SMTP id 9mr2286269ebi.21.1257364148579;
        Wed, 04 Nov 2009 11:49:08 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:07 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132125>

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
1.6.5.2.295.g0d105
