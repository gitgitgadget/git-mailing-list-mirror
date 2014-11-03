From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in log for path in case of identical commit
Date: Mon, 03 Nov 2014 12:02:03 -0800
Message-ID: <xmqqwq7cqchw.fsf@gitster.dls.corp.google.com>
References: <CAFFOgCUeqcEPdjUyri0bivCj-Ofzp_9GhH3mR7UTzD-8PY9tGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git ML <git@vger.kernel.org>
To: Alexandre Garnier <zigarn+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:02:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlNpf-0006NC-P3
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 21:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbaKCUC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 15:02:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752335AbaKCUC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 15:02:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 03FE61AD17;
	Mon,  3 Nov 2014 15:02:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IMg6UwvbSkS+/LZv/EP21Q9UHf4=; b=IZWFaH
	Pbg7Jp3kSA4GJKxxq0YcUDo08v2ymbK4YNPViJy7+BbxMQVVCrEY27fb3DgxjyNf
	7J6qbLVY9HwORrXDvMPsai+TvQ755U/kBhrIhEX4ThFomd0D7kkbUD7Apc5V2ht+
	5wd1PNP0gdwnRcDtCHCfkmgrP9+oLGPgWHMYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KoOv+INtDcuxEoDjf8s3aSte4B099yXq
	+5JaRuO1LWYQMyN06ny69IGPYZGZ3QPr+4NdYtVy6VaKY0jNgvDL5yv1/7cJ8fOM
	WDGGhHgkLdMbpjUSvqu8jJeg0IDbjSklZaahgEsQCq/Y5Lb8veayrWWakM8m47m0
	iTx/Ww28M3g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ECC371AD16;
	Mon,  3 Nov 2014 15:02:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 968A61AD09;
	Mon,  3 Nov 2014 15:02:05 -0500 (EST)
In-Reply-To: <CAFFOgCUeqcEPdjUyri0bivCj-Ofzp_9GhH3mR7UTzD-8PY9tGw@mail.gmail.com>
	(Alexandre Garnier's message of "Fri, 31 Oct 2014 09:40:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 48D60BB6-6394-11E4-B53D-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandre Garnier <zigarn+git@gmail.com> writes:

> When merging 2 branches with the same modifications on the both sides,
> depending the merge side, one branch disappear from the file history.

Isn't this a basic and fundamental of feature of Git called merge
simplification, i.e. if two or more branches did the same thing and
did not contribute to the end result, drop all but the one of them
to show one simplest explanation of the history?

An option to get messier and fuller history is --full-history, if
the above matches what you are seeing.

>
> To be more clear, there is a script in attachment to reproduce, but
> here is the result :
> $ git log --graph --oneline --all --decorate --name-status
> *   63c807f (HEAD, master) Merge branch 'branch' into 'master'
> |\
> | * 5dc8785 (branch) Change line 15 on branch
> | | M   file
> | * d9cd3ce Change line 25 on branch
> | | M   file
> * | 7220d52 Change line 15 on master
> |/
> |   M   file
> * 7566672 Initial commit
>   A     file
>
> $ git log --graph --oneline --all --decorate --name-status -- file
> * 5dc8785 (branch) Change line 15 on branch
> | M     file
> * d9cd3ce Change line 25 on branch
> | M     file
> * 7566672 Initial commit
>   A     file
>
> => The commit 7220d52 modified the file but is not shown in file
> history anymore.
> The expected result would be:
> * 5dc8785 (branch) Change line 15 on branch
> | M     file
> * d9cd3ce Change line 25 on branch
> | M     file
> | * 7220d52 Change line 15 on master
> |/
> |   M   file
> * 7566672 Initial commit
>   A     file
>
> The order between the 2 commits on the branch is not important.
> If you do a 'cherry-pick 7220d52' or a 'merge --squash master' instead
> of applying the same modification for commit 5dc8785, you get the same
> result (cherry-picking was my initial use-case).
> If you do not create the commit d9cd3ce, then the file history show all commits.
> If you merge 'master' into 'branch', then the file history show all commits.
>
> Am I missing something or is it really a bug?
> Thanks.
