From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat() functions
Date: Thu, 18 Jul 2013 10:43:53 -0700
Message-ID: <7v8v134vc6.fsf@alter.siamese.dyndns.org>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk>
	<51E2CE97.2040900@gmail.com> <51E5BCDF.5070004@ramsay1.demon.co.uk>
	<51E5D38E.6080202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 19:44:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzsFF-0003UQ-8q
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759274Ab3GRRn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:43:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758954Ab3GRRn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:43:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4880C32D54;
	Thu, 18 Jul 2013 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0nYmDbhCUsz0uxzRnLMhRTG6nNg=; b=l1irnZ
	MQB4uY4R8RnZwEMBpBAjR+Yj8trP9wWuDHiys42lsnAeU20Qwh94rq08fz9tE0lf
	1f4dnM4X75xBOm1Ajdl8FzczAjvQJQ5D8OBUjsK/GWC8MK4Ojc3jVEhq52c8LIr2
	7iK5l8kIscD/rb2kaY19q0fwJ4fC//i+gQIBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NDEq9rnPifRpXYX2TICFFYrg0iJpSmOK
	jTLjbvXiSLfymlcIFZXmIGwkiZQ3ZX8RJr0aeOya06byoprAyPJBkVkim3Uf2lDl
	IulWKVKkoTxFKFgB+ajEAiJbdlezfUe6le2n/THQpdQfpuZPDI6iX3M/QIhmEfas
	Oc0E9JSdAas=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EC5C32D53;
	Thu, 18 Jul 2013 17:43:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90DEF32D52;
	Thu, 18 Jul 2013 17:43:54 +0000 (UTC)
In-Reply-To: <51E5D38E.6080202@gmail.com> (Mark Levedahl's message of "Tue, 16
	Jul 2013 19:13:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DAA2C72-EFD1-11E2-B88D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230712>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Cygwin 1.7 is very different than the earlier, no longer supported,
> and no longer available Cygwin variants in many ways, but stat is one
> of them. Cygwin 1.7 uses Windows ACLs to represent file permissions,
> and therefore gets the file permissions directly from the underlying
> OS calls. Earlier Cygwin versions (attempted to) overlay POSIX
> permissions on Windows systems using extended attributes and other
> means, and in many cases had to resort to opening the file and
> examining it to determine executability. This is not true in 1.7.
>
> Therefore, your later patch would be expected to have much less
> benefit for 1.7 than for 1.5 (I don't detect *any* benefit on 1.7 when
> I set core.filemode=false). There are many choices, three are:
>
> a) Remove the win32 stat funcs, eliminating all of the troublesome
> code paths and maintenance burden (your original patch).
> b) Add your latest patch, with attendant complexity and maintenance
> burden, to support a version of Cygwin that is no longer available and
> was last updated over four years ago.
> c) Like b, except make this triggered only by a "CYGWIN_15" macro,
> limiting this to use by the legacy cygwin platform.

Let's do (a) in a single patch, then.

People who do want to keep running older Cygwin installation they
already have can revert the removal and rebuild Git, but the number
of people who have to do so will become only smaller over time if
older Cygwin versions are no longer available.

I presume that we _could_ add a CYGWIN_15 macro that conditionally
keeps the win32 lstat implementation and get_st_mode_bits() part,
and that might make it easier for folks with older Cygwin
installations, but I am not sure if it is worth it.

> I strongly vote for a, could support c, but fear b is just going to
> keep us chasing down bugs. Especially so when we consider that this
> patch can only speed things up when core.filemode=false, which mode:
> a) causes git to fail its test suite.
> b) breaks compatibility with Linux
> c) violates the primary goal of the Cygwin project, which is to
> provide a Linux environment on Windows.
