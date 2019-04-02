Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4DD202BB
	for <e@80x24.org>; Tue,  2 Apr 2019 18:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfDBSfi (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 14:35:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55179 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfDBSfi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 14:35:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 485EA64EBF;
        Tue,  2 Apr 2019 14:35:29 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=JT+a8Z6QsHmDDS/r6eax4jgwI
        9k=; b=Mv7ZitLn3tnsvN10AOUG9enFD0PgxcVux3qLTZYCkrBN1OjWUqItLigk8
        WBy7igAaubDboL5mz0tgB+6sYDbdsCWXMFhDWMQ2fUMSATR+T0toHDLAxV6FC35+
        ME4hPe/rfVUXIe62nsUuFV9RD77QB7kVj6DSI2AT4Yh9faefbU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4185A64EBE;
        Tue,  2 Apr 2019 14:35:29 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=mesmtp; bh=lFF+A4VpdynPDEVHoCydIinCSfT1Mlp01eg+peh4eQ4=; b=XCzUEcMEkf/mJbMFV6cJ3wrge2gAqDkPWbnWiQpfqpShARCLG0pbFI+B/CvqIaKCz3Igs5IuOsNCtGWM/iR26sSvVoi80Wewe4ppVMTpYo+5PTxmYAUo3jgRRjfilA6zfMUuY8pciR/9p76bytXIcisqCsZembx04oP2R7vC9Ck=
Received: from hylob.dartmouth.edu (unknown [129.170.31.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 759C564EBB;
        Tue,  2 Apr 2019 14:35:26 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Cc:     debian@onerussian.com
Subject: [PATCH v2 0/4] dir: Treat a repository without commits as a repository
Date:   Tue,  2 Apr 2019 14:35:01 -0400
Message-Id: <20190402183505.31512-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <87lg1eq146.fsf@kyleam.com>
References: <87lg1eq146.fsf@kyleam.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 1587B484-5576-11E9-886F-EE24A11ADF13-24757444!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Kyle Meyer <kyle@kyleam.com> writes:
>
> [...]
>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 514ede2596..6c74656027 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -234,10 +234,18 @@ cmd_add()
>>  	if test -z "$force" &&
>>  		! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_p=
ath" > /dev/null 2>&1
>>  	then
>> -		eval_gettextln "The following path is ignored by one of your .gitig=
nore files:
>> +		if test -d "$sm_path" &&
>> +			test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null) &&
>> +			! git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null
>> +		then
>> +			die "$(eval_gettext "'\$sm_path' does not have any commits")"
>> +		else
>> +			eval_gettextln "\
>> +The following path is ignored by one of your .gitignore files:
>>  \$sm_path
>>  Use -f if you really want to add it." >&2
>> -		exit 1
>> +			exit 1
>> +		fi
>
> I didn't think through this check, which would have been obvious had I
> ran the added test without the rest of the patches in this series.  It
> assumes that the 'git add --dry-run' call fails, but that failure
> depends on the last patch of this series.  So I'd need to move this
> patch to the end or find a new place for this "no commits" check.

v2 moves the "no commits" check outside of the 'git add --dry-run'
failure condition so that the first patch doesn't depend on the final
patch in this series.


Kyle Meyer (4):
  submodule: refuse to add repository with no commits
  t3000: move non-submodule repo test to separate file
  t3009: test that ls-files -o traverses bogus repo
  dir: do not traverse repositories with no commits

 dir.c                                   |  6 ++-
 git-submodule.sh                        |  7 ++++
 t/t3000-ls-files-others.sh              |  7 ----
 t/t3009-ls-files-others-nonsubmodule.sh | 56 +++++++++++++++++++++++++
 t/t3700-add.sh                          |  1 +
 t/t7400-submodule-basic.sh              | 11 ++++-
 6 files changed, 78 insertions(+), 10 deletions(-)
 create mode 100755 t/t3009-ls-files-others-nonsubmodule.sh

Range-diff against v1:
1:  e0db7e3c3c ! 1:  b080e2c557 submodule: refuse to add repository with =
no commits
    @@ -9,10 +9,9 @@
         in the sub-repository are added to the current repository.
    =20
         Detect if the path is a repository with no commits and abort to =
avoid
    -    getting into this state unless --force is used.  Reacting to --f=
orce
    -    isn't very useful, especially because an upcoming commit will ma=
ke
    -    'git add' fail in this situation, but it allows us to use the sa=
me
    -    'git add --dry-run' condition as the ignored path case.
    +    getting into this state.  Note that this check must come before =
the
    +    'git add --dry-run' check because an upcoming commit will make '=
git
    +    add' fail in this situation.
    =20
         Signed-off-by: Kyle Meyer <kyle@kyleam.com>
    =20
    @@ -20,26 +19,19 @@
      --- a/git-submodule.sh
      +++ b/git-submodule.sh
     @@
    + 		die "$(eval_gettext "'\$sm_path' already exists in the index and =
is not a submodule")"
    + 	fi
    +=20
    ++	if test -d "$sm_path" &&
    ++		test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null)
    ++	then
    ++	    git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null ||
    ++	    die "$(eval_gettext "'\$sm_path' does not have any commits")"
    ++	fi
    ++
      	if test -z "$force" &&
      		! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm=
_path" > /dev/null 2>&1
      	then
    --		eval_gettextln "The following path is ignored by one of your .git=
ignore files:
    -+		if test -d "$sm_path" &&
    -+			test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null) &=
&
    -+			! git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null
    -+		then
    -+			die "$(eval_gettext "'\$sm_path' does not have any commits")"
    -+		else
    -+			eval_gettextln "\
    -+The following path is ignored by one of your .gitignore files:
    - \$sm_path
    - Use -f if you really want to add it." >&2
    --		exit 1
    -+			exit 1
    -+		fi
    - 	fi
    -=20
    - 	if test -n "$custom_name"
    =20
      diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.s=
h
      --- a/t/t7400-submodule-basic.sh
2:  6eed1f5daf =3D 2:  c027701842 t3000: move non-submodule repo test to =
separate file
3:  7ba3209762 =3D 3:  97f53e30c0 t3009: test that ls-files -o traverses =
bogus repo
4:  2901375dc1 =3D 4:  a926b87102 dir: do not traverse repositories with =
no commits
--=20
2.21.0

