From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/7] tree_entry_interesting(): Make return value more specific
Date: Tue, 24 Aug 2010 20:53:12 -0600
Message-ID: <1282704795-29661-5-git-send-email-newren@gmail.com>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 04:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo66O-0008G6-9L
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 04:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587Ab0HYCwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 22:52:10 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33622 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481Ab0HYCwA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 22:52:00 -0400
Received: by mail-vw0-f46.google.com with SMTP id 3so180848vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BnjPTtSe9rIM1+6D604Dxkb2G+GJpKLVCE/kLloAUPI=;
        b=c4ye9k5V6n0C6PSXyl2ML0w+pNrbNZhulPR0xNYSaixKgyDzOOPIiCYqwn4Hv3FxPa
         uYNp81GRTvCDQ5qUyD/2t5oKiXQY2XuUhzMSLSR/KrKJ9aEuhaOyfW2z7lC9796upK9c
         AJ53UAcPaK/5t03mHeh9xKBAJFTh5BsOh42HY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vmFl1aIBqbZ87mccFCFRe9AxLXCGAyUKe66k5vB4S+9lbK/RfsRTp/tuvS6BGIrTBq
         R0hBfDwCrHs9dlMBTaeo0v5axkJAekbSBnGl5ylnbFhqSOq4TzrNIJcjAOHWy79iAPzd
         K9Ff1h4gHJAq3BeoIp8CgTrdqbiZKqFxOwWxE=
Received: by 10.220.89.30 with SMTP id c30mr4976577vcm.21.1282704713267;
        Tue, 24 Aug 2010 19:51:53 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id v11sm577473vbb.3.2010.08.24.19.51.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 19:51:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.39.gf7e23
In-Reply-To: <1282704795-29661-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154401>

tree_entry_interesting() can signal to its callers not only if the given
entry matches one of the specified paths, but whether all remaining paths
will (or will not) match.  When no paths are specified, all paths are
considered interesting, so intead of returning 1 (this path is interesting)
return 2 (all paths are interesting).

This will allow the caller to avoid calling tree_entry_interesting() again,
which theoretically should speed up tree walking.  I am not able to measure
any actual gains in practice, but it certainly can not hurt and makes more
sense to me.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 tree-diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 2fb670b..a740a9c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -101,7 +101,7 @@ int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen
 	int never_interesting = -1;
 
 	if (!opt->nr_paths)
-		return 1;
+		return 2;
 
 	sha1 = tree_entry_extract(desc, &path, &mode);
 
-- 
1.7.2.2.39.gf7e23
