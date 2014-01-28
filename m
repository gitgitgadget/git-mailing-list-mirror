From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 3/4] combine-diff: Optimize combine_diff_path sets
 intersection
Date: Tue, 28 Jan 2014 19:46:55 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140128154654.GA5925@tugrik.mns.mnsspb.ru>
References: <cover.1390234183.git.kirr@mns.spb.ru>
 <b97e63128093f6c5f5cab854b9b9487c4e6b955a.1390234183.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 28 16:45:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8Aqf-0007tr-Fj
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 16:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbaA1PpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 10:45:07 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:36826 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755005AbaA1PpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 10:45:06 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1W8AqS-0008IQ-Eh; Tue, 28 Jan 2014 19:45:00 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1W8AsJ-0001bs-1f; Tue, 28 Jan 2014 19:46:55 +0400
Content-Disposition: inline
In-Reply-To: <b97e63128093f6c5f5cab854b9b9487c4e6b955a.1390234183.git.kirr@mns.spb.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241188>

On Mon, Jan 20, 2014 at 08:20:40PM +0400, Kirill Smelkov wrote:
[...]

> @@ -1343,6 +1374,26 @@ void diff_tree_combined(const unsigned char *sha1,
>  		if (p->len)
>  			num_paths++;
>  	}
> +
> +	/* order paths according to diffcore_order */
> +	if (opt->orderfile && num_paths) {
> +		struct obj_order *o;
> +
> +		o = xmalloc(sizeof(*o) * num_paths);
> +		for (i = 0, p = paths; p; p = p->next, i++)
> +			o[i].obj = p;
> +		order_objects(opt->orderfile, path_path, o, num_paths);
> +		for (i = 0; i < num_paths - 1; i++) {
> +			p = o[i].obj;
> +			p->next = o[i+1].obj;
> +		}
> +
> +		p = o[num_paths-1].obj;
> +		p->next = NULL;
> +		paths = o[0].obj;
> +	}

I found I've introduced memory leak here (malloc without free). Please
apply the fix.  Thanks, Kirill.

---- 8< ----
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Tue, 28 Jan 2014 19:39:16 +0400
Subject: [PATCH] fixup! combine-diff: Optimize combine_diff_path sets intersection

Plug a memory leak.
---
 combine-diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/combine-diff.c b/combine-diff.c
index 07faa96..2d79312 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1383,6 +1383,7 @@ void diff_tree_combined(const unsigned char *sha1,
 		p = o[num_paths-1].obj;
 		p->next = NULL;
 		paths = o[0].obj;
+		free(o);
 	}
 
 
-- 
1.9.rc1.181.g641f458
