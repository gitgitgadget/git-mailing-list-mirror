From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make xmalloc and xrealloc thread-safe
Date: Wed, 24 Mar 2010 14:11:41 -0700
Message-ID: <7veij95ss2.fsf@alter.siamese.dyndns.org>
References: <20100323173114.GB4218@fredrik-laptop>
 <20100323184309.GA31668@spearce.org>
 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <20100324202814.GA24830@spearce.org>
 <alpine.LFD.2.00.1003241656010.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Mar 24 22:12:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuXrx-0005U1-Mp
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 22:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642Ab0CXVL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 17:11:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab0CXVL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 17:11:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8910FA5C14;
	Wed, 24 Mar 2010 17:11:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qN6VH/TgozLcRuWafvNmPowt62o=; b=kd8Kjh
	HuVmnM8XV3N5rFpEXc2aF42pVGmyuu3uySbex/QcZRQze45/oBjELaAhXFFCl1v3
	AAJELGNtgjzd28mddJfFofJMwMrDUE42O55qldRZfTZsmJhEJKdQQ89PyUW2TPsx
	6duZNuagKsjN5SW52p5YpdTa25cNQ9x6F/rCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AOY6xbRip6fPa20IjVdTYQ5VoogG6SDP
	oZvklwLOXMksEg/T2Qrkkk4HjyLGxjn4BJCvwZkdkmKe+ttTiyYVG4vcUsO0UI3U
	UxEh3PWUjNTcRTSyIuB2hvbBcgE23u16Hp3zW/nh4qk4o+9XJeolA7+yWYUCSTYJ
	qXP+VbkBd38=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CC21A5C0F;
	Wed, 24 Mar 2010 17:11:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEECCA5C06; Wed, 24 Mar
 2010 17:11:42 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1003241656010.694@xanadu.home> (Nicolas Pitre's
 message of "Wed\, 24 Mar 2010 17\:02\:15 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DC3EE594-3789-11DF-90A2-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143127>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Wed, 24 Mar 2010, Shawn O. Pearce wrote:
>
>> Nicolas Pitre <nico@fluxnic.net> wrote:
>> > Note: there was a dubious usage of fd when calling release_pack_memory() 
>> > in xmmap() which is now removed.
>> ...
>> > @@ -100,7 +112,7 @@ void *xmmap(void *start, size_t length,
>> >  	if (ret == MAP_FAILED) {
>> >  		if (!length)
>> >  			return NULL;
>> > -		release_pack_memory(length, fd);
>> > +		try_to_free_routine(length);
>> 
>> This isn't dubious!  The fd passed here is to prevent the pack
>> release code from closing this fd right before we try to mmap it.
>> Its an actual bug fix that I had to write years ago, check the
>> history of that section of code...  :-)
>
> Argh.  My bad.  I somehow thought that fd was the actual pack to free 
> when specified.  Let's drop the very last hunk of the patch then.  
> xmmap() is certainly not going to be invoked concurrently to the rest of 
> sha1_file.c in a separate thread.
>
> Junio: I suppose you don't need me to resend?

Will just drop the last hunk.  Thanks, both.
