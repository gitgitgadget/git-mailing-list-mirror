From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 06/12] Allow specifying the remote helper in the url
Date: Wed, 18 Nov 2009 02:42:26 +0100
Message-ID: <1258508552-20752-7-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-4-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-5-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-6-git-send-email-srabbelier@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:44:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZaq-0000vW-6K
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839AbZKRBnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756831AbZKRBne
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:34 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:40383 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721AbZKRBnd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:33 -0500
Received: by ey-out-2122.google.com with SMTP id 25so5818eya.19
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PxaKezQcRfNNSJKJTQZuTRoSXJ8Vcj2qk5d9DZfRXkU=;
        b=a+S8RUWhjN4Fqr55nANxojZsXj4Jz/ye2HG3on9BLBKVCYGfXkr14YWgCT9LJxMwNN
         4MnZNRaEO08jPSJWPfB9pZo4MY3FnDDdJuLJUyYH45cBe+IzMDVEA/vI/QPfnOSSGWGv
         Pp7YU7y3jp1UJ9w7Zc8FtNf2rmJ3lluK/SW3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QIoA783cA6VbmWvivLWg9NyjzH92Uhp2IGpHWxiW8KV994aLv48hPOrkGzmIEE+VZA
         1WUcNI1yooq/AwLFnFClfyK7Nk2DBPuJ4EBsxtnS1ARCGLGcT72w61lzHWfo+QOlamO6
         KUe3cREZvu969VF78YBz80Fs0usYUEfsbPxkA=
Received: by 10.213.25.66 with SMTP id y2mr171983ebb.93.1258508616557;
        Tue, 17 Nov 2009 17:43:36 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:35 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-6-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133126>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The common case for remote helpers will be to import some repository
which can be specified by a single URL.  Support this use case by
allowing users to say:

	git clone hg::https://soc.googlecode.com/hg/ soc

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Unchanged.

 transport.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index aa90648..ea39535 100644
--- a/transport.c
+++ b/transport.c
@@ -821,6 +821,16 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		url = remote->url[0];
 	ret->url = url;
 
+	/* maybe it is a foreign URL? */
+	if (url) {
+		const char *p = url;
+
+		while (isalnum(*p))
+			p++;
+		if (!prefixcmp(p, "::"))
+			remote->foreign_vcs = xstrndup(url, p - url);
+	}
+
 	if (remote && remote->foreign_vcs) {
 		transport_helper_init(ret, remote->foreign_vcs);
 		return ret;
-- 
1.6.5.3.164.g07b0c
