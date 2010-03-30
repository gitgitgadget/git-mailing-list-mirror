From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] remote-curl: Add sanity check for url
Date: Wed, 31 Mar 2010 01:38:42 +0530
Message-ID: <f3271551003301308y683173f6y6a4fadb01b791049@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 22:09:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwhkN-0008Bh-Da
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 22:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab0C3UJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 16:09:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35254 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405Ab0C3UJE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 16:09:04 -0400
Received: by gwaa18 with SMTP id a18so4898936gwa.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=6QFfy3TXIWmL/EsGFluxQm85x4EPeI+Y0sHOj9ypzMA=;
        b=IW0Ubyo21dDUJh0xPrQYJX8LJQTyOMsQeMrcAsLopWEhsoiaAatfnr1zb34qXy5U2A
         cf8AUDD3Mrnu7mQppsxC/h3JWpdxE199kfdOx56zgmxiEsCw4ov8oNDYm5lAsGFmiCWc
         fbaBlA4MHkJ45UI5dtKBnMI0hbSE5yjRy/Lc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=PrHmhlmZ/PdUCFjXsIyuueKYn4IyLFgQvr3AmR26/MPmBq+K27Wwq40eYnn9oPbAjP
         T0H3jLebLUjELf5S4i9V/1OE9J1PgsozznBe6yYRJY6z7a5igonKffxtvlPkcMUhxgV5
         LfDaBqW1/LwsLJaJuJSGJ0JRhrSErdxJRlmLA=
Received: by 10.90.69.14 with HTTP; Tue, 30 Mar 2010 13:08:42 -0700 (PDT)
Received: by 10.91.88.13 with SMTP id q13mr2356787agl.99.1269979742163; Tue, 
	30 Mar 2010 13:09:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143597>

Previously, `git remote-http foo` and subsquent commands would try to
work on a HTML page. This patch fixes the bug by making one assumption
about the URL handled by libcurl: it must contain the string "://"

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote-curl.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index b76bfcb..9320897 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -112,6 +112,9 @@ static struct discovery* discover_refs(const char *service)
 	}
 	refs_url = strbuf_detach(&buffer, NULL);

+	/* sanity check: does this look like a url expected by libcurl? */
+	if (!strstr(url, "://"))
+		die("%s is not a url supported by this remote helper", url);
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);

 	/* try again with "plain" url (no ? or & appended) */
-- 
1.7.0.3
