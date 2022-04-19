Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF09C433FE
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 19:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357436AbiDSTC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 15:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357528AbiDSTCb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 15:02:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F76C04
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 11:59:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y20so14686062eju.7
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=c+P0eYAuVEAAeLZIMq6Zu+QKNnTL4TEtcPcm8GtiFVQ=;
        b=IMhnMQC7J790Y9OGjgcmvjzhbA+NP1V8w3lmEeAJuQ/uyaHoj4vHlZdKicir2yVYG/
         vQoqsYc5RbK2tYa9NfAVVQn3tvJ77LUaBidpW1r71cQlkJj/OawQkSuYOSqHroEkDuvb
         sR0INadsGrPHKJEpYifvVbSjNm/+vDiWsWugYBGfXuLz189bBcg7mw0AWMOlWTlotzWf
         0uKPPJYpii/CPI/S7WKmoPQzrmZGqAhq9oc2Nc6TcdZ/oKw4TRew1+LWwnkNeYo0Qo3S
         99AZxMoDfCHqe+kVjjoLnq4+NwsLdaHZ8Gzrdov0oyeo3lL79re2fAFfHVhTrCn+L1H/
         BumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=c+P0eYAuVEAAeLZIMq6Zu+QKNnTL4TEtcPcm8GtiFVQ=;
        b=nHo0ii1osbnUvCXcgy+AlTnCA5+kazPj+jKw0v0wFNqIaUHaZ8JQqgtH2DxWsLi3tX
         x9YLpNZ4saAUGy2MQjKPDHCGIaht/FezmCJmK+SqIaA2JlyWLZNVheULu8tqqc/3ar1l
         xOJeGWSk8ornSrIuu5I/FXOtB+FGMaJXoz7yULmseq8anolCQx5Zm9Gp6zb5qGfoo6BO
         RV0+gwzi90HvAXCXdKbxcoovmZBWy/63LA1orF/Sfl9LYUfHglnCUPpSYZCXNJZo4Wtm
         OE5a20yTCaOcbLazc/nBesH155KaKNaoALELhs2Fchb0y7CIVvMx17Gg3foTMPbHhFq9
         SmmQ==
X-Gm-Message-State: AOAM530EP4BHDbrPFtnK5+nPf2bP3qk/DZxH9Nk2+s+Bp18vttYg75b7
        0x3zZgFXNDZHiqvgji/XAGBRrsguA+dd1LqqtHnfwhjT1s2NZQ==
X-Google-Smtp-Source: ABdhPJzk4h/3tYo3hq5Sji/+H9Q4iYvdIGAoSsoGF5Hk2wt2wrcriKhJ3kVdmRDwSjPROp2YkKLVHf57a4+WPzxvaV4=
X-Received: by 2002:a17:906:2bd4:b0:6e8:7e5:39b6 with SMTP id
 n20-20020a1709062bd400b006e807e539b6mr14717306ejg.25.1650394785491; Tue, 19
 Apr 2022 11:59:45 -0700 (PDT)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 19 Apr 2022 14:59:36 -0400
Message-ID: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
Subject: git 2.36.0 regression: pre-commit hooks no longer have stdout/stderr
 as tty
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

here's the shortest reproduction --

```console
$ cat ../testrepo/.git/hooks/pre-commit
#!/usr/bin/env bash
if [ -t 1 ]; then
    echo GOOD
fi
```

in previous git versions:

```
$ git commit -q --allow-empty -m foo
GOOD
$
```

with git 2.36.0:

````
$ git commit -q --allow-empty -m foo
$
```

why I care: I maintain a git hooks framework which uses `isatty` to
detect whether it's appropriate to color the output.  many tools
utilize the same check.  in 2.36.0+ isatty is false for stdout and
stderr causing coloring to be turned off.

I bisected this (it was a little complicated, needed to force a pty):

`../testrepo`: a git repo set up with the hook above

`../bisect.sh`:

```bash
#!/usr/bin/env bash
set -eux
git clean -fxfd >& /dev/null
make -j6 prefix=3D"$PWD/prefix" NO_GETTEXT=3D1 NO_TCLTK=3D1 install >& /dev=
/null
export PATH=3D"$PWD/prefix/bin:$PATH"
cd ../testrepo
(../pty git commit -q --allow-empty -m foo || true) | grep GOOD
```

`../pty`:

```python
#!/usr/bin/env python3
import errno
import os
import subprocess
import sys

x: int =3D 'nope'


class Pty(object):
    def __init__(self):
        self.r =3D self.w =3D None

    def __enter__(self):
        self.r, self.w =3D os.openpty()

        return self

    def close_w(self):
        if self.w is not None:
            os.close(self.w)
            self.w =3D None

    def close_r(self):
        assert self.r is not None
        os.close(self.r)
        self.r =3D None

    def __exit__(self, exc_type, exc_value, traceback):
        self.close_w()
        self.close_r()


def cmd_output_p(*cmd, **kwargs):
    with open(os.devnull) as devnull, Pty() as pty:
        kwargs =3D {'stdin': devnull, 'stdout': pty.w, 'stderr': pty.w}
        proc =3D subprocess.Popen(cmd, **kwargs)
        pty.close_w()

        buf =3D b''
        while True:
            try:
                bts =3D os.read(pty.r, 4096)
            except OSError as e:
                if e.errno =3D=3D errno.EIO:
                    bts =3D b''
                else:
                    raise
            else:
                buf +=3D bts
            if not bts:
                break

    return proc.wait(), buf, None


if __name__ =3D=3D '__main__':
    _, buf, _ =3D cmd_output_p(*sys.argv[1:])
    sys.stdout.buffer.write(buf)
```

the first commit it points out:

```
f443246b9f29b815f0b98a07bb2d425628ae6522 is the first bad commit
commit f443246b9f29b815f0b98a07bb2d425628ae6522
Author: Emily Shaffer <emilyshaffer@google.com>
Date:   Wed Dec 22 04:59:40 2021 +0100

    commit: convert {pre-commit,prepare-commit-msg} hook to hook.h

    Move these hooks hook away from run-command.h to and over to the new
    hook.h library.

    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
    Acked-by: Emily Shaffer <emilyshaffer@google.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 commit.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)
bisect run success
```


Anthony
