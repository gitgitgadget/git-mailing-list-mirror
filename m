From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] Add another option for receive.denyCurrentBranch
Date: Thu, 13 Nov 2014 09:51:36 -0800
Message-ID: <xmqq7fyz2dlj.fsf@gitster.dls.corp.google.com>
References: <cover.1415629053.git.johannes.schindelin@gmx.de>
	<cover.1415876330.git.johannes.schindelin@gmx.de>
	<7bd583cb3c7097811cff81cada9720eb30c3585e.1415876330.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 18:51:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoyYZ-0003ej-I1
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 18:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933579AbaKMRvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 12:51:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933484AbaKMRvi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 12:51:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E11501D754;
	Thu, 13 Nov 2014 12:51:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CqlZf+q0KB1gMDV1Dk+3E7EQtok=; b=cSM/ts
	7NPFVqySMdBjRopbDHTZeX7rppr+LqP5ggme20oxk/XFXZ/Ww2/tDmG2JaU9LD5z
	lQmTYsTpCD27Mby3RPyddTRxT5TxI+aESrv31/uqM4exSO/CNCGhC/1WEBjbII4V
	p9JviQdPB1MkQXPHkWYe3bjHywu+lXgEK5cNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pcp6a5Gswhh4fda8Q5kXZrWfv1YgZ7dd
	4hMwTagOlrfDvdi8zsSlJfcmi3vAzfkJcgP5lhDig1jSI18dZCGl63eWynQL86sA
	4Ziw4cddL/jtXkNWUAUMjdyE93cBY79i03SsNRg6vimm53dxCUFMgC4VwXZk+aad
	6Cng1UX3QEc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7FEA1D753;
	Thu, 13 Nov 2014 12:51:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42E921D751;
	Thu, 13 Nov 2014 12:51:37 -0500 (EST)
In-Reply-To: <7bd583cb3c7097811cff81cada9720eb30c3585e.1415876330.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 13 Nov 2014 12:03:46 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6E96B7C-6B5D-11E4-AEB9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index f4da20a..ba002a9 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1330,4 +1330,21 @@ test_expect_success 'fetch into bare respects core.logallrefupdates' '
>  	)
>  '
>  
> +test_expect_success 'receive.denyCurrentBranch = updateInstead' '
> +	git push testrepo master &&
> +	(cd testrepo &&
> +		git reset --hard &&
> +		git config receive.denyCurrentBranch updateInstead
> +	) &&
> +	test_commit third path2 &&
> +	git push testrepo master &&
> +	test $(git rev-parse HEAD) = $(cd testrepo && git rev-parse HEAD) &&
> +	test third = "$(cat testrepo/path2)" &&
> +	(cd testrepo &&
> +		git update-index --refresh &&
> +		git diff-files --quiet &&
> +		git diff-index --cached HEAD --
> +	)
> +'
> +

This new feature has two sides.  Update when we can and more
importantly fail the update safely.  This tests the "success" case,
but not the "safely fail" one.

For the latter "test_must_fail git push" on the sending side, and
"original HEAD stays the same and the working tree changes are
preserved when there are local changes before the push" on the
receiving side needs to be tested.

Thanks.
