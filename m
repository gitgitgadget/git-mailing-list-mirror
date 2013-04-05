From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] perl: redirect stderr to /dev/null instead of
 closing
Date: Fri, 05 Apr 2013 11:57:19 -0700
Message-ID: <7vsj34byb4.fsf@alter.siamese.dyndns.org>
References: <20130404011653.GA28492@dcvr.yhbt.net>
 <801ebb2a75d7cddfeee70eb86e8854c78d22eb3e.1365107899.git.trast@inf.ethz.ch>
 <20130405144828.GX6137@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Marcin Owsiany <marcin@owsiany.pl>
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:10:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWNF-0001b9-CV
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162498Ab3DES5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 14:57:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38565 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162494Ab3DES5W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 14:57:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E5031446B;
	Fri,  5 Apr 2013 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Se2z66msRrTbEpabKHEDMGy02Y=; b=bPECTF
	bUMcC3EFn54f9986i71TaLdgdsEIueFXuA78GgC+o6B+JRJmlMqUCHMqjcFHe80T
	SBb++4K6+quKIPdHJ7lXlOkJsvHWP6VZfe1W+5gKbxMiqjr11NaRflmM51UHZnWJ
	URwXlM+V7DJkhF7uM2rZ2n2MXc61wZ1arKOFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hw+TaPTHo9/pxackE6ig4lVWo3+Yd1FA
	z9KzkVdbL1/l3mlzeHL4Sxql0LUofZU4OR6JLKy0PpCVLO/T4PbFFy0y2caHbkpw
	xCgWKz4NYs+kW2dtMS1OsBWxlq2+VEk5XJlq9yk5L26DGezeeKNMtufciAYRogan
	uhLRzpihxKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9560D1446A;
	Fri,  5 Apr 2013 18:57:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02C8614468; Fri,  5 Apr
 2013 18:57:20 +0000 (UTC)
In-Reply-To: <20130405144828.GX6137@machine.or.cz> (Petr Baudis's message of
 "Fri, 5 Apr 2013 16:48:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A514D63E-9E22-11E2-B1BD-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220193>

Petr Baudis <pasky@ucw.cz> writes:

>> >  		} elsif ($pid == 0) {
>> > -			if (defined $opts{STDERR}) {
>> > -				close STDERR;
>> > -			}
>> >  			if ($opts{STDERR}) {
>> >  				open (STDERR, '>&', $opts{STDERR})
>> >					or die "dup failed: $!";
>> 
>> Indeed.  Thanks for pointing that out.
>
>   I'm sorry, I don't follow. Doesn't this just break the STDERR option
> altogether as we will try to dup2() over an already open file
> descriptor? We do need to close STDERR if we are going to reopen it,
> I think.

When $opts{STDERR} is 2, what the three lines the proposed patch
removes did is actively wrong, because you dup2 the fd you just
closed.

When $opts{STDERR} is 1, it seems to do the right thing with or
without the "close STDERR" in front.  Isn't this because the usual
"open($fd, <<<anything>>>) closes $fd as necessary" applies to this
case as well?

So, I am not sure what you are viewing as a problem.  Puzzled...
