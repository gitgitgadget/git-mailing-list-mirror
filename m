From: Adrian Johnson <ajohnson@redneon.com>
Subject: Re: [PATCH] userdiff: update Ada patterns
Date: Mon, 03 Feb 2014 22:00:12 +1030
Message-ID: <52EF7DC4.8060200@redneon.com>
References: <52EE234C.1060002@redneon.com> <20140202233531.GE16196@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 03 12:30:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAHja-0001ZB-6g
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 12:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbaBCLaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 06:30:20 -0500
Received: from redneon.com ([66.221.1.90]:56756 "EHLO redneon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbaBCLaP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 06:30:15 -0500
Received: from bearcat.lan (ppp121-45-65-240.lns20.adl6.internode.on.net [121.45.65.240])
	by redneon.com (Postfix) with ESMTPA id 029E653C033A;
	Mon,  3 Feb 2014 22:00:15 +1030 (CST)
Received: from [192.168.1.1] (bearcat.lan [192.168.1.1])
	by bearcat.lan (Postfix) with ESMTP id 95DA44C590;
	Mon,  3 Feb 2014 22:00:12 +1030 (CST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140202233531.GE16196@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241424>

On 03/02/14 10:05, Jeff King wrote:
> On Sun, Feb 02, 2014 at 09:21:56PM +1030, Adrian Johnson wrote:
>> - Fix bug in word regex for numbers
>> -	 "|[0-9][-+0-9#_.eE]"
>> +	 "|[-+0-9#_.eE]+"
> 
> This makes "E" or "_" a number. Is that right?
> 
> I think the intent of the original was "starts with a digit, and then
> has one or more of these other things after it". You do not describe the
> bug, but I guess it would be that it does not match obvious things like
> "5". Should it be "zero or more" instead, like:
> 
>   [0-9][-+0-9#_.eE]*

Yes, the original was missing the '*' at the end. 

I changed it to be similar to the number regexes used by the other builtin
patterns which are of the form '[-+0-9#_.eE]+'.

> 
> ? Also, should -/+ be hoisted to the front?
> 
>   [-+]?[0-9][0-9#_.eE]*

The other builtins don't do this. But it is probably better to have
[-+]?[0-9] at the front.

> Again, I am just guessing, as I am not familiar enough with Ada.

Ada numbers have the form:

- integers and reals eg 123, 1.23, 1e-2 ('.' can not be first)
- a '_' may be used between digits to improve readability eg 123_456
- base n (2 <= n <= 16) is of the form n#digits# eg 16#FFEF#
- base n numbers can include a radix point and/or an exponent
  eg 16#FF12.8#e-2
- Ada is case insensitive

After having another look I noticed it was missing the hex characters.
The new number regex I am proposing is:

[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?

I kept exponents containing a +/- sign separate from the digits
to prevent things like '1+2' from matching. I'll send an updated patch.

> 
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
