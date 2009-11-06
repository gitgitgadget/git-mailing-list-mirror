From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 06/12] Allow specifying the remote helper in the url
Date: Fri,  6 Nov 2009 23:52:40 +0100
Message-ID: <1257547966-14603-7-git-send-email-srabbelier@gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-2-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-3-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-4-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-5-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-6-git-send-email-srabbelier@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Xgo-000813-JX
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 23:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbZKFWxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 17:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760095AbZKFWxh
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 17:53:37 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:48718 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759945AbZKFWxe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 17:53:34 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so1557918ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 14:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OYCGqd/3bdUaMhCIZkht9KJFLDIZrs8eCUiq9h20JFE=;
        b=Y55++ML4ys2Tw4TQz4q/BEzz1QmvhRIgBQ2EopaCdhATYrC9cxROAbPR9CHUnr53z9
         2IeI10sPKM74sKDKWFvb/LN5iTDfaBjyufZuCz2T4AzQ8Xa3LReC1PO+KcuwXESpoTe/
         ER7RDEIUqIyJatF4q/uN3QSbQqt5jX4yAf3xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=k1MZwMBrfuDn8OfFY9bKWyLTGdqb5xRihbGP8IVlW583yiph9tJqkRy2cEyIXQo6rk
         nR+NjFg/RZbb9T7kgYtf+7uwO83niSSJAzC9Ymr6zdvfNXKPYwzkoTgPRYr/sz8s+XXj
         K+nI3O4E1KlJvr5/jk/CB5xLnirn5EhLVAvJM=
Received: by 10.213.2.73 with SMTP id 9mr5769299ebi.21.1257548019136;
        Fri, 06 Nov 2009 14:53:39 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 7sm1501175eyb.40.2009.11.06.14.53.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 14:53:38 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.158.g6dacb
In-Reply-To: <1257547966-14603-6-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132330>

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
1.6.5.2.158.g6dacb
