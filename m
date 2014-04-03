From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] git-send-email: two new options: to-cover, cc-cover
Date: Thu, 03 Apr 2014 11:31:51 -0700
Message-ID: <xmqqa9c2qn6w.fsf@gitster.dls.corp.google.com>
References: <1396548814-27278-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 20:32:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVmQi-0002Cx-HE
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 20:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbaDCSb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 14:31:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186AbaDCSbz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 14:31:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A7497AAE9;
	Thu,  3 Apr 2014 14:31:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M4UM7qdY1/K4RP7dHwmYaq80R+s=; b=pdcZlP
	JIgWLC/liwnP/rkgHN2Av29TDAw30kJ2FdvbWaWvCkc7tkRGifhPNr40FObCa+yy
	XuJeGfCM66csSGOKKa00rw0G3/to6fn92a4OFl0RrGlHPqF6GTlXWgCoPGTH8/5y
	QF4ucIorzTR+NCVbawTsHmDEpbw/i+7Qn9FQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CnEc19JQGlWjJWm1tRQzAztmhZ4jjUsz
	7Y1/zUacHMIFg6SPT0qlQcXbwbgrpYqtPmIcNeuqc6/LVjgFTeh2AD8o9yH9t+tS
	1klMhSqlCZeDZCwmTfdFJyMzf2t9fP6juuw9woCd3IRuyW9RlVdglGryvIzBsaxs
	eWrv2O8Boe4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75E487AAE8;
	Thu,  3 Apr 2014 14:31:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B6217AAE0;
	Thu,  3 Apr 2014 14:31:53 -0400 (EDT)
In-Reply-To: <1396548814-27278-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 3 Apr 2014 21:14:08 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3A86EB0E-BB5E-11E3-B902-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245747>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Allow extracting To/Cc addresses from cover letter.

Please say what you are doing with what you extract, which is the
more important part of the objective.  Extracting is merely a step
to achieve that.

s/.$/, to be used as To/Cc addresses of the remainder of the series./

or something.


I think this will be a very handy feature.

If you have a series *and* you bothered to add To/Cc to the cover
letter, it is likely that you want all the messages read by these
people [*1*].

> @@ -1468,6 +1475,15 @@ foreach my $t (@files) {
>  	@to = (@initial_to, @to);
>  	@cc = (@initial_cc, @cc);
>  
> +	if ($message_num == 1) {
> +		if (defined $cover_cc and $cover_cc) {
> +			@initial_cc = @cc;
> +		}
> +		if (defined $cover_to and $cover_to) {
> +			@initial_to = @to;
> +		}
> +	}
> +

What is stored away with this code to @initial_cc/to includes:

 - what was given to @initial_cc/to before ll.1468-1469
 - what was in @cc/to before ll.1468-1469

when we see the first message [*2*].  The former come from the
command line --to/--cc, and the latter comes from the header lines
of the first message.  Am I reading the code correctly?

If that is the case, I think the updated code makes sense.

Thanks.


[Footnote]

*1* Allowing this to be disabled is also a good thing this patch
    does.  A 100 patch series that does a tree-wide clean-up may
    have different set of people on To/Cc of individual patches, and
    you may want the union of them on To/Cc on the cover letter, so
    that a person may get the cover letter and a single patch that
    relates to his area of expertise without having to see the
    remainder.

*2* The first message may not necessarily be the cover letter.  Is
    there a reliable way to detect that?  The user may want to send
    out a series with only a few patches without any cover, and
    taking To/Cc from the [PATCH 1/3] and propagating them to the
    rest does not match what the documentation and the option name
    claim to do.
