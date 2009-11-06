From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 01/12] Fix memory leak in helper method for disconnect
Date: Fri,  6 Nov 2009 23:52:35 +0100
Message-ID: <1257547966-14603-2-git-send-email-srabbelier@gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:55:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6XiA-00008E-FD
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 23:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874AbZKFWyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 17:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbZKFWxc
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 17:53:32 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:37835 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283AbZKFWx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 17:53:28 -0500
Received: by ewy3 with SMTP id 3so1557922ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 14:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1IhCVyFew8n/9Odq06tLMrZiRwO0q9nmZAREemxEkSA=;
        b=c0CJQhlw2Np0+Uw+NJkiFZ/H/i3gVHm6X8VtDF98mcilGe/LBqpEXVx0nQHW2VmBN0
         Zmk9mQNs95mMT7fwBCsuQcrLGH9MZN1qbzkUs4fEOYP6/P6CGoDBWvAnBLWFWWe/HbQc
         LC0QIL0uli66z7WWPlr23XeC2g3S67iljyp4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rgRtxSHuurgT1ysqvm4Vwq3FQTgkSijQp6Mbzvr4r0XYdvKB3OHEcLoweo8SfY6/TB
         52zaDJoTVyjJNQcN53CKp9864DYnvAKeBn8Q9Fi3W/03wMfh/reDs09XgELuC58OBmoM
         bdH8CFNdV3+dtANh0riAbfuT24ujSuPYQqobo=
Received: by 10.213.0.129 with SMTP id 1mr1557214ebb.82.1257548012356;
        Fri, 06 Nov 2009 14:53:32 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 7sm1501175eyb.40.2009.11.06.14.53.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 14:53:31 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.158.g6dacb
In-Reply-To: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132337>

From: Daniel Barkalow <barkalow@iabervon.org>

Since some cases may need to disconnect from the helper and reconnect,
wrap the function that just disconnects in a function that also frees
transport->data.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

	Unchanged.

 transport-helper.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index f57e84c..e24fcbb 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -67,6 +67,13 @@ static int disconnect_helper(struct transport *transport)
 	return 0;
 }
 
+static int release_helper(struct transport *transport)
+{
+	disconnect_helper(transport);
+	free(transport->data);
+	return 0;
+}
+
 static int fetch_with_fetch(struct transport *transport,
 			    int nr_heads, const struct ref **to_fetch)
 {
@@ -163,6 +170,6 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->data = data;
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
-	transport->disconnect = disconnect_helper;
+	transport->disconnect = release_helper;
 	return 0;
 }
-- 
1.6.5.2.158.g6dacb
