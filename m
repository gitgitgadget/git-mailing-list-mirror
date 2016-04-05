From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: run arguments through precompose_argv
Date: Tue, 05 Apr 2016 10:09:52 -0700
Message-ID: <xmqqzit80yov.fsf@gitster.mtv.corp.google.com>
References: <1459802325-22056-1-git-send-email-alex@fournova.com>
	<1459802325-22056-2-git-send-email-alex@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Alexander Rinass <alex@fournova.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 19:10:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anUUR-0005XZ-To
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 19:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759143AbcDERJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2016 13:09:59 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759121AbcDERJ4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2016 13:09:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3343851130;
	Tue,  5 Apr 2016 13:09:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ufvLLJewcIOR
	47gQDJu3L7lrqqs=; b=R2X10Zc26Kg3EU+kr5GKT1w+8I2a8cay5/bd3pNxbcRY
	IjsFUOXtG+6jPQZuwiRpHZ4srFaqpxXFxQLP9aRgCvl2h2kIcMU2iqAMqpFryZo/
	Q9xn++z1Xw6S/Ilpe23yM536sZ94VPHixIXGGJMHF2MzzrDF0sou5Q2K/dZ+Npw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TRqexV
	h07XsQkYL5dS2NgMrcrXcWqWT5JIC2clHAGNOTFncm+LynAj6A9quInI9R/GrPsg
	P2l/kFL4hEl8yoltHmuyPDq4IT2Vlr/eTljP4jwS1WW9m4MSr4n4BqXCFe4UC2as
	YaLvUUxrXobYKd+4EmRfkvY4PdIjpQGXoAwbY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28FBC5112F;
	Tue,  5 Apr 2016 13:09:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 768295112E;
	Tue,  5 Apr 2016 13:09:54 -0400 (EDT)
In-Reply-To: <1459802325-22056-2-git-send-email-alex@fournova.com> (Alexander
	Rinass's message of "Mon, 4 Apr 2016 22:38:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 37659602-FB51-11E5-BBB7-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290799>

Alexander Rinass <alex@fournova.com> writes:

> File paths containing decomposed unicode chars passed to diff
> command are not converted to precomposed unicode form.
>
> As a result, no diff is displayed when feeding such a file path to th=
e
> diff command.
>
> Opposite to most builtin commands, the diff builtin is missing the
> parse_options call, which internally runs arguments through the
> precompose_argv call, which ensures all arguments are in precomposed
> unicode form.
>
> Fix the problem by adding a precompose_argv call directly, as a call =
to
> parse_options would require additional work to call it.
>
> Also applies to diff-index, diff-files and diff-tree.

Thanks.  The log message talks about "such a file path", but
precompose_argv() applies indiscriminately on any command line
arguments, so things like -G<string> would also get the same
treatment, which I think is what most users would want).

Will queue.

> Signed-off-by: Alexander Rinass <alex@fournova.com>
> Thanks-to: Torsten Bo=CC=88gershausen <tboegi@web.de>
> Thanks-to: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/diff-files.c         |  1 +
>  builtin/diff-index.c         |  1 +
>  builtin/diff-tree.c          |  2 ++
>  builtin/diff.c               |  1 +
>  t/t3910-mac-os-precompose.sh | 42 ++++++++++++++++++++++++++++++++++=
++++++++
>  5 files changed, 47 insertions(+)
>
> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> index 8ed2eb8..15c61fd 100644
> --- a/builtin/diff-files.c
> +++ b/builtin/diff-files.c
> @@ -24,6 +24,7 @@ int cmd_diff_files(int argc, const char **argv, con=
st char *prefix)
>  	gitmodules_config();
>  	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>  	rev.abbrev =3D 0;
> +	precompose_argv(argc, argv);
> =20
>  	argc =3D setup_revisions(argc, argv, &rev, NULL);
>  	while (1 < argc && argv[1][0] =3D=3D '-') {
> diff --git a/builtin/diff-index.c b/builtin/diff-index.c
> index d979824..1af373d 100644
> --- a/builtin/diff-index.c
> +++ b/builtin/diff-index.c
> @@ -21,6 +21,7 @@ int cmd_diff_index(int argc, const char **argv, con=
st char *prefix)
>  	gitmodules_config();
>  	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>  	rev.abbrev =3D 0;
> +	precompose_argv(argc, argv);
> =20
>  	argc =3D setup_revisions(argc, argv, &rev, NULL);
>  	for (i =3D 1; i < argc; i++) {
> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index 2a12b81..806dd7a 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -114,6 +114,8 @@ int cmd_diff_tree(int argc, const char **argv, co=
nst char *prefix)
>  	opt->disable_stdin =3D 1;
>  	memset(&s_r_opt, 0, sizeof(s_r_opt));
>  	s_r_opt.tweak =3D diff_tree_tweak_rev;
> +
> +	precompose_argv(argc, argv);
>  	argc =3D setup_revisions(argc, argv, opt, &s_r_opt);
> =20
>  	while (--argc > 0) {
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 52c98a9..d6b8f98 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -319,6 +319,7 @@ int cmd_diff(int argc, const char **argv, const c=
har *prefix)
>  	if (!no_index)
>  		gitmodules_config();
>  	git_config(git_diff_ui_config, NULL);
> +	precompose_argv(argc, argv);
> =20
>  	init_revisions(&rev, prefix);
> =20
> diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose=
=2Esh
> index 8319356..26dd5b7 100755
> --- a/t/t3910-mac-os-precompose.sh
> +++ b/t/t3910-mac-os-precompose.sh
> @@ -49,12 +49,54 @@ test_expect_success "setup" '
>  test_expect_success "setup case mac" '
>  	git checkout -b mac_os
>  '
> +# This will test nfd2nfc in git diff
> +test_expect_success "git diff f.Adiar" '
> +	touch f.$Adiarnfc &&
> +	git add f.$Adiarnfc &&
> +	echo f.Adiarnfc >f.$Adiarnfc &&
> +	git diff f.$Adiarnfd >expect &&
> +	git diff f.$Adiarnfc >actual &&
> +	test_cmp expect actual &&
> +	git reset HEAD f.Adiarnfc &&
> +	rm f.$Adiarnfc expect actual
> +'
> +# This will test nfd2nfc in git diff-files
> +test_expect_success "git diff-files f.Adiar" '
> +	touch f.$Adiarnfc &&
> +	git add f.$Adiarnfc &&
> +	echo f.Adiarnfc >f.$Adiarnfc &&
> +	git diff-files f.$Adiarnfd >expect &&
> +	git diff-files f.$Adiarnfc >actual &&
> +	test_cmp expect actual &&
> +	git reset HEAD f.Adiarnfc &&
> +	rm f.$Adiarnfc expect actual
> +'
> +# This will test nfd2nfc in git diff-index
> +test_expect_success "git diff-index f.Adiar" '
> +	touch f.$Adiarnfc &&
> +	git add f.$Adiarnfc &&
> +	echo f.Adiarnfc >f.$Adiarnfc &&
> +	git diff-index HEAD f.$Adiarnfd >expect &&
> +	git diff-index HEAD f.$Adiarnfc >actual &&
> +	test_cmp expect actual &&
> +	git reset HEAD f.Adiarnfc &&
> +	rm f.$Adiarnfc expect actual
> +'
>  # This will test nfd2nfc in readdir()
>  test_expect_success "add file Adiarnfc" '
>  	echo f.Adiarnfc >f.$Adiarnfc &&
>  	git add f.$Adiarnfc &&
>  	git commit -m "add f.$Adiarnfc"
>  '
> +# This will test nfd2nfc in git diff-tree
> +test_expect_success "git diff-tree f.Adiar" '
> +	echo f.Adiarnfc >>f.$Adiarnfc &&
> +	git diff-tree HEAD f.$Adiarnfd >expect &&
> +	git diff-tree HEAD f.$Adiarnfc >actual &&
> +	test_cmp expect actual &&
> +	git checkout f.$Adiarnfc &&
> +	rm expect actual
> +'
>  # This will test nfd2nfc in git stage()
>  test_expect_success "stage file d.Adiarnfd/f.Adiarnfd" '
>  	mkdir d.$Adiarnfd &&
