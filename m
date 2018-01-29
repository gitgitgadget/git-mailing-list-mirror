Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0F81F404
	for <e@80x24.org>; Mon, 29 Jan 2018 16:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeA2Qsd (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 11:48:33 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38672 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeA2Qsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 11:48:32 -0500
Received: by mail-wm0-f53.google.com with SMTP id 141so34825604wme.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 08:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowanthorpe.com; s=base;
        h=mime-version:from:date:message-id:subject:to;
        bh=EZdFhXY7o85XohXSaQfpMuOtYSFYs+ikGyCqNk6khOc=;
        b=ANZYrVwl5d9my7JhLQ7Zvf1y2cI0+kApWRzLkQ5DBMFpoxp6vZjmv+JGkRSQbNefLu
         Y245k5ws2qCCHJjevvw+EDFXSyzdnm2HSHR7AhmbbmFVm0vwBMYqsg3RhElH6fUXpwN/
         lHorhl47/j9dQpFGIF3ZjEEkxo1WUHj5AIQtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EZdFhXY7o85XohXSaQfpMuOtYSFYs+ikGyCqNk6khOc=;
        b=B5SFxhPB0aIRC52d2WJPmgvZ5myhCB7mX/xBUojkm3+7q9OdZW4CmZ1yuFwLBJIMHJ
         DlTEAkK4PBf8JMPpqgq4qnP3yxDzNVxzlSopmjOF4vb0EbIr9sJIBl0FVhWLJGsyIrz6
         hvMDFs86+zzWa1RWTC9l5BN0kCa+7l0IKEyZe/TZLi6hyg9LfLql6ClzNcuiv5LqSlWz
         TrFdGJ278CCa3LqPCyJyJybKSjDfAPneHGkfteNxbonPfRZxZVf7xlY0hFsD3AewEC0+
         ZvS67nt5g4HrF3ltE+AtKd1JzHA+K7/Ha2wFfzLZzB5DA1TmTs5vL4ILRb3u93HT0LGx
         ilMQ==
X-Gm-Message-State: AKwxytdp+iBoa+B4mDjAfu48nzG+/rTnIUyLlSZv09uy2pPWI8H3QgXa
        lhSWaRy/68K6j26h2VW3vvX6CFTYSD8v6ADEqWwrNn4KLEQ=
X-Google-Smtp-Source: AH8x226ct/WuF15JaFiMKlfB+/BOF9HhxBjly1BbAzskgFI+ggmsu3IGy3IG1+ACafCgAOlblTs19aIz6EZoAZcXUlY=
X-Received: by 10.80.230.148 with SMTP id z20mr45792009edm.61.1517244511071;
 Mon, 29 Jan 2018 08:48:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.176.69 with HTTP; Mon, 29 Jan 2018 08:47:50 -0800 (PST)
X-Originating-IP: [79.166.136.209]
From:   Rowan Thorpe <rowan@rowanthorpe.com>
Date:   Mon, 29 Jan 2018 18:47:50 +0200
Message-ID: <CACgDUr6XG+dZ+GJcf9+11Edf=q-=QLSkmgpGf=XmondaLaescA@mail.gmail.com>
Subject: "git fast-import" crashes parsing output from "fossil export --git"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git fast-import" fails while trying to import the latest "Fossil"
fossil-sources (it dog-foods its own source-code). Namely, the below
pasted commands caused the crash report below them (I've trimmed
irrelevant noise from the report for brevity). One of the tests
included in Fossil uses example-files to test its handling of
filenames with special characters - in this case an embedded newline
in "abc[NEWLINE]def.txt" - and "git fast-import" causes the second
part of that filename (post-newline) to spill over as the "command" on
the next line of its input when transforming the "fossil export"
output into usable input. Considering git can handle such filenames, I
guess "git fast-import" not handling them counts as a bug - unless a
design-decision was made to not be as rigorous for the sake of
simplicity in the import protocol? Or is "fossil export" perhaps
outputting the filename incorrectly for the "fast-import" protocol
(maybe it needs some kind of quoting)?

* Commands which cause the crash:
----8<----
fossil clone https://www.fossil-scm.org/xfer fossil.fossil
git init fossil-git
cd fossil-git
fossil export --git ../fossil.fossil | git fast-import
----8<----

* The part of "fossil export" output which breaks "git fast-import":
----8<----
...

commit refs/heads/test-ticket-d17d6e5b17
mark :26782
committer jan.nijtmans <jan.nijtmans> 1353531216 +0000
data 82
Just commit some weird filenames, even one with a newline in it, to
test the code.
from :26779
M 100644 :427 :abc
M 100644 :10049 abc
def.txt
M 100644 :427 str"i"ng.h
M 100644 :427 str[ing.txt
M 100644 :427 xyz<5.x

...
----8<----

Crash report [trimmed]:
----8<----
fast-import crash report:
    fast-import process: 23836
    parent process     : 23835
    at 2018-01-29 15:12:07 +0000

fatal: Unsupported command: def.txt

Most Recent Commands Before Crash
---------------------------------
  M 100644 :10003 src/tkt.c
  M 100644 :9992 src/update.c
  M 100644 :9838 src/wiki.c
  M 100644 :9986 src/wikiformat.c
  M 100644 :9995 src/xfer.c
  M 100644 :10007 src/th_main.c

  commit refs/heads/trunk
  mark :26772
  committer drh <drh> 1353449638 +0000
  data 115
  from :26770
  M 100644 :9981 src/attach.c
  M 100644 :10028 src/captcha.c
  M 100644 :10012 src/info.c
  M 100644 :9906 src/login.c
  M 100644 :9965 src/style.c
  M 100644 :10017 src/tkt.c
  M 100644 :10025 src/wiki.c

  commit refs/heads/th1Hooks
  mark :26773
  committer mistachkin <mistachkin> 1353449970 +0000
  data 48
  from :26771
  M 100644 :10008 src/main.c

  commit refs/heads/trunk
  mark :26774
  committer mistachkin <mistachkin> 1353450526 +0000
  data 70
  from :26772
  M 100644 :9245 src/captcha.c
  M 100644 :10030 src/login.c

  commit refs/heads/th1Hooks
  mark :26775
  committer mistachkin <mistachkin> 1353452400 +0000
  data 51
  from :26773
  M 100644 :10036 src/main.c

  commit refs/heads/trunk
  mark :26776
  committer drh <drh> 1353459061 +0000
  data 141
  from :26774
  M 100644 :10027 src/attach.c
  M 100644 :9833 src/captcha.c
  M 100644 :9904 src/setup.c
  M 100644 :10031 src/style.c
  M 100644 :10032 src/tkt.c
  M 100644 :10033 src/wiki.c

  commit refs/heads/trunk
  mark :26777
  committer drh <drh> 1353460136 +0000
  data 56
  from :26776
  M 100644 :10037 src/captcha.c

  commit refs/heads/ticket-d17d6e5b17
  mark :26778
  committer jan.nijtmans <jan.nijtmans> 1353489155 +0000
  data 80
  from :26767
  M 100644 :10019 src/file.c
  M 100644 :9846 src/rebuild.c
  M 100644 :9677 src/vfile.c

  commit refs/heads/ticket-d17d6e5b17
  mark :26779
  committer jan.nijtmans <jan.nijtmans> 1353489615 +0000
  data 41
  from :26778
  M 100644 :10043 src/file.c

  commit refs/heads/trunk
  mark :26780
  committer drh <drh> 1353510669 +0000
  data 64
  from :26777
  M 100644 :9850 src/encode.c
  M 100644 :10018 src/wikiformat.c

  commit refs/heads/trunk
  mark :26781
  committer drh <drh> 1353515283 +0000
  data 51
  from :26780
  M 100644 :10047 src/wikiformat.c

  commit refs/heads/test-ticket-d17d6e5b17
  mark :26782
  committer jan.nijtmans <jan.nijtmans> 1353531216 +0000
  data 82
  from :26779
  M 100644 :427 :abc
  M 100644 :10049 abc
* def.txt

Active Branch LRU
-----------------
    active_branches = 5 cur, 5 max

  pos  clock name
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1)   4672 refs/heads/test-ticket-d17d6e5b17
   2)   4669 refs/heads/ticket-d17d6e5b17
   3)   4654 refs/heads/dbReOpenConfigAttach
   4)   4665 refs/heads/th1Hooks
   5)   4671 refs/heads/trunk

Inactive Branches
-----------------
...[loads of trimmed entries]...

Marks
-----
...[loads of trimmed entries]...

-------------------
END OF CRASH REPORT
----8<----
