From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 5/7] Finally make remote helper support useful
Date: Wed, 28 Oct 2009 23:40:24 -0700
Message-ID: <1256798426-21816-6-git-send-email-srabbelier@gmail.com>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 07:41:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Ohj-0003Ks-Tr
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 07:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbZJ2Glb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 02:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756478AbZJ2Glb
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 02:41:31 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:53125 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449AbZJ2Gl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 02:41:29 -0400
Received: by pzk26 with SMTP id 26so1081006pzk.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TBOLGfLRQtpHraQ8lcKe/Ulu2NohhBjAh8dZ3wzfqek=;
        b=FqOIDBNXblM45f/cVvzvEVk/pyXuVLUEUu2NHzVMldGOOoAwSCO9WmnzcLKpcqB5mc
         GLnmfL4vUjyumWBupS/cIInCNjVx1dyjM+koYRD1DVRUyeR29Lh9rf1z2aKg/je9bdqB
         Kq+mC4JrScAB8zLiU6XFCMKAEvjjRNTgIaYws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b4+pDFO3cDxnkvrSvSNajzbSKfwwGGfUxZbeB6QBZNQzLxlUFotFwL3O/etSG8UMNB
         9R0VznhfR/IApivbbExLLV/vi6CgTYfm2D4G3vNefmqNUkiYe/KrKXRMU3vVbSYq646l
         KDxQWug5iqFYLJL1gXDLtcpdHn1Cg8yeT87EI=
Received: by 10.115.114.18 with SMTP id r18mr10313389wam.24.1256798494700;
        Wed, 28 Oct 2009 23:41:34 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm401242pxi.1.2009.10.28.23.41.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 23:41:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131559>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The common case for remote helpers will be to import some repository which
can be specified by a single URL.  Rather than supporting those who say
that Git is really complicated, let's be nice to users so that they will
be able to say:

	git clone hg::https://soc.googlecode.com/hg/ soc

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
--

	Dscho wrote this a while back and it really does make the
	series so much more useful.

 transport.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index ef33404..a682c75 100644
--- a/transport.c
+++ b/transport.c
@@ -813,6 +813,16 @@ struct transport *transport_get(struct remote *remote, const char *url)
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
