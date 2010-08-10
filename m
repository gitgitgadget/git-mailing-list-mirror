From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 3/3] read-tree: stop leaking tree objects
Date: Mon, 9 Aug 2010 22:33:44 -0500
Message-ID: <20100810033344.GD2386@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 05:35:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OifcU-0001IU-Bl
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 05:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185Ab0HJDfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 23:35:14 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64070 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506Ab0HJDfM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 23:35:12 -0400
Received: by gxk23 with SMTP id 23so3634710gxk.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 20:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AXEKHu00meqgyE7UjWlufiIRb9WRBSWv0GoXXdluY90=;
        b=RdXnCi2hiVmgZ8C7TyWxtVFLw5wMotjd2t3kM4aZL7JzqKpp1QJMnikQ+Ur38cun4g
         qdriYw74Ztcx/N6l5tVc0l7mYp+54h8OQtd2/qXGuWqdk90TqXV1+tPBLVB1bjUEn45P
         JC65ZCo3OiQ76Tyg6MexH6x5hs1z2thC0G1dU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ju4fenp+iXgrnOx8OtE2iX2FSZ0wI7NBBEGL+oPfiTiBBzBpmq2eT+zBCmgoDQYmpJ
         AcIBbETZY8DTtU869JgVaSmmjg8QReLL9B+pA/M2qzDC8PJ60a4CdmwYotVFjFuGkisT
         B7KSW7uhKR/ttsJDgsxWCvc2hOz6ISMnL+6/8=
Received: by 10.101.207.21 with SMTP id j21mr18749634anq.269.1281411312129;
        Mon, 09 Aug 2010 20:35:12 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id c6sm9641113anj.11.2010.08.09.20.35.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 20:35:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100810032647.GA2386@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153075>

The underlying problem is that the fill_tree_descriptor()
API is easy to misuse, and this patch does not fix that.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 unpack-trees.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 8cf0da3..f561d88 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -329,6 +329,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long
 {
 	int i, ret, bottom;
 	struct tree_desc t[MAX_UNPACK_TREES];
+	void *buf[MAX_UNPACK_TREES];
 	struct traverse_info newinfo;
 	struct name_entry *p;
 
@@ -346,12 +347,16 @@ static int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long
 		const unsigned char *sha1 = NULL;
 		if (dirmask & 1)
 			sha1 = names[i].sha1;
-		fill_tree_descriptor(t+i, sha1);
+		buf[i] = fill_tree_descriptor(t+i, sha1);
 	}
 
 	bottom = switch_cache_bottom(&newinfo);
 	ret = traverse_trees(n, t, &newinfo);
 	restore_cache_bottom(&newinfo, bottom);
+
+	for (i = 0; i < n; i++)
+		free(buf[i]);
+
 	return ret;
 }
 
-- 
1.7.2.1.544.ga752d.dirty
