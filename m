Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 076381F437
	for <e@80x24.org>; Fri, 27 Jan 2017 22:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750755AbdA0WiK (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 17:38:10 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36495 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbdA0WiI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 17:38:08 -0500
Received: by mail-qk0-f170.google.com with SMTP id 11so77521648qkl.3
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 14:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ctx/LHsL7Xm3aBaW2tLeHv0+CwBdKzEm4bnWViEzQj8=;
        b=e5yw+5IekFg6MTGKFOmkeSG3wNnAHcN2Ci+BK1EgXFzr7JnDxM0ZvCgA4GFn9MMbUW
         rJj8ctJiA/Yd+dtD+dv1ycMN/lPOpmgj3dcCs6IEd7oiRdKgF0xiWLKt2gFCilfnyFc1
         mzN6ypGniRWDaY8NSfZrLEA1XhKK1Nhdfwtd8n+1h05hATyKzN4Oimh0Jiq+O39CSqSl
         rbPex2y3w75UYei+QwYLHppjJdBrFzpIt0vR83VjJ2CboMPnRYUwj+/kW+jtxwNbOoV0
         OxgHGjy5rgnoaEPMejoFVBayLQyp1lJ6jQWzpM/FKpPRJzrGGSjlkvE8RCH3PAg0T03a
         hfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ctx/LHsL7Xm3aBaW2tLeHv0+CwBdKzEm4bnWViEzQj8=;
        b=PJQFF7DRXwgNRHLW/4at9Ho4w27HkjYvjQ4OqB5LmYVOheBJnhYUgMRjMWIFHUV77J
         JHOQGOyYWS9/Z3bZxIUnFmHf1ndbAtfaJO8KY5fqG9B5uJjbqXv3lyoSk0GsxRoXAxpg
         8LdBjkYFA8Kb+QN6GhfLboV4oDCp7XL4RwHk40KLRgKx23ySRs4m0OBOVl26QwrOES4h
         fFm37CMJNW3oso5Tl0/WOnV9lric7cXbHPgJIA+Vik8g2H0KeSOcMBHfdN9ClextC958
         j4RuRLHw8EZF7nbiKzWZ8LgXLDFLeVgf1Oe+YliJHk490MASYjN9XEyeXXTz/eRYT4H/
         CrKw==
X-Gm-Message-State: AIkVDXIgkcgmaQiLxgYAbWxnkMrah/cVBFerROiL3D7Dy8xxKXwkbbnbB/Uw/E6LCCQnFoNASI0qJYllzacxTw==
X-Received: by 10.55.178.133 with SMTP id b127mr4963587qkf.170.1485556296287;
 Fri, 27 Jan 2017 14:31:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.55.89.196 with HTTP; Fri, 27 Jan 2017 14:31:15 -0800 (PST)
From:   tsuna <tsunanet@gmail.com>
Date:   Fri, 27 Jan 2017 14:31:15 -0800
Message-ID: <CAFKYj4cMSK5nQ1nS66c4Opz8y7x+xQH+OdW8PTi7LmCiGBP1ZA@mail.gmail.com>
Subject: Deadlock between git-remote-http and git fetch-pack
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,
While investigating a hung job in our CI system today, I think I found
a deadlock in git-remote-http

Git version: 2.9.3
Linux (amd64) kernel 4.9.0

Excerpt from the process list:

jenkins  27316  0.0  0.0  18508  6024 ?        S    19:30   0:00  |
               \_ git -C ../../../arista fetch --unshallow
jenkins  27317  0.0  0.0 169608 10916 ?        S    19:30   0:00  |
                   \_ git-remote-http origin http://gerrit/arista
jenkins  27319  0.0  0.0  24160  8260 ?        S    19:30   0:00  |
                       \_ git fetch-pack --stateless-rpc --stdin
--lock-pack --include-tag --thin --no-progress --depth=3D2147483647
http://gerrit/arista/

Here PID 27319 (git fetch-pack) is stuck reading on stdin, while its
parent, PID 27317 (git-remote-http) is stuck reading on its child=E2=80=99s
stdout.  Nothing has moved for like 2h, it=E2=80=99s deadlocked.

> strace -fp 27319
strace: Process 27319 attached
read(0,

Here FD 0 is a pipe:

~ @8a33a534e2f7> lsof -np 27319 | grep 0r
git     27319 jenkins    0r  FIFO   0,10      0t0 354519158 pipe

The writing end of which is owned by the parent process:

~ @8a33a534e2f7> lsof -n 2>/dev/null | fgrep 354519158
git-remot 27317                jenkins    4w     FIFO   0,10      0t0
354519158 pipe
git       27319                jenkins    0r     FIFO   0,10      0t0
354519158 pipe

And the parent process (git-remote-http) is stuck reading from another FD:

> strace -fp 27317
strace: Process 27317 attached
read(5,

And here FD 5 is another pipe:

~ @8a33a534e2f7> lsof -np 27317 | grep 5r
git-remot 27317 jenkins    5r  FIFO   0,10      0t0 354519159 pipe

Which is the child=E2=80=99s stdout:

> lsof -n 2>/dev/null | fgrep 354519159
git-remot 27317                jenkins    5r     FIFO   0,10      0t0
354519159 pipe
git       27319                jenkins    1w     FIFO   0,10      0t0
354519159 pipe

Hence the deadlock.

Stack trace in git-remote-http:

(gdb) bt
#0  0x00007f04f1e1363d in read () from target:/lib64/libpthread.so.0
#1  0x0000562417472d73 in xread ()
#2  0x0000562417472f2b in read_in_full ()
#3  0x0000562417438a6e in get_packet_data ()
#4  0x0000562417439129 in packet_read ()
#5  0x00005624174245e0 in rpc_service ()
#6  0x0000562417424f10 in fetch_git ()
#7  0x00005624174233fd in main ()

Stack trace in git fetch-pack:

(gdb) bt
#0  0x00007fb3ab478620 in __read_nocancel () from target:/lib64/libpthread.=
so.0
#1  0x000055f688827283 in xread ()
#2  0x000055f68882743b in read_in_full ()
#3  0x000055f6887ce35e in get_packet_data ()
#4  0x000055f6887cea19 in packet_read ()
#5  0x000055f6887ceb90 in packet_read_line ()
#6  0x000055f68879dd05 in get_ack ()
#7  0x000055f68879f6b4 in fetch_pack ()
#8  0x000055f688710619 in cmd_fetch_pack ()
#9  0x000055f6886dff7b in handle_builtin ()
#10 0x000055f6886df026 in main ()

I looked at the diff between v2.9.3 and HEAD on fetch-pack.c and
remote-curl.c and didn=E2=80=99t see anything noteworthy in that area of th=
e
code, so I presume the bug is still there in master.

--=20
Benoit "tsuna" Sigoure
