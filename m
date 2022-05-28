Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05C6C433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 23:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiE1XL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 19:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiE1XL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 19:11:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E192C3A
        for <git@vger.kernel.org>; Sat, 28 May 2022 16:11:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D04A189123;
        Sat, 28 May 2022 19:11:23 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N/SGIpqwNNJx
        kAEP1wslqpEpjS7GiD1KNxQ0/+7GJG4=; b=po4HNGTyGMdwvtAFjhb0Vl0Crue+
        ZeAgw6uzyJJbNdZtN9P6n9ZuccE2d25nOzz8tO5FZA0KnfocD5sI0jWC1atsWmjJ
        PyN6xiExuk/15SI79XuKBW6bP6nUVDURLRwQiSkV1k7nHTS0UN4WBvQkjxOM/jIz
        sVJ+mNmm7nbhPN4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32E57189122;
        Sat, 28 May 2022 19:11:23 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC8BE189121;
        Sat, 28 May 2022 19:11:19 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v6+ 0/7] js/scalar-diagnose rebased 
Date:   Sat, 28 May 2022 16:11:11 -0700
Message-Id: <20220528231118.3504387-1-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-385-g60203f3fdb
In-Reply-To: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 7BD6CEC2-DEDB-11EC-AA47-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent document clarification on the "--prefix" option of the "git
archive" command from Ren=C3=A9 serves as a good basis for the
documentation of the "--add-virtual-file" option added by this
series, so here is my attempt to rebase js/scalar-diagnose topic
on it to hopefully help reduce Dscho's workload ;-)

Aside from obvious adjustments needed while rebasing onto the
updated documentation, there are only a couple of changes:

 - The way the <path> in --add-virtual-file=3D<path>:<contents> is
   used has been corrected.  Earlier, leading directory components
   of the <path> were all discarded and used nowhere, which made no
   sense.  The <path> is used as a whole, but for consistency with
   --add-file=3D<path>, <prefix> is still applied.

 - Overly loose quoting of variables in test scripts has been
   corrected.

Both changes have been in 'seen' from before the rebase.

1:  510f6b226b ! 1:  61522a0866 archive: optionally add "virtual" files
    @@ Commit message
    =20
      ## Documentation/git-archive.txt ##
     @@ Documentation/git-archive.txt: OPTIONS
    - 	by concatenating the value for `--prefix` (if any) and the
    - 	basename of <file>.
    + --prefix=3D<prefix>/::
    + 	Prepend <prefix>/ to paths in the archive.  Can be repeated; its
    + 	rightmost value is used for all tracked files.  See below which
    +-	value gets used by `--add-file`.
    ++	value gets used by `--add-file` and `--add-virtual-file`.
    +=20
    + -o <file>::
    + --output=3D<file>::
    +@@ Documentation/git-archive.txt: OPTIONS
    + 	concatenating the value of the last `--prefix` option (if any)
    + 	before this `--add-file` and the basename of <file>.
     =20
     +--add-virtual-file=3D<path>:<content>::
     +	Add the specified contents to the archive.  Can be repeated to add
     +	multiple files.  The path of the file in the archive is built
    -+	by concatenating the value for `--prefix` (if any) and the
    -+	basename of <file>.
    ++	by concatenating the value of the last `--prefix` option (if any)
    ++	before this `--add-virtual-file` and `<path>`.
     ++
     +The `<path>` cannot contain any colon, the file mode is limited to
     +a regular file, and the option may be subject to platform-dependent
    @@ archive.c: static int queue_or_write_archive_entry(const struct ob=
ject_id *oid,
     =20
      int write_archive_entries(struct archiver_args *args,
     @@ archive.c: int write_archive_entries(struct archiver_args *args,
    - 		strbuf_addstr(&path_in_archive, basename(path));
     =20
    - 		strbuf_reset(&content);
    + 		put_be64(fake_oid.hash, i + 1);
    +=20
    +-		strbuf_reset(&path_in_archive);
    +-		if (info->base)
    +-			strbuf_addstr(&path_in_archive, info->base);
    +-		strbuf_addstr(&path_in_archive, basename(path));
    +-
    +-		strbuf_reset(&content);
     -		if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
    -+		if (info->content)
    -+			err =3D write_entry(args, &fake_oid, path_in_archive.buf,
    -+					  path_in_archive.len,
    -+					  canon_mode(info->stat.st_mode),
    +-			err =3D error_errno(_("cannot read '%s'"), path);
    +-		else
    +-			err =3D write_entry(args, &fake_oid, path_in_archive.buf,
    +-					  path_in_archive.len,
    ++		if (!info->content) {
    ++			strbuf_reset(&path_in_archive);
    ++			if (info->base)
    ++				strbuf_addstr(&path_in_archive, info->base);
    ++			strbuf_addstr(&path_in_archive, basename(path));
    ++
    ++			strbuf_reset(&content);
    ++			if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
    ++				err =3D error_errno(_("could not read '%s'"), path);
    ++			else
    ++				err =3D write_entry(args, &fake_oid, path_in_archive.buf,
    ++						  path_in_archive.len,
    ++						  canon_mode(info->stat.st_mode),
    ++						  content.buf, content.len);
    ++		} else {
    ++			err =3D write_entry(args, &fake_oid,
    ++					  path, strlen(path),
    + 					  canon_mode(info->stat.st_mode),
    +-					  content.buf, content.len);
     +					  info->content, info->stat.st_size);
    -+		else if (strbuf_read_file(&content, path,
    -+					  info->stat.st_size) < 0)
    - 			err =3D error_errno(_("cannot read '%s'"), path);
    - 		else
    - 			err =3D write_entry(args, &fake_oid, path_in_archive.buf,
    ++		}
    ++
    + 		if (err)
    + 			break;
    + 	}
     @@ archive.c: static void extra_file_info_clear(void *util, const ch=
ar *str)
      {
      	struct extra_file_info *info =3D util;
2:  208f4aad5f ! 2:  5e9d19a70f archive --add-virtual-file: allow paths c=
ontaining colons
    @@ Commit message
    =20
      ## Documentation/git-archive.txt ##
     @@ Documentation/git-archive.txt: OPTIONS
    - 	by concatenating the value for `--prefix` (if any) and the
    - 	basename of <file>.
    + 	by concatenating the value of the last `--prefix` option (if any)
    + 	before this `--add-virtual-file` and `<path>`.
      +
     -The `<path>` cannot contain any colon, the file mode is limited to
     -a regular file, and the option may be subject to platform-dependent
     -command-line limits. For non-trivial cases, write an untracked file
     -and use `--add-file` instead.
     +The `<path>` argument can start and end with a literal double-quote
    -+character; The contained file name is interpreted as a C-style stri=
ng,
    ++character; the contained file name is interpreted as a C-style stri=
ng,
     +i.e. the backslash is interpreted as escape character. The path mus=
t
     +be quoted if it contains a colon, to avoid the colon from being
     +misinterpreted as the separator between the path and the contents, =
or
    @@ t/t5003-archive-zip.sh: check_zip with_untracked
      test_expect_success UNZIP 'git archive --format=3Dzip --add-virtual=
-file' '
     +	if test_have_prereq FUNNYNAMES
     +	then
    -+		PATHNAME=3Dquoted:colon
    ++		PATHNAME=3D"pathname with : colon"
     +	else
    -+		PATHNAME=3Dquoted
    ++		PATHNAME=3D"pathname without colon"
     +	fi &&
      	git archive --format=3Dzip >with_file_with_content.zip \
    -+		--add-virtual-file=3D\"$PATHNAME\": \
    ++		--add-virtual-file=3D\""$PATHNAME"\": \
      		--add-virtual-file=3Dhello:world $EMPTY_TREE &&
      	test_when_finished "rm -rf tmp-unpack" &&
      	mkdir tmp-unpack && (
      		cd tmp-unpack &&
      		"$GIT_UNZIP" ../with_file_with_content.zip &&
      		test_path_is_file hello &&
    -+		test_path_is_file $PATHNAME &&
    ++		test_path_is_file "$PATHNAME" &&
      		test world =3D $(cat hello)
      	)
      '
3:  bc1164404f =3D 3:  4f5b3aa775 scalar: validate the optional enlistmen=
t argument
4:  69daeb7d9d ! 4:  f4f070df8e Implement `scalar diagnose`
    @@ Metadata
     Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    =20
      ## Commit message ##
    -    Implement `scalar diagnose`
    +    scalar: implement `scalar diagnose`
    =20
         Over the course of Scalar's development, it became obvious that =
there is
         a need for a command that can gather all kinds of useful informa=
tion
5:  5c1ef19524 =3D 5:  0417d8abe4 scalar diagnose: include disk space inf=
ormation
6:  0325b9c3ab =3D 6:  5531b65ddb scalar: teach `diagnose` to gather pack=
file info
7:  8fee365b07 =3D 7:  ce9eba5e32 scalar: teach `diagnose` to gather loos=
e objects information


