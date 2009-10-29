From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 08/19] Fix memory leak in helper method for disconnect
Date: Thu, 29 Oct 2009 11:01:16 -0700
Message-ID: <1256839287-19016-9-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:02:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKl-0004ac-G9
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbZJ2SC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbZJ2SC1
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:27 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:43668 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125AbZJ2SC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:26 -0400
Received: by mail-pz0-f188.google.com with SMTP id 26so1412783pzk.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=edb/42xjKQk8JC9aeyjNLXGgdJMspkppMuwU5Myg8a8=;
        b=abnkQawNw7rXoKsz1Mm1bjaW2iqcZSw+GCqaoQy4LNgThjEcpx3g8kf+r8dnNSl5r0
         K9ofVwPzAOj21mo6NRynJqeoz8Fx2hCjD9XTbd2FbJhf6ddsG35AB2YACl/7HYz0NxDK
         dhZJPNvpYNmxY/HqG97v+PT2Ii387/wtyRzA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OwzbPG26upt0M+Y0E4n0CNnqBGbKDiJmkhZZPwO0+oJ0QhXn2v+R0yfdeoJx0vIqsi
         uR1LCakqpA08Rc979uvPasMtIGwMZMWghG3GwwCEUtfQHxN7BL8RgY/1EAyNYJbmtWQa
         qm3katGifWX+8l2sxj+60JFPO50RcKqCG7ZPM=
Received: by 10.115.98.40 with SMTP id a40mr268707wam.97.1256839351113;
        Thu, 29 Oct 2009 11:02:31 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131624>

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
index e093d05..36a265d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -70,6 +70,13 @@ static int disconnect_helper(struct transport *transport)
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
 			    int nr_heads, struct ref **to_fetch)
 {
@@ -252,6 +259,6 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
 	transport->update_refs = update_refs;
-	transport->disconnect = disconnect_helper;
+	transport->disconnect = release_helper;
 	return 0;
 }
-- 
1.6.5.2.291.gf76a3
