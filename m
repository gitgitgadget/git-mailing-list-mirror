From: Junio C Hamano <gitster@pobox.com>
Subject: Re: expanding pack idx fanout table
Date: Mon, 08 Jul 2013 10:37:09 -0700
Message-ID: <7vsizpymuy.fsf@alter.siamese.dyndns.org>
References: <CAJo=hJsto1ik=GTC8c3+2_jBuUqcAPL0UWp-1uoYYMpgbLB+qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 08 19:37:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwFNG-0000SM-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 19:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373Ab3GHRhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 13:37:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60887 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171Ab3GHRhL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 13:37:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00A5E2C14E;
	Mon,  8 Jul 2013 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UiRdT9STIJNT8frpryaw9pQeNJc=; b=GU7Tbh
	z+FGwWk4kRwAfBnz7fhyY07Z1/rEJT9SQ7X1zJlYtF61DPVcSCnfOpIZ633xe6DT
	AF89D3HSOUxiArJgDiw1HJ+x588VmX0Lg3WOoH67lysn/xOjqiepjbCTc4EhqvXf
	QN/2JRYhy6MWCQd1bOLimQhQCizqb8Ak3K+Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AJlr87y0rpppOuOx2pEL+2wknw55tvk1
	j+MHhYh9p3P2B5Do4b5WOeL5tNTAlN+e82KYF6XWucigTEzrcbOm0fOhdLy+U9bY
	xTzGiiF6Buf5f9G0uVqLF2/rdX3/3WZZa9H5uqNva09mPILdtA2D4hYVZNOV/x71
	cawrsb1IbWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBC182C14D;
	Mon,  8 Jul 2013 17:37:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 716052C14A;
	Mon,  8 Jul 2013 17:37:10 +0000 (UTC)
In-Reply-To: <CAJo=hJsto1ik=GTC8c3+2_jBuUqcAPL0UWp-1uoYYMpgbLB+qg@mail.gmail.com>
	(Shawn Pearce's message of "Mon, 8 Jul 2013 08:54:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0499FB4A-E7F5-11E2-94A0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229880>

Shawn Pearce <spearce@spearce.org> writes:

> Has anyone studied the impact of converting the pack idx fanout table
> from 256 entries to 65536 entries?
>
> Back of the envelope estimates for 3.1M objects in linux.git suggests
> a 2^16 fanout table would decrease the number of binary search
> iterations from ~14 to ~6. The increased table costs an extra 255 KiB
> of disk. On a 70M idx file this is noise.
>
> I'm starting to wonder if increasing the fanout table once the object
> count is above a certain threshold is a reasonable optimization for
> larger repositories.

Yeah, and I do not think we have to be worried too much about
backward compatibility for .idx files, as they are local and can be
regenerated if an older version cannot read it.

I also wonder if we can generate a finer-grained fan-out table on
the fly, perhaps lazily, without changing the on-disk format ;-)
