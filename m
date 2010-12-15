From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] make open/unlink failures user friendly on
 windows using retry/abort
Date: Wed, 15 Dec 2010 12:45:09 -0800
Message-ID: <7vmxo6pxyi.fsf@alter.siamese.dyndns.org>
References: <20101214220604.GA4084@sandbox>
 <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 15 21:45:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSyEA-0001oW-UD
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 21:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab0LOUp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 15:45:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab0LOUp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 15:45:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 049512040;
	Wed, 15 Dec 2010 15:45:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+bY2lZikenN13Y0lj9LFL9AxXjM=; b=FGP6HX
	0J2MHtbQGSTalinmv2xPmj8a/nwNIawOxwtiboKjZG/niVrEP/7SQCjC+deDWSoj
	zvOvVNMmU8RjyH1gX4MkAEIpG9/+iWOMHl0jjYy54sZ4lvUKr8P8+jFZl2W2Fpxt
	52behFdMe0GWtaBGGwcFAtsGF8VOxuwdWisRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fOc1jVH/aQLCM6/v+pCESFeuAROf0Aqc
	TIl4TLUlBhaS1XAb5mwtJIOA9dawutoz3kVoExjOWUg84zieTHWVSPf1ARtjTlCQ
	OkBs+E36Af3yxlqHrcKjMSkR23VI/U/WhTEU7nB80PyPBJEXye0BNVI0Ucnc1tXX
	F1rTwidWK4M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 904DD203E;
	Wed, 15 Dec 2010 15:45:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6329B2039; Wed, 15 Dec 2010
 15:45:38 -0500 (EST)
In-Reply-To: <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com>
 (Erik Faye-Lund's message of "Wed\, 15 Dec 2010 16\:52\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4AD8502A-088C-11E0-9613-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163790>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Perhaps instead we would be better of with something like an xunlink
> (etc) in wrapper.c that deals with this on all platforms (and make
> sure that unlink sets errno to EBUSY correctly if it doesn't already)?

That is superficially similar to the way we let xread() silently handle
short read to give us an easier to use API.  Especially, the part to
silently retry for a few times is similar to xread() recovering by
repeating short reads.

I do not think "ask the user one last time" part belongs to such a
wrapper, though.
