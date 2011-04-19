From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/9] sparse: Fix errors due to missing target-specific
 variables
Date: Tue, 19 Apr 2011 11:18:25 -0700
Message-ID: <7vbp025clq.fsf@alter.siamese.dyndns.org>
References: <4DADC729.5060705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:18:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCFVd-000245-GD
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 20:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085Ab1DSSSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 14:18:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab1DSSSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 14:18:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F7F64B35;
	Tue, 19 Apr 2011 14:20:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6o8C5lGurw/sz3wgsNvH58+ynZU=; b=FiQhtS
	RVX2hK9ppHRW0Wms96UDxLT1Wz0VDqCNz1ScTdWBYmK/0NIiw29yogNvWCj6fOQx
	BVfugVqa8DD30wBIPnxwdrW5O1kwvDgtvxKBTwHnS2VVkDHK16qQftj2jo7HdCWO
	ZyhUo0rYfrUrSDozJkQcVF52ivO+FGIoSdMtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IjT3z4VNjA4WeuqXfpPM3nHPysAW2+tT
	WXXHh95aQpgP+yQB0fJ8mpNbicG14aoDA0rjNmirn8E2D3cSxqwt2h9xQWE0KdE1
	2+5hJZWNPhY1++sD2iZO3QLumXyGguCrnV/w5hUsuv94+ICTNgWqrJEjw1BO607C
	etL5Ag/wVNc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F07754B31;
	Tue, 19 Apr 2011 14:20:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BA8304B2F; Tue, 19 Apr 2011
 14:20:28 -0400 (EDT)
In-Reply-To: <4DADC729.5060705@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 19 Apr 2011 18:32:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6C1BE66-6AB1-11E0-A69B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171807>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> I decided not to mark the $(SP_OBJ) as .PHONY targets; after some
> testing, it seems that it is not necessary, even if users do
> something like:
>     make git.sp 2>git.sp
> Do you know of any advantages to doing so that I have missed?

The info documentation on GNU make states two reasons to use .PHONY.

One is to avoid existing file (e.g. git.sp in the above) to interfere
(especially when the target itself does not have a listed dependency), and
the other is that .PHONY tells make that it does not have to spend cycles
to consider implicit rules.

> -help.o: common-cmds.h
> +help.sp help.o: common-cmds.h

I am not sure if you even want any dependency listed for any %.sp target
to begin with. If sparse _were_ a normal build target, it would be sensible
to change the rule for sparse to create/update %.sp files, perhaps even
like this:

> +%.sp: %.c GIT-CFLAGS FORCE
	rm -f $@+ $@
> +	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
> +		$(SPARSE_FLAGS) $< 2>&1 >$@+
	mv $@+ $@

so that once you run sparse on help.c, unless you touch help.c or do
something to cause common-cmds.h to be updated, you do not have to
run the same thing again whose outcome you have already seen.

BUT. That is obviously not what we want.

In the case of sparse, you *do* want it to be run every time the user says
"make sparse", even when you already know you would get exactly the same
result from the previous run.

The situation is exactly the same as "make clean"; it runs even when it is
run immediately after another "make clean".

So why list any dependency?  If it is sensible to treat "sparse" target
just like "clean" target, it would make sense not to give it any
dependencies and mark it as .PHONY, no?
