From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] difftool: fix dir-diff when file does not exist in working tree
Date: Fri, 17 May 2013 11:46:15 -0700
Message-ID: <7vhai1xx54.fsf@alter.siamese.dyndns.org>
References: <de6690bea81de561747ca49893fbc77fa3eb8529.1368811736.git.john@keeping.me.uk>
	<7v38tlzdcv.fsf@alter.siamese.dyndns.org>
	<20130517182608.GB27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Bracey <kevin@bracey.fi>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 17 20:46:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdPfa-0003LY-LH
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 20:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617Ab3EQSqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 14:46:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755519Ab3EQSqS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 14:46:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D21B41DA1F;
	Fri, 17 May 2013 18:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fWMYy2YUa9UkrAXn6NkoF/EKWFo=; b=v4iR/A
	N3vqMeQ1on4YzlJjcBaY35TOe6xxCYHNMOdm6EP2IFIRYyiRUGpfDdn/vzUrxW1J
	GKVd7Ei9CuvhqysgJvhn97lRzN9VJU41b3qc4W1r6ue0gu86v3LGyeaoKDEhXSfX
	Sw74IECKeTT8ISmZPZHb5KLdbxH4kjIEKX4KA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hw0fEVHyrxcXpbSeDj2a/MrbqolTrjGf
	pAGWPbu/gZJriqwsL08tDlRLPm6BI+ZS3JL4reilN1fyiwTswZGRdPSenue3SqIu
	zLEbE/uzhcM/iwk17ifk1UUHhFiIFFUjZecZlWjzePIW2ds8T3SgSyDrC28Ah/5C
	LTVhr+tyxXs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA4C11DA1E;
	Fri, 17 May 2013 18:46:17 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31C401DA1D;
	Fri, 17 May 2013 18:46:17 +0000 (UTC)
In-Reply-To: <20130517182608.GB27005@serenity.lan> (John Keeping's message of
	"Fri, 17 May 2013 19:26:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EC4CEAC-BF22-11E2-9232-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224731>

John Keeping <john@keeping.me.uk> writes:

> It can't ever happen because we only call this if the mode is non-zero
> in which case the SHA-1 is only null if there are unstaged changes.
>
> However, I think this revised version is much clearer.

Yes, that makes the intention crystal clear.  I like it.

>
>  git-difftool.perl   | 6 ++++++
>  t/t7800-difftool.sh | 7 +++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 6780292..8a75205 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -92,6 +92,12 @@ sub use_wt_file
>  		return 0;
>  	}
>  
> +	if (! -e "$workdir/$file") {
> +		# If the file doesn't exist in the working tree, we cannot
> +		# use it.
> +		return (0, $null_sha1);
> +	}
> +
>  	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
>  	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
>  	return ($use, $wt_sha1);
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index a6bd99e..d46f041 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -356,6 +356,13 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory' '
>  	)
>  '
>  
> +run_dir_diff_test 'difftool --dir-diff when worktree file is missing' '
> +	test_when_finished git reset --hard &&
> +	rm file2 &&
> +	git difftool --dir-diff $symlinks --extcmd ls branch master >output &&
> +	grep file2 output
> +'
> +
>  write_script .git/CHECK_SYMLINKS <<\EOF
>  for f in file file2 sub/sub
>  do
