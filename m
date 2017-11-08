Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F461F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 16:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbdKHQ6Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 11:58:25 -0500
Received: from a27-143.smtp-out.us-west-2.amazonses.com ([54.240.27.143]:45526
        "EHLO a27-143.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752364AbdKHQ6Y (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2017 11:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1510160304;
        h=Content-Type:From:To:Subject:Message-ID:Date:Content-Transfer-Encoding:MIME-Version:Feedback-ID;
        bh=edzGhSrOAvWF71heTcdsexJqkT6JbiwsZXr3AjBzDDk=;
        b=cF7rVz9nkYdPtOXOXAmfQarsVmMbfD0K4CJVtfKe01aHe1SiVfgYdHp9fjqxnDYt
        Nrf0tpVRNklel+E+josmLBdiFxVzHSSzyg1QbHbZ6l8kzVbmtLBcMjt4Qa9InfhuHcN
        ymOYXGgvbq4AxEqq4K3giTYwoULfKjvJoIAXAb5Q=
Content-Type: text/plain
From:   mqudsi@neosmart.net
To:     git@vger.kernel.org
Subject: Invalid memory access in `git apply`
Message-ID: <0101015f9c91871f-2f750aec-6877-4e29-9c15-c8399670dd48-000000@us-west-2.amazonses.com>
Date:   Wed, 8 Nov 2017 16:58:23 +0000
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-SES-Outgoing: 2017.11.08-54.240.27.143
Feedback-ID: 1.us-west-2.PCEy91/Vd+GU67P48MglE9FKtQG6qQD9MhgwC/YKQRM=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

**Resending as it seems that the attachments caused the last email to wind =
up
in a black hole**

There seems to be bug in the `git apply` that leads =
to out-of-bounds memory
access when --ignore-space-change is combined with =
--inaccurate-eof and
applying a patch.

On occasion, this can lead to error=
 output like the following:

	 mqudsi@ZBook ~> git apply =
--ignore-space-change --ignore-whitespace
	 --allow-overlap =
--inaccurate-eof without_whitespace.diff
	 *** Error in `git': malloc(): =
memory corruption: 0x0000000002543530 ***
	 =3D=3D=3D=3D=3D=3D=3D =
Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
	 /lib/x86_64-linux-gnu/libc.so.=
6(+0x777e5)[0x7fdda79c77e5]
	 /lib/x86_64-linux-gnu/libc.so.=
6(+0x8213e)[0x7fdda79d213e]
	 /lib/x86_64-linux-gnu/libc.so.=
6(__libc_malloc+0x54)[0x7fdda79d4184]
	 /lib/x86_64-linux-gnu/libc.so.=
6(_IO_file_doallocate+0x55)[0x7fdda79bd1d5]
	 /lib/x86_64-linux-gnu/libc.so=
.6(_IO_doallocbuf+0x34)[0x7fdda79cb594]
	 /lib/x86_64-linux-gnu/libc.so.=
6(_IO_file_overflow+0x1c8)[0x7fdda79ca8f8]
	 /lib/x86_64-linux-gnu/libc.so.=
6(_IO_file_xsputn+0xad)[0x7fdda79c928d]
	 /lib/x86_64-linux-gnu/libc.so.=
6(fputs+0x98)[0x7fdda79be0c8]
	 git[0x5386cd]
	 git[0x538714]
	 git[0x538940]
	 git[0x40e220]
	 git[0x410a10]
	 git[0x41256e]
	 git[0x412df7]
	 git[0x415935]
	 git[0x406436]
	 git[0x40555c]

The original file being patched (clipboard.vim) and the patch file that I =
had
attempted to apply (without_whitespace.diff) are attached, along with =
the
full, unabridged output of the memory map as a result of the =
out-of-bounds
access (memory_map.txt).

The memory map output was generated=
 under git 2.7.4; repeated attempts to
reproduce the memory map dump with =
both 2.7.4 and 2.15 produce the following
output:

	 mqudsi@ZBook ~/.=
c/nvim> git apply --ignore-space-change  --inaccurate-eof
	 --whitespace=3Dfix without_whitespace.diff
	 fatal: BUG: caller =
miscounted postlen: asked 248, orig =3D 251, used =3D 249

Mahmoud Al-Qudsi
NeoSmart Technologies

--Attachments--

* clipboard.vim: http://termbin.=
com/u25t
* without_whitespace.diff: http://termbin.com/bu9y
* memory_map.txt: http://termbin.com/cboz


