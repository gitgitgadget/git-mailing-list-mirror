From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] tests: teach verify_parents to check for extra parents
Date: Fri, 6 May 2011 16:00:21 -0500
Message-ID: <20110506210021.GC20182@elie>
References: <20110503090351.GA27862@elie>
 <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
 <20110506205441.GA20182@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 23:00:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIS8V-0002kB-Oy
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 23:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab1EFVA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 17:00:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52133 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab1EFVA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 17:00:27 -0400
Received: by iwn34 with SMTP id 34so2984465iwn.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=szlDrWSZZOeg72/NAleP3jl1kNN0vR6gxOw8p6rfwRk=;
        b=RDxzYgBQbsgM3SywyQAi9lUmPXkJAP8+CJJCiC/f8BC0Z468qe/8Qrv/5Ymbxxq/XL
         rBY6Ir6NSkVNyiJhBP2Gjfps+GRnn0WXoD0wxDt9nh2qHHXtfmYWys1yrBRwJljsb5jX
         JXQXXxHf52a71qG/fq7eHxDoGaanH8tdoeN+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rSpih6K+5DPy+XC4Y8c6lYL9B0xDfsOmBXWRPZx8XfyN6Epliw8i9kpZXOtx5m7KAu
         Un2MSsO21NkqCRsLdJkkoLDD+oef7VOJCvyOoltqY2AXrD7lhMVep4bUTOg6RG2ocUNO
         +FpUY4XXREU+1QOYXv0/CvPec6tNZ+g3+Igzc=
Received: by 10.42.162.193 with SMTP id z1mr3267058icx.515.1304715626447;
        Fri, 06 May 2011 14:00:26 -0700 (PDT)
Received: from elie ([76.206.232.100])
        by mx.google.com with ESMTPS id 14sm1473219ibc.59.2011.05.06.14.00.24
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 14:00:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110506205441.GA20182@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173010>

Currently verify_parents only makes sure that the earlier parents of
HEAD match the commits given, and does not care if there are more
parents.  This makes it harder than one would like to check that, for
example, parent reduction works correctly when making an octopus.

Fix it by checking that HEAD^(n+1) is not a valid commit name.
Noticed while working on a new test that was supposed to create a
fast-forward one commit ahead but actually created a merge.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7600-merge.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index c665acd..9af748a 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -89,6 +89,7 @@ verify_parents () {
 		i=$(expr $i + 1) ||
 		return 1
 	done &&
+	test_must_fail git rev-parse --verify HEAD^$(($# + 1)) &&
 	test_cmp parents.expected parents.actual
 }
 
-- 
1.7.5.1
