From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] mailsplit: support unescaping mboxrd messages
Date: Mon, 06 Jun 2016 11:24:53 -0700
Message-ID: <xmqq7fe2xjii.fsf@gitster.mtv.corp.google.com>
References: <20160605044641.9221-1-e@80x24.org>
	<20160605044641.9221-3-e@80x24.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 20:25:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9zCw-0007PA-Fr
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 20:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbcFFSY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 14:24:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751469AbcFFSY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 14:24:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D987F22079;
	Mon,  6 Jun 2016 14:24:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JJxX0FjcystOJXQVllBdI/cKgcM=; b=dvXZ6z
	2NumuCkwYYe3H45XNhQR19G1MDABqKi7TUR2MzpH0/eacd6/Lc2jL9OqWZ9v8eJA
	a8l372zOxfjNhW1QjJlqcMCtbbuFnN6oGtjitbhvdd4k8Ht54MNvrH8tqwOx26rZ
	WQTAwTKdzzezjUBX1waQzy4ebJXIzIJVGRNIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z0c/OnpuGnT+wnErmV/kWr6ay4FtefZR
	XGTdJGjjSg0HxEwtczjd8u4pXQ5m6BCGtTcnzLRvDjekHMyEh2L/ZCA0idqHNU9q
	WAWRT0W5jHnujWX6S7OJ1/On2oqOWxsJR/J4O+yFLfKHSPTRDxHJTuRDl5AvZ0i1
	kPtAWWTEPHY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D21D522078;
	Mon,  6 Jun 2016 14:24:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DFED22075;
	Mon,  6 Jun 2016 14:24:55 -0400 (EDT)
In-Reply-To: <20160605044641.9221-3-e@80x24.org> (Eric Wong's message of "Sun,
	5 Jun 2016 04:46:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7C0A070-2C13-11E6-B6F5-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296548>

Eric Wong <e@80x24.org> writes:

> This will allow us to parse the output of --pretty=mboxrd
> and the output of other mboxrd generators.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  Documentation/git-mailsplit.txt |  7 ++++++-
>  builtin/mailsplit.c             | 18 ++++++++++++++++++
>  t/t5100-mailinfo.sh             | 31 +++++++++++++++++++++++++++++++
>  t/t5100/0001mboxrd              |  4 ++++
>  t/t5100/0002mboxrd              |  5 +++++
>  t/t5100/sample.mboxrd           | 19 +++++++++++++++++++
>  6 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 t/t5100/0001mboxrd
>  create mode 100644 t/t5100/0002mboxrd
>  create mode 100644 t/t5100/sample.mboxrd
>
> diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
> index 4d1b871..e3b2a88 100644
> --- a/Documentation/git-mailsplit.txt
> +++ b/Documentation/git-mailsplit.txt
> @@ -8,7 +8,8 @@ git-mailsplit - Simple UNIX mbox splitter program
>  SYNOPSIS
>  --------
>  [verse]
> -'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] -o<directory> [--] [(<mbox>|<Maildir>)...]
> +'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] [--mboxrd]
> +		-o<directory> [--] [(<mbox>|<Maildir>)...]
>  
>  DESCRIPTION
>  -----------
> @@ -47,6 +48,10 @@ OPTIONS
>  --keep-cr::
>  	Do not remove `\r` from lines ending with `\r\n`.
>  
> +--mboxrd::
> +	Input is of the "mboxrd" format and "^>+From " line escaping is
> +	reversed.

This just makes me wonder if there is a practical reason why people
would not want this always enabled.  I just looked at output from

    $ git log --grep='>>*From '

in the kernel repository, and I saw no cases where the committer
really wanted to preserve the leading one or more '>' on that line.
No, I didn't go through all of 150+ such commits, but I did check
the couple dozen of them from the recent history.

Our history also have 5 instances of them, none of which should have
had the leading '>' if the committer were careful.

> diff --git a/t/t5100/sample.mboxrd b/t/t5100/sample.mboxrd
> new file mode 100644
> index 0000000..79ad5ae
> --- /dev/null
> +++ b/t/t5100/sample.mboxrd
> @@ -0,0 +1,19 @@
> +From mboxrd Mon Sep 17 00:00:00 2001
> +From: mboxrd writer <mboxrd@example.com>
> +Date: Fri, 9 Jun 2006 00:44:16 -0700
> +Subject: [PATCH] a commit with escaped From lines
> +
> +>From the beginning, mbox should have been mboxrd

Indeed ;-)
