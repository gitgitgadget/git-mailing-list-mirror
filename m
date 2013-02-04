From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/RFH/RFD/PATCH] grep: allow to use textconv filters
Date: Mon, 04 Feb 2013 09:12:49 -0800
Message-ID: <7vtxps2eb2.fsf@alter.siamese.dyndns.org>
References: <2c0641ea4df6a872a4466efe0c0124f304f44c3e.1359991521.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:13:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2PbY-0002NL-N2
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 18:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab3BDRMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 12:12:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176Ab3BDRMx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 12:12:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E50D3BB0F;
	Mon,  4 Feb 2013 12:12:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AtwJ+FC/GZh9tspUBOVauJpxovw=; b=KfCuC/
	KLfXXbpLMSl/0vCwqy3qIG15ESrdQvblMqCRRNc+gYmEHg25SSRmaLGnFjIXukOs
	tuzCgjKcYkRzO3Mr8JXvNJB1jVBrEsVHAzrj62q4NyOiIjZcF6nnAOgu64lLxZtT
	13/TkWDEQmcPyswqNb4bYntZsvaX89LvqoHzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NI4KxOhame3aTYQdPd/aNooJTxvSkMex
	8tZvmVUxcOqpmhguml+anF6kou6FaatChDaX0AFN4klhfoVUnSVLEPGYsZeQZGbf
	4hYQQYvpEAXeqO7G4mi9M/xgDjj3D0a/jq9Wu050TBX9Uc681ittMBMfpPDjesuq
	tej7LG7Sn8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7D51BB0D;
	Mon,  4 Feb 2013 12:12:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15F69BAFF; Mon,  4 Feb 2013
 12:12:50 -0500 (EST)
In-Reply-To: <2c0641ea4df6a872a4466efe0c0124f304f44c3e.1359991521.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon, 4 Feb 2013 16:27:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B23B4B2-6EEE-11E2-9361-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215399>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Recently and not so recently, we made sure that log/grep type operations
> use textconv filters when a userfacing diff would do the same:
>
> ef90ab6 (pickaxe: use textconv for -S counting, 2012-10-28)
> b1c2f57 (diff_grep: use textconv buffers for add/deleted files, 2012-10-28)
> 0508fe5 (combine-diff: respect textconv attributes, 2011-05-23)
>
> "git grep" currently does not use textconv filters at all, that is
> neither for displaying the match and context nor for the actual grepping.
>
> Introduce a binary mode "--textconv" (in addition to "--text" and "-I")
> which makes git grep use any configured textconv filters for grepping
> and output purposes.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>
> Notes:
>     I'm somehow stuck in textconv/filespec/... hell, so I'm sending this out
>     in request for help. I'm sure there are people for whom it's a breeze to
>     get this right.

Looks like the patch touches the right places in the codepaths that
need to be updated from a quick read.

>     The difficulty is in getting the different cases (blob/sha1 vs.
>     worktree) right, and in making the changes minimally invasive.

I think grep_source abstraction was intended to be a way for that,
and if what it gives you is not sufficient for your needs, extending
it should not be seen as "invasive" at all.
