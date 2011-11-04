From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] fsck: print progress
Date: Fri, 4 Nov 2011 16:14:16 -0400
Message-ID: <20111104201416.GA26591@sigill.intra.peff.net>
References: <1320421670-518-1-git-send-email-pclouds@gmail.com>
 <1320421670-518-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 21:14:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMQ9g-0000uP-1d
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 21:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038Ab1KDUOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 16:14:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33638
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916Ab1KDUOS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 16:14:18 -0400
Received: (qmail 5199 invoked by uid 107); 4 Nov 2011 20:14:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Nov 2011 16:14:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2011 16:14:16 -0400
Content-Disposition: inline
In-Reply-To: <1320421670-518-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184801>

On Fri, Nov 04, 2011 at 10:47:50PM +0700, Nguyen Thai Ngoc Duy wrote:

>  static int traverse_reachable(void)
>  {
> +	struct progress *progress = NULL;
> +	unsigned int nr = 0;
>  	int result = 0;
> +	if (show_progress)
> +		progress = start_progress_delay("Checking connectivity", 0, 0, 2);
>  	while (pending.nr) {
>  		struct object_array_entry *entry;
>  		struct object *obj;
> @@ -146,7 +152,9 @@ static int traverse_reachable(void)
>  		entry = pending.objects + --pending.nr;
>  		obj = entry->item;
>  		result |= traverse_one_object(obj);
> +		display_progress(progress, ++nr);
>  	}
> +	stop_progress(&progress);
>  	return !!result;
>  }

Thanks, this is a good place to put a progress meter, too. If you're
feeling like pushing this topic further, "git prune" might be a good
place for a progress meter, too. It does a similar traversal[1] for
reachability, and makes "git gc" appear to hang at the end (we have nice
progress meters for packing, but it takes something like 25 seconds to
run "git prune" at the end, during which we are silent).

-Peff

[1] I wonder why fsck doesn't use mark_reachable from reachable.c.
