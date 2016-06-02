From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Wed, 01 Jun 2016 22:46:04 -0700
Message-ID: <xmqqy46ouorn.fsf@gitster.mtv.corp.google.com>
References: <20160601235233.21040-1-sbeller@google.com>
	<574F800D.6070107@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, pclouds@gmail.com,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 07:46:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8LSV-0003T1-P7
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 07:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbcFBFqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 01:46:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750731AbcFBFqI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 01:46:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8456222E1F;
	Thu,  2 Jun 2016 01:46:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GPHTngBpfOaP3WZs1cBlSBgyY5E=; b=k3+r+L
	JJAAaWyvhWKg8VCKd+4+BKYsk/UxMS7/JSd0MmVf+ItH6fKzBIU8bH0EAKt5JmaW
	7pBaD71AtCxUboSPDu5bZDToct27vnSPz5A/mku3eleIZx3D0LPUu/WhLqkxd5Bx
	K4+HWiB6t1I+yCTzKJBQVfDvL1zHPeeATZmX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sDIeWBImggl7hCUb1u8NvSB+j6Qtg5Ex
	Cpd3539sr2laYR+0xQRvTfQtDkNgVQUfmhgAW+KqOYMGnSLYqP8psr9hePz7BAXh
	gKQYoCoWrEtpyptbOSmhVtnExIvI6SOfWFozU5urAu6jTj+Hy/kc/KuSLnW/R2s4
	C3dhBMqXJwM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D6E422E1E;
	Thu,  2 Jun 2016 01:46:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B7C122E1D;
	Thu,  2 Jun 2016 01:46:06 -0400 (EDT)
In-Reply-To: <574F800D.6070107@ramsayjones.plus.com> (Ramsay Jones's message
	of "Thu, 2 Jun 2016 01:38:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C897C5E-2885-11E6-B237-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296187>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Not having given this much thought at all, but the question which comes
> to mind is: can you use some other separator for the <attr>-s rather than
> a comma? That way you don't need to quote them in the <value> part of the
> <attr>-spec.
>
> (I dunno, maybe use ; or : instead?)

There are two kinds of comma involved in this discussion.

 * Multiple pathspec magic can be attached to augment the way
   <pattern> selects paths. ":(<magic1>,<magic2>,...)<pattern>" is
   the syntax, and <magicN> are things like "icase" (select the path
   that matches <pattern> case-insensitively), "top" (<pattern> must
   match from the top level of the working tree, even when you are
   running the command from a subdirectory).  We added a new kind of
   <magic> whose syntax is "attr:VAR=VAL" recently, which says "not
   only <pattern> must match the path, in order to be selected, the
   path must have the attribute VAR with value VAL".

   The comma that separates multiple magic is not something you can
   change now; it has been with us since v1.7.6 (Jun 2011)

 * My example wanted to use the attr:VAR=VAL form to select those
   paths that has one specific string as the value for whitespace
   attribute, i.e. VAR in this case is "whitespace".  The value for
   whitespace attribute determines what kind of whitespace anomalies
   are considered as errors by "git apply" and "git diff", and it is
   formed by concatenating things like "indent-with-non-tab" (starts
   a line with more than 8 consecutive SPs), "space-before-tab" (a
   SP appears immediately before HT in the indent), etc., with a
   comma in between.

   The comma that separates various kinds of whitespace errors is
   not something you can change now; it has been with us since
   v1.5.4 (Feb 2008).

So using different separator is not a viable solution.
