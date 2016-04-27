From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bisect limited to Merge Commits
Date: Wed, 27 Apr 2016 15:25:36 -0700
Message-ID: <xmqqk2ji7kpr.fsf@gitster.mtv.corp.google.com>
References: <20160427204551.GB4613@virgo.localdomain>
	<xmqq8tzy93ed.fsf@gitster.mtv.corp.google.com>
	<57213041.5070506@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Hagen Paul Pfeifer <hagen@jauu.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:25:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avXtw-0002ME-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 00:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbcD0WZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 18:25:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751731AbcD0WZk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 18:25:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C39816492;
	Wed, 27 Apr 2016 18:25:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FbHvsd5HUnpDSCorIV/Ist+lt30=; b=rGcpc3
	Gr+4ZQwYJvKS4/9A8az2CBqVDSm/QG6KLnuK1YhOJFTM12zSiirJ2KuqRy9CNiYp
	75P3jh5Gh591u90fw5MUgbA5ma7sLDcTxM3IaUIYJAZhyT7WzHEO1dRI+UiJjQPH
	CUIPGaMLYVB2X5ZBo/cU27HEYlcbQ4iSXsCCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CGqdqfNoTiaiEo7E2335M+ZV2S5UfFS3
	c5r9QlK4zk2lhqYXdtQUIcB2w9MXc9G9D4UU/2dJqJQ71GgAdugAf6uWQdm/dwFX
	O7GlbvRQWS7iZO6DxwiFFUDMB5r7ANsEL7i0uZPNH28tOOLUMAGtaTpRJoh8JFSd
	U2sh6bs4LV4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 74F6616491;
	Wed, 27 Apr 2016 18:25:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF91F16490;
	Wed, 27 Apr 2016 18:25:37 -0400 (EDT)
In-Reply-To: <57213041.5070506@kdbg.org> (Johannes Sixt's message of "Wed, 27
	Apr 2016 23:33:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7A5C7A8-0CC6-11E6-BD0C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292835>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 27.04.2016 um 22:56 schrieb Junio C Hamano:
>> So being able to stop at only commits on the first-parent chain is a
>> valid and useful tool.  "git bisect --first-parent" is one of the
>> things that are sometimes asked for.
>
> With origin pointing to git.git, I attempted this:
>
>  git bisect start
>  git rev-list --first-parent --boundary origin..origin/pu |
>    sed -ne s/-//p | xargs git bisect good
>  git bisect bad origin/pu
>
> and it starts bisecting among the 50-something first-parent commits
> between origin and origin/pu.

That is a cute idea but I wonder if it would work well in a history
full of pointless no-ff merges.

Here is a sample topology (output from "git log --oneline --graph")

    *   84ef1bb pointless
    |\  
    | * 4ae9f68 third
    |/  
    *   aec8732 pointless
    |\  
    | * fd4ed0d second
    |/  
    * 696b5c1 initial

where the tip of 'master' was initial, a side branch built 'second'
on it and then 'master' made a no-ff 'pointless' merge, another side
branch built 'third' on it and then 'master' again made a no-ff
'pointless' merge.

    $ git rev-list --first-parent --boundary initial..pointless

would give us 'third' and 'second' as boundaries, but by marking
'third' as GOOD, we declare to 'bisect' machinery that it and all of
its ancestors are GOOD.  So upon seeing 'bisect bad HEAD', we would
immediately see that HEAD is the first bad commit, wouldn't we?

Actually, "pointless no-ff merges" is a red herring.  Any history
with side branch that branched from the first-parent chain after the
commit at the bottom of the bisection range (in this example, the
side branch that built 'third' was forked off of the first 'pointless'
commit on the first-parent chain of 'master', which was made after
the bottom of the range 'initial') would have the same problem, I
would imagine.
