From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool: Skip autoresolved paths
Date: Fri, 20 Aug 2010 10:57:50 +0100
Message-ID: <4C6E519E.1080700@hashpling.org>
References: <7veie0gy3r.fsf@alter.siamese.dyndns.org> <1282036966-26799-1-git-send-email-davvid@gmail.com> <201008191202.36508.trast@student.ethz.ch> <20100820035236.GA18267@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?TWFnbnVzIELDpGNr?= <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 12:07:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOVl-0000IP-Sk
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763Ab0HTKHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 06:07:39 -0400
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:42576 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467Ab0HTKHh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:07:37 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2010 06:07:37 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAErubUxUXebr/2dsb2JhbACDGJ1EcahUkhWBIoMicwQ
Received: from outmx07.plus.net ([84.93.230.235])
  by relay.pcl-ipout01.plus.net with ESMTP; 20 Aug 2010 10:57:47 +0100
Received: from hashpling.plus.com ([212.159.69.125])
	 by outmx07.plus.net with esmtp (Exim) id 1OmOM7-0004R3-2Q; Fri, 20 Aug 2010 10:57:47 +0100
Received: from heisenberg2.hashpling.org ([192.168.76.29])
	by hashpling.plus.com with esmtps (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1OmOM6-0001jE-1v; Fri, 20 Aug 2010 10:57:46 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <20100820035236.GA18267@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153993>

On 20/08/2010 04:52, David Aguilar wrote:
>
> git-mergetool lines 295-307:
>
>      files_to_merge |
>      while IFS= read i
>      do
> 	if test $last_status -ne 0; then
> 	    prompt_after_failed_merge<  /dev/tty || exit 1
> 	fi
> 	printf "\n"
> 	merge_file "$i"<  /dev/tty>  /dev/tty
> 	last_status=$?
> 	if test $last_status -ne 0; then
> 	    rollup_status=1
> 	fi
>      done
>
> The reason the test fails without a tty is that we've never
> exercised this code in the past.
>
> This commit did not introduce the "<  /dev/tty>  /dev/tty"
> idiom.  It was introduced in b0169d84 by Charles Bailey.
> What this commit did do was add test coverage to it,
> which is good because it uncovered this problem :-)
>
> Charles, is there another way we can write this?
> Is there a reason why we need the tty redirection?
> Can we drop it or is there a portability concern?
>
> FWIW, the merge_file call in the else clause that follows
> this section does not use tty redirection.
>

Actually, it's been like this since c4b4a5af which is when mergetool was 
introduced.

(b0169d84 didn't change this line, 0eea3451 but made only whitespace 
changes, it comes from the original mergetool code.)

When you say "drop it" what are you proposing to replace it with? We're 
in the middle of a shell pipe which has replaced stdin and merge_file 
needs access to the human on it's stdin; hence the </dev/tty. Strictly. 
I believe that the >/dev/tty isn't needed.

Is there some way of juggling file descriptors in shell? I had a quick 
play with this but suspect it's a bashism (and it might make mergetool 
less readable!).

echo hidden | { echo lost | cat 0<&3- ; } 3<&0

mergetool has never really been very approachable for automatic testing 
as it's fundamentally an interactive script. It would be nice if 
sufficient of the guts of mergetool were in testable library code and 
mergetool was just an obviously correct slim shell UI.

merge_file in the 'else' doesn't need the redirection as nobody has 
redirected the original stdin.

Charles.
