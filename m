From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 4/4] Plug memory leak in git-pack-objects
Date: Mon, 8 Aug 2005 22:46:58 +0400
Message-ID: <20050808184658.GE5789@procyon.home>
References: <20050808184332.GA5789@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 20:49:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2CfA-0000e0-2l
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 20:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVHHSrt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 14:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVHHSrt
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 14:47:49 -0400
Received: from mail.murom.net ([213.177.124.17]:47811 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S932192AbVHHSrt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 14:47:49 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1E2Cf6-0008DT-E8; Mon, 08 Aug 2005 22:47:48 +0400
Received: by procyon.home (Postfix, from userid 500)
	id 0B20DE51111; Mon,  8 Aug 2005 22:46:58 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050808184332.GA5789@procyon.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Plug memory leak in git-pack-objects

find_deltas() should free its temporary objects before returning.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---

 pack-objects.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

8b38f80b97affd0d9808b8f276a9e2e04bf03464
diff --git a/pack-objects.c b/pack-objects.c
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -382,6 +382,10 @@ static void find_deltas(struct object_en
 		if (idx >= window)
 			idx = 0;
 	}
+
+	for (i = 0; i < window; ++i)
+		free(array[i].data);
+	free(array);
 }
 
 int main(int argc, char **argv)
