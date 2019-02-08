Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_SBL,URIBL_SBL_A
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A391F453
	for <e@80x24.org>; Fri,  8 Feb 2019 03:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBHDRw (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 22:17:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50526 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfBHDRv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 22:17:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E430144849;
        Thu,  7 Feb 2019 22:17:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=QFgynYgJdOdhVyaE79b9mjScr
        w0=; b=sMzga+rqMLokxffy6s+aOMyCGwUQeuSShlahoIf4RAScPkuDNQahfUx3t
        rBKWnGJCgkFAW2fevOEZPF+aPjdqCBdITa6qjEcj9OahKFwEKuOyyo4VbXzhEiJI
        7Ulga2av49Ze4tLBHxjj2fOFQu/CtFfOpRYz1ZHhxWX8UBB/uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=LMvhpGOLTv6gNwzwJe+
        Grdw+T0XNJO/cqgZjL3o4XjF7IMWD3QVFQaT1VxIPyNOdMGaLX6VisvSKDSB7rJz
        Hf0H+tZp/jSqJAMWfhFWKTkMRHoQD6uxBXsdqNK7LV7ZXSnntcnLVzKVL1gCOaJJ
        acDbPSUl+IZTiKlzCbLCYkr4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6690D144848;
        Thu,  7 Feb 2019 22:17:49 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C013A144846;
        Thu,  7 Feb 2019 22:17:48 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/2] t/lib-gpg: a gpgsm fix, a minor improvement, and a question
Date:   Thu,  7 Feb 2019 22:17:44 -0500
Message-Id: <20190208031746.22683-1-tmz@pobox.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 1C9CB576-2B50-11E9-AA42-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Looking through the build logs for the fedora git packages, I noticed it
was missing the GPGSM prereq.  I added the necessary package to the
build requirements but GPGSM was still failing to be set.  This turned
out to be due to a use of ${GNUPGHOME} without quoting, which leads to a
non-zero exit from echo and the end of the happy && chain when using
bash as the test shell.  Fixing this allows the GPGSM test prereq to be
set.

While I was poking around I also saw an extra gpgconf call to kill
gpg-agent.  This was copied from the GPG block earlier in lib-gpg.sh,
but should not be needed (as far as I can tell).  I don't think it can
cause any real harm apart from causing gpg and gpgsm to start the agent
more often than necessary.  But I didn't run the tests with the --stress
option to look for potential issues that could be more serious.

Lastly, the GPG test prereq was failing in two of the tests where it was
used, t5573-pull-verify-signatures and t7612-merge-verify-signatures.  I
tracked this down to an annoying issue with gnugp-2=C2=B9, which recently
became the default /bin/gpg in fedora=C2=B2.

Using gnupg2 as /bin/gpg means using gpg-agent by default.  When using a
non-standard GNUPGHOME, gpg-agent defaults to putting its socket files
in GNUPGHOME and fails if the path for any of them is longer than
sun_path (108 chars on linux, 104 on OpenBSD and FreeBSD, and likely
similar on other unices).

When building in the typical fedora build tool (mock), the path to the
git test dir is "/builddir/build/BUILD/git-2.20.1/t."  That path then
has "trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX" appended and a
"gpghome" directory within.  For t5573 and t7612, the gpg-agent socket
path for S.gpg-agent.browser exceeds the sun_path limit and gpg-agent
fails to start.  Sadly, this is handled poorly by gpg and makes the
tests fail to set either the GPG or GPGSM prereqs.

For the fedora packages, I decided to pass --root=3D/tmp/git-t.XXXX (via
mktemp, of course) to the test suite which ensures a path short enough
to keep gpg-agent happy.

I don't know if there are other packagers or builders who run into this,
so maybe it's not worth much effort to try and have the test suite cope
better.  It took me longer than I would have liked to track it down, so
I thought I'd mention it in case anyone else has run into this or has
thoughts on how to improve lib-gpg.sh while waiting for GnuPG to improve
this area.

A GIT_TEST_GNUPGHOME_ROOT var to set the root path for the GNUPGHOME
dirs in the tests is one thought I had, but didn't try to put it into
patch form.  Setting the --root test option is probably enough control
for most cases.

=C2=B9 https://dev.gnupg.org/T2964
=C2=B2 https://fedoraproject.org/wiki/Changes/GnuPG2_as_default_GPG_imple=
mentation

Todd Zullinger (2):
  t/lib-gpg: quote path to ${GNUPGHOME}/trustlist.txt
  t/lib-gpg: drop redundant killing of gpg-agent

 t/lib-gpg.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--=20
Todd
