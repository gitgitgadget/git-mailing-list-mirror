From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bisect working only from toplevel dir
Date: Wed, 23 Nov 2011 12:45:18 -0800
Message-ID: <7vzkfma7q9.fsf@alter.siamese.dyndns.org>
References: <20111123145034.GB17927@angband.pl>
 <7vd3cibqqe.fsf@alter.siamese.dyndns.org>
 <20111123192329.GA21630@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Borowski <kilobyte@angband.pl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 23 21:45:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTJh9-0004O9-85
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 21:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab1KWUpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 15:45:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120Ab1KWUpV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 15:45:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F856D32;
	Wed, 23 Nov 2011 15:45:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KtFAYhqxCFE6n96K14E6hj8dWcA=; b=axtJT/
	57QUlB/Q/xim7H/LWfn7SL+ot5oDFPkBEqWBmRSAgDpAjG6SXqJrmispaprZ0c57
	pdwK4mpLFcK33PPB2a7OdhJoZ6KqJgZ66RxtDx8mYzFi3EfUr6CTgeswMTCKR/21
	MAeq5cxVIRg1z6oew6o0BsoCtlixplobAyJQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cPp0H3fJaoK1Wv/PfMYo9cuQYHgVDrYp
	C1O6xbddy628+cP6aQqnfZ1yTuROUHgKMmLuos+zQF+Tf6/z0Y1S9jQkLbGyC2Hh
	TGfqV4k2ZH2PUwWhmlWkKirKJ3zvQ6St7wCwU52ABW08UQRHpjcHCJDkqDHVI/h6
	cv80h9aDdlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC7126D31;
	Wed, 23 Nov 2011 15:45:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F7B36D30; Wed, 23 Nov 2011
 15:45:19 -0500 (EST)
In-Reply-To: <20111123192329.GA21630@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 23 Nov 2011 14:23:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EC48126-1614-11E1-B317-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185872>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 23, 2011 at 11:09:29AM -0800, Junio C Hamano wrote:
>
>> As to the approach, I suspect that it would be far better if it made
>> workable with cd_to_toplevel at the beginning, instead of saying
>> SUBDIRECTORY_OK.
>> 
>> After all, the current directory may disappear during the course of
>> bisection, upon checking out a revision that did not have the directory
>> you started your bisection from.
>
> But from what directory would you expect:
>
>   git bisect run make

My usual way to enlighten somebody is by forcing him/her to think the
consequences, but because you did the thinking for the OP in this thread
instead, it didn't work. Makes me somewhat sad ;-<.

> If we cd_to_toplevel, we can remember the prefix that we started from
> and cd to it before running the user's command, but there is no
> guarantee that it actually exists. Maybe that commit should be
> considered indeterminate then?

Yeah that sounds like a reasonable thing to do.

> I dunno. I haven't thought that hard about it. But I don't think it's
> quite as simple as just telling bisect it's OK to run from a subdir.

Absolutely. Saying SUBDIRECTORY_OK without thinking about the consequence
through is a good discussion starter but is not a good patch.

Also didn't we make bisect workable in a bare repository recently? So the
start-up sequence has to be something more elaborate like...

        . git-sh-setup
        if we are in a bare repository
        then
         	: we are happy...nothing funky needs to be done
	elif we are not in a working tree
		barf
	elif we are not at the top
        	prefix=$(git rev-parse --show-prefix)
		cd_to_toplevel
	fi

and then inside bisect_next() you would check if $prefix exists, and go
there to run bisect--helper (or fail to go there and say "cannot test").
