From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 06/13] Allow specifying the remote helper in the url
Date: Wed,  4 Nov 2009 20:48:11 +0100
Message-ID: <1257364098-1685-7-git-send-email-srabbelier@gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:49:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrg-0000NL-DV
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758087AbZKDTtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758083AbZKDTtK
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:10 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:61042 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758038AbZKDTtI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:08 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3490470ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lF/06eCB6WxrsiRwc4F8ncd3y+JfAVm09+xl67KCUW4=;
        b=vTXfgUMZWK2vvkpEIFg1h7RHlebY6Dec7G4PHkq9VYMcvy00bNfWePynU1bBin4Ne7
         29xskTT9RO/pnHxsjkOV2qowDPGMr5/6JWI6AZq8TRTpkzbttxYq8sMxsagiIM2jlEd/
         OKKkkJ8ET1cvDzTAbi0GPHemIopmx0mC8drmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oVgL6QQLc4HPkjh6S1Xm7Puh+SpEO2GIpGkUYgTkLsrVjo9RW6i+LJwiZ9h1Bhfpq2
         tM7SBFFHR2NHS/3iRvP6AkQqyx3SjbYpwVcH8iabkss0/84l11ZeQpeQulhZN7xVKfAv
         cYnd679fhl/EMKwG7UjVv7PdrjpqOVKChGve4=
Received: by 10.213.3.140 with SMTP id 12mr2694419ebn.20.1257364153493;
        Wed, 04 Nov 2009 11:49:13 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:13 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132122>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The common case for remote helpers will be to import some repository
which can be specified by a single URL.  Support this use case by
allowing users to say:

	git clone hg::https://soc.googlecode.com/hg/ soc

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Reworded commit message to be more neutral.

 transport.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index 13bab4e..5d814b5 100644
--- a/transport.c
+++ b/transport.c
@@ -818,6 +818,16 @@ struct transport *transport_get(struct remote *remote, const char *url)
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
1.6.5.2.295.g0d105
