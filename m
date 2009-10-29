From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 09/19] Finally make remote helper support useful
Date: Thu, 29 Oct 2009 11:01:17 -0700
Message-ID: <1256839287-19016-10-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKm-0004ac-IX
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbZJ2SCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754369AbZJ2SCa
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:30 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:48301 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323AbZJ2SC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:28 -0400
Received: by mail-pw0-f42.google.com with SMTP id 9so194495pwj.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GK+w3B07IvWfKvS0Jlbu4DUa09MeIAP/pTtrQrxUMBw=;
        b=LXoTHFPe0wcPdSuN0hlQqsMI9NvibblhS9O+1HVyKfrlEBQPyoIYD4qzbe6Jd8M3wJ
         KEeetQ66GAa9yZzyPT3Oj/eKfGFA7p9u3ZuBQWmfh5A13n4h+2OY2GdQVmbbyF7xjeO1
         gmoFS4XURCc0rFwTCoJy0DkB2VritIDAuebtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e5FXhzVdFqB6k4WDhz3NgUMHvmagpJCRtX9QTArHa0sD6xmrlMLeWJilsqlBd1nZrj
         EW24uS61CBPX3sUaKj0WePiNDF0ktO8LD27Vnqy3F86i4dAdAJ/eQ3lKGFdxegG0qihm
         cWvDpd568Uljk4A0mbWivGDEzLaYwDHc5oe7I=
Received: by 10.114.248.35 with SMTP id v35mr289367wah.9.1256839353699;
        Thu, 29 Oct 2009 11:02:33 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The common case for remote helpers will be to import some repository which
can be specified by a single URL.  Rather than supporting those who say
that Git is really complicated, let's be nice to users so that they will
be able to say:

	git clone hg::https://soc.googlecode.com/hg/ soc

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	I decided to not allow 'hg+https' format, since clone does
	not deal well with that syntax (it checks to see whether
	there is a ':' in the url or not).

 transport.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index 741a3a7..e6a00b2 100644
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
1.6.5.2.291.gf76a3
