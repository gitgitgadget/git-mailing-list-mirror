Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD2EE499F
	for <git@archiver.kernel.org>; Sat, 19 Aug 2023 00:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbjHRX7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 19:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243112AbjHRX7i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 19:59:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274972D65
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 16:59:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8ED1029F1A;
        Fri, 18 Aug 2023 19:59:36 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=uA0eMbvJVVbxvh6tq3SBfW1jV
        146bCHrLY9EX8knJHA=; b=ak/Z2q6Eaep56loLKryUH/bJgKrBP2If9wNDYFn0P
        Pg/QWPI7b/qeFjEWrny+iDNls1H0hejCSwpnMTkfY45SX1Mhm+dXFN8Q6BgoIh30
        Eg3gCJiFdvYVvq4UFtCMbxXcAIfHOuvreIBm/7NaD43U+wip6akeeEjEtsps/nBf
        og=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8842E29F18;
        Fri, 18 Aug 2023 19:59:36 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3BB6529F15;
        Fri, 18 Aug 2023 19:59:33 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 0/5] fix interactions with "-w" and "--exit-code"
Date:   Fri, 18 Aug 2023 16:59:27 -0700
Message-ID: <20230818235932.3253552-1-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2-7-gf9972720e9
In-Reply-To: <20230817222949.3835424-1-gitster@pobox.com>
References: <20230817222949.3835424-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 4717FA1E-3E23-11EE-A5BA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Watson reported that "diff --no-index --exit-code
--ignore-all-space" does not work when used with "--shortstat".  It
turns out that this is not limited to "--no-index" mode, and it is
not limited to "--shortstat".  Anything that does not use the "--patch"
machinery to discover the content level differences ignored --exit-code
when used with options like "-w" and always exited with 0.  In fact,
even the "--patch" machinery was slightly faulty in corner cases.

And here is another round to fix it.
Previous one is at https://lore.kernel.org/git/20230817222949.3835424-1-g=
itster@pobox.com/

The interdiff is not all that interesting.  One patch dropped, two
patches stay the same, one patch has one-line change, and the final
one patch has been completely reworked.  Here is the summary:

 * The first patch about dirstat leak-fix is now gone.  The series
   has instead been rebased on top of the official "dirstat leak-fix"
   series that was merged in Git 2.41.

 * The next patch (preliminary code clean-up) stays the same.  It is
   now [1/5] instead of being the second step.

 * The next patch is to fix the corner case bug of "--patch"
   machinery.  The code stays the same, but the tests were asking
   the filesystem to do something impossible when they do not have
   executable bit support, so a prerequisite has been added to work
   around them.

 * The next patch is to fix "--stat -w --exit-code", which stays
   the same.

 * The last step is completely new.  v2 took an approach to reuse
   the "--patch" machinery even for "--raw" and other modes, but it
   would mean that "diff --raw --exit-code" may exit with 0 even
   when it has different paths to report, which is confusing.  v3
   changes the approach to align the exit status with the presence
   of reported paths that are different better.  "--raw" has ignored
   "-w" when producing its output.  It should ignore "-w" when
   reporting differences with its exit code, instead of always
   exiting with 0.

Junio C Hamano (5):
  diff: move the fallback "--exit-code" code down
  diff: mode-only change should be noticed by "--patch -w --exit-code"
  diff: teach "--stat -w --exit-code" to notice differences
  t4040: remove test that succeeded for a wrong reason
  diff: the -w option breaks --exit-code for --raw and other output
    modes

 diff.c                       | 40 ++++++++++++++++++++++--------------
 t/t4015-diff-whitespace.sh   | 39 ++++++++++++++++++++++++++++++++++-
 t/t4040-whitespace-status.sh |  3 +--
 3 files changed, 64 insertions(+), 18 deletions(-)

Range-diff against v2:
1:  65ff4655a2 < -:  ---------- diff: --dirstat leakfix
2:  533f974c9b ! 1:  df869ac550 diff: move the fallback "--exit-code" cod=
e down
    @@ Commit message
         diff: move the fallback "--exit-code" code down
    =20
         When "--exit-code" is asked and the code cannot just answer by
    -    comparing the object names on both sides but need to inspect and
    +    comparing the object names on both sides but needs to inspect an=
d
         compare the contents, there are two ways that the result is foun=
d
         out.
    =20
         Some output modes, like "--stat" and "--patch", inherently have =
to
    -    inspect the contents in order to _show_ the differences in the w=
ay
    +    inspect the contents in order to show the differences in the way
         they do.  The codepaths for these modes set the .found_changes b=
it
         as they compute what to show.
    =20
         However, other output modes do not need to inspect the contents =
to
         show the differences in the way they do.  The most notable examp=
le
    -    is "--quiet", which does not need to compute any output.  When t=
hey
    -    are asked to report "--exit-code", they run the codepaths for th=
e
    -    "--patch" output with their output redirected to "/dev/null", on=
ly
    -    to set the .found_changes bit.
    +    is "--quiet", which does not need to compute any output to show.
    +    When they are asked to report "--exit-code", they run the codepa=
ths
    +    for the "--patch" output with their output redirected to "/dev/n=
ull",
    +    only to set the .found_changes bit.
    =20
         Currently, this fallback invocation of "--patch" output is done
         after the "--stat" output format and its friends and before the
3:  89338b9302 ! 2:  b349ad5278 diff: mode-only change should be noticed =
by "--patch -w --exit-code"
    @@ Metadata
      ## Commit message ##
         diff: mode-only change should be noticed by "--patch -w --exit-c=
ode"
    =20
    -    The codepath to notice the content-level changes, taking certaio=
n
    +    The codepath to notice the content-level changes, taking certain
         no-op changes like "ignore whitespace" into account, forgot that
         a mode-only change is still a change.  This resulted in
    =20
    @@ t/t4015-diff-whitespace.sh: TEST_PASSES_SANITIZE_LEAK=3Dtrue
     +		test_expect_code 1 git diff -w $opts --exit-code x
     +	'
     +
    -+	test_expect_success "status with $opts (mode differs)" '
    ++	test_expect_success POSIXPERM "status with $opts (mode differs)" '
     +		test_when_finished "git update-index --chmod=3D-x x" &&
     +		echo foo >x &&
     +		git add x &&
4:  8fc63f4a04 ! 3:  be50b023a8 diff: teach "--stat -w --exit-code" to no=
tice differences
    @@ Commit message
    =20
             $ git diff --stat -w --exit-code
    =20
    -    for a change that does have an outout to exit with status 0.
    +    for a change that does have an output to exit with status 0.
    =20
         Set the bit by inspecting the list of paths the diffstat output =
is
         given for (a mode-only change will still appear as a "0-line add=
ed
5:  200593e9e0 < -:  ---------- diff: teach "--name-status" and friends t=
o honor "--exit-code -w"
-:  ---------- > 4:  d1a6fa7d17 t4040: remove test that succeeded for a w=
rong reason
-:  ---------- > 5:  573f810cce diff: the -w option breaks --exit-code fo=
r --raw and other output modes

base-commit: 83973981eb475ce90f829f8a5bd6ea99cd3bbd8e
--=20
2.42.0-rc2-7-gf9972720e9

