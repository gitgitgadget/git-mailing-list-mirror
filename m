From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Sun, 07 Jul 2013 02:58:46 -0700
Message-ID: <7vk3l26695.fsf@alter.siamese.dyndns.org>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 11:58:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvlk5-0007Qq-Va
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 11:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab3GGJ6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 05:58:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436Ab3GGJ6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 05:58:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 997F2288D9;
	Sun,  7 Jul 2013 09:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4xKqCzszh42MZxYv1ZK2GGXzbgc=; b=TuTIkm
	TJdzJOdz039jdPhakFJipEbo3rAAJF2BAKY7Hp54UzJtuh3w0eRd9L+T+252e5uX
	kmCqOJ4M7QPUwvmSzZGhseQm4xuqzKXplxtTzeaAavLkUpMcGWYxt0YvssdNlwBt
	1UODMFXTYQTuO5NWVoSbFk6B3tVMmRMQwX55I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LGm8YvEs18PoGa9OOGzgti/Qjon1dr8I
	s4VEt3sDFpS12GVBBXNfm/Vtu5PxJpe/04gbtVumRgXpd9j98iIyEHhcyOR3bgs5
	e2BgUFBj9gjAOSCBDCo8QcgwXZRYDzZxO/zvl8HhES+ZGFWM/SUGWe6GjZFSdqtD
	DwEIbX2SEhg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DAB5288D8;
	Sun,  7 Jul 2013 09:58:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA2D5288D4;
	Sun,  7 Jul 2013 09:58:47 +0000 (UTC)
In-Reply-To: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Sun, 7 Jul 2013 04:45:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D16AFF8A-E6EB-11E2-92F4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229760>

Eric Sunshine <sunshine@sunshineco.com> writes:

> git-blame accepts only zero or one -L option. Clients requiring blame
> information for multiple disjoint ranges are therefore forced either to
> invoke git-blame multiple times, once for each range, or only once with
> no -L option to cover the entire file, which can be costly. Teach
> git-blame to accept multiple -L ranges.
>
> Overlapping and out-of-order ranges are accepted and handled gracefully.
> For example:
>
>   git blame -L 3,+4 -L 91,+7 -L 2,3 -L 89,100 source.c
>
> emits blame information for lines 2-6 and 89-100.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> This is RFC because it lacks documentation and test updates, and because
> I want to make sure the approach is sound and not abusive of the blame
> machinery.

Thanks.  Procrastination (and being down sick) pays off.

A few commments (without reading too deep in the patch, so do not
take any of these as complaint---if you did it the way I said "I'd
prefer", take it as a praise ;-).

 - The general concept to start from not just one but multiple blame
   entries that share the same source (and initial suspect) is the
   right way to implement multiple ranges.

 - I'd prefer to see the command parser for multiple -L options to
   ensure that they are in strictly increasing order without
   overlap.  Error out with a message if the input ranges are out of
   order or with overlap.  Doing it that way, it would be easier to
   explain to the users how "blame -L /A/,/B/ -L /C/,/D/" should
   work.  It would find the first line that matches C _after_ the
   end of the first range.  This is in line with the way we find the
   end of the range (e.g. the line that matches B) starting from the
   last line previously specified (e.g. the line that matches A).

 - I'd be somewhat unhappy to see coalesce() butchered to blindly
   accept overlapping ranges (if anything, I'd rather see it
   tightened to detect such input as a programming error), but this
   is a minor point.
