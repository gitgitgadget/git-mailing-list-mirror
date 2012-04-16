From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Tue, 17 Apr 2012 00:44:25 +0200
Message-ID: <20120416224424.GA10314@ecki>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
 <20120414121358.GA26372@ecki>
 <20120414122127.GA31220@ecki>
 <4F8C3E0F.2040300@in.waw.pl>
 <20120416174230.GA19226@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 01:04:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJuy9-000344-3D
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 01:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab2DPXEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 19:04:16 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:53847 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553Ab2DPXEP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 19:04:15 -0400
Received: from [127.0.0.1] (p5B22C2B7.dip.t-dialin.net [91.34.194.183])
	by bsmtp.bon.at (Postfix) with ESMTP id E03A613004A;
	Tue, 17 Apr 2012 01:04:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120416174230.GA19226@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195721>

On Mon, Apr 16, 2012 at 01:42:30PM -0400, Jeff King wrote:
> 
> Hmm. t5570 seems to pass reliably on dash for me with:
> 
> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> index ef2d01f..9f52cb6 100644
> --- a/t/lib-git-daemon.sh
> +++ b/t/lib-git-daemon.sh
> @@ -33,7 +33,7 @@ start_git_daemon() {
>  	{
>  		read line
>  		echo >&4 "$line"
> -		cat >&4 &
> +		cat >&4 <git_daemon_output &
>  
>  		# Check expected output
>  		if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"

Yes, me too. I can reproduce reliably with dash and the above fixes it
reliably.

> But the test above does fail.

Which one do you mean? The output check works for me.

> Is it purely luck of the timing that git-daemon never gets SIGPIPE? I
> guess the problem is that the {}-section can finish before "cat
> <git_daemon_output" has actually opened the pipe?

No clue. But shouldn't the fork return only after the fd's have been
opened successfully? If I change cat to "(echo di; cat; echo do); sleep
1; pgrep yes", then one can see that cat terminates right away, even
though yes is still running. It's as if cat never gets to read from the
pipe, but from /dev/null instead. A bug in dash?

> I'd just feel better about the solution if we were sure we understood
> the exact problem.

Yeah. I have to admit that I have a strongly empirical approach to these
things and no true understanding of the inner workings.
