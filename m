From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] strbuf_getwholeline: use getc_unlocked
Date: Sun, 05 Apr 2015 13:09:24 -0700
Message-ID: <xmqq4moue3rf.fsf@gitster.dls.corp.google.com>
References: <20150405010611.GA15901@peff.net>
	<20150405011110.GC30127@peff.net> <20150405045614.GA12053@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:09:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeqrM-0008Ui-5z
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 22:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbbDEUJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 16:09:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752010AbbDEUJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 16:09:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E08AD455FF;
	Sun,  5 Apr 2015 16:09:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ITD83zRphVhshIAvdZHshQwyUU=; b=b32PyB
	tBi1wmlV30bAKtLLLUeIG+aHbjTFOe/yPVwhkglPvuN250PZAOTr5lByvmmfpers
	B6Wm86Lj9UdIq1GMP2JOlwF7UMu6UgsXjS7weljw7BgibDd1WO7p9jV8YL7u4zKr
	8DXbsTnT9zN8ke48ceYF0d6v1aPAMgzxUF/uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BiKG3JYEN/IvJmWWK3BTyyEax9PZMZxS
	ZnDrF8p45FjsaNYd7XIosS2lePcDCHep2D48DytWLAsJ4mCUL5cbYYahEj/f8PCM
	07+XKS30OLfgNEz6A5BdYDFh68bXtEr9LS91ILyEUTAff6CEiZqksfVm4i6nlqyG
	z4woNSiao9k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7BA7455FE;
	Sun,  5 Apr 2015 16:09:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5003F455FB;
	Sun,  5 Apr 2015 16:09:25 -0400 (EDT)
In-Reply-To: <20150405045614.GA12053@peff.net> (Jeff King's message of "Sun, 5
	Apr 2015 00:56:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A82151E4-DBCF-11E4-9D2A-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266817>

Jeff King <peff@peff.net> writes:

> So we'd have to either:
>
>   1. Decide that doesn't matter.
>
>   2. Have callers specify a "damn the NULs, I want it fast" flag.

The callers that used to call fgets and then later rewritten to
strbuf_getwholeline(), either of the above obviously should be OK,
and because the whole reason why we added strbuf_getline() interface
was to avoid having to repeatedly call fgets() and concatenate the
result if the fixed-size buffer we would give it is too small, I'd
say the callers that want to read lines terminated by LF and have NUL
as part of payload would be a tiny minority.

It depends on what we would find out after auditing all callers of
this function, but I would not be surprised if we decided #1 (i.e.
"this is about a _line_; what are you doing by having a NUL on
it?"), and the safest would be to do the inverse of #2, i.e. make it
fast by default and make oddball callers that care about NULs to
pass a flag.

Thanks for working on this.
