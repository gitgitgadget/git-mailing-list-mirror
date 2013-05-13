From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] stash: introduce 'git stash store'
Date: Mon, 13 May 2013 10:29:19 -0700
Message-ID: <7vppwun5zk.fsf@alter.siamese.dyndns.org>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
	<1368449154-21882-5-git-send-email-artagnon@gmail.com>
	<7vbo8fosd9.fsf@alter.siamese.dyndns.org>
	<CALkWK0kMj6q1rppzfxGWrthub4K_+C+jnvF=K4m2Fhk0pAnt7A@mail.gmail.com>
	<7v61ymop61.fsf@alter.siamese.dyndns.org>
	<CALkWK0mQhzrndaEp28nOpLs5STq136PY8hntCpX5RUZKrdJVAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 19:29:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbwYx-0006E3-T6
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 19:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab3EMR3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 13:29:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60537 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab3EMR3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 13:29:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEFEA1EA65;
	Mon, 13 May 2013 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PGt6BQqJqPJySGcPZC+tbS+W8EU=; b=U158m3
	ZC074awlzOBvKHzyDI3kBLLJHyX4Yp0Jvu24yc3VWXg4JM3qz9yj5mDnWK+Adeqg
	djTQyfLil62sHD0rpJCQ2xUx4tw7Nqw+ex/yP+WVfuP2tetdO0n3ztE3pxW9pY40
	1df79bytM3me/KXj2AWLWg2rdGwPtvgpmHPCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JvVp/G/18NEd4zQCNggGP6vIk6+vEfEw
	IdATModl60BdPvhIruvVnEfYjJwTDPr8g4rPbdfnKE4TgcJG6lzTb18VNb+oRrig
	obPDvRKvgOEizOgwNYZHr84anl8LEZDqhG20lFruqjxG7NZZrilPls646bnlX9ZI
	eXXYneZuYgo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E27C31EA64;
	Mon, 13 May 2013 17:29:21 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C7D51EA61;
	Mon, 13 May 2013 17:29:21 +0000 (UTC)
In-Reply-To: <CALkWK0mQhzrndaEp28nOpLs5STq136PY8hntCpX5RUZKrdJVAA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 13 May 2013 22:45:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5D527FC-BBF2-11E2-B88E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224182>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>         git stash store [-m <message>] [-e <error message>] $stash_sha1
> ...
> 3. Why are we designing a command-line interface?  git stash store
> "$stash_sha1" "$message" is sufficient for scripts, and there is
> absolutely no point in parsing '-m', '-e', or any such thing.

"git stash store $stash_sha1 $message [ $error_message ]" is
adequate an internal API _for now_.

I however suspect that you would regret later when you need more
customization.  It already happened once for "git merge" when it was
an internal API for "git pull" and it was painful to support saner
interface and the traditional one at the same time [*1*].

[Footnote]

*1* And no, don't even try to rewrite "git merge" call inside "git
pull" to use the modern style with "-m <message>"; you will likely
break it (I've tried once and decided it was not worth the hassle).
