From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Thu, 16 Aug 2012 14:51:21 -0700
Message-ID: <7vvcgizesm.fsf@alter.siamese.dyndns.org>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
 <20120702215736.GA5790@sigill.intra.peff.net> <m2vci5n5r5.fsf@igel.home>
 <20120703032345.GA7143@sigill.intra.peff.net>
 <CACsJy8AmCo82YxHA_6+rkbuJOjOG-HqCgjoP2tz753SXH5w8_Q@mail.gmail.com>
 <20120703051426.GA12965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 16 23:51:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T27yX-0000w1-2u
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 23:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745Ab2HPVv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 17:51:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064Ab2HPVvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 17:51:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E262990D;
	Thu, 16 Aug 2012 17:51:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nq6RTW7+1UT2BAB9A+z+fCEzfYg=; b=hOdAJ+
	TR6m1k7R5rWLCPVQv19QLgjXg5uehKI3x0JrSbY8KBHBL7X4VISZPtU1tkoI5cpC
	rpfSbddonJFu0gNazUtUJuekiH5P90HhycyFJ7wIMaNkBvSBL5K3g7wU7h2X8RVz
	xsbXBQADgPIAnGUKf6BWCY1AZMrl/Y06Xr5vE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BWPudZMkPxngVnuojgKR1BH3bPUJkuA2
	7vrZtGVu4VGtE4pC4G2Ujj5Hc7HyrJRp2ROQqBGIYVRzL0m52y0TAM1DGNFQ3Gi5
	aimnkeN3xMowDt72dWz3AC2R5BXVCne56GkTvxOcSqgiwW+gkJxoLk1PM/iKuPCL
	ceFBgoRvouI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C2BF990C;
	Thu, 16 Aug 2012 17:51:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79DEE9909; Thu, 16 Aug 2012
 17:51:23 -0400 (EDT)
In-Reply-To: <20120703051426.GA12965@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Jul 2012 01:14:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8573D146-E7EC-11E1-984D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jul 03, 2012 at 11:25:16AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Tue, Jul 3, 2012 at 10:45 AM, Jeff King <peff@peff.net> wrote:
>> > On Tue, Jul 03, 2012 at 12:43:42AM +0200, Andreas Schwab wrote:
>> >
>> >> Jeff King <peff@peff.net> writes:
>> >>
>> >> > It's very odd for pread to report ENOENT (since it is always operating
>> >> > on an already-opened file descriptor).
>> >>
>> >> It doesn't, but gettext will clobber errno:
>> >>
>> >>               n = pread(pack_fd, inbuf, n, from);
>> >>               if (n < 0)
>> >>                       die_errno(_("cannot pread pack file"));
>> >>
>> >> There is nothing that saves errno.  This isn't limited to i18n though,
>> >> any function call in the arguments may potentially clobber errno.
>> >
>> > That's horribly lame of gettext. I don't expect arbitrary functions to
>> > save errno, but when the entire purpose of a function is to be a
>> > non-intrusive wrapper to massage messages to the user, it seems kind of
>> > evil to overwrite errno. Isn't the whole point of calling it "_" that
>> > you don't want to or have to notice it?
>> 
>> Agreed.
>
> Hmm. According to gettext(3):
>
>   ERRORS
>          errno is not modified.
>
> And googling for "gettext" and "errno" reveals several bugfixes in GNU
> gettext to make sure that gettext preserves errno. I wonder if there are
> systems where that is not the case, though; I don't know what non-GNU
> gettext implementations are in common use these days. I'd still be
> curious to hear what platform the server is for this bug report.

Hrm, has this ever been resolved?
