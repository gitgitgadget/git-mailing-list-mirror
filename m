Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5CFA2055E
	for <e@80x24.org>; Wed,  1 Nov 2017 17:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754843AbdKARKf (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 13:10:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:58041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751562AbdKARKe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 13:10:34 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTjua-1djRPy3M4e-00QThA; Wed, 01
 Nov 2017 18:10:22 +0100
Date:   Wed, 1 Nov 2017 18:10:21 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/3] mingw: introduce a way to avoid std handle
 inheritance
In-Reply-To: <cover.1509382976.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1509556153.git.johannes.schindelin@gmx.de>
References: <cover.1509382976.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pk5myS1ehP/9GFwYJ+YAEF/P7RM7B+2cZk5i+n4ptXRZ7h5J8XI
 JGFEKVSj5TFt+1ipV6y6j51IWsI5gaugQO7X0i1YMiRo/sB98pi4tPvij7F67eRdk20WJhs
 ZAxqxabL7fVLf/fbrWvobyCZnLGBEUM/cx3gOVRsJqBDtnDhb6auLoMC5+pqcF2pFbAe7hQ
 VT7EGxNVyKYj8YHh1rnEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2Wl2u+di/qU=:sRpEUOpgI2mOc5yc5zSI8b
 6z+X2pCBfgjnrfO5sdGf2VlodkgYTA6rimvdIde7T1X2QuV2MBKkfnNY0p1vKtVuIXh8oFbQ6
 /JMQoyUI76HgqNlIswnDuFjAKw3mTn/HrXBMaQW4Na8HpDjKYcJtlzkQcRjOycveN1AncEHvH
 syGHPTOmIpXmpucegO1bpobM4O0O5gz9Zb/dTaHl+KmcwEaJFmb3XXyiCSCjBu6AeryvhXOSu
 GERTCI/wRJxpWmg7B86zvclkLCfXexe5jrk7JLIk+806NV3BmD6J7NmJMkLCSDoAJiBsxis/F
 Z363ahuFznyRvWYRt3qQJd9jiCm9B65UaOrVBviJqSNEUWInVmouKyQBFy9vaqw5sJ9Mp/dbz
 mPGn6uQgmwO1+kfqhEN4a4TOwOgsrHDNUbfd9VceE5fR4AV4sWvjjGaagLO7IYdsrGRoVUMCp
 Bkkf5JtLhAaDgfqAxV3G47Z9jzw3yn6MO3zaU2GAt2PRICE5iTxIWFam73StdcBBiMHCsXyfE
 KZKGHMtzvQGvjCKwmUsNh1z3aM6kqsFjOM6wdfEXnGE5SwPRW9m3yy10KEUzPZVKnQiPFIazn
 QayipWjXOnHU2kCk97xTsil9YMvI76gJQ8DWz64n0AMrj7XU4DjJmGFZCu5h6zfXvFb7PUwih
 LcSCegWNUsBHXpa05+5WYHtoPWeUe+IuqiVEDC28qd9n059QXuGp2+gytUgvVF4rera708jZy
 k/ovSi1wOIfp5/fMJ1e37V8g7Gb1EngRPTgvudTtkWG9B3dIknwjhM00t0IbvwqfORuTV61Uq
 8zh5q6ioTY30F6xxTsJY29Y42WbP+2nbIeTSrN7vpVnnu3SzGYjUqYc4sVBrzSs0xJvmIkf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Particularly when calling Git from applications, such as Visual Studio,
it is important that stdin/stdout/stderr are closed properly. However,
when spawning processes on Windows, those handles must be marked as
inheritable if we want to use them, but that flag is a global flag and
may very well be used by other spawned processes which then do not know
to close those handles.

As a workaround, introduce handling for the environment variables
GIT_REDIRECT_STD* to read/write from/to named pipes instead
(conceptually similar to Unix sockets, for you Linux folks). These do
not need to be marked as inheritable, as the process can simply open the
named pipe. No global flags. No problems.

This feature was introduced as an experimental feature into Git for
Windows v2.11.0(2) and has been tested ever since. I feel it is
well-tested enough that it can be integrated into core Git.

Changes since v1:

- clarified what the values of the environment variables mean.

- the feature is no longer marked experimental (I actually expected *some*
  remark about this, but it seems nobody looked at that patch all that closely
  *frown*)

- edited all commit messages heavily (primarily prodded by Jonathan's feedback).


Johannes Schindelin (3):
  mingw: add experimental feature to redirect standard handles
  mingw: optionally redirect stderr/stdout via the same handle
  mingw: document the standard handle redirection

 Documentation/git.txt | 18 ++++++++++++++++
 compat/mingw.c        | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0001-init.sh       | 12 +++++++++++
 3 files changed, 88 insertions(+)


base-commit: cb5918aa0d50f50e83787f65c2ddc3dcb10159fe
Published-As: https://github.com/dscho/git/releases/tag/redirect-std-handles-v2
Fetch-It-Via: git fetch https://github.com/dscho/git redirect-std-handles-v2

Interdiff vs v1:
 diff --git a/Documentation/git.txt b/Documentation/git.txt
 index 10a98603b39..463b0eb0f5c 100644
 --- a/Documentation/git.txt
 +++ b/Documentation/git.txt
 @@ -712,14 +712,15 @@ of clones and fetches.
  `GIT_REDIRECT_STDIN`::
  `GIT_REDIRECT_STDOUT`::
  `GIT_REDIRECT_STDERR`::
 -	(EXPERIMENTAL) Windows-only: allow redirecting the standard
 -	input/output/error handles. This is particularly useful in
 -	multi-threaded applications where the canonical way to pass
 -	standard handles via `CreateProcess()` is not an option because
 -	it would require the handles to be marked inheritable (and
 -	consequently *every* spawned process would inherit them, possibly
 -	blocking regular Git operations). The primary intended use case
 -	is to use named pipes for communication.
 +	Windows-only: allow redirecting the standard input/output/error
 +	handles to paths specified by the environment variables. This is
 +	particularly useful in multi-threaded applications where the
 +	canonical way to pass standard handles via `CreateProcess()` is
 +	not an option because it would require the handles to be marked
 +	inheritable (and consequently *every* spawned process would
 +	inherit them, possibly blocking regular Git operations). The
 +	primary intended use case is to use named pipes for communication
 +	(e.g. `\\.\pipe\my-git-stdin-123`).
  +
  Two special values are supported: `off` will simply close the
  corresponding standard handle, and if `GIT_REDIRECT_STDERR` is
-- 
2.15.0.windows.1

