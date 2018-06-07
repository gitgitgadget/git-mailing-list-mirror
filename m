Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84DE1F517
	for <e@80x24.org>; Thu,  7 Jun 2018 05:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeFGFUF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:20:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51488 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbeFGFUE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:20:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9C18F1689;
        Thu,  7 Jun 2018 01:20:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=VZF2UxKJ/wTIbDbuCAkbOxlzs
        oc=; b=pcIkeRiPqigcSKZJWCYjprYZ2MnojcDc1k9lRxmkFlM01JKpRFKA0Xki7
        H9lS4/WBFIu5p9XfbhvmegU8h63/Ite7HsQu2dDdgXesCuwTnL25EuMGOICWtvFu
        hTsySBSkMKVzMCvdS7GhzCOFN7hqgWkVRHskNdHOcTFcD7FCp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=xkx3WI52yDsta8gn7lE
        814AajvBQAZ4OLZC62s0EngS9GJ2BnghvjD8Q1taO2B9igF8aaT5/VC2kJDeBtsc
        6udDJ9kbQm0f499RjcQSWtcEmwmaUZvrNYgNNh20yYBgppofC/sWa1kGsvpZQn6g
        H8a7pdJgQFF1/86JTxzUa2rs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3756F1683;
        Thu,  7 Jun 2018 01:20:02 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C495F1681;
        Thu,  7 Jun 2018 01:20:00 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/2] contrib/credential/netrc Makefile & test improvements
Date:   Thu,  7 Jun 2018 01:19:56 -0400
Message-Id: <20180607051958.759-1-tmz@pobox.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 6CE665AE-6A12-11E8-BEFF-44CE1968708C-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed failures from the contrib/credential/netrc tests
while building 2.18.0 release candidates.  I was surprised
to see the tests being run when called with a simple 'make'
command.

The first patch in the series adds an empty 'all::' make
target to match most of our other Makefiles and avoid the
surprise of running tests by default.  (When the netrc
helper was added to the fedora builds, it copied the same
'make -C contrib/credential/...' pattern from other
credential helpers -- despite the lack of anything to
build.)

The actual test failures were initially due to my build
environment lacking the perl autodie module, which was added
in 786ef50a23 ("git-credential-netrc: accept gpg option",
2018-05-12).

After installing the autodie module, the failures were due
to the build environment lacking a git install (specifically
the perl Git module).  The tests needing a pre-installed
perl Git seemed odd and worth fixing.

The second patch in the series aims to fix this.  I'm not
sure if there's a better or more preferable way to fix this,
which is one of the reasons for the RFC tag. (It's also why
I added you to the Cc =C3=86var, as you're one of the
knowledgeable perl folks here.)

The other reason for the RFC tag is that I'm unsure of how
to fix the last issue I found.  The tests exit cleanly even
when there are failures, which seems undesirable.  I'm not
familiar with the perl test_external framework to suggest a
fix in patch form.  It might be a matter of adding something
like this, from t/t9700/test.pl:

    my $is_passing =3D eval { Test::More->is_passing };
    exit($is_passing ? 0 : 1) unless $@ =3D~ /Can't locate object method/=
;

?  But that's a wild guess which I haven't tested.

Here's the output from 'make test' showing that most tests
fail and we still get a clean exit status:

$ make -C contrib/credential/netrc test ; echo "netrc test exit status: $=
?"
make: Entering directory '/builddir/build/BUILD/git-2.18.0.rc1/contrib/cr=
edential/netrc'
./t-git-credential-netrc.sh
ok 1 - set up test repository
# run 1: git-credential-netrc (perl /builddir/build/BUILD/git-2.18.0.rc1/=
t/../contrib/credential/netrc/test.pl)
ok 2 - Got 0 keys from insecure file
ok 3 - Got 0 keys from missing file
not ok 4 - Got first found keys with bad data
ok 5 - Got no corovamilkbar keys
not ok 6 - Got 2 Github keys
not ok 7 - Got correct Github password
not ok 8 - Got correct Github username
not ok 9 - Got 2 username-specific keys
not ok 10 - Got correct user-specific password
not ok 11 - Got correct user-specific protocol
not ok 12 - Got 2 host:port-specific keys
not ok 13 - Got correct host:port-specific password
not ok 14 - Got correct host:port-specific username
not ok 15 - Got 2 'host:port kills host' keys
not ok 16 - Got correct 'host:port kills host' password
not ok 17 - Got correct 'host:port kills host' username
not ok 18 - Got keys decrypted by git config option
not ok 19 - Got keys decrypted by command option
# test_external test git-credential-netrc was ok
make: Leaving directory '/builddir/build/BUILD/git-2.18.0.rc1/contrib/cre=
dential/netrc'
netrc test exit status: 0

Todd Zullinger (2):
  git-credential-netrc: make "all" default target of Makefile
  git-credential-netrc: use in-tree Git.pm for tests

 contrib/credential/netrc/Makefile | 3 +++
 contrib/credential/netrc/test.pl  | 3 +++
 2 files changed, 6 insertions(+)

Thanks all.

--=20
2.18.0.rc1
