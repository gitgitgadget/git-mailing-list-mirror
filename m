From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Replace memcpy with hashcpy when dealing hash copy globally
Date: Wed, 05 Mar 2014 13:48:29 -0800
Message-ID: <xmqqfvmwfhaq.fsf@gitster.dls.corp.google.com>
References: <1393839599-6955-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:48:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLJg9-0000L2-TJ
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 22:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbaCEVsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 16:48:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbaCEVse (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 16:48:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B2AB702B9;
	Wed,  5 Mar 2014 16:48:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=75yYZMrVOSKPhmSQl6zmi4evmPA=; b=xVwoJu
	VDHUCKZ+ZT+wCJMvkSbpdRbj1EO94/9BeerqQmRz+QT2Je3OBXs3BfsVsEgxjMrL
	Uv9Q4KBP+8+CW91P34o+4pNSvRM1n9uarkWj1iZd9uySJ0RMlGMPUFExtbGkWXgw
	H79iYvsBdKEWexS78LA7gkQtB4g1SvVZWCzeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U3C2uzo2FRT1XcYK7pxUF9ff/WHgy+ah
	nWZHQ+x+OaCuWXAYT8cHyxIszJ8QToMHw7khw9WRCkFrU8AOUaeWaVhnKcBsZDuD
	EyEdOUhrz2YV2bOpr9qVCozn5/kdnrew9vQ8ffBDRCyeAHNlS4M22IfzqUb0yr9o
	g4QITnW13VE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FABD702B8;
	Wed,  5 Mar 2014 16:48:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 976CF702B6;
	Wed,  5 Mar 2014 16:48:32 -0500 (EST)
In-Reply-To: <1393839599-6955-1-git-send-email-sunheehnus@gmail.com> (Sun He's
	message of "Mon, 3 Mar 2014 17:39:59 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E568B964-A4AF-11E3-8E96-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243484>

Sun He <sunheehnus@gmail.com> writes:

> Replacing memcpy with hashcpy is more directly and elegant.

Can we justify the change without being subjective?

> Leave ppc/sha1.c alone, as it is an isolated component.
> Pull cache.h(actually ../cache.h) in just for one memcpy
> there is not proper.

That is not the reason why that memcpy of 20-byte must stay as it
is.  If for whatever reason we later choose to switch to using
another hash function, say MD5, to come up with the object names,
the majority of memcpy(..., 20) must change to copy 16 bytes, and it
makes sense to contain that implementation-specific knowledge of
twenty behind the hashcpy() abstraction.  The 20-byte memcpy() call
in ppc/sha1.c, however, is an implementation of *THE* SHA-1
algorithm, whose output is and will always be 20-byte.  It will not
change when we decide to replace what hash function is used to name
our objects (which would result in updating the implementation of
hashcpy()).  That is the reason why you shouldn't touch that one.
It has to be explicitly 20 byte, without ever getting affected by
what length our hashcpy() may choose to copy.

Perhaps...

	We invented hashcpy() to keep the abstraction of "object
	name" behind it.  Use it instead of calling memcpy() with
	hard-coded 20-byte length when moving object names between
        pieces of memory.

	Leave ppc/sha1.c as-is, because the function *is* about
	*the* SHA-1 hash algorithm whose output is and will always
	be 20-byte.

or something.

> Find the potential places with memcpy by the bash command:
>  $ find . | xargs grep "memcpy.*\(.*20.*\)"

If you are planning to hack on git, learn how to use it first ;-)

    $ git grep 'memcpy.*, 20)'
