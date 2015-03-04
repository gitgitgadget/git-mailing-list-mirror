From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Wed, 04 Mar 2015 12:01:07 -0800
Message-ID: <xmqqfv9k8rcs.fsf@gitster.dls.corp.google.com>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>
	<xmqqzj7takks.fsf@gitster.dls.corp.google.com>
	<54F6D3B0.60600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, tboegi@web.de,
	sunshine@sunshineco.com, charles@hashpling.org,
	Johannes.Schindelin@gmx.de
To: Anton Trunov <anton.a.trunov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 21:01:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTFU4-0005R4-PF
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 21:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbbCDUBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 15:01:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754508AbbCDUBK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 15:01:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D63503C6EF;
	Wed,  4 Mar 2015 15:01:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QxgeMLbO3pYS1RGf6PcQiYKxivc=; b=pTMb2k
	ez/R0zS8mmKgNLayD9rh72lxdrmZN7yP3qLYFl6G+RvbWUHHNx3E7uBxG6GJqtlQ
	DoU3aqjHLpY3mpFmevqD+ICETPKd+IUBW+83IIsxP5kJ8oYZOPD4AZp9Cok4oVB4
	QTFCqMtLQx5ryPpau0POGxf05PSeVDVrmygws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R2YW78fQRo6NSC4DfZG1fAt10zqrfDLI
	k1tYI2wpcF+WabzTfvXoT6gP/yHrebqtazhtU0UQd3o2OgasUBAV0NQ+5hkkMJTw
	8O2ePHCwuThPfILnqbdK53J3RdzuQmyTHiLxpcozA4Y9S6JT9FLuQysQcIasCljI
	Ls+AcuCDe8k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA3C53C6ED;
	Wed,  4 Mar 2015 15:01:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A8763C6EB;
	Wed,  4 Mar 2015 15:01:08 -0500 (EST)
In-Reply-To: <54F6D3B0.60600@gmail.com> (Anton Trunov's message of "Wed, 04
	Mar 2015 12:43:12 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32B4D6EA-C2A9-11E4-AC2D-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264771>

Anton Trunov <anton.a.trunov@gmail.com> writes:

> For the code version before applying this patch the following scenario
> will take place if "git merge -Xignore-all-space remote" gets executed.
>
> base file:
> 1st line
> 2nd line
>
> master file:
>   1st line
>   2nd line with substantial change
>
> remote file:
>               1st line
>               2nd line
>
> merge result file:
>   1st line
>   2nd line with substantial change
>
> So essentially it does what "git merge -s ours remote" does in case if
> all their changes are trivial.
> This seems like reasonable solution to me: we _are_ trying to ignore
> whitespace changes and we are explicit about it.

Now, the above makes readers wonder what happens when you merged
master into the remote.  I.e. in the opposite direction.
