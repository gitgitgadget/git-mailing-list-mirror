From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach checkout the -n|--dry-run option
Date: Fri, 06 May 2011 15:49:15 -0700
Message-ID: <7vhb97xx5g.fsf@alter.siamese.dyndns.org>
References: <4DC47242.6060205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat May 07 00:49:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QITpy-0000as-UV
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 00:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab1EFWtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 18:49:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab1EFWtY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 18:49:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 20FFD43E4;
	Fri,  6 May 2011 18:51:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PcFrdgVjGxMsL1nDihHmJmiJUAU=; b=KK9PRT
	ABTyJ2nzbn6aTnyP4tn3R40EBAyCHEI5grMAgZeYXPWpYvmJ7W6VTNXhvH6c5Ggo
	wxj+dieLpeGrxuac9hZBzysMSqJZbU2hKOBauooighFChIkqtVSByWL6ot7xL/FG
	exhgn6C+ylDJ4gUGwoyiXHD6C+gvY1SDXQv78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s5iyp2O4ZXO4N7/w0f94k1L/+v8UIJ+v
	7+ZNE3ojC5btkAl93ebHYNn5CyWNwrRBMgdFma9kk7Hep3TpRbAyb1ZrN1KpWwHf
	lxtPQiTiCu9rQk0DeGnptaNz4yW9U3YZ22AGVIxdJFMiP8i/hoZPzCvZRcgkDuef
	qDcPkGegplQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F21DD43E0;
	Fri,  6 May 2011 18:51:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E64843DB; Fri,  6 May 2011
 18:51:19 -0400 (EDT)
In-Reply-To: <4DC47242.6060205@web.de> (Jens Lehmann's message of "Sat, 07
 May 2011 00:12:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D88D19C-7833-11E0-9D4F-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173025>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> This option can be used to determine if checking out a branch or commit
> would touch files which are modified in the work tree. It doesn't change
> the work tree contents or the index, so it can only tell if the checkout
> would succeed using trivial merges.

I hated this patch when I saw it the first time.  I thought you were
joking and let it pass. But now you brought it again, I hate it even more
now.

I do not see a merit in contaminating the checkout Porcelain with a half
baked [*1*] "dry-run" code, when your ultimate motive to use it in
submodule script and exercise only a small portion of checkout codepaths.
You are only interested in branch switching, and not other things the
Porcelain can do, like checking out a path out of the index or a tree, or
re-checking out a conflicted path out of the index.

In other words, can't the check you need in submodule be scripted around
the specific plumbing responsible for the branch switching, which is:

    $ git read-tree -m HEAD $other_branch

> @@ -397,7 +400,7 @@ static int merge_working_tree(struct checkout_opts *opts,
>
>  		/* 2-way merge to the new branch */
>  		topts.initial_checkout = is_cache_unborn();
> -		topts.update = 1;
> +		topts.update = !opts->dry_run;
>  		topts.merge = 1;
>  		topts.gently = opts->merge && old->commit;
>  		topts.verbose_update = !opts->quiet;

What you are doing in this part of your patch is exactly that two-tree
form of the "read-tree -m", no?


[Footnote]

*1* Look at how many places you say "are incompatible" when you really
mean "I didn't bother to think deeply enough about implementing this
combination".
