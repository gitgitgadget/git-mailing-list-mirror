From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ensure SHELL_PATH is the hash bang for test suite askpass helper script.
Date: Mon, 29 Sep 2014 10:49:03 -0700
Message-ID: <xmqq38bauxkg.fsf@gitster.dls.corp.google.com>
References: <20140928231428.GA9061@peff.net>
	<1411974127-5258-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 19:49:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYf4V-0000iG-BW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 19:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbaI2RtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 13:49:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51105 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926AbaI2RtL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 13:49:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B5FD3D04A;
	Mon, 29 Sep 2014 13:49:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=0pG9zG3kSbMzXpJmXVcfaq5l4+M=; b=QksUfegX92Z68LsfiGCc
	9xBtMcbs0Skbe+H+07wqYcpMJ/qqRPY6TDyhUQ/dJIZZV6xS5kPrs87YK7VAm3Lo
	gr+JKGG04hE/YiPpFxu2NEh6huGPXQdGRcF9CwF67ZEXnw3deUl9VOTPJHggvqUz
	bvmadKXwXXQbuHeSPVonu8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hOS6TsFuWlazGt8TYlzAkwhX4BlgutJ5FNvBL0VpW4QY7D
	Aobz6rptLQYBR4g+JZGtrxSI+p1Fc17mYgrADwymMsjDFKRSnzGU/zuEOOb1MPlA
	/G/AyQTHZbp33Q6kfVSTgzdxTBmyjAocPYJyYyZJNEeJCC40EIMfiHWzKbnJM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8CEEA3D049;
	Mon, 29 Sep 2014 13:49:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EE6183D048;
	Mon, 29 Sep 2014 13:49:04 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EA86DFEE-4800-11E4-848E-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257633>

Ben Walton <bdwalton@gmail.com> writes:

> The askpass script that is created for use by the test suite should
> use SHELL_PATH for its hash bang instead of /bin/sh. Commit 5a4352024
> introduced the use of idioms not supported in some legacy /bin/sh
> implementations.
>
> Use write_script to ensure this happens automatically. This lets us
> remove the chmod step as well, since write_script handles that.
>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---

I'll leave out the "some legacy shells we do not support want to use
`command`" from the justification of this change.  Use of the
write_script helper is the right thing to do---$SHELL_PATH points at
the shell the user told us s/he wants to use, and that is a reason
enough for this change.  The reason why the user wants to use that
shell is immaterial.

Thanks.


>  t/lib-credential.sh | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> index 9e7d796..d8e41f7 100755
> --- a/t/lib-credential.sh
> +++ b/t/lib-credential.sh
> @@ -278,12 +278,10 @@ helper_test_timeout() {
>  	'
>  }
>  
> -cat >askpass <<\EOF
> -#!/bin/sh
> +write_script askpass <<\EOF
>  echo >&2 askpass: $*
>  what=$(echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z)
>  echo "askpass-$what"
>  EOF
> -chmod +x askpass
>  GIT_ASKPASS="$PWD/askpass"
>  export GIT_ASKPASS
