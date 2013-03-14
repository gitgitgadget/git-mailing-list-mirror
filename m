From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] difftool --dir-diff: symlink all files matching
 the working tree
Date: Thu, 14 Mar 2013 14:28:31 -0700
Message-ID: <7v620ty8lc.fsf@alter.siamese.dyndns.org>
References: <cover.1363206651.git.john@keeping.me.uk>
 <cover.1363291949.git.john@keeping.me.uk>
 <ae17a152cadc650920c6446a4493384cc2e77309.1363291949.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Mar 14 22:29:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGFhw-000857-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 22:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab3CNV2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 17:28:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab3CNV2g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 17:28:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 631CBC4D5;
	Thu, 14 Mar 2013 17:28:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KvmcqxtPnp9w9cJCzXvJbEwI26M=; b=ZHfh5k
	nfLFQwOTESrHU236ehUw2NWqRCDQvaT6GDHCJPenvkOcNtv+VIHEewJqS1jbUHPE
	iYe0sYd66rvGb2LE3NUnntnQVAA8tZPmxyw0MI51wtuWB8PPx2lqPf36gkkDSmj9
	dL1uEAT5D8EgvYgcU/SLQoDPoSLVUalGcb46I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nImnCKRZEck8IMTPKl0F0qw1dkxlWONJ
	JaiIvtY6Y767hN5J104eqkevmiJw7IItaqcPLO1G1eyvz5LKaLKZjt1VzDd72QUl
	hwDzbkK8uLOsVOzkQbSCJj/gImWXFdvn6g67s5HtwtiQIu95Jh5tn3QRps5Btn1e
	MauiDhn5230=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57009C4D4;
	Thu, 14 Mar 2013 17:28:36 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 958DFC4D1; Thu, 14 Mar 2013
 17:28:35 -0400 (EDT)
In-Reply-To: <ae17a152cadc650920c6446a4493384cc2e77309.1363291949.git.john@keeping.me.uk>
 (John Keeping's message of "Thu, 14 Mar 2013 20:19:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20EB92A2-8CEE-11E2-A720-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218170>

John Keeping <john@keeping.me.uk> writes:

> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 3aab6e1..70e09b6 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -340,6 +340,28 @@ test_expect_success PERL 'difftool --dir-diff' '
>  	stdin_contains file <output
>  '
>  
> +write_script .git/CHECK_SYMLINKS <<\EOF
> +for f in file file2 sub/sub
> +do
> +	echo "$f"
> +	readlink "$2/$f"
> +done >actual
> +EOF

When you later want to enhance the test to check a combination of
difftool arguments where some paths are expected to become links and
others are expected to become real files, wouldn't this helper
become a bit awkward to use?  The element that expects a real file
could be an empty line to what corresponds to the output from
readlink, but still...

If t/ directory (or when the test is run with --root=<there>) is
aliased with symlinks in such a way that "cd <there> && $(pwd)" does
not match <there>, would this check with $(pwd) still work, I have
to wonder?

> +test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
> +	cat <<EOF >expect &&
> +file
> +$(pwd)/file
> +file2
> +$(pwd)/file2
> +sub/sub
> +$(pwd)/sub/sub
> +EOF

You can do this to align them nicer (note the "-" before EOF):

	cat >expect <<-EOF &&
	file
        $(pwd)/file
        ...
        EOF

> +	git difftool --dir-diff --symlink \
> +		--extcmd "./.git/CHECK_SYMLINKS" branch HEAD &&
> +	test_cmp actual expect
> +'
> +

Thanks.
