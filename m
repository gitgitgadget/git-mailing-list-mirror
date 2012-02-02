From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] vcs-svn: Fix some compiler warnings
Date: Thu, 02 Feb 2012 18:24:15 +0000
Message-ID: <4F2AD4CF.7020303@ramsay1.demon.co.uk>
References: <4F28378F.6080108@ramsay1.demon.co.uk> <20120131192053.GC12443@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 19:38:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1Y2-0003V3-2V
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 19:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259Ab2BBSiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 13:38:13 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:48318 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932549Ab2BBSiM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 13:38:12 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Rt1Xu-0002lX-ai; Thu, 02 Feb 2012 18:38:11 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20120131192053.GC12443@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189666>

Jonathan Nieder wrote:
> Ramsay Jones wrote:
> 
>> In particular, some versions of gcc complains as follows:
>>
>>         CC vcs-svn/sliding_window.o
>>     vcs-svn/sliding_window.c: In function `check_overflow':
>>     vcs-svn/sliding_window.c:36: warning: comparison is always false \
>>         due to limited range of data type
> 
> Yuck.  Suppressing this warning would presumably also suppress the
> optimization that notices the comparison is always false.

I didn't check, but I would assume so.  I would prefer not to loose any
chance at optimizing the code, but in this case, given that we are talking
about a fatal error path, I don't think it is much of a loss.

> The -Wtype-limits warning also triggers in some other perfectly
> reasonable situations: see <http://gcc.gnu.org/PR51712>.
[...]
>> Note that the "some versions of gcc" which complain includes 3.4.4 and
>> 4.1.2, whereas gcc version 4.4.0 compiles the code without complaint.
> 
> Thanks for tracking this down.  Interesting.  -Wtype-limits was split
> out from the default set of warnings (!) in gcc 4.3 to address
> <http://gcc.gnu.org/PR12963>, among other bugs (r124875, 2007-05-20).

Thanks for the above references, and for taking the time to track them
down.

> Is there some less ugly way to write the condition "if this value is
> not representable in this type"?
> 
> I guess I could live with something like the following (please don't
> take the names too seriously):
> 
> 	static inline off_t off_t_or_die(uintmax_t val, const char *msg_if_bad)
> 	{
> 		if (val > maximum_signed_value_of_type(off_t))
> 			die("%s", msg_if_bad);
> 		return (off_t) val;
> 	}
> 
> 	...
> 
> 		off_t delta_len = off_t_or_die(len, "enormous delta");
> 		postimage_len = apply_delta(delta_len, input, ...);
> 
> What do you think?

An static inline function was actually my first thought (although I had
something more like Junio's suggestion [elsewhere in this thread] in mind),
but I didn't want to place it in git-compat-util.h and could not find a
suitable place in the vcs-svn directory.

Hmm, I will send a v2 patch along these lines ...

ATB,
Ramsay Jones
