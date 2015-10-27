From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: avoid symlinks when reusing worktree files
Date: Tue, 27 Oct 2015 15:24:49 -0700
Message-ID: <xmqq1tcgne4u.fsf@gitster.mtv.corp.google.com>
References: <1445981088-6285-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ismail Badawi <ismail@badawi.io>,
	John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 23:25:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrCfu-0003gd-14
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 23:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbbJ0WY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 18:24:57 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751824AbbJ0WY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 18:24:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0C72B25551;
	Tue, 27 Oct 2015 18:24:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qF/1feKqMhRrDLFNhBiSCH40LPE=; b=G0qgPn
	iQiKVWVFfIQKrVejgYnCGxQ1ZvaFrksFYkEBlB+oHIDSnxrja8SqqtODCsQngR2F
	nDfyL3Bj2a+9EWhaPlkPFPqPWXgPK4Qp4b5Rdw3ibHw918QxKzARCNBbhKNVnJJQ
	PvbWjeMsoRKtHbFo/WnSMmWFfRWYZ1Ew3Vyio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ACzOaNiytn8ta+kmywUrvn5YCIZwDi8F
	dES4yCENo84jRQHoDqKhI73X35+qpURGtHYrMOdVw3Cm3ZeLad4DXX4er29GlpCB
	dsnw+D7FnlxtpVG9FMV5oZvD6A8pRDk730+4OskBfTFPZ7OaCo6aAxTg9Kusm/Eh
	tnGzxuAwD1M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 025B425550;
	Tue, 27 Oct 2015 18:24:55 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7FE2C2554F;
	Tue, 27 Oct 2015 18:24:54 -0400 (EDT)
In-Reply-To: <1445981088-6285-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Tue, 27 Oct 2015 14:24:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C3085E2-7CF9-11E5-BB99-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280309>

David Aguilar <davvid@gmail.com> writes:

> difftool's dir-diff should never reuse a symlink, regardless of
> what it points to.  Tighten use_wt_file() so that it rejects all
> symlinks.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---

Sorry.  I do recall saying "it is wrong to feed the contents of a
file that a symlink points at to hash-object" but other than that,
I completely lost track.

What purpose does this function play in its callchain?  What does
its caller wants it to compute?  Is use of the entity in the working
tree completely optional?  Would the caller happily produce correct
result even if we changed this function to unconditionally return
($use=0, $wt_sha1='0'x40) regardless of the result of lstat(2) on
"$workdir/$file"?

The conclusion of the thought process that starts from "it is wrong
to feed the contents of a file that a symlink points at to
hash-object" may not be "so let's return $use=0 for all symlinks",
which is this patch. Depending on what its caller wants it to
compute, the right conclusion may be "we need to call hash-object
correctly by first running readlink and then feeding the result to
it".

And if the answer is "the caller wants us to compute the hash for a
symbolic link and say $use=1", then we would instead need to do
an equivalent of

	wt_sha1=$(readlink "$workdir/$file" | hash-object --stdin)

I cannot quite tell which from the patch and explanation.

Perhaps an additional test or two would help illustrate what issues
are being addressed better?

Thanks.

>  git-difftool.perl | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 1abe647..873db57 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -70,13 +70,13 @@ sub use_wt_file
>  	my ($repo, $workdir, $file, $sha1) = @_;
>  	my $null_sha1 = '0' x 40;
>  
> -	if (! -f "$workdir/$file") {
> -		return (0, $null_sha1);
> +	my $workfile = "$workdir/$file";
> +	if (-f $workfile && ! -l $workfile) {
> +		my $wt_sha1 = $repo->command_oneline('hash-object', $workfile);
> +		my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
> +		return ($use, $wt_sha1);
>  	}
> -
> -	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
> -	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
> -	return ($use, $wt_sha1);
> +	return (0, $null_sha1);
>  }
>  
>  sub changed_files
