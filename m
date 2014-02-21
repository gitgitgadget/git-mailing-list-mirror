From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2014, #06; Wed, 19)
Date: Fri, 21 Feb 2014 10:04:03 -0800
Message-ID: <xmqqr46w4a24.fsf@gitster.dls.corp.google.com>
References: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com>
	<BCF58F31-7130-4F4B-BE53-D917C4D50D96@quendi.de>
	<xmqqsird6137.fsf@gitster.dls.corp.google.com>
	<FB0B19C8-65BF-49CF-8EE4-5B9D55BBCE7C@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Fri Feb 21 19:04:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGuSS-0002OX-3a
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 19:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002AbaBUSEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 13:04:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838AbaBUSEP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 13:04:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33D3C6C150;
	Fri, 21 Feb 2014 13:04:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IC5uC7TaQCV7rdXTBOkydTrV3ds=; b=lnzIOT
	YHHiZir4/Sn5g7CMtem51WyhqabnUXyUNHZKhClAymyUHtDmWlM3+DeFaXF1XKLi
	gRsL/e8FksNr1hxTfuHCGTtEqToC1c/i2gIOk6578F4kGZ7hhyUBsNpoEc9heknT
	l3Wkl9zu0rINSQbp4HNQKanfQP8JzM4+9HygE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ppAcs7D3xxcyYZqrvLPfz491QEYU4aaR
	ir0RGvusbAyT1cuMB7diZ1lFW/sEddOGzQTPVDMUWd81ujlwfmXXTm3Y8CWUsNOi
	JAAPLnP2FgQ6ZIjJ0yRVdc/onCszjqvYt40RzfWTFwJ5M4qPnXzinIpptj/xUMS9
	Na3y2PrQKVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C27266C14F;
	Fri, 21 Feb 2014 13:04:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 356BF6C14D;
	Fri, 21 Feb 2014 13:04:09 -0500 (EST)
In-Reply-To: <FB0B19C8-65BF-49CF-8EE4-5B9D55BBCE7C@quendi.de> (Max Horn's
	message of "Fri, 21 Feb 2014 10:55:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8FA38E5A-9B22-11E3-AC64-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242483>

Max Horn <max@quendi.de> writes:

>> Thanks.  Let's keep it a bit longer and see how your new
>> investigation (and possibly help from others) develops to a
>> solution.
>
> So I had a closer look, and I now believe to now understand what
> the right fix is. Simply dropping transport-helper: check for
> 'forced update' message would be wrong, because it would cause the
> contrib/remote-helpers test cases to fail -- when I tested last
> night, I forgot that I had to run those separately. Silly me!
> ...
> In other words, the following patch should be the correct
> solution, as far as I can tell. I verified that it fixes t5541 and
> causes no regressions in the contrib/remote-helpers test suite.

Here is a description I wrote for a tentative commit to queue on
'pu' after seeing your response:

    transport-helper.c: do not overwrite forced bit
    
    It does not necessarily mean the update was *not* forced, when the
    helper did not say "forced update".  When the helper does say so, we
    know the update is forced.
    
    A workaround to fix breakage introduced by the previous step,
    proposed by Max Horn.

It troubled me that "it does not necessarily mean" sounded really
wishy-washy.  Isn't it possible for some helpers to _do_ want to
tell us that it did not have to force after all by _not_ saying
"forced update" and overwrite ->forced_update with zero?  How do we
tell helpers that do want to do so apart from other helpers that say
"forced update" only when they noticed they are indeed forcing?

Perhaps the logic needs to be more like:

	if (we know helper will tell us the push did not have to
            force by *not* saying "forced update") {
		(*ref)->forced_update = forced;
	}

i.e. for helpers that do not use the 'forced update' feature, simply
ignore this "forced" variable altogether, no?

> -- 8< --
> diff --git a/transport-helper.c b/transport-helper.c
> index fa7c608..86e1679 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -734,7 +734,7 @@ static int push_update_ref_status(struct strbuf *buf,
>         }
>
>         (*ref)->status = status;
> -       (*ref)->forced_update = forced;
> +       (*ref)->forced_update |= forced;
>         (*ref)->remote_status = msg;
>         return !(status == REF_STATUS_OK);
>  }
> -- 8< --
