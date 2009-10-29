From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 01/19] Use a function to determine whether a remote is valid
Date: Thu, 29 Oct 2009 11:01:09 -0700
Message-ID: <1256839287-19016-2-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKi-0004ac-AM
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbZJ2SCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbZJ2SCN
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:13 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:55291 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbZJ2SCH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:07 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so1335963pxi.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=C4Yh9HDYLPJVm9037bOIrrdUHNFWfpbkdlNGs1TGI4w=;
        b=UwCVjyYCqNCFp4M7AZAHu/bfzhjVgT/CoNjtnHk9IDieFVPTjM02+EXpCKu/+RiQ0x
         VGz10/LB6RN3JMQaVjdqHFS0E9Uwk9rmX5vi/WydD6rwb/3v5tgDnyJhpppjniPUW3lD
         jTpkZ/xR3uU6NKSDn56dLC6N2X50tesRcg8vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HRo4Vs4ubFnxqz2dcXyT3tdCyeY5M2ccCqy2oBxO8umoaoDICQw68DQqOQ/p40yXZV
         9Cw4BniPslMDk4+YApmZo92BE9YirEtuFt29zJHVCkAYYW4rMn2HIdACCEkEWuzSAbE4
         wioqVeMtCUrN9PM4Naowi//2lcrUpE/JXjkGE=
Received: by 10.115.148.16 with SMTP id a16mr271008wao.57.1256839332956;
        Thu, 29 Oct 2009 11:02:12 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131621>

From: Daniel Barkalow <barkalow@iabervon.org>

Currently, it only checks url, but it will allow other things in the future.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Signed off by me because I fixed the conflict with alias_url.

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
1.6.5.2.291.gf76a3
