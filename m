From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and
 arguments
Date: Sat, 15 Feb 2014 00:29:50 +0100 (CET)
Message-ID: <20140215.002950.97819205213642217.chriscool@tuxfamily.org>
References: <xmqqa9dxr09k.fsf@gitster.dls.corp.google.com>
	<20140214.224133.484636406629780362.chriscool@tuxfamily.org>
	<xmqqfvnlgyel.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	sunshine@sunshineco.com, dan.carpenter@oracle.com, greg@kroah.com,
	peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 15 00:30:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WESDA-00072E-2L
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 00:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbaBNXaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 18:30:16 -0500
Received: from [194.158.98.14] ([194.158.98.14]:57444 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751460AbaBNXaP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 18:30:15 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 7362674;
	Sat, 15 Feb 2014 00:29:51 +0100 (CET)
In-Reply-To: <xmqqfvnlgyel.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242159>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> For example some people might want:
>>
>>     if_exists = overwrite
>>     if_missing = add
>>
>> while others might want:
>>
>>     if_exists = overwrite
>>     if_missing = do_nothing
>>
>> and I don't see how we can say that with just:
>>
>>     action = do_Y_if_X_and_Z
> 
> Yes, but then we go back to my original question: why exists and
> missing are so special,

Because they are completely disjoint, easy to understand, and they can
avoid a lot of combinatorial explosion we would have if we used only
one "action" variable, while still providing lot of expressiveness.

They are just a good tradeoff for the special problem we have.

> and why there aren't two kinds of exists
> (i.e. "there exists an entry with the same <key, value>" vs "there
> exists an entry with the same <key>").

Because it doesn't improve expressiveness much, doesn't remove much
combinatorial explosion and make it significantly more difficult to
understand, compared to only "if_exists" and "if_missing".

> I would have understood your
> "this is not too hard to understand for users" if you had three
> (i.e. "missing", in addition to these two flavours of "exists"), but
> with only two, I do not see how it is useful in a hypothetical
> situation like above.

You mean that you do not see why:

     if_exists = overwrite
     if_missing = do_nothing

is simple and expressive?

> For example, how would you express something like this only with
> "if-exists" vs "if-missing"?
> 
> 	if_exists_exactly = ignore
>         if_exists_with_different_value = append
>         if_missng = prepend_to_the_beginning

First, previously in the discussion you said that you didn't want us
to talk about the "where = (after | before)" part, because you could
see that it was orthogonal to the other stuff, but now it looks like
you want again to put that on the table.

Then yes, it is not possible to express the above with what I
implemented. But it could be possible with only "if-exists" vs
"if-missing" like this:

	if_exists = append_if_different
	if_missing = prepend

And yes I think it is much better than:

	if_exists_exactly = ignore
	if_exists_with_different_value = append
	if_missng = prepend_to_the_beginning

because we can still easily express things like:

	if_exists = append_if_different_neighbor
	if_missing = prepend

while it would be more difficult to understand with
"if_exists_exactly", "if_exists_with_different_value" and
"if_missing".

Thanks,
Christian.
