From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Consider object stores in alternates during a dissociating clone
Date: Thu, 22 Oct 2015 09:12:32 -0700
Message-ID: <xmqq7fmeubkf.fsf@gitster.mtv.corp.google.com>
References: <561F8DE9.4040703@cetitec.com>
	<alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>
	<561FBA48.3050609@cetitec.com> <56274922.80007@cetitec.com>
	<xmqqpp085cth.fsf@gitster.mtv.corp.google.com>
	<5628EBAF.1030205@cetitec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Alexander Riesen <alexander.riesen@cetitec.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 18:12:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpITn-0008F4-4e
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 18:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978AbbJVQMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 12:12:35 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756855AbbJVQMe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 12:12:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 038702464B;
	Thu, 22 Oct 2015 12:12:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3thOfYvd8cKfnQGNo3WM78Dm+50=; b=OUWu+h
	hOO03vWr41o0iwrcphTNKZRLfdWZwNINTGcndmF0x68eABzTpAO2PgBjX+eya4aO
	+hVXTQEfH+N27I2gTPd7BO/vctHlwfoQl8jC8eGcTKQUHvqljcTF8S5B50wIAXiF
	sIVJyDPhs2FGhIbMdEN/8WpjqvMMXNxZeq+Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rhQwAZ9z/nvEeePN3dXDGulPY+KROSLv
	s3nIxuj/8OrzXk6gB7se9Mr/rUGd5z7jW8mREH6Odqxr6o1a6MtDG69RP2r5mwMY
	KxoFMixGYzuSediaX33PQ1UGe/h446m01xxOK+K0fTsS/SZQwf7iYOkgcT4tL+ME
	OSXq62eE9Ts=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF0902464A;
	Thu, 22 Oct 2015 12:12:33 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 60E4824649;
	Thu, 22 Oct 2015 12:12:33 -0400 (EDT)
In-Reply-To: <5628EBAF.1030205@cetitec.com> (Alexander Riesen's message of
	"Thu, 22 Oct 2015 15:59:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B3C653AA-78D7-11E5-9D9F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280061>

Alexander Riesen <alexander.riesen@cetitec.com> writes:

> I think I understand. How about this?
>
>  builtin/clone.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 9eaecd9..a7d0c07 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -801,11 +801,15 @@ static void write_refspec_config(const char *src_ref_prefix,
>  static void dissociate_from_references(void)
>  {
>      static const char* argv[] = { "repack", "-a", "-d", NULL };
> +    char *alts = git_pathdup("objects/info/alternates");
>
> +    if (access(alts, F_OK) < 0)
> +        return;

You leak alts here.

>      if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
>          die(_("cannot repack to clean up"));
> -    if (unlink(git_path("objects/info/alternates")) && errno != ENOENT)
> +    if (unlink(alts) && errno != ENOENT)
>          die_errno(_("cannot unlink temporary alternates file"));
> +    free(alts);
>  }
>
>  int cmd_clone(int argc, const char **argv, const char *prefix)
> @@ -954,10 +958,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>
>      if (option_reference.nr)
>          setup_reference();
> -    else if (option_dissociate) {
> -        warning(_("--dissociate given, but there is no --reference"));
> -        option_dissociate = 0;
> -    }
>
>      fetch_pattern = value.buf;
>      refspec = parse_fetch_refspec(1, &fetch_pattern);

Perhaps you would want a new test somewhere that (1) prepares the
ultimate source, (2) prepares a borrowing source with "clone
--reference" from the previous, (3) creates a local clone of the
previous with "clone --local" without "--reference" but with
"--dissociate", and (4) checks the end result by ensuring the
absense of $GIT_DIR/objects/info/alternates and runs "fsck" on it.

Other than these two points, the patch looks good to me.
