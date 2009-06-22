From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v2] builtin-remote: (get_one_entry): use strbuf
Date: Tue, 23 Jun 2009 00:27:44 +0200
Message-ID: <1245709664-23611-1-git-send-email-bert.wesarg@googlemail.com>
References: <20090622213204.GB19364@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 23 00:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIrzb-0008LL-V2
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 00:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987AbZFVW1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 18:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbZFVW1r
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 18:27:47 -0400
Received: from mail-fx0-f224.google.com ([209.85.220.224]:57068 "EHLO
	mail-fx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164AbZFVW1q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 18:27:46 -0400
Received: by fxm24 with SMTP id 24so1091410fxm.37
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3QAtNfnpier0y8PG9UauZ7mlCP3Wd+DGe+QpmLPycSo=;
        b=Fv8Agu2/wd5gHqv258oohk0JcFcz5GRxQD2fyd5Hdr4xzVUXLeZDUGyh9l8yLcoxru
         czrNViiFRcr1sndsQvoEnu1Oyk+ufEJIpjVBT1CMnWUl7MHsQsMyL/Q1HBNzAOe8/+fX
         uh2ayJtBGje4hoBJwjGUw2j3FnwnAV24MJnrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Aa+6LML5xQEe34x68u1s+qh7YIycFpS8PeFL+CF/gmfVCU1sxrO89MEQdiWC3vVvaP
         UQDcGGESZkuLiRo/PfMZyD5QGmrZQsonbBFdQyA3XjXuHvmghqOeywhITV4s30meufFa
         x5iwrB7TwdU3cf9WgCvNQ+s1QzWHylUoOy5Uc=
Received: by 10.86.86.2 with SMTP id j2mr7358049fgb.50.1245709667792;
        Mon, 22 Jun 2009 15:27:47 -0700 (PDT)
Received: from localhost (drsd-4db3aaef.pool.einsundeins.de [77.179.170.239])
        by mx.google.com with ESMTPS id e20sm2304190fga.5.2009.06.22.15.27.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 15:27:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.416.g03cc
In-Reply-To: <20090622213204.GB19364@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122064>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
v2: - remove assigment indirection
    - keep old code flow

  On Mon, Jun 22, 2009 at 23:32, Jeff King <peff@peff.net> wrote:
  > But that is somewhat nit-picking. As long as the const-warning goes
  > away, I will be happy enough.
  >
  Thanks for the review. I have no objections to your comments and have all
  incroporated into v2.

  Thanks,
  Bert
  > -Peff

 builtin-remote.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 658d578..2fb76d3 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1276,15 +1276,14 @@ static int update(int argc, const char **argv)
 static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
+	struct strbuf url_buf = STRBUF_INIT;
 	const char **url;
 	int i, url_nr;
-	void **utilp;
 
 	if (remote->url_nr > 0) {
-		utilp = &(string_list_append(remote->name, list)->util);
-		*utilp = xmalloc(strlen(remote->url[0])+strlen(" (fetch)")+1);
-		strcpy((char *) *utilp, remote->url[0]);
-		strcat((char *) *utilp, " (fetch)");
+		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
+		string_list_append(remote->name, list)->util =
+				strbuf_detach(&url_buf, NULL);
 	} else
 		string_list_append(remote->name, list)->util = NULL;
 	if (remote->pushurl_nr) {
@@ -1296,10 +1295,9 @@ static int get_one_entry(struct remote *remote, void *priv)
 	}
 	for (i = 0; i < url_nr; i++)
 	{
-		utilp = &(string_list_append(remote->name, list)->util);
-		*utilp = xmalloc(strlen(url[i])+strlen(" (push)")+1);
-		strcpy((char *) *utilp, url[i]);
-		strcat((char *) *utilp, " (push)");
+		strbuf_addf(&url_buf, "%s (push)", url[i]);
+		string_list_append(remote->name, list)->util =
+				strbuf_detach(&url_buf, NULL);
 	}
 
 	return 0;
-- 
tg: (d4b46b0..) bw/remote-v-use-strbuf (depends on: next)
