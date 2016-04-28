From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: make --rebase --verify-signatures illegal
Date: Thu, 28 Apr 2016 10:23:26 -0700
Message-ID: <xmqqmvod641d.fsf@gitster.mtv.corp.google.com>
References: <20160428095254.GA5205@netblarch>
	<20160428134435.GA5901@netblarch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:23:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avpfA-0003rA-8b
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 19:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbcD1RXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 13:23:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753021AbcD1RX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 13:23:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59626142D5;
	Thu, 28 Apr 2016 13:23:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3OjhK0Fdiqb2Ub4wx51cyEkKP9Y=; b=JWc6UK
	h1I2RvEwSDuNRUdoIB4F9iP309dqXzYo5o1+jcBSZ4HN62VVeOR5nFcDU0N3YOZS
	ei0xxzEAaQkY6uYuNRSJAsKwTqx6GvOTh5zsz271qbJye6l777RG31Kd0yQ2xB5E
	BEZ1CTLa7XDQxk/7M1RjI7XdZqNsXF6yGTYRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NB7Wz6MAz0nLpWeAqvQxgVOCiI+XopnS
	3xPWUASePfEdi73CzVgKu7A9xLusGt8MlNp60GVrmtWux5K7tRsAB7KiiOuYwXBW
	m8vIQCmB4CWbMnkW4iDTsbvyybsVNyYTU/0Q8fKIic6CbgClb5SNJTbV/R5iwfOJ
	a6rdluQrlsU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FEBE142CF;
	Thu, 28 Apr 2016 13:23:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E43F142CE;
	Thu, 28 Apr 2016 13:23:27 -0400 (EDT)
In-Reply-To: <20160428134435.GA5901@netblarch> (Alexander Hirsch's message of
	"Thu, 28 Apr 2016 15:44:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EB94647A-0D65-11E6-AE07-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292924>

Alexander 'z33ky' Hirsch <1zeeky@gmail.com> writes:

> Previously git-pull would silently ignore the --verify-signatures
> option.

I do not see a point of making it error out.  Adding a warning about
the option being ignored might be a worthwhile thing to do (e.g. it
may solicit responses from those who have been depending on it not
erroring out, saying "these warnings are pointless and noisy--here
is my valid use case that ends up passing --rebase and --v-s at the
same time"), though.



> Signed-off-by: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
> ---
>
> I made the error-message conform to the CodingGuidelines (removed
> capitalization and full stop).
>
> Also, in the previous mail I said that I proposed a patch for git-pull
> last December, when I actually meant git-rebase.
>
>  builtin/pull.c  |  2 ++
>  t/t5520-pull.sh | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index d98f481..b6e1507 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -809,6 +809,8 @@ static int run_rebase(const unsigned char *curr_head,
>  		argv_array_push(&args, "--no-autostash");
>  	else if (opt_autostash == 1)
>  		argv_array_push(&args, "--autostash");
> +	if (opt_verify_signatures && strcmp(opt_verify_signatures, "--verify-signatures") == 0)
> +		die(_("the --verify-signatures option does not work for --rebase"));
>  
>  	argv_array_push(&args, "--onto");
>  	argv_array_push(&args, sha1_to_hex(merge_head));
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 739c089..cb8f741 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -341,6 +341,20 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
>  	test new = "$(git show HEAD:file2)"
>  '
>  
> +test_expect_success "pull --rebase --verify-signatures is illegal" '
> +	git reset --hard before-rebase &&
> +	test_must_fail git pull --rebase --verify-signatures . copy 2>err &&
> +	test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
> +	test_i18ngrep "The --verify-signatures option does not work for --rebase." err
> +'
> +
> +test_expect_success "pull --rebase --no-verify-signatures" '
> +	git reset --hard before-rebase &&
> +	git pull --rebase --no-verify-signatures . copy &&
> +	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
> +	test new = "$(git show HEAD:file2)"
> +'
> +
>  # add a feature branch, keep-merge, that is merged into master, so the
>  # test can try preserving the merge commit (or not) with various
>  # --rebase flags/pull.rebase settings.
