From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] reachable.c: add HEAD to reachability starting commits
Date: Sun, 31 Aug 2014 11:28:06 -0400
Message-ID: <20140831152806.GC17449@peff.net>
References: <1409432315-20803-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 17:28:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XO737-0007Rs-Qy
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 17:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbaHaP2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 11:28:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:41897 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751671AbaHaP2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 11:28:07 -0400
Received: (qmail 16160 invoked by uid 102); 31 Aug 2014 15:28:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 31 Aug 2014 10:28:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Aug 2014 11:28:06 -0400
Content-Disposition: inline
In-Reply-To: <1409432315-20803-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256290>

On Sat, Aug 30, 2014 at 11:58:35PM +0300, Max Kirillov wrote:

> HEAD is not explicitly used as a starting commit for
> calculating reachability, so if it's detached and reflogs
> are disabled it may be pruned.

Eek, you're right. I think nobody noticed because the HEAD reflog
usually picks it up (and you do not usually detach HEAD on a bare repo).
But I agree we should include it to cover this case.

> diff --git a/reachable.c b/reachable.c
> index 654a8c5..6f6835b 100644
> --- a/reachable.c
> +++ b/reachable.c
> @@ -229,6 +229,9 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
>  	/* Add all external refs */
>  	for_each_ref(add_one_ref, revs);
>  
> +	/* detached HEAD is not included in the list above */
> +	head_ref(add_one_ref, revs);
> +
>  	/* Add all reflog info */
>  	if (mark_reflog)
>  		for_each_reflog(add_one_reflog, revs);

Looks obviously correct.

> diff --git a/t/t5312-prune-detached.sh b/t/t5312-prune-detached.sh
> new file mode 100755
> index 0000000..fac93e1
> --- /dev/null
> +++ b/t/t5312-prune-detached.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +
> +test_description='no prune detached head without reflog'
> +. ./test-lib.sh
> +
> +test_expect_success 'make repo' '
> +	git config core.logAllRefUpdates false
> +	git commit --allow-empty -m commit1 &&
> +	git commit --allow-empty -m commit2 &&
> +	git checkout  --detach master &&
> +	git commit --allow-empty -m commit3
> +'
> +
> +test_expect_success 'prune does not delete anything' '
> +	git prune -n >prune_actual &&
> +	: >prune_expected &&
> +	test_cmp prune_expected prune_actual'
> +
> +test_done

Your test looks reasonable, but is there any reason it cannot go in
t5304 with the other prune tests?

-Peff
