Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F58C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 05:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06CC61159
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 05:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhKJFn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 00:43:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:56380 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhKJFn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 00:43:59 -0500
Received: (qmail 26537 invoked by uid 109); 10 Nov 2021 05:41:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Nov 2021 05:41:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9887 invoked by uid 111); 10 Nov 2021 05:41:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Nov 2021 00:41:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Nov 2021 00:41:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
Message-ID: <YYtbdkLsCSFFE5io@coredump.intra.peff.net>
References: <xmqq4k8kzuz2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4k8kzuz2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 04:59:29PM -0800, Junio C Hamano wrote:

>  * Use ssh public crypto for object and push-cert signing.

I'm seeing some test breakage from the release candidates here. On my
Debian unstable system, everything passed a few days ago. But after
upgrading openssh-client from 1:8.4p1-5 to 1:8.7p1-1 (which hit unstable
on Saturday), all of the GPGSSH bits seem to break:

  Test Summary Report
  -------------------
  t5534-push-signed.sh                             (Wstat: 256 Tests: 13 Failed: 2)
    Failed tests:  8, 12
    Non-zero exit status: 1
  t6200-fmt-merge-msg.sh                           (Wstat: 256 Tests: 31 Failed: 2)
    Failed tests:  7-8
    Non-zero exit status: 1
  t7031-verify-tag-signed-ssh.sh                   (Wstat: 256 Tests: 8 Failed: 5)
    Failed tests:  2, 4-7
    Non-zero exit status: 1
  t7528-signed-commit-ssh.sh                       (Wstat: 256 Tests: 23 Failed: 10)
    Failed tests:  2-5, 7, 9, 12-13, 17, 19
    Non-zero exit status: 1

This doesn't have anything to do with -rc2 in particular. The breakage
bisects to f265f2d630 (ssh signing: tests for logs, tags & push certs,
2021-09-10), and is triggered by the system openssh upgrade.

It's hard to tell what's going on, as we seem to just be getting bad
results from ssh-keygen. Here's the first failing test in t7031 (with
GIT_TRACE and -x):

  [...]
  + git verify-tag initial
  trace: built-in: git verify-tag initial
  trace: run_command: ssh-keygen -Y find-principals -f '/home/peff/compile/git/t/trash directory.t7031-verify-tag-signed-ssh/gpghome/ssh.all_valid.allowedSignersFile' -s /tmp/.git_vtag_tmpSxXLIv
  trace: run_command: ssh-keygen -Y check-novalidate -n git -s /tmp/.git_vtag_tmpSxXLIv
  + exit 1
  error: last command exited with $?=1
  not ok 2 - verify and show ssh signatures

Likewise, this segfault (!) from t7528 is scary:

  [...]
  + git verify-commit initial
  trace: built-in: git verify-commit initial
  trace: run_command: ssh-keygen -Y find-principals -f '/home/peff/compile/git/t/trash directory.t7528-signed-commit-ssh/gpghome/ssh.all_valid.allowedSignersFile' -s /tmp/.git_vtag_tmpCOAwhp
  error: ssh-keygen died of signal 11
  trace: run_command: ssh-keygen -Y check-novalidate -n git -s /tmp/.git_vtag_tmpCOAwhp
  Good "git" signature with ED25519 key SHA256:E+1Xptv1zGa2fWFjSL36Tl2m2NVxcyJVzhfQTnU+yWc
  + exit 1
  error: last command exited with $?=1
  not ok 2 - verify and show signatures

So it may not be a bug we need to fix in Git. But shipping v2.34 with
lots of test failures may cause some headaches. Maybe we need to tighten
up the GPGSSH prereq checks to block broken versions?

-Peff
