From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/24] t7600 (merge): test merge from branch yet to be born
Date: Tue, 17 Aug 2010 01:56:46 -0500
Message-ID: <20100817065646.GE22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 08:58:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlG7w-0006eL-Lz
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 08:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505Ab0HQG6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 02:58:22 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56303 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460Ab0HQG6W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 02:58:22 -0400
Received: by ywh1 with SMTP id 1so2268811ywh.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aDTEZWno2w+jEjXVFSPZyNpPDsLCLxgCbEU1fV1rmmc=;
        b=gXFvRVeTp5Lykv5OSNpQ6gjJtWb1YyGODk4bKxQNhbLORVdXs42dJWvGrYNoA5JJwW
         wtrK7otLW3fHBtFfH5Wu7l8xWcFTXW+k3+nCMaCDuQiJV7Rkkc1Y1adqPGMyIAELL1Wc
         ptkoORmmcEFmN3PkHdX1aoltduVKoCzo1YUek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WmBVVwaQPq7cBgX5VNHKBFlLgY2lIvAMwW8IBkHMLm00n6DSFE9ZhxEIoIBwv36b/G
         /zp5QJLJWKQf45c3zTDintljwqM1kC39oE5UtEoIsL2lpFiUhoqrdVgjVDpXHNqMZlq7
         wUUPxGsvysKiyLnHNmN2bxYbnG1q/TWdbfOts=
Received: by 10.100.43.19 with SMTP id q19mr4120462anq.152.1282028301777;
        Mon, 16 Aug 2010 23:58:21 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w6sm11758795anb.3.2010.08.16.23.58.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 23:58:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153708>

Some people like to "git fetch origin && merge origin/master" from
the unborn branch provided when first initializing a repository.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7600-merge.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 6e839a6..b4f40e4 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -173,6 +173,27 @@ test_expect_success 'merge c0 with c1 with --ff-only' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+test_expect_success 'merge from unborn branch' '
+	git checkout -f master &&
+	test_might_fail git branch -D kid &&
+
+	echo "OBJID HEAD@{0}: initial pull" >reflog.expected &&
+
+	git checkout --orphan kid &&
+	test_when_finished "git checkout -f master" &&
+	git rm -fr . &&
+	test_tick &&
+	git merge --ff-only c1 &&
+	verify_merge file result.1 &&
+	verify_head "$c1" &&
+
+	git reflog -1 >reflog.actual &&
+	sed "s/$_x05[0-9a-f][0-9a-f]/OBJID/g" reflog.actual >reflog.fuzzy &&
+	test_cmp reflog.expected reflog.fuzzy
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test_tick &&
-- 
1.7.2.1.544.ga752d.dirty
