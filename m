From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Combine diff improvements
Date: Thu, 14 Mar 2013 22:54:22 -0700
Message-ID: <7vboalw6lt.fsf@alter.siamese.dyndns.org>
References: <CALWbr2zY3uo==QTd69t1eXNS4-CX1w3T-AaMjOLVmxj-SMJyvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 06:54:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGNbT-0006FK-K3
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 06:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab3COFyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 01:54:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab3COFyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 01:54:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B9168926;
	Fri, 15 Mar 2013 01:54:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xt+TFNTOpW9oW0Fkk8t473X9Hs4=; b=adiO0t
	4QjgGJMPZ06eaHaWgS3TpD/WjqOyL6/VUZ8RKeL6YyvRJDuxu7Z7jhZAY13TSQa5
	Ap7koFe5mo7FLBH0NgNyGsQ4KL03MniTVfK61UrYuIZh/vOlBbgcuR241rH8JRgf
	5/jX+T3I2hiVveuKMJt5IJl5pIsAlYszBKD8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xTyR6K45tRqB+Jx4D07F2Me4hIV9+Ibo
	zyE7m+Mk+UHz76Fg034W441qxXPXtTZFx0Qyd2/o0PHqGcaY5/aGQLVvxWZ90uXH
	d+chwF+JVYBHElu8whnRrY7ZtuDE12zgmWFveBMW/9AAufsDUEfzIQ4i1Z9gzOrh
	+Hcu7uEfDWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E3718925;
	Fri, 15 Mar 2013 01:54:24 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7FB48923; Fri, 15 Mar 2013
 01:54:23 -0400 (EDT)
In-Reply-To: <CALWbr2zY3uo==QTd69t1eXNS4-CX1w3T-AaMjOLVmxj-SMJyvg@mail.gmail.com> (Antoine
 Pelisse's message of "Thu, 14 Mar 2013 23:32:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9BCFFA6-8D34-11E2-802D-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218186>

Antoine Pelisse <apelisse@gmail.com> writes:

> While if we invert the two parents order we will have:
> - 3
> --1
> --2
> - 4
>  -3
>  -4
>
> While clearly, in both cases, the optimal solution would be close to:
> - 3
> --1
> --2
>  -3
> --4

We should shoot for better readability as the primary goal.  When I
am viewing "--cc" output, I find it easier to read if the lines for
the same parent are consecutive.  That is, I find the right one far
easier to grok than the left one:

     - 1                - 1
      -2                - 3
     - 3                 -2
      -4                 -4

when trying to see what got changed from the first parent (we had 1
and then 3 and whatever comes after this block; 2 and 4 are noise
and it makes it easier to skip them because they are together).

This can probably be done as a post-process phase after you find the
coalescing matches to express the result in the smallest number of
lines, but I thought it is worth mentioning that not all solutions
with the same number of lines are equally good.
