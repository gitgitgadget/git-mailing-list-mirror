From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Thu, 26 Jul 2012 10:46:01 -0700
Message-ID: <7vehny8lgm.fsf@alter.siamese.dyndns.org>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <50092993.6010203@alum.mit.edu> <20120720154403.GB2862@sigill.intra.peff.net>
 <5009892E.9010808@kdbg.org> <20120720170913.GA14057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Alexey Muranov <alexey.muranov@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 19:46:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuS8a-0003d3-Fy
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 19:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab2GZRqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 13:46:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab2GZRqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 13:46:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E08E48BEE;
	Thu, 26 Jul 2012 13:46:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5yZtmC7ix4i+B93ZaSJAJ+WkcEc=; b=QY5sNu
	e3s8HmdQ33qvKAMJ7/ZhudiJFwKf1rfNOhrNiYiBfuQm9DfrS3Eu1WOBeAs4x9X/
	gRqY4+igu4U68NVWBjAeLiu8MCtH1+tKiaClyebT/Tgvv0ZdzadT2xaStGuTMEKo
	IIs36HJfw2nBJLmI6jvNh6RAXwlI3LwdJwWcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FWzitteraaudPTfa0E54sFFozfxIMwCH
	EIXoqBeCcTuyoBfAlc+c03zdOZKs8Gq+4d4uGC1uNqGi77id6UljPotcRkmOSqbG
	KJdF+T4R1HqoY8EbZsOKLV3ET0GZanfh1pB5VQirat4VM53mSW1KS6TG+uBpQx7A
	gydHKS9l08I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD4A78BED;
	Thu, 26 Jul 2012 13:46:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F2CC8BEC; Thu, 26 Jul 2012
 13:46:02 -0400 (EDT)
In-Reply-To: <20120720170913.GA14057@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 20 Jul 2012 13:09:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C47A5D28-D749-11E1-9C6D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202284>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 20, 2012 at 06:37:02PM +0200, Johannes Sixt wrote:
>
>> Am 20.07.2012 17:44, schrieb Jeff King:
>> > So I think a suffix like ":d" is probably the least horrible.
>> 
>> Not so. It does not work on Windows :-( in the expected way. Trying to
>> open a file with a colon-separated suffix either opens a resource fork
>> on NTFS or fails with "invalid path".
>
> Bleh. It seems that we did too good a job in coming up with a list of
> disallowed ref characters; they really are things you don't want in your
> filenames at all. :)

Why do no need to even worry about ~ vs : vs whatever in the first
place?

With a flag-day per repository "core.repositoryformatversion = 1",
you do not have to worry about mixture of old-style refs and new
ones, so refs/heads/next-d/log could be a topic branch 'next/log'
that is based on an integration branch 'next' branch that physically
resides at refs/heads/next-f or an entry refs/heads/next in packed
refs.  Only the API functions in refs.c should care, no?
