Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A23C120A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 18:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbeLNS3V (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 13:29:21 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:51297 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbeLNS3V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 13:29:21 -0500
Received: by mail-it1-f170.google.com with SMTP id x19so10261751itl.1
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 10:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=i6I5Y3C+bADjNVeUHwfxrm1+2xG6BYw1Mkv81S93Yt0=;
        b=EkYL20lJlJPxgWeDRcHlDHMHafoClJRyMALNb5zsk8TbTu042BQQnol4xyMApn5/Nj
         QubTTTlMHqrWeIXCGPfNmRtjqROUcLzzuIczvnJ93WmNduvGUavVxjsQxEB29b/ARsBe
         P4PNb41gYvB8CGeeJAbKs+P7/gxrr4XfG090IY0sU48IdNLXO6uwarb8vyqdGAXIop7C
         zkfT8ApLR0f/UV3qMIbHi1g052OWOUZNC5oxl8sjIZFlmu8wt1Yorwy5ZoYz+1I2otXk
         Kjb1urAPedXddqRBNzHj335MlV/XPGj9Q6yF67FuJdWIMpmvYeQ3Y6ZolCf3KFzmWY6s
         wz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=i6I5Y3C+bADjNVeUHwfxrm1+2xG6BYw1Mkv81S93Yt0=;
        b=cRjTNQ0IbCF4392va/4QGjijfib5cIR+HvNCPVpoUh5HLCoHrCaIKQe8Gk/1kdQqgk
         vw2cN3X6Q3P6Q/ptHON3jmbmo7A4vo/QOcWQnTjfU0GWtn+nBbMR1j+9GD3z9SbzSa6e
         bhD2d3EQmi225COczt6lqi865MnMoWaNzNLZxpY+Ky5QzLjKl556a/VhLIyk72SWiDmI
         1NCsjLOslnWlHJh0ZpjHWuCNq8NknCQCW9s+iHx1qclrXe4lqlXCJ5vP96qg4vlVFkIZ
         VKM+iZ2AcSZtA22CjAHEeemLYs3+8RUVtGd7KjoPdUnwjxmBoUiEmyIpmu3QQlEIQXlk
         Mg1A==
X-Gm-Message-State: AA+aEWbKyFwK3EDJEVHidinu/5MiiAnWuO0EltxF3dttyGw6NRvA4nBc
        cbhqnzer4gW13hnehzuFcfFwN3xtH637O0E2ydEKNIbvoZI=
X-Google-Smtp-Source: AFSGD/WcVa/vUY2I7kGpy41IFiqJa7QTmUjq9VKgKyBNI9H3OuP4KjmDd60ilamyNOiP8A0DFv7UIVS8MI6SoZciObQ=
X-Received: by 2002:a24:cfc4:: with SMTP id y187mr4130340itf.144.1544812159363;
 Fri, 14 Dec 2018 10:29:19 -0800 (PST)
MIME-Version: 1.0
From:   Clement Moyroud <clement.moyroud@gmail.com>
Date:   Fri, 14 Dec 2018 10:29:17 -0800
Message-ID: <CABXAcUzoNJ6s3=2xZfWYQUZ_AUefwP=5UVUgMnafKHHtufzbSA@mail.gmail.com>
Subject: Git blame performance on files with a lot of history
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My group at work is migrating a CVS repo to Git. The biggest issue we
face so far is the performance of git blame, especially compared to
CVS on the same file. One file especially causes us trouble: it's a
30k lines file with 25 years of history in 3k+ commits. The complete
repo has 200k+ commits over that same period of time.

Currently, 'cvs annotate' takes 2.7 seconds, while 'git blame'
(without -M nor -C) takes 145s.

I tried using the commit-graph with the Bloom filter, per
https://public-inbox.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com=
/.
No dice:
    > time GIT_TEST_BLOOM_FILTERS=3D1
/wv/cmoyroud/calibre-src/git-bloom-filters/git-bloom-bin/bin/git
commit-graph write --reachable
    Annotating commits in commit graph: 573705, done.
    Computing commit graph generation numbers: 100% (286441/286441), done.
    Computing commit diff Bloom filters: 100% (286441/286441), done.
    GIT_TEST_BLOOM_FILTERS=3D1  commit-graph write --reachable  386.80s
user 31.78s system 78% cpu 8:53.87 total
    > time GIT_TEST_BLOOM_FILTERS=3D1 GIT_TRACE_BLOOM_FILTER=3D2
GIT_USE_POC_BLOOM_FILTER=3Dy /path/to/git blame master --
important/file.C > /tmp/foo.compiler.bloom
    Blaming lines: 100% (33179/33179), done.
    GIT_TEST_BLOOM_FILTERS=3D1 GIT_TRACE_BLOOM_FILTER=3D2
GIT_USE_POC_BLOOM_FILTER=3Dy   145.11s user 0.97s system 99% cpu 2:26.22
total
    > time /path/to/git blame master -- important/file.C >
/tmp/foo.compiler.nobloom
    Blaming lines: 100% (33179/33179), done.
    GIT_TEST_BLOOM_FILTERS=3D1 GIT_TEST_BLOOM_FILTERS=3D1
GIT_USE_POC_BLOOM_FILTER=3Dy   141.69s user 0.77s system 99% cpu 2:22.56
total

I used Derrick Stolee's tree at
https://github.com/derrickstolee/git/tree/bloom/stolee

Looking at the blame code, it does not seem to be able to use the
commit graph, so I tried the same rev-list command from the e-mail,
using my own file:
    > GIT_TRACE_BLOOM_FILTER=3D2 GIT_USE_POC_BLOOM_FILTER=3Dy
/path/to/git rev-list --count --full-history HEAD -- important/file.C
    3576

No trace information there either. Running 'strings' on the binary
reports the env. variable names, so I'm not totally crazy. Let me know
if I tried the right thing :)

Looks like blame performance is gonna be the biggest issue for us, so
I'm really interested in seeing improvements there. Let me know if
there's anything else I can try.

Cheers,

Cl=C3=A9ment
