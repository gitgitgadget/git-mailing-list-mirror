From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/22] rollback_lock_file(): set fd to -1
Date: Wed, 02 Apr 2014 09:58:15 -0700
Message-ID: <xmqqtxabwtw8.fsf@gitster.dls.corp.google.com>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
	<1396367910-7299-5-git-send-email-mhagger@alum.mit.edu>
	<20140401195930.GC21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:20:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeSU-0000xS-7N
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbaDBQ6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 12:58:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932442AbaDBQ6S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 12:58:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38B4977AD2;
	Wed,  2 Apr 2014 12:58:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oEnGDrJC6TEkCDyLY63Q9YcLIIM=; b=TO4qsB
	+ByiZHY2Eh4wqOswHlBJP6N/sdQtCzv+tGhL5FGmd5wQLVUg4dvJpAsplRGweED7
	LnvkAoN3MJ/ee68HY9idBiWGVpJOpR1ZTTxJFke9wp1QBfCpGFBGCj+16MYMgL6z
	5Y0YT7AKsmr2Rr4cxTLdF6Bx3JC5EmG0f5MEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P/Im1UcJg0wXQFlK4/DJVAPmZeoTO1lK
	XLujvYrRiA8LhAv5NeKE6BGIcIE5SAD/XoTsSCj2M7rZ00uXWfnwuFxVeXWQBDCS
	Iq+b6O0DCtFdGwEyjxo378WYStmOfv/pyJ1HNucbw3aI2oRNQzfBuOhCMVPalJq7
	6IpsKdlWnrY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2982577AD0;
	Wed,  2 Apr 2014 12:58:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71B7877ACC;
	Wed,  2 Apr 2014 12:58:17 -0400 (EDT)
In-Reply-To: <20140401195930.GC21715@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Apr 2014 15:59:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FCBBE0C6-BA87-11E3-B0F6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245712>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 01, 2014 at 05:58:12PM +0200, Michael Haggerty wrote:
>
>> When rolling back the lockfile, call close_lock_file() so that the
>> lock_file's fd field gets set back to -1.  This could help prevent
>> confusion in the face of hypothetical future programming errors.
>
> This also solves a race. We could be in the middle of rollback_lock_file
> when we get a signal, and double-close. It's probably not a big deal,
> though, since nobody could have opened a new descriptor in the interim
> that got the same number (so the second close will just fail silently).
>
> Still, this seems like a definite improvement.

This is probably related to my comments on 2/22, but is "fd" the
only thing that has a non-zero safe value?  Perhaps lock_file_init()
that clears the structure fields to 0/NULL and fd to -1, and a
convenience function lock_file_alloc() that does xmalloc() and then
calls lock_file_init() may help us a bit when the lockfile structure
is reused?
