From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -i: avoid --cherry-pick when rebasing to a
 direct ancestor
Date: Sat, 20 Feb 2010 02:27:28 -0500
Message-ID: <20100220072728.GA12168@coredump.intra.peff.net>
References: <dfb660301002191324i7aeca7f5x990501bbca1475a9@mail.gmail.com>
 <d1a75633daa062b25527dfb0675673480974c940.1266620423.git.trast@student.ethz.ch>
 <201002200102.15777.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Laine Walker-Avina <lwalkera@pasco.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 20 08:27:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nijka-0003wo-JE
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 08:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab0BTH1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 02:27:32 -0500
Received: from peff.net ([208.65.91.99]:52234 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621Ab0BTH1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 02:27:31 -0500
Received: (qmail 26727 invoked by uid 107); 20 Feb 2010 07:27:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 20 Feb 2010 02:27:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Feb 2010 02:27:28 -0500
Content-Disposition: inline
In-Reply-To: <201002200102.15777.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140518>

On Sat, Feb 20, 2010 at 01:02:15AM +0100, Thomas Rast wrote:

> > the --cherry-pick is useless since there are no commits to compare to.
> [...]
> Or maybe it's as simple as this?
> 
> diff --git i/revision.c w/revision.c
> index 438cc87..29721ec 100644
> --- i/revision.c
> +++ w/revision.c
> @@ -547,6 +547,9 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
>  			right_count++;
>  	}
>  
> +	if (!left_count || !right_count)
> +		return;
> +
>  	left_first = left_count < right_count;
>  	init_patch_ids(&ids);
>  	if (revs->diffopt.nr_paths) {

>From my reading of the code, that is right, but this is the first time I
ever looked at it, so who knows? :)

Also, I was curious whether we correctly respected gitattributes when
calculating patch ids (specifically, do we actually treat this thing as
binary). But it looks like patch-id's don't make any exceptions for
binary files, and they get fed to xdiff. I think this is not buggy (the
xdiff consumer seems to get the diff content with a length, so we are
not treating the potentially binary data as a C-string anywhere that I
see). But it is probably the source of the slowness to xdiff that
gigantic files.

Does it really make sense to treat binary files as anything other than a
blob for generating patch id? That is, should we simply turn it into:

  binary diff
  $from_sha1
  $to_sha1

and hash that for the patch id?

-Peff
