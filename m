Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4953A1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 16:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbdHSQ6O (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 12:58:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56322 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752025AbdHSQ6N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 12:58:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C222CB2106;
        Sat, 19 Aug 2017 12:58:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TAXm/zyy0g/c
        3Mwz1chGCp1/x+4=; b=LONmFGNa3tVpvpCKzrtB10OpyBnX8FtGwk9E8Puj/El1
        N1gmu6ChFNF2gwLqOfG/U22tNCnFiO4CvijaqEPwkV6KVbnRf80SuG5x9vGvDzTm
        uFWWUmzzv042MwTt2alO00WOGV8Fz8I1lnDSvbz21R5fd+CRGPknVfmlbA1NBEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VxI5uE
        7DM/sqj5XFMOn8eO4YWCDDVLYAioJRw9QYarSjBtMLOU8gVp87Om+23h/YWqW4/L
        YaEV740xEErPBTeTGRiUTMoqwcudsJLoP8i1ynDUGKOfjaSIiNJy+U4KLhW48vhs
        yda8k2vvwBK+1X2Wkr6ceIknj/0MuvToXat04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B97D2B2105;
        Sat, 19 Aug 2017 12:58:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B8ABB2104;
        Sat, 19 Aug 2017 12:58:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] archive: queue directories for all types of pathspecs
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
        <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
        <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
        <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de>
Date:   Sat, 19 Aug 2017 09:58:06 -0700
In-Reply-To: <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 19 Aug 2017 07:33:50 +0200")
Message-ID: <xmqq378na40x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 92C3AB68-84FF-11E7-B32D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> When read_tree_recursive() encounters a directory excluded by a pathspe=
c
> then it enters it anyway because it might contain included entries.  It
> calls the callback function before it is able to decide if the director=
y
> is actually needed.
>
> For that reason git archive adds directories to a queue and writes
> entries for them only when it encounters the first child item -- but
> only if pathspecs with wildcards are used.  Do the same for literal
> pathspecs as well, as the reasoning above applies to them, too.  This
> prevents git archive from writing entries for excluded directories.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  archive.c               | 2 +-
>  t/t5001-archive-attr.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

This seems to break t/t5004-archive-corner-cases.sh though...

    expecting success:
            git archive --format=3Dtar $root_tree -- sub >subtree-path.ta=
r &&
            make_dir extract &&
            "$TAR" xf subtree-path.tar -C extract &&
            check_dir extract sub

    --- expect      2017-08-19 16:56:49.761513537 +0000
    +++ actual      2017-08-19 16:56:49.769513535 +0000
    @@ -1,2 +1 @@
     extract
    -extract/sub
    not ok 10 - archive empty subtree by direct pathspec

> diff --git a/archive.c b/archive.c
> index 1ab8d3a1d7..174c0555b6 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -123,7 +123,7 @@ static int check_attr_export_subst(const struct att=
r_check *check)
> =20
>  static int should_queue_directories(const struct archiver_args *args)
>  {
> -	return args->pathspec.has_wildcard;
> +	return args->pathspec.nr;
>  }
> =20
>  static int write_archive_entry(const unsigned char *sha1, const char *=
base,
> diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
> index 897f6f06d5..e9aa97117a 100755
> --- a/t/t5001-archive-attr.sh
> +++ b/t/t5001-archive-attr.sh
> @@ -73,7 +73,7 @@ test_expect_missing	archive-pathspec/ignored-by-tree
>  test_expect_missing	archive-pathspec/ignored-by-tree.d
>  test_expect_missing	archive-pathspec/ignored-by-tree.d/file
>  test_expect_exists	archive-pathspec/ignored-by-worktree
> -test_expect_missing	archive-pathspec/excluded-by-pathspec.d failure
> +test_expect_missing	archive-pathspec/excluded-by-pathspec.d
>  test_expect_missing	archive-pathspec/excluded-by-pathspec.d/file
> =20
>  test_expect_success 'git archive with wildcard pathspec' '
