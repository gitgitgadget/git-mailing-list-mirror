From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] repack: accept larger window-memory and
 max-pack-size
Date: Wed, 22 Jan 2014 20:06:42 -0500
Message-ID: <20140123010642.GB17254@sigill.intra.peff.net>
References: <1390420685-18449-1-git-send-email-gitster@pobox.com>
 <1390420685-18449-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 02:07:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W68lD-0007Zc-Uq
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 02:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbaAWBGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 20:06:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:37215 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751276AbaAWBGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 20:06:44 -0500
Received: (qmail 4535 invoked by uid 102); 23 Jan 2014 01:06:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Jan 2014 19:06:44 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jan 2014 20:06:42 -0500
Content-Disposition: inline
In-Reply-To: <1390420685-18449-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240887>

On Wed, Jan 22, 2014 at 11:58:05AM -0800, Junio C Hamano wrote:

> These quantities can be larger than an int.  Use ulong to express
> them like the underlying pack-objects does, and also parse them with
> the human-friendly unit suffixes.

Hrm. I think that is a valid strategy, but...

> -	int max_pack_size = 0;
> +	unsigned long max_pack_size = 0, window_memory = 0;

Here we must use the correct C type...

> -		OPT_INTEGER(0, "window-memory", &window_memory,
> +		OPT_HUM_ULONG(0, "window-memory", &window_memory,

And here use the correct parser...

>  	if (window_memory)
> -		argv_array_pushf(&cmd_args, "--window-memory=%u", window_memory);
> +		argv_array_pushf(&cmd_args, "--window-memory=%lu", window_memory);

And here use the correct format string...

All of which must match what pack-objects does, or we risk a further
break (though I do not guess it will change from ulong anytime soon).
The original shell version worked because they were all strings. We do
not care about the numeric value here, and are just forwarding the value
along to pack-objects. Why not just use a string?

The only advantage I can think of is that this gives us slightly earlier
error detection for "git repack --window-memory=bogosity".

But I think there is a subtle problem. Here (and elsewhere) we use the
parsed value of "0" as a sentinel. I think that is OK for
--max-pack-size, where "0" is not a reasonable value. But git-repack(1)
says:

  --window-memory=0 makes memory usage unlimited, which is the default.

What does:

  git config pack.windowMemory 256m
  git repack --window-memory=0

do? It should override the config, but I think it does not with your
patch (nor with the current code). Using a string would fix that (though
you could also fix it by using a different sentinel, like ULONG_MAX).

>  	if (max_pack_size)
> -		argv_array_pushf(&cmd_args, "--max_pack_size=%u", max_pack_size);
> +		argv_array_pushf(&cmd_args, "--max_pack_size=%lu", max_pack_size);

These underscores are interesting:

  $ git pack-objects --max_pack_size=256m
  error: unknown option `max_pack_size=256m'

I get the feeling the test suite does not cover this feature very well.
:)

-Peff
