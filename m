From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] builtin-remote: (get_one_entry): use strbuf
Date: Mon, 22 Jun 2009 10:24:19 +0200
Message-ID: <1245659059-11852-1-git-send-email-bert.wesarg@googlemail.com>
References: <4A3778B8.5040903@drmicha.warpmail.net>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 10:24:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIepM-0005EI-NG
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 10:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbZFVIYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 04:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbZFVIYW
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 04:24:22 -0400
Received: from mail-fx0-f224.google.com ([209.85.220.224]:43104 "EHLO
	mail-fx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbZFVIYV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 04:24:21 -0400
Received: by fxm24 with SMTP id 24so478241fxm.37
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GxWJ0o9zcRpOO+PuWnmp02GvhWQFH/Yzlmk7SuOPGwE=;
        b=qkNL14mXOIGTIuYTm+giCkKq/uqrdyN24gnDgSM1KbBxJQUA+0wLeDnIx6Db5GXbM3
         krCMlV8hJKMKHabqpxrFkqCOX5pvrXp4g77+Gsj9jI/qRAAzi7wSdATA9b7dl9AIsP85
         hcPHjnk8OX+P3ZNwwuvEwxHwjTYx4czYe1YbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Hw7tkIr53u3qdypXtylkJ3yuluIzm7eO5X6us3v4Tpv8H5AYdhX34QYGIz2LG+r04G
         6ej44VAIpCzjGYUyo9ojRly51nvfylPJixdolON8srdSNQhiQwZYBokySX5vnquwTvUT
         VglvoDB1vNWFBOAQOP9rH3O/3L5i+Da/Y3ISE=
Received: by 10.86.90.2 with SMTP id n2mr6240230fgb.61.1245659062629;
        Mon, 22 Jun 2009 01:24:22 -0700 (PDT)
Received: from localhost ([141.76.90.80])
        by mx.google.com with ESMTPS id 12sm5524427fgg.15.2009.06.22.01.24.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 01:24:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.439.g4c889
In-Reply-To: <4A3778B8.5040903@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122020>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

    On Tue, Jun 16, 2009 at 12:49, Michael J Gruber<git@drmicha.warpmail.net> wrote:
    > Bert Wesarg venit, vidit, dixit 16.06.2009 09:56:
    >> On Tue, Jun 16, 2009 at 09:39, Michael J Gruber<git@drmicha.warpmail.net> wrote:
    >>> For whatever reason, your patch does not apply (am) here on top of next
    >>> + Jim's patch. Given the context (xmallocs), it looks like it's against
    >>> something + Jim's patch. OTOH: 709f8a6 show's a get_one_entry with
    >>> mallocs. Did you hand edit the diff?
    >> Its on top of next (d6a466e528119011d512379f7f9dfac26deb7fd9), plus
    >> hand editing s/malloc/xmalloc/g.
    >> Sorry for this.
    >>
    >> Bert
    >
    > Junio will have to deal with it...
    Here is an updated version.

    Bert

 builtin-remote.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 658d578..d47a124 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1276,17 +1276,17 @@ static int update(int argc, const char **argv)
 static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
+	struct strbuf url_buf = STRBUF_INIT;
+	const char *url_str = NULL;
 	const char **url;
 	int i, url_nr;
-	void **utilp;
 
 	if (remote->url_nr > 0) {
-		utilp = &(string_list_append(remote->name, list)->util);
-		*utilp = xmalloc(strlen(remote->url[0])+strlen(" (fetch)")+1);
-		strcpy((char *) *utilp, remote->url[0]);
-		strcat((char *) *utilp, " (fetch)");
-	} else
-		string_list_append(remote->name, list)->util = NULL;
+		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
+		url_str = strbuf_detach(&url_buf, NULL);
+	}
+	string_list_append(remote->name, list)->util = url_str;
+
 	if (remote->pushurl_nr) {
 		url = remote->pushurl;
 		url_nr = remote->pushurl_nr;
@@ -1296,10 +1296,9 @@ static int get_one_entry(struct remote *remote, void *priv)
 	}
 	for (i = 0; i < url_nr; i++)
 	{
-		utilp = &(string_list_append(remote->name, list)->util);
-		*utilp = xmalloc(strlen(url[i])+strlen(" (push)")+1);
-		strcpy((char *) *utilp, url[i]);
-		strcat((char *) *utilp, " (push)");
+		strbuf_addf(&url_buf, "%s (push)", url[i]);
+		url_str = strbuf_detach(&url_buf, NULL);
+		string_list_append(remote->name, list)->util = url_str;
 	}
 
 	return 0;
-- 
tg: (363bdbe..) bw/remote-v-use-strbuf (depends on: next)
