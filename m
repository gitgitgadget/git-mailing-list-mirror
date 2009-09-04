From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-completion.bash: prevent 'git help' from
 searching for git repository
Date: Fri, 04 Sep 2009 02:57:59 -0700
Message-ID: <7vvdjzxc9k.fsf@alter.siamese.dyndns.org>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org>
 <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com>
 <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 11:58:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjVYk-0004Ci-Pu
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 11:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933450AbZIDJ6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 05:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933437AbZIDJ6J
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 05:58:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933431AbZIDJ6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 05:58:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C6EC43A04;
	Fri,  4 Sep 2009 05:58:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mfhme0y5BJ8tugn/418kq+nzIYM=; b=N8vrDU
	wXy4CFwFHc8BUw9QwHtvL8JpWaKAzJ12+iuRz8NB7B/UG78/hd7Rw/M3imvSoMWg
	6PwTot5YH16I+yMNVvUWLTLCiskIR4DZ0wJXj5TmsuTieBTnms+3fH0Rx0FI/7mU
	HW7nxUlEizuIi+0P3MaL8cho7x/jlSbPdIfMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sYYEIMEcWXpUZVZzEw9+zMjv3HplcR4c
	J9Tk+kGpXsw4CgJGlpXfqJWFNoaWg+11T7LdWvAJ5i6uGlIcdG9qzx34qEcJZLs9
	68vbYTtw0rHZgWGVcE3HS3F1oezfhewZCaeVIxyQBrM/CfIUz4RqCjAgjnd2dsL8
	jXkZvmPsq/I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F21A43A03;
	Fri,  4 Sep 2009 05:58:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D433643A02; Fri,  4 Sep 2009
 05:58:02 -0400 (EDT)
In-Reply-To: <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org> (Gerrit
 Pape's message of "Fri\, 4 Sep 2009 09\:29\:29 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 720DC396-9939-11DE-9683-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127702>

Gerrit Pape <pape@smarden.org> writes:

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index bf688e1..a55e3cd 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -500,7 +500,7 @@ __git_all_commands ()
>  		return
>  	fi
>  	local i IFS=" "$'\n'
> -	for i in $(git help -a|egrep '^ ')
> +	for i in $(git --no-git-dir help -a|egrep '^ ')

Thanks.

What the --no-git-dir option actually does is "pretend that cwd is the git
directory but do not worry if it is not", which is different from "there
is no git directory, so do not barf as long as you do not need to access
git-dir".  The latter is what the name implies, and also additionally it
implies "but please do barf if you ever need to access something from git
directory."  I do not know if that holds true with your Patch 1/2, and I
am a bit too tired to check.

Besides, "git --git-dir=." is shorter to type, and it is equally magical
that the user has to know about it anyway.  Hopefully, most of the time
the end user would not have to use it directly, and the only demonstrated
use case is here in this completion script.

Would it be an option to chuck the Patch 1/2 at least for now and instead
say "git --git-dir=. help -a" here in this patch?
