From: Douglas Mencken <dougmencken@gmail.com>
Subject: [regression] Newer gits cannot clone any remote repos
Date: Mon, 12 Nov 2012 11:32:44 -0500
Message-ID: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 17:33:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXwwW-0004b0-Dz
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 17:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab2KLQcr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2012 11:32:47 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35974 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab2KLQcq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2012 11:32:46 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so4792769lbo.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 08:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=jG1FaAk8oPtYqs1YonrwX/zyScsHnsV0e39mwvTEht4=;
        b=lhHap7t4L5w+1VfirmX/oF0osoAx7UFKaW22ehaqV0cqmJjsB/JyUE9u+s03n928rP
         AfAqzvQEsbQbxaZejXkK1WeQkFgGBwblTCPt5dDl3rK3vsFwp8U5vLTMdWsAuy0I1/bJ
         pjeazJc2FlF66IfNe0IOpXJt6aRPm83Hw/oItWCKYw3yknKE/dHyaSX8ZndVWSz53Hqs
         XWM9blBeYOEoovz7LDQwgRS7pR5RBqGk/jeD+P1PpO+Wl+TNiDs/GUCphTkl/qqDj/zF
         m29lZwJJGe0jePyMP3SJYfNRVL2kLWCTLMj4o4+wORQ/KVtMGJX4wiv7eqZi4KVnCoBp
         KLpw==
Received: by 10.112.26.130 with SMTP id l2mr685272lbg.41.1352737964159; Mon,
 12 Nov 2012 08:32:44 -0800 (PST)
Received: by 10.112.22.6 with HTTP; Mon, 12 Nov 2012 08:32:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209484>

*Any* git clone fails with:

fatal: premature end of pack file, 106 bytes missing
fatal: index-pack failed

At first, I tried 1.8.0, and it failed. Then I tried to build 1.7.10.5
then, and it worked. Then I tried 1.7.12.2, but it fails the same way
as 1.8.0.
So I decided to git bisect.

b8a2486f1524947f232f657e9f2ebf44e3e7a243 is the first bad commit
``index-pack: support multithreaded delta resolving''

-----------------------------------------------------------------------=
---------

b8a2486f1524947f232f657e9f2ebf44e3e7a243 is the first bad commit
commit b8a2486f1524947f232f657e9f2ebf44e3e7a243
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Sun May 6 19:31:55 2012 +0700

    index-pack: support multithreaded delta resolving

    This puts delta resolving on each base on a separate thread, one ba=
se
    cache per thread. Per-thread data is grouped in struct thread_local=
=2E
    When running with nr_threads =3D=3D 1, no pthreads calls are made. =
The
    system essentially runs in non-thread mode.

    An experiment on a Xeon 24 core machine with git.git shows that
    performance does not increase proportional to the number of cores. =
So
    by default, we use maximum 3 cores. Some numbers with --threads fro=
m 1
    to 16:

    1..4
    real    0m8.003s  0m5.307s  0m4.321s  0m3.830s
    user    0m7.720s  0m8.009s  0m8.133s  0m8.305s
    sys     0m0.224s  0m0.372s  0m0.360s  0m0.360s

    5..8
    real    0m3.727s  0m3.604s  0m3.332s  0m3.369s
    user    0m9.361s  0m9.817s  0m9.525s  0m9.769s
    sys     0m0.584s  0m0.624s  0m0.540s  0m0.560s

    9..12
    real    0m3.036s  0m3.139s  0m3.177s  0m2.961s
    user    0m8.977s  0m10.205s 0m9.737s  0m10.073s
    sys     0m0.596s  0m0.680s  0m0.684s  0m0.680s

    13..16
    real    0m2.985s  0m2.894s  0m2.975s  0m2.971s
    user    0m9.825s  0m10.573s 0m10.833s 0m11.361s
    sys     0m0.788s  0m0.732s  0m0.904s  0m1.016s

    On an Intel dual core and linux-2.6.git

    1..4
    real    2m37.789s 2m7.963s  2m0.920s  1m58.213s
    user    2m28.415s 2m52.325s 2m50.176s 2m41.187s
    sys     0m7.808s  0m11.181s 0m11.224s 0m10.731s

    Thanks Ramsay Jones for troubleshooting and support on MinGW platfo=
rm.

    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:040000 040000 e5597fe041cd7985648030c8cf1cc35ea57786bb
6e64f3e76b350c04c9d0c435e0a53b89e0821339 M      Documentation
:100644 100644 cf2c40b44f8383d002235400660d76ef7f6de33c
e41955ff955693ddc78722c14fff2a6e98663a46 M      Makefile
:040000 040000 1e6b5ac5f11bf7ba3eff7b5be4410bad379feee6
85bc79414f00b7fc3698c069161ea10039641082 M      builtin
:040000 040000 04916545d959c8af772cd3a2de5e6b470529bea1
325c8c748dd41d469135db84c7621d8225cc1cdd M      t

$ git bisect log
    git bisect start
    # bad: [d8cf053dacb4f78920c112d10c7be21e4f5a5817] Git 1.7.12.2
    git bisect bad d8cf053dacb4f78920c112d10c7be21e4f5a5817
    # good: [785ee4960c3d334cbc2b17ab74d2cebdf1b4db64] Git 1.7.10.5
    git bisect good 785ee4960c3d334cbc2b17ab74d2cebdf1b4db64
    # bad: [d692d34653f74be6b16add3e993e957f33fe049b] Merge branch
'rs/git-blame-mapcar-mapc'
    git bisect bad d692d34653f74be6b16add3e993e957f33fe049b
    # good: [73ff8cf784b6ee447072fad6c06fd0eef0e9c9f6] Merge branch
'lp/diffstat-with-graph'
    git bisect good 73ff8cf784b6ee447072fad6c06fd0eef0e9c9f6
    # bad: [7903e66a3e10e98f29fc9524c13274376bae5303] Merge branch
'mh/test-keep-prove-cache'
    git bisect bad 7903e66a3e10e98f29fc9524c13274376bae5303
    # good: [499e7b31509cfbb59dcb2a046f8e2fd1a3e73d6f] Merge branch
'jc/install-no-hardlinks'
    git bisect good 499e7b31509cfbb59dcb2a046f8e2fd1a3e73d6f
    # bad: [2e464dd5b220d4d2d8a16d5c43efe7af3c9adda9] Merge branch
'rs/xdiff-lose-emit-func'
    git bisect bad 2e464dd5b220d4d2d8a16d5c43efe7af3c9adda9
    # good: [8fbe0db4fce68ed8239742b14e9d77d45201870b] Merge branch
'master' of git://github.com/git-l10n/git-po
    git bisect good 8fbe0db4fce68ed8239742b14e9d77d45201870b
    # bad: [2b26b65f9abc77c4af87626452005a73edda0c8f] git-svn: clarify
the referent of dcommit's optional argument
    git bisect bad 2b26b65f9abc77c4af87626452005a73edda0c8f
    # bad: [cc13431a49800a6a1d2b7ff0b94f67da0fecdbab] Merge branch
'nd/threaded-index-pack'
    git bisect bad cc13431a49800a6a1d2b7ff0b94f67da0fecdbab
    # bad: [b8a2486f1524947f232f657e9f2ebf44e3e7a243] index-pack:
support multithreaded delta resolving
    git bisect bad b8a2486f1524947f232f657e9f2ebf44e3e7a243
    # good: [5272f75587abb4cb396059ecbf1a6130bb2e69d3] index-pack:
restructure pack processing into three main functions
    git bisect good 5272f75587abb4cb396059ecbf1a6130bb2e69d3

$ git bisect reset
Previous HEAD position was 5272f75... index-pack: restructure pack
processing into three main functions
HEAD is now at d8cf053... Git 1.7.12.2
