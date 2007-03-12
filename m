From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/6] Fix some "printf format" warnings.
Date: Mon, 12 Mar 2007 12:40:14 -0700
Message-ID: <7vfy8as129.fsf@assigned-by-dhcp.cox.net>
References: <45E9BE46.1020801@ramsay1.demon.co.uk>
	<7v4pp29eok.fsf@assigned-by-dhcp.cox.net>
	<45EAFD21.6010002@ramsay1.demon.co.uk> <45F55DC5.8060702@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:40:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqNi-000408-Ew
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbXCLTk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbXCLTk0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:40:26 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48593 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbXCLTkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:40:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070312194024.TCHJ748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Mar 2007 15:40:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZvgN1W00D1kojtg0000000; Mon, 12 Mar 2007 15:40:24 -0400
In-Reply-To: <45F55DC5.8060702@fs.ei.tum.de> (Simon Schubert's message of
	"Mon, 12 Mar 2007 15:03:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42067>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

> Ramsay Jones wrote:
>>>> -        printf("%s%06o %s %d\t",
>>>> +        printf("%s%06lo %s %d\t",
>>>>                 tag,
>>>>                 ntohl(ce->ce_mode),
>>> I think we should do this instead:
>>>
>>>     printf("%s%06o %s %d\t", tag, (unsigned) ntohl(ce->ce_mode), ...
>>
>> Oops, yes you are right.
>> (cygwin typedef's uint32_t as unsigned long.)
>>
>> However, I would hate to add all those casts! Casts are not always
>> evil, but should be avoided if possible. Having said that, I don't
>> see another solution ...
>
> shouldn't it be something like this?
>
> printf("%s%06"PRIo32" %s %d\t", tag, ntohl(ce->ce_mode), ...)
>
> that's the correct and allegedly portable way I guess.

Yes, except that that is only portable across platforms with
inttypes.h, and we would need a compatibility definition in
git-compat-util.h next to PRIuMAX definition we already have.

But I wonder if this is really worth it.  The thing is,

    printf("%s%06o %s %d\t", tag, (unsigned) ntohl(ce->ce_mode), ...

is perfectly readable for even old timers about git, as long as
they know traditional C and what ntohl() is.  And ce->ce_mode
even fits in 16-bit, so while we are _not_ supporting platforms
whose unsigned int is 16-bit, the above cast is not losing any
useful precision either.
