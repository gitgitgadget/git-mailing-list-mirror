From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 13:48:49 -0800
Message-ID: <7vmyc8rhry.fsf@gitster.siamese.dyndns.org>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com>
 <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
 <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 22:50:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lco7r-0002hY-Ke
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 22:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbZBZVtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 16:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbZBZVtB
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 16:49:01 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbZBZVs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 16:48:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 801759D57F;
	Thu, 26 Feb 2009 16:48:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1F07A9D57C; Thu,
 26 Feb 2009 16:48:50 -0500 (EST)
In-Reply-To: <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com> (Jay
 Soffian's message of "Thu, 26 Feb 2009 15:43:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 43DA7962-044F-11DE-B795-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111601>

Jay Soffian <jaysoffian@gmail.com> writes:

>>> +x1="[a-z0-9]"
>>
>> Why [a-z0-9] not [0-9a-f]?
>
> No reason. It's just what popped out of my head.
>
>> I'd rather see the basic BRE grep used if you are shooting for
>> portability.
>>
>> There are some oddballs in the source (git-submodule.sh is a notable
>> offender) but none of the core-ish scripts uses egrep nor "grep -E".
>
> Sigh, I just wanted the test to pass. I did a check to see if any
> other tests were already using egrep, and when I found that they were,
> I thought that would be good enough.
>
> Originally I had switched to perl. Would you prefer:

Not really.  

If we are fixing it we should do it right.  The regexp you inherited seem
somewhat suboptimal, too.

"(?:PUT|MOVE) .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+" 20\d"

 - It has a double-quote. can it be anywhere or only at the beginning (if
   so "^" is missing at the beginning -- I didn't check)?

 - We then expect PUT or MOVE; Ok (that's "\(PUT\|MOVE\)").

 - We then expect one space and one or more garbage before we see
   "objects/"; do we really care if it is one-or-more garbage, or is it
   zero-or-more garbage?  Don't we want to see slash before "objects/" (I
   think we do)?

 - Then we expect objects/ and two hexdigits that should be spelled as
   [0-9a-f]{2} or [0-9a-f][0-9a-f] (or $x2).

 - Then we expect / and thiry-eight hexdigits, underscore and then 40
   hexdigits (I think your $x38 and $x40 are fine);

 - Then we expect exactly one SP followed by HTTP/ (Ok);

 - And version can be one-or-more of [0-9.]; do we really allow
   HTTP/..999?, or we don't care?  I think we shouldn't care, and in that
   case I think [.0-9]* is good enough here;

So perhaps define a variable:

good="\"\(PUT\|MOVE\) .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*" 20[0-9]\""

and grep for it?
