Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9908CC433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359241AbiELWjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352418AbiELWjq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:39:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C73282000
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:39:43 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E137136A7E;
        Thu, 12 May 2022 18:39:43 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=WALHf6uwZTuZWK7lcqgKq8p04
        n60bPinbzYTY/JsGxY=; b=nr+j7itnZeGaBdylVqJRl/EP1ZMiKuckIi6nSAdTf
        LZw2tQAlAsc88z1LDqU11/snaNKD832Fyjo/Oezjy3OGI0QaY38dv6jCCGG3LFoI
        /obMDrFkzUdsyJ9xPx5aT3PSVgbMNVQk0n8/lG81zonw4yhEeF3baGGcpR14tfAB
        X4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 536A1136A7D;
        Thu, 12 May 2022 18:39:43 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2E48136A7C;
        Thu, 12 May 2022 18:39:42 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v4 0/4] ci: avoid perforce/brew issues affecting macOS
Date:   Thu, 12 May 2022 15:39:36 -0700
Message-Id: <20220512223940.238367-1-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-338-g1c7f76a54c
In-Reply-To: <20220423142559.32507-1-carenas@gmail.com>
References: <20220423142559.32507-1-carenas@gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 6A77DC50-D244-11EC-B895-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We see macOS CI job failures from time to time when the version of
p4 brew expects is slightly older than what is offered at Perforce's
download site.  Instead of failing to run the tests altogether, just
skip "git-p4" tests, like we do for tests that depends on any other
optional packages, when this happens.

This is essentially unchanged from the v3 posted by Carlo on April
23rd, with a few fix-ups that have been cooking on top squashed in.

The changes from the previous round (i.e. the "fix-ups" that have
been floating on top, which got squashed in) are:

 * The first step has a fix to a couple of wrong redirections that
   created a junk file whose name is "2", instead of sending the
   messages to the standard error.

 * The last step makes two places that we download Perforce packages
   to use https://cdist2.perforce.com/ (earlier one of the places
   used that, the other https://filehost.perforce.com/).

I am sending this out as a final "complain now, or this will go to
'next' soonish" warning.  The "What's cooking" report is getting
crowded with too many topics marked as "Expecting a reroll", and I'm
trying to do easier ones myself to see how much reduction we can
make.

Carlo Marcelo Arenas Bel=C3=B3n (3):
  ci: make failure to find perforce more user friendly
  ci: avoid brew for installing perforce
  ci: reintroduce prevention from perforce being quarantined in macOS

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
  ci: use https, not http to download binaries from perforce.com

 ci/install-dependencies.sh | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)


1:  5730a749bc ! 1:  024459486c ci: make failure to find perforce more us=
er friendly
    @@ ci/install-dependencies.sh: linux-gcc-default)
      	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
      	p4 -V | grep Rev.
     +else
    -+	echo "WARNING: perforce wasn't installed, see above for clues why"=
 >2
    ++	echo >&2 "WARNING: perforce wasn't installed, see above for clues =
why"
      fi
     -if type git-lfs >/dev/null
     +if type git-lfs >/dev/null 2>&1
    @@ ci/install-dependencies.sh: linux-gcc-default)
      	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
      	git-lfs version
     +else
    -+	echo "WARNING: git-lfs wasn't installed, see above for clues why" =
>2
    ++	echo >&2 "WARNING: git-lfs wasn't installed, see above for clues w=
hy"
      fi
2:  8cd96645ae =3D 2:  8717dbe8d9 ci: avoid brew for installing perforce
3:  1f06d0ba06 =3D 3:  6a4f085d63 ci: reintroduce prevention from perforc=
e being quarantined in macOS
4:  6bf267b995 ! 4:  5be72d9150 ci: use https, not http to download binar=
ies from perforce.com
    @@ Commit message
         at least, and is one less thing to worry about when checking whe=
re
         else we rely on non-TLS'd http connections.
    =20
    +    Also, use the same download site at perforce.com for Linux and m=
acOS
    +    tarballs for consistency.
    +
         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
    +    Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.co=
m>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      ## ci/install-dependencies.sh ##
    @@ ci/install-dependencies.sh
      . ${0%/*}/lib.sh
     =20
     -P4WHENCE=3Dhttp://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
    -+P4WHENCE=3Dhttps://filehost.perforce.com/perforce/r$LINUX_P4_VERSIO=
N
    ++P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
      LFSWHENCE=3Dhttps://github.com/github/git-lfs/releases/download/v$L=
INUX_GIT_LFS_VERSION
      UBUNTU_COMMON_PKGS=3D"make libssl-dev libcurl4-openssl-dev libexpat=
-dev
       tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sas=
l-perl



--=20
2.36.1-338-g1c7f76a54c

