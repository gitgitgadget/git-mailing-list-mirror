From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Bug: write-tree corrupts intent-to-add index state
Date: Tue, 6 Nov 2012 19:37:34 +0700
Message-ID: <20121106123734.GA11836@lanh>
References: <3E62F933-76CD-4578-8684-21444EAA454F@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 13:37:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TViPj-0006Yt-Du
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 13:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147Ab2KFMhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 07:37:42 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:58703 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab2KFMhl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 07:37:41 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so185129dak.19
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 04:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=J828+CTcaw1Umr1zLv5fqvhwfGVZ77tfFWbUPEqpQr4=;
        b=ZJHwopUJyM/rfJA8gXw9yRW7Ra3oTkfUghsQfrjockZDqEapXppMGBr7bEz6xNDqLr
         whMR1AKXvhlOAKL269y9xkLOmeGk2Xrankrox5CCWRXgF+OxKCWqCFHCoT27tes2aLbw
         7rhJ0XsCHi5QrtF2LTaSmcWgiPBA9W35NMXQtNBgoaLEowOTSI7jmN+w12s8+FdGECzg
         gpeOI+XjG3zOBia5Z8m0eynftxtstJk5pgIa27SizZ9ooKqcmBorprt2G0X2uWUz2hB/
         M3c/K1cywVvDG6DIGj+cRyZXT0RXXpFbz92dXfR/09N66zLZWCcvP1mAhrKsK2CGro9t
         hPGQ==
Received: by 10.68.202.131 with SMTP id ki3mr2897779pbc.72.1352205460970;
        Tue, 06 Nov 2012 04:37:40 -0800 (PST)
Received: from lanh ([115.74.35.221])
        by mx.google.com with ESMTPS id xk2sm5911676pbc.45.2012.11.06.04.37.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Nov 2012 04:37:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 06 Nov 2012 19:37:34 +0700
Content-Disposition: inline
In-Reply-To: <3E62F933-76CD-4578-8684-21444EAA454F@JonathonMah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209108>

On Tue, Nov 06, 2012 at 12:53:27AM -0800, Jonathon Mah wrote:
> It appears the index forgot that those files were new. So not only
> has the intent-to-add status been lost, but git status shows a file
>  existing in neither HEAD nor the index as not-new-but-modified.
>
> Tracing through it, I narrowed it down to git write-tree affecting
> the index state. As far as I can tell, it's incorrect for that
> command to change the index. I'm now out of my (shallow) depth in
> the git codebase, so I'm throwing it out there for someone to tackle
> (hopefully). I've attached a failing test case.

I played with your test a bit and found that if we skip the commit
step, the bug disappears. I checked and believe that i-t-a flag in
index is preserved, which leaves cache-tree as the culprit. If
cache-tree is (incorrectly) valid, diff operations won't bother
checking index.

We used to not allow writing tree with i-t-a entries present. Then we
allowed it, but forgot that we need to invalidate any paths that
contain i-t-a entries, otherwise cache-tree won't truly reflect
index.

The below patch seems to do the trick, but I'd rather do the
invalidation inside update_one() so we don't need to traverse over the
index again. I haven't succesfully put cache-tree.c back in my head
again to make it happen. Anybody is welcome to step up, or I'll finish
it this weekend.

-- 8< --
diff --git a/cache-tree.c b/cache-tree.c
index 28ed657..30a8018 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -381,6 +381,9 @@ int cache_tree_update(struct cache_tree *it,
 	i = update_one(it, cache, entries, "", 0, flags);
 	if (i < 0)
 		return i;
+	for (i = 0; i < entries; i++)
+		if (cache[i]->ce_flags & CE_INTENT_TO_ADD)
+			cache_tree_invalidate_path(it, cache[i]->name);
 	return 0;
 }
 
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index ec35409..3ddbd89 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -62,5 +62,25 @@ test_expect_success 'can "commit -a" with an i-t-a entry' '
 	git commit -a -m all
 '
 
+test_expect_success 'cache-tree invalidates i-t-a paths' '
+	git reset --hard &&
+	mkdir dir &&
+	: >dir/foo &&
+	git add dir/foo &&
+	git commit -m foo &&
+
+	: >dir/bar &&
+	git add -N dir/bar &&
+	git diff --cached --name-only >actual &&
+	echo dir/bar >expect &&
+	test_cmp expect actual &&
+
+	git write-tree >/dev/null &&
+
+	git diff --cached --name-only >actual &&
+	echo dir/bar >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 8< -- 
