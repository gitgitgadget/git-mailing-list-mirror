From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH 15/19] tree-diff: no need to call "full" diff_tree_sha1
 from show_path()
Date: Thu, 27 Mar 2014 18:21:29 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140327142129.GA17333@mini.zxlink>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <7e5e5a381ba4204eac14c5be9e270ffdc0e2be7a.1393257006.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 15:18:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTB8N-0003r6-UT
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 15:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473AbaC0OSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 10:18:15 -0400
Received: from forward8.mail.yandex.net ([77.88.61.38]:39246 "EHLO
	forward8.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239AbaC0OSO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 10:18:14 -0400
Received: from smtp7.mail.yandex.net (smtp7.mail.yandex.net [77.88.61.55])
	by forward8.mail.yandex.net (Yandex) with ESMTP id D9720F60FA5;
	Thu, 27 Mar 2014 18:18:10 +0400 (MSK)
Received: from smtp7.mail.yandex.net (localhost [127.0.0.1])
	by smtp7.mail.yandex.net (Yandex) with ESMTP id 70B7515808F3;
	Thu, 27 Mar 2014 18:18:10 +0400 (MSK)
Received: from unknown (unknown [93.185.17.156])
	by smtp7.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id rCZL9zqaxw-I72mxWhR;
	Thu, 27 Mar 2014 18:18:08 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 0e0ea198-711c-4907-8d9f-5fd0a867159d
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WTBBS-0005U3-12; Thu, 27 Mar 2014 18:21:30 +0400
Content-Disposition: inline
In-Reply-To: <7e5e5a381ba4204eac14c5be9e270ffdc0e2be7a.1393257006.git.kirr@mns.spb.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245278>

On Mon, Feb 24, 2014 at 08:21:47PM +0400, Kirill Smelkov wrote:
> As described in previous commit, when recursing into sub-trees, we can
> use lower-level tree walker, since its interface is now sha1 based.
> 
> The change is ok, because diff_tree_sha1() only invokes
> __diff_tree_sha1(), and also, if base is empty, try_to_follow_renames().
> But base is not empty here, as we have added a path and '/' before
> recursing.
> 
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
> ( re-posting without change )
> 
>  tree-diff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tree-diff.c b/tree-diff.c
> index f90acf5..aea0297 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -114,8 +114,8 @@ static void show_path(struct strbuf *base, struct diff_options *opt,
>  
>  	if (recurse) {
>  		strbuf_addch(base, '/');
> -		diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
> -			       t2 ? t2->entry.sha1 : NULL, base->buf, opt);
> +		__diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
> +				 t2 ? t2->entry.sha1 : NULL, base->buf, opt);
>  	}
>  
>  	strbuf_setlen(base, old_baselen);

I've found this does not compile as I've forgot to add __diff_tree_sha1
prototype, and also we are changing naming for __diff_tree_sha1() to
ll_diff_tree_sha1() to follow Git coding style for consistency and
corrections to previous patch, so here goes v2:

(please keep author email)
---- 8< ----
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Mon, 24 Feb 2014 20:21:47 +0400
Subject: [PATCH v2] tree-diff: no need to call "full" diff_tree_sha1 from show_path()

As described in previous commit, when recursing into sub-trees, we can
use lower-level tree walker, since its interface is now sha1 based.

The change is ok, because diff_tree_sha1() only invokes
ll_diff_tree_sha1(), and also, if base is empty, try_to_follow_renames().
But base is not empty here, as we have added a path and '/' before
recursing.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---

Changes since v1:

 - adjust to renaming __diff_tree_sha1 -> ll_diff_tree_sha1;
 - added ll_diff_tree_sha1 prototype as the function is defined below
   here-introduced call-site.

 tree-diff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 1d02e43..7fbb022 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -6,6 +6,10 @@
 #include "diffcore.h"
 #include "tree.h"
 
+
+static int ll_diff_tree_sha1(const unsigned char *old, const unsigned char *new,
+			     const char *base_str, struct diff_options *opt);
+
 /*
  * Compare two tree entries, taking into account only path/S_ISDIR(mode),
  * but not their sha1's.
@@ -118,8 +122,8 @@ static void show_path(struct strbuf *base, struct diff_options *opt,
 
 	if (recurse) {
 		strbuf_addch(base, '/');
-		diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
-			       t2 ? t2->entry.sha1 : NULL, base->buf, opt);
+		ll_diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
+				  t2 ? t2->entry.sha1 : NULL, base->buf, opt);
 	}
 
 	strbuf_setlen(base, old_baselen);
-- 
1.9.rc0.143.g6fd479e
