From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] remote-curl: sanity check ref advertisement from
 server
Date: Sun, 17 Feb 2013 03:05:34 -0800
Message-ID: <20130217110533.GF6759@elie.Belkin>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064929.GC22626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 17 12:06:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U724Z-0004pg-Ac
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 12:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab3BQLFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 06:05:41 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:59158 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891Ab3BQLFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 06:05:40 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so1223352pbb.34
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 03:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=rQVnGY80bD1NS0dWSqBk55TK2ql9XEhEdy69yREp72k=;
        b=QGnYQxbf5GljOfCnU2HoRaQFvmGZCIP9tSAnqM/1tY3YGQ95XgC4pzKDOWVaDkY6qv
         mYj53d8WBI24ydvYVYap+y3ZpruxgS16mazbx/7E/5RNapUhHxef4lmtwnagojUnwI8K
         CglSPrJn9q8IPhU7YdCI3x5r2jVI/9555OnWZNJlKiPi/l5vkuuSy35coF5sIvIsJLAL
         y3ltjB8oFsS9WA1Jb/4e02A7A6mFNwQDJPALJxMHvdRqQoxuF7PruujsjU15NsmJn3/n
         6O0X7fuBeXQy5VOx7Q7mGKMUw/uxDxhwF2l7dQxhnaa1W/cxl0WzOKsLfFbT1VSUBm5U
         Ik3A==
X-Received: by 10.66.252.38 with SMTP id zp6mr17320955pac.12.1361099139864;
        Sun, 17 Feb 2013 03:05:39 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id in5sm10848603pbc.20.2013.02.17.03.05.37
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Feb 2013 03:05:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130216064929.GC22626@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216389>

Jeff King wrote:

> If the smart HTTP response from the server is truncated for
> any reason, we will get an incomplete ref advertisement. If
> we then feed this incomplete list to "fetch-pack", one of a
> few things may happen:
>
>   1. If the truncation is in a packet header, fetch-pack
>      will notice the bogus line and complain.
>
>   2. If the truncation is inside a packet, fetch-pack will
>      keep waiting for us to send the rest of the packet,
>      which we never will.

Mostly harmless since the operator could hit ^C, but still unpleasant.

[...]
> This fortunately doesn't happen in the normal fetching
> workflow, because git-fetch first uses the "list" command,
> which feeds the refs to get_remote_heads, which does notice
> the error. However, you can trigger it by sending a direct
> "fetch" to the remote-curl helper.

Ah.  Would a test for this make sense?

[...]
> --- a/remote-curl.c
> +++ b/remote-curl.c
[...]
> @@ -174,6 +183,9 @@ static struct discovery* discover_refs(const char *service)
>  			die("smart-http metadata lines are invalid at %s",
>  			    refs_url);
>  
> +		if (verify_ref_advertisement(last->buf, last->len) < 0)
> +			die("ref advertisement is invalid at %s", refs_url);

Won't this error out with

	protocol error: bad line length character: ERR

instead of the current more helpful behavior for ERR lines?

Same stylistic comment about "what would it mean for the return value
to be positive?" as in patch 2/3.

Aside from those two details, the idea looks sane, though.  Good
catch, and thanks for a pleasant read.

Good night,
Jonathan
