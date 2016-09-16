Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51832070F
	for <e@80x24.org>; Fri, 16 Sep 2016 00:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755592AbcIPAM1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33949 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbcIPAMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:25 -0400
Received: by mail-qt0-f196.google.com with SMTP id e5so2169635qtb.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=mGdYTPEog8Hz592Cd0tqFyEa2spuVnTDTE6iizhHuX0=;
        b=RMn5s96FwT5v+9nZWgHSlocQpk6cZoDrQGz6qqippM1PYOlqML+8OQVijmvLYA3hM5
         RiVz9A0y+5BIXXoi1E3h/Ou+KBOP0AQ2XbW9kTCM9Po6LXgiUUnqqZtQcN3AdzOUmdoS
         DVeREmEij/JTG9O1twEDqN1N0WHizyCPQQhxG+xtc+aUKBG8cm6yhkSiEB/QywL1OJHC
         4jmlt4hiIP+hjrgQi95c9qrCYZnw7m9BDORRKdtceHTYTl91QS49qf09L5ZrG4fGcypn
         R3fcrOHpXNBWjb7X9GT3jbFTGu+VpG7i5A3vpn15O+eik/Zf6NCjLEBQvrEHKe+TPEOB
         nRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=mGdYTPEog8Hz592Cd0tqFyEa2spuVnTDTE6iizhHuX0=;
        b=JMBEkI2Ckc/yttw/mqNg+1B+Ye9gnljZf9Uj6XcwvsNhYcEbuUcgRleVsEF2nrHbrc
         4wKud5iFFh+nJJa+vxJ5Klai/c7caVye/uhtsM/fmoK8lkycVdi3YzO9x5GE/6JyNu7v
         6fZytov1MHQ2+UQinDnU7CyfAHewPvm8v15SKM1gSA/Q8/pLilqZdoz8qbsxFA9KCAAs
         Dt48VKYtXNR30zkw8sl2TgcG67jhD03HAYCpAf0tUZ80TIaAjQpGQHjDFy1kUNx0bH6b
         jZJoJp/CdPnpfFa4QAL14yfNcNH4O1Fsg6VuebJ9h5t9QGkEonSlSvjRmGoxt+Vqj0gz
         J5PQ==
X-Gm-Message-State: AE9vXwMRR5DwtK/94SZz0lYBZMQdyg0icZqMYzkfv0jUsEQHUX0olyA9QtWbsa8ibsSyKQ==
X-Received: by 10.200.53.110 with SMTP id z43mr12957501qtb.85.1473984744444;
        Thu, 15 Sep 2016 17:12:24 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:23 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 00/11] Resumable clone
Date:   Thu, 15 Sep 2016 20:12:11 -0400
Message-Id: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey, all,

It's been a while (sent a very short patch in May), but I've
still been working on the resumable clone feature and checking up on
the mailing list for any updates. After submitting the prime-clone
service alone, I figured implementing the whole thing would be the best
way to understand the full scope of the problem (this is my first real
contribution here, and learning while working on such an involved
feature has not been easy). 

This is a functional implementation handling a direct http/ftp URI to a
single, fully connected packfile (i.e. the link is a direct path to the
file, not a prefix or guess). My hope is that this acts as a bare
minimum cross-section spanning the full requirments that can expand in
width as more cases are added (.info file, split bundle, daemon
download service). This is certainly not perfect, but I think it at
least prototypes each component involved in the workflow.

This patch series is based on jc/bundle, because the logic to find the
tips of a pack's history already exists there (I call index-pack
--clone-bundle on the downloaded file, and read the file to write the
references to a temporary directory). If I need to re-implement this
logic or base it on another branch, let me know. For ease of pulling
and testing, I included the branch here:

https://github.com/kevinwern/git/tree/feature/prime-clone

Although there are a few changes internally from the last patch,
the "alternate resource" url to download is configured on the
server side in exactly the same way:

[primeclone]
	url = http://location/pack-$NAME.pack
	filetype = pack

The prime-clone service simply outputs the components as:

####url filetype
0000

On the client side, the transport_prime_clone and
transport_download_primer APIs are built to be more robust (i.e. read
messages without dying due to protocol errors), so that git clone can
always try them without being dependent on the capability output of
git-upload-pack. transport_download_primer is dependent on the success
of transport_prime_clone, but transport_prime_clone is always run on an
initial clone. Part of achieving this robustness involves adding
*_gentle functions to pkt_line, so that prime_clone can fail silently
without dying.

The transport_download_primer function uses a resumable download,
which is applicable to both automatic and manual resuming. Automatic
is programmatically reconnecting to the resource after being
interrupted (up to a set number of times). Manual is using a newly
taught --resume option on the command line:

git clone --resume <resumable_work_or_git_dir>

Right now, a manually resumable directory is left behind only if the
*client* is interrupted while a new junk mode, JUNK_LEAVE_RESUMABLE,
is set (right before the download). For an initial clone, if the
connection fails after automatic resuming, the client erases the
partial resources and falls through to a normal clone. However, once a
resumable directory is left behind by the program, it is NEVER
deleted/abandoned after it is continued with --resume.

I think determining when a resource is "unsalvageable" should be more
nuanced. Especially in a case where a connection is perpetually poor
and the user wishes to resume over a long period of time. The timeout
logic itself *definitely* needs more nuance than "repeat 5 times", such
as expanding wait times and using earlier successes when deciding to
try again. Right now, I think the most important part of this patch is
that these two paths (falling through after a failed download, exiting
to be manually resumed later) exist.

Off the top of my head, outstanding issues/TODOs inlcude:
	- The above issue of determining when to fall through, when to
	  reattempt, and when to write the resumable info and exit
	  in git clone.
	- Creating git-daemon service to download a resumable resource.
	  Pretty straightforward, I think, especially if
	  http.getanyfile already exists. This falls more under
	  "haven't gotten to yet" than dilemma.
	- Logic for git clone to determine when a full clone would
	  be superior, such as when a clone is local or a reference is
	  given.
	- Configuring prime-clone for multiple resources, in two
	  dimensions: (a) resources to choose from (e.g. fall back to
	  a second resource if the first one doesn't work) and (b)
	  resources to be downloaded together or in sequence (e.g.
	  download http://host/this, then http://host/that). Maybe
	  prime-clone could also handle client preferences in terms of
	  filetype or protocol. For this, I just have to re-read a few
	  discussions about the filetypes we use to see if there are
	  any outliers that aren't representable in this way. I think
	  this is another "haven't gotten to yet".
	- Related to the above, seeing if there are any outlying
	  resource types whose process can't be modularized into:
	  download to location, use, clean one way if failed, clean
	  another way if succeeded. The "split bundle," for example,
	  is retrieved (download), read for the pack location (use),
	  and then the packfile is retrieved (download). I believe, in
	  this case, all of that can be considered the "download," and
	  then indexing/writing can be considered "use." But I'm not
	  sure if there are more extreme cases.
	- Creating the logic to guess a packfile, and append that to a
	  prefix specified by the admin. Additionally, allowing the
	  admin to use a custom script to use their own logic to
	  output the URL.
	- Preventing the retry wait period (currently set by using
	  select()) from being interrupted by other system calls.
	  I believe there is a setting in libcurl, but I don't want
	  to make any potentially large-impact changes without
	  discussing it first. Plus, I believe changes to http.c were
	  up for discussion anyway.
	- Finding if there's a more elegant way to access the alternate
	  resource than invoking remote-helper with a url we don't care
	  about (the same url that will be specified later to stdin
	  with "download-primer").
	- Finding if there is a better way to suppress index-pack's
	  output than creating a run-command option specifically to
	  suppress stdout.
	- When running with ssh and a password, the credentials are
	  prompted for twice. I don't know if there is a way to
	  preserve credentials between executions. I couldn't find any
	  examples in git's source.

Some of these are issues I've been actively working on, but I'm
hitting a point where keeping everyone up-to-date trumps completeness.
Hopefully, the bulk of the 'learning and re-doing' is done and I can
update more frequently in smaller increments.

I will probably work on the git-daemon download service, the curl
timeout issue, and supporting other filetypes next.

Feedback is appreciated.

Kevin Wern (11):
  Resumable clone: create service git-prime-clone
  Resumable clone: add prime-clone endpoints
  pkt-line: create gentle packet_read_line functions
  Resumable clone: add prime-clone to remote-curl
  Resumable clone: add output parsing to connect.c
  Resumable clone: implement transport_prime_clone
  Resumable clone: add resumable download to http/curl
  Resumable clone: create transport_download_primer
  path: add resumable marker
  run command: add RUN_COMMAND_NO_STDOUT
  Resumable clone: implement primer logic in git-clone

 .gitignore                         |   1 +
 Documentation/git-clone.txt        |  16 +
 Documentation/git-daemon.txt       |   7 +
 Documentation/git-http-backend.txt |   7 +
 Documentation/git-prime-clone.txt  |  39 +++
 Makefile                           |   2 +
 builtin.h                          |   1 +
 builtin/clone.c                    | 590 +++++++++++++++++++++++++++++++------
 builtin/prime-clone.c              |  77 +++++
 cache.h                            |   1 +
 connect.c                          |  47 +++
 connect.h                          |  10 +-
 daemon.c                           |   7 +
 git.c                              |   1 +
 http-backend.c                     |  22 +-
 http.c                             |  86 +++++-
 http.h                             |   7 +-
 path.c                             |   1 +
 pkt-line.c                         |  47 ++-
 pkt-line.h                         |  16 +
 remote-curl.c                      | 192 +++++++++---
 run-command.c                      |   1 +
 run-command.h                      |   1 +
 t/t9904-git-prime-clone.sh         | 181 ++++++++++++
 transport-helper.c                 |  75 ++++-
 transport.c                        |  53 ++++
 transport.h                        |  27 ++
 27 files changed, 1361 insertions(+), 154 deletions(-)
 create mode 100644 Documentation/git-prime-clone.txt
 create mode 100644 builtin/prime-clone.c
 create mode 100755 t/t9904-git-prime-clone.sh

-- 
2.7.4

