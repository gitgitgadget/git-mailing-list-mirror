From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] refs.c: enable large transactions
Date: Sat, 25 Apr 2015 01:24:27 -0400
Message-ID: <20150425052427.GA20653@peff.net>
References: <1429738227-2985-1-git-send-email-sbeller@google.com>
 <xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYO9NifvWQ7nWHP6==ZFmrMj47-94rEHOhWooR5Nh7EUw@mail.gmail.com>
 <xmqq8udi2tn8.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYGDOUgzKmQOLAXkYYb-HZJCw3Y=iSLXWHVXcQ0pAiDBw@mail.gmail.com>
 <20150424181236.GK5467@google.com>
 <20150424201734.GA4747@peff.net>
 <xmqqzj5w25vv.fsf@gitster.dls.corp.google.com>
 <20150425050058.GA20256@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 07:24:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlsZv-0001Uh-7g
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 07:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbbDYFYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 01:24:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:49983 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752786AbbDYFYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 01:24:30 -0400
Received: (qmail 22714 invoked by uid 102); 25 Apr 2015 05:24:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Apr 2015 00:24:30 -0500
Received: (qmail 22730 invoked by uid 107); 25 Apr 2015 05:24:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Apr 2015 01:24:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Apr 2015 01:24:27 -0400
Content-Disposition: inline
In-Reply-To: <20150425050058.GA20256@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267773>

On Sat, Apr 25, 2015 at 01:00:58AM -0400, Jeff King wrote:

> A better solution to what I proposed earlier is perhaps:
> 
>   git config alias.debug '!gdb --quiet \
> 	    -ex "break exit" \
> 	    -ex "run" \
> 	    -ex "bt full" \
> 	    -ex "continue" \
> 	    -ex "quit" \
> 	    --args git \
>   '
>   git debug rev-parse foobar
> 
> It has the minor irritation that gdb will control the process stdio
> (slurping from stdin and polluting stdout, whereas we would prefer no
> input and output to stderr). There might be a way to convince gdb to do
> otherwise, or you could probably go pretty far with some shell fd
> redirects and using "set args" inside gdb. Or maybe something with
> gdbserver.

Just to extend the thought exercise, here is something marginally less
horrible. Save as "git-debug" in your PATH and chmod +x.

-- >8 --
#!/bin/sh

if ! type gdb >/dev/null 2>&1; then
	echo >&2 "Sorry, you don't seem to have gdb installed."
	exit 1
fi

args=
for i in "$@"; do
	args="$args '$(printf '%s' "$i" | sed "s/'/'\\\\''/")'"
done

gdb --quiet \
	-ex "set args $args <&7 >&8 2>&9" 7<&0 8>&1 9>&2 </dev/null >&2 \
	-ex 'break exit' \
	-ex 'run' \
	-ex 'bt full' \
	-ex 'continue' \
	-ex 'quit' \
	git
-- 8< --

It's still rather hard to use with sub-programs started by git (e.g.,
the upload-pack spawned by a fetch), but I think it would work for many
simple cases. I'm not sure if I would use it myself. As somebody
confident in using gdb, my next step after seeing the backtrace would be
to start poking around interactively. Besides the stdio magic, this is
not really buying me much beyond running gdb myself.

-Peff
