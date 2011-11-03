From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: print progress
Date: Thu, 3 Nov 2011 15:38:26 -0400
Message-ID: <20111103193826.GB19483@sigill.intra.peff.net>
References: <20111103033325.GA10230@sigill.intra.peff.net>
 <1320310234-11243-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 20:38:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM37T-0002Pk-PF
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 20:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243Ab1KCTib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 15:38:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32980
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab1KCTia (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 15:38:30 -0400
Received: (qmail 27485 invoked by uid 107); 3 Nov 2011 19:44:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Nov 2011 15:44:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2011 15:38:26 -0400
Content-Disposition: inline
In-Reply-To: <1320310234-11243-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184742>

On Thu, Nov 03, 2011 at 03:50:34PM +0700, Nguyen Thai Ngoc Duy wrote:

>  2011/11/3 Jeff King <peff@peff.net>:
>  > We're actually leaking some memory here, since stop_progress will also
>  > free() the progress object and any associated resources. It's not a lot,
>  > but it's kind of ugly.
> 
>  Fixed by always calling stop_progress_msg() but make sure no newline
>  is printed (actually "done\n" is not)

Thanks, that sounds reasonable, and the output looks good.

>  > Or perhaps we could even come up with a total object count
>  > before starting.  I guess it would involve mapping each pack index
>  > simultaneously, though by my reading of the code, I think we do that
>  > anyway (the opened index is cached in the pack object).
> 
>  I think this way is better because we can count two numbers at a
>  time, nr. packs and nr. objects of current pack. Total object
>  (I assume you mean of all packs) may be less informative.

Yeah, I meant all of the packs. It's a little more accurate as a
progress meter, because you don't otherwise know what's in each of the
packs. For example, if I see that we are halfway through "pack 1/2",
does that mean we are a quarter of the way done? Not really. Pack 2/2
may be much smaller or much bigger. Finishing pack 1 may make us 99%
done, or it may make us 10% done.

Showing all of the objects in a flat list gives a more accurate
representation (though it's still not entirely accurate; even one
gigantic blob may dwarf the earlier objects. But it's the best we can
do).

In practice, though, I think people tend to have one really big pack and
some small ones. And the packs are sorted in recency order, so we'll
quickly go through the early little ones, and then spend all of our time
on the big old one. Unless they have .keep files.

So I don't really care that much. But it would also make the newline
stuff go away.

> +		for (i = 1, p = packed_git; p; p = p->next, i++) {
> +			if (show_progress) {
> +				char buf[32];
> +				snprintf(buf, sizeof(buf), "Verifying pack %d/%d",
> +					 i, nr_packs);
> +				if (open_pack_index(p))
> +					continue;
> +				progress = start_progress(buf, p->num_objects);
> +			}
>  			/* verify gives error messages itself */
> +			verify_pack(p, progress);
>  
> +			if (p->next)
> +				stop_progress_msg(&progress, NULL);
> +		}
> +		stop_progress(&progress);

You start the progress in the loop, but stop the final one outside the
loop. Which means that if there are no packs, we'll call stop_progress
even though we didn't start one. I think the progress code will handle
the NULL fine, but it took me a minute to convince myself it's right.

I would find this:

  if (p->next)
          stop_progress_msg(&progress, NULL);
  else
          stop_progress(&progress);

a little more readable, or even:

  stop_progress_msg(&progress, p->next ? NULL : "done\n");

But I almost wonder if it is worth factoring out the concept of a
"progress group", where you would call it like:

  progress = progress_group_start("Checking objects in pack", nr_packs);
  for (p = packed_git; p; p = p->next) {
          progress_group_next(progress, p->num_objects);
          for (j = 0; j < num; j++) {
                  fsck_sha1(p, j);
                  display_progress(progress, j+1);
          }
  }
  stop_progress(&progress);

and progress_set_next would take care of formatting the %d/%d counter,
and would not output a newline before writing the new description line.

> +           snprintf(buf, sizeof(buf), "Checking objects on pack %d/%d",
> +                    i, nr_packs);

s/on/in/

-Peff
