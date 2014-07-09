From: Junio C Hamano <gitster@pobox.com>
Subject: Re: move detection doesnt take filename into account
Date: Wed, 09 Jul 2014 08:51:07 -0700
Message-ID: <xmqqegxu7cpg.fsf@gitster.dls.corp.google.com>
References: <53B105DA.30004@gmail.com>
	<287177519.16421.1404206204124.JavaMail.zimbra@dewire.com>
	<xmqqtx71xh27.fsf@gitster.dls.corp.google.com>
	<53B2CE4A.9060509@gmail.com>
	<xmqq61jhxb0g.fsf@gitster.dls.corp.google.com>
	<20140709064521.GA14682@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elliot Wolk <elliot.wolk@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 17:51:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4u9Q-00013q-51
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 17:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbaGIPvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 11:51:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55633 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498AbaGIPvP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 11:51:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D20EF26C34;
	Wed,  9 Jul 2014 11:50:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=drJt/qmv56jsbVoVuImq81LKloc=; b=jIrNs5
	2szE56JVoZHmIC+onPNtRj/k3L8iJbSqQ85Suk0edDA4QV0KBiuGUoRmIUHULYVi
	NSvqnKL2tFhX4qAFcym0Kaq32ggRNIAoAShNJeD5BI1imA6HW/oocrSu0Z26VrCV
	rf63h9Dahq7pQHF7IAp+u1lRorNb1Kt5nuGBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BPGor4ZdFfvflLQqx1B7xclM7wuq/6O5
	XVTEbUilLaL5U7ta+Tmi13YTeaxypWc3MLEJicmQfxCR2tKaLqWfMFfd7AI3C00r
	HWQsRCvJfuCXYJUoH28UCZFsaZGxE+Cs8b9B3g/yA1ciZ6E0dSaVz6pCv/5AWDsj
	CR7ZClx6KP0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6BD326C33;
	Wed,  9 Jul 2014 11:50:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 71ED426C24;
	Wed,  9 Jul 2014 11:50:54 -0400 (EDT)
In-Reply-To: <20140709064521.GA14682@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 9 Jul 2014 02:45:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF66FE3A-0780-11E4-81E9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253131>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 01, 2014 at 10:08:15AM -0700, Junio C Hamano wrote:
>
>> I didn't think it through but my gut feeling is that we could change
>> the name similarity score to be the length of the tail part that
>> matches (e.g. 1.a to a/2.a that has the same two bytes at the tail
>> is a better match than to a/2.b that does not share any tail, and to
>> a/1.a that shares the three bytes at the tail is an even better
>> match).
>
> The delta heuristics in pack-objects use pack_name_hash, which claims:
>
>         /*
>          * This effectively just creates a sortable number from the
>          * last sixteen non-whitespace characters. Last characters
>          * count "most", so things that end in ".c" sort together.
>          */
>
> which might be another option (and seems like a superset of the basename
> check, short of basenames that are longer than 16 characters).

Perhaps.

I am however not sure if the code to compute similarity score is as
OK with false positives, i.e. dissimilar names that happen to hash
together getting clumped in a same bin or in close bins, as the
existing callers of pack_name_hash().
