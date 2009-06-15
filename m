From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] builtin-remote: (get_one_entry): use strbuf
Date: Mon, 15 Jun 2009 22:45:28 +0200
Message-ID: <1245098728-7502-1-git-send-email-bert.wesarg@googlemail.com>
References: <4A35FCFB.1080000@drmicha.warpmail.net>
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 22:45:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGJ3l-0005TY-7V
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 22:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbZFOUpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 16:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbZFOUpa
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 16:45:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:41072 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbZFOUp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 16:45:29 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1198665fgg.17
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VkLvirJR4N/DiLKEw/RZ1WxYA/NRGwhGbRJL2vlGRLM=;
        b=gWjJ24mluXDcoizeQb7z7t/pW3DmDgNVjMqil0Gc6hQ/jrjM5HKTElmqr+nhgmqofy
         ox7e/ZC1+9u5J+Al3TyK/mezGwva43DuuDbRmW9yQIV7JzfvUjz6dftilLi4dVlKqyXV
         g9OfyB4c0pYViX3WmPyAN5KiDGO9O7+fWgcm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x1nwCtYJmuBEmkAoKbDFNZuZe43udOaTgY48rRyimufm/s0eX6Kl729U3keiPBiUaV
         NbO11rKEOTxZPln0GxBGo2vIPqMEhrWJtSbAclkWHSKLjsVbsSpQOkcNUvNEDlIUVqTX
         xSwdgR8qWISYANScmt9hz1e83iStCcys4VfaM=
Received: by 10.86.86.10 with SMTP id j10mr6921204fgb.37.1245098730729;
        Mon, 15 Jun 2009 13:45:30 -0700 (PDT)
Received: from localhost (drsd-4db3e3f8.pool.einsundeins.de [77.179.227.248])
        by mx.google.com with ESMTPS id l19sm9619703fgb.12.2009.06.15.13.45.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Jun 2009 13:45:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.416.g03cc
In-Reply-To: <4A35FCFB.1080000@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121622>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

On Mon, Jun 15, 2009 at 09:49, Michael J Gruber<git@drmicha.warpmail.net> wrote:
> Jim Meyering venit, vidit, dixit 14.06.2009 21:46:
>>
>> * builtin-remote.c (get_one_entry): Use xmalloc, not malloc.
>
> Learning something new with every patch... Sorry, Junio; thanks, Jim!
>
One more reason to re-use existing string handling functions.

Regards,
Bert

 builtin-remote.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 709f8a6..31adeaa 100644
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
tg: (d6a466e..) bw/remote-v-use-strbuf (depends on: next)
