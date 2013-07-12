From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] open() error checking
Date: Fri, 12 Jul 2013 10:29:12 -0700
Message-ID: <7vtxjzlmaf.fsf@alter.siamese.dyndns.org>
References: <cover.1373618940.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, "Dale R. Worley" <worley@alum.mit.edu>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 12 19:29:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh9l-0003w7-OJ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133Ab3GLR3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:29:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964904Ab3GLR3P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:29:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 224552F429;
	Fri, 12 Jul 2013 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wDtIU0AFekDrN+Ou0Lgk8f8i8Qw=; b=ph24TH
	ZYl/ykpiEXVX0ayyF8jOy4jknGGwa9w8xdEbuS3rGOpd1rrVKzTVLkYBje5bMZuM
	HLCwUw6okU67HYNJwvcLijL7QR39FjJsKELhO4aABQ11SqmoCx3ixTMUbwiN5hqZ
	50VEtYx72tdNq1yBiruh8nHV2SJ/LwXhhTTnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TQkLuEgPQosBDnnAyQ1PVoXJ9eeZVcOO
	HwVazuoDXwZT9prAFoVipb/s3tCCTTbXtxkKsRORy+2bRqZPABAo52wIiHe8jIRu
	xq8Hwi+mcyMfkd9DaYKcU8BnrqT8Uf8apBXymfUVm05RBkQKbYvpkswhSDU7nGZv
	ahdDtA7Pt3E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 184682F428;
	Fri, 12 Jul 2013 17:29:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 606852F424;
	Fri, 12 Jul 2013 17:29:14 +0000 (UTC)
In-Reply-To: <cover.1373618940.git.trast@inf.ethz.ch> (Thomas Rast's message
	of "Fri, 12 Jul 2013 10:58:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 927E6254-EB18-11E2-826E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230220>

Thomas Rast <trast@inf.ethz.ch> writes:

> #1 is Dale's suggested change.  Dale, to include it we'd need your
> Signed-off-by as per Documentation/SubmittingPatches.
>
> #2 is a similar error-checking fix; I reviewed 'git grep "\bopen\b"'
> and found one case where the return value was obviously not tested.
> The corresponding Windows code path has the same problem, but I dare
> not touch it; perhaps someone from the Windows side can look into it?
>
> I originally had a four-patch series to open 0/1/2 from /dev/null, but
> then I noticed that this was shot down in 2008:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/93605/focus=93896

The way I recall the thread was not "shot down" but more like
"fizzled out without seeing a clear consensus".  As a normal POSIX
program, we do rely on fd#2 connected to an error stream, and I do
agree with the general sentiment of that old thread that it is very
wrong for warning() or die() to write to a pipe or file descriptor
we opened for some other purpose, corrupting the destination.

I briefly wondered if we can do the sanity check lazily (e.g. upon
first warning() see of fd#2 is open and otherwise die silently), but
we may open a fd (e.g. to create a new loose object) that may happen
to grab fd#2 and then it is too late for us to do anything about it,
so...

> Do you want to resurrect this?
>
> The worst part about it is that because we don't have a stderr to rely
> on, we can't simply die("stop playing mind games").

Right.
