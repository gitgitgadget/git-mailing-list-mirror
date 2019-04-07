Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22ED20248
	for <e@80x24.org>; Sun,  7 Apr 2019 20:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDGUsm (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 16:48:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37400 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDGUsm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 16:48:42 -0400
Received: by mail-it1-f195.google.com with SMTP id u65so17734058itc.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VFbFNXQSH3SGwwW14rin0+/BGXRHlKzUzRNUpeKgPNc=;
        b=uti5Y9794QwYlfdAgT5UzvN6/JANEiJpyJ5reoqLRzuO873uvSAGoY77iBS1Sx333F
         PyBaF9vtbWIYqkPa6G7hnUJpuzWlyP5DXT8H+Jsi4Vj8c7IdMUHmCpntQFrKzjDLQSAy
         KeT8zW7ESoWMql/meXr/BJY5wvLGrn15WmB69d49aGdoordeQjpR947c/CXO8qE/iH1c
         NYLo7pyxAnMg98L3UJ55CnrrE+YekBy3pyOx6MvbZ8Oi3NCOlPrVpxdinB+ur51DG/44
         FXiYXJwQsY98XFQAdS+rdxbObS75W2NIYW4gLmCybxsC6kpBmmwp8jtA8uk7c4tdjPYB
         NLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VFbFNXQSH3SGwwW14rin0+/BGXRHlKzUzRNUpeKgPNc=;
        b=N+fFmQXB4NhPvan4He36UBo7RFElOZbic0crFd3BknfwnKaskhtu+uFhiH08W4BUJe
         fDv+bly1NSEoGt1FGJ6yJXAWGiGnNUAg6lc8mtzP+A60rxhkpn8Qp8IkMQFEjFRy1FVk
         PsdklFglGFv9s6w238f1dNZZpxPmfms9sPZMEHxOhXj+an/gI+qsh8ExWX81rOF9a9Yo
         Ya91Wa2COUIWMVokVcgK/up9wm255eKRUKmNivbAxMEz5dUP6IgruHB3D8YhWMmOPUvG
         vvxupxAA9VCw01OAmBFXOb/JeHeYDDld6XwotkuiR17PCJJnuDjrDFBuBNpcbb3z1gsl
         uC5w==
X-Gm-Message-State: APjAAAW2fEGf2rbz76btNiI7oXA9rfuHMCWmNeYOWGSztGpr5Kn6L/h5
        9+J0JeIRI0p7bKeXdEGfQDZlZpDija6P8bQgycUddnFg3rM=
X-Google-Smtp-Source: APXvYqwuBkjqAccPc24l8/T1j9e/MYm8T0+1EQ0m/dQodhSfNdFHdivr87P3QwgxexKSKXQoQOwzL16rxJszj/AbbY0=
X-Received: by 2002:a02:ab90:: with SMTP id t16mr18958248jan.119.1554670121066;
 Sun, 07 Apr 2019 13:48:41 -0700 (PDT)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 7 Apr 2019 17:48:30 -0300
Message-ID: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
Subject: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     git <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

This is my proposal for GSoC with the subject "Make pack access code
thread-safe". I'm late in schedule but I would like to ask for your
comments on it. Any feedback will be highly appreciated.

The "rendered" version can be seen here:
https://docs.google.com/document/d/1QXT3iiI5zjwusplcZNf6IbYc04-9diziVKdOGkT=
HeIU/edit?usp=3Dsharing

I kindly ask you to read the text at the google docs link, because in
the conversion to plain text I noticed it discards some information :(
But for those who prefer to comment by email, here it is:

Thanks,
Matheus Tavares

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Making pack access code thread-safe
April, 2019

#Contact Info

Name Matheus Tavares Bernardino
Timezone GMT-3
Email matheus.bernardino@usp.br
IRC Nick matheustavares on #git-devel
Telefone [...]
Postal address [...]
Github https://github.com/MatheusBernardino/
Gitlab https://gitlab.com/MatheusTavares

# About me

I=E2=80=99m a senior student at the University of S=C3=A3o Paulo (USP), att=
ending the
Bachelor=E2=80=99s degree in Computer Science course. Currently, I=E2=80=99=
m at the end
of a one year undergraduate research in High-Performance Computing. The
goal of this project was to accelerate astrophysical software for black
hole studies using GPUs. Also, I=E2=80=99m working as a teaching assistant =
on
IME-USP=E2=80=99s Concurrent and Parallel Programming course, giving lectur=
es
and developing/grading programming assignments. Besides parallel and
high-performance computing I=E2=80=99m very passionate about software
development in general, but especially low-level coding, and FLOSS.

# About me and FLOSS

## Linux Kernel

Last year, I started contributing to the Linux Kernel in the IIO
subsystem, together with a group of colleagues. I worked with another
student, to move the ad2s90 module out of staging area to Kernel=E2=80=99s
mainline, which we accomplished by the end of the year. In total, I
authored 11 patches and co-authored 3 (all of which are already at
Torvald=E2=80=99s repo). If you want to know more about my contributions to
Linux Kernel, take a look at the Appendix section.

## FLUSP: FLOSS at USP

After the amazing experience contributing to the Linux Kernel, we
decided to found FLUSP: FLOSS at USP, a group opened to undergraduate
and graduate students that aims to contribute to FLOSS software. Since
then, the group has grown and evolved a lot: Currently, we have members
contributing to the Kernel, GCC, IGT GPU Tools, Git and some projects of
our own such as KernelWorkflow. And as a recognition of our endeavor
with free software, we received some donations from AnalogDevices and
DigitalOcean.

Besides administrative questions and contributions to FLOSS projects, at
FLUSP, I=E2=80=99ve been mentoring people who want to start contributing to=
 the
Linux Kernel and now, to Git, as well.

# About me and Git

I joined Git community in February and, so far, I have sent the
following patches:

        clone: test for our behavior on odd objects/* content
        clone: better handle symlinked files at .git/objects/
        dir-iterator: add flags parameter to dir_iterator_begin
        clone: copy hidden paths at local clone
        clone: extract function from copy_or_link_directory
        clone: use dir-iterator to avoid explicit dir traversal
        clone: Replace strcmp by fspathcmp

And three more patches for git.github.io:

        rn-50: Add git-send-email links to light readings
        SoC-2019-Microprojects: Remove git-credential-cache
        SoC-2019-Microprojects: Remove all trailing spaces

Participating at FLUSP, I=E2=80=99ve also been part of some Git related act=
ivities:

* I actively helped to organize a Git workshop for newcomer students.
* I=E2=80=99ve written an article at our website to help people configure a=
nd
use git-send-email to send patches.
* I=E2=80=99ve been writing a =E2=80=98First steps at Git=E2=80=99 article =
(not finished yet),
in which I=E2=80=99m registering what I=E2=80=99ve learned in the Git commu=
nity so far,
since downloading the source, subscribing to the mailings list and
joining the channel at IRC until how to use travis-ci and begin sending
patches.

# The Project

As direct as possible, the goal with this project is to make more of
Git=E2=80=99s codebase thread-safe, so that we can improve parallelism in
various commands. The motivation behind this are the complaints from
developers experiencing slow Git commands when working with large
repositories[1], such as chromium and Android. And since nowadays, most
personal computers have multi-core CPUs, it is a natural step trying to
improve parallel support so that we can better use the available resources.

With this in mind, pack access code is a good target for improvement,
since it=E2=80=99s used by many Git commands (e.g., checkout, grep, blame, =
diff,
log, etc.). This section of the codebase is still sequential and has
many global states, which should be protected before we can work to
improve parallelism.

## The Pack Access Code

To better describe what the pack access code is, we must talk about
Git=E2=80=99s object storing (in a simplified way): Besides what are called
loose objects, Git has a very optimized mechanism to compactly store
objects (blobs, trees, commits, etc.) in packfiles[2]. These files are
created by[3]:

1. listing objects;
2. sorting the list with some good heuristics;
3. traversing the list with a sliding window to find similar objects in
the window, in order to do delta decomposing;
4. compress the objects with zlib and write them to the packfile.

What we are calling pack access code in this document, is the set of
functions responsible for retrieving the objects stored at the
packfiles. This process consists, roughly speaking, in three parts:

1. Locate and read the blob from packfile, using the index file;
2. If the blob is a delta, locate and read the base object to apply the
delta on top of it;
3. Once the full content is read, decompress it (using zlib inflate).

Note: There is a delta cache for the second step so that if another
delta depends on the same base object, it is already in memory. This
cache is global; also, the sliding windows, are global per packfile.

If these steps were thread-safe, the ability to perform the delta
reconstruction (together with the delta cache lookup) and zlib inflation
in parallel could bring a good speedup. At git-blame, for example,
24%[4] of the time is spent in the call stack originated at
read_object_file_extended. Not only this but once we have this big
section of the codebase thread-safe, we can work to parallelize even
more work at higher levels of the call stack. Therefore, with this
project, we aim to make room for many future optimizations in many Git
commands.

# Plan

I will probably be working mainly with packfile.c, sha1-file.c,
object-store.h, object.c and pack.h, however, I may also need to tackle
other files. I will be focusing on the following three pack access call
chains, found in git-grep and/or git-blame:


read_object_file =E2=86=92 repo_read_object_file =E2=86=92 read_object_file=
_extended =E2=86=92
read_object =E2=86=92 oid_object_info_extended =E2=86=92 find_pack_entry =
=E2=86=92
fill_pack_entry =E2=86=92 find_pack_entry_one =E2=86=92 bsearch_pack and
nth_packed_object_offset

oid_object_info =E2=86=92 oid_object_info_extended =E2=86=92 <same as previ=
ous>

read_object_with_reference =E2=86=92 read_object_file =E2=86=92 <same as pr=
evious>


Ideally, at the end of the project, it will be possible to call
read_object_file, oid_object_info and read_object_with_reference with
thread-safety, so that these operations can be, latter, performed in
parallel.

Here are some threads on Git=E2=80=99s mailing list where I started discuss=
ing
my project:

* https://public-inbox.org/git/CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8ia=
oc+b8=3DQ@mail.gmail.com/
* https://public-inbox.org/git/20190402005245.4983-1-matheus.bernardino@usp=
.br/#t

And also, a previous attempt to make part of the pack access code
thread-safe which I may use as a base:

* https://public-inbox.org/git/20140212015727.1D63A403D3@wince.sfo.corp.goo=
gle.com/#Z30builtin:gc.c

# Points to work on

* Investigate pack access call chains and look for non-thread-safe
operations on then.
* Protect packfile.c read-and-write global variables, such as
pack_open_windows, pack_open_fds and etc., using mutexes.
* Just like the previous item, protect sha1-file.c global states such as
the object cache used by read_object_file(). (The object cache may be
thread-local thought. This should still be studied.)
* Investigate the delta cache, sliding pack window, and maybe other
states that should be protected as well.
* Use GDB or GPROF to follow call chains inside pack access looking for
functions with static variables in their scopes. These variables are
thread-shared and should be protected or the functions to which they
belong be refactored.
* Make sure tests cover functions I=E2=80=99ll be working on and refactor/a=
dd
tests as needed
* [Bonus] Once pack access is thread-safe, refactor the critical
sections at git-grep to use more fine-grained mutexes. This will
hopefully increase git-grep performance, especially in large repositories.
* [Bonus] Check other mutex protected functions git-grep uses, not
related with pack access, to see if we can implement a more
fined-grained parallelism there. This functions are: fill_textconv,
is_submodule_active, repo_submodule_init, repo_read_gitmodules and
add_to_alternates_memory.
* [Bonus] Once pack access is thread-safe, ensure xdiff code used by
git-blame has thread-safety. I expect this to be easier.
* [Bonus] If the previous bonus get completed, start discussing a
possible parallel git-blame implementation with the community. We could
work a producer-consumer mechanism at blame.c=E2=80=99s assign_blame() func=
tion,
for a very good work sharing assignment (90% of git-blame=E2=80=99s time is
spent here[5]). Or try threading at lower functions on the call stack
that still uses a lot of execution time such as the libxdiff ones.

# Schedule

This is the planned schedule in which I should be working on. But I
would like to highlight that since there=E2=80=99s still a significant
investigation period from now until early May, this can have some
changes or additions during the process.

Timeline:

Investigation Time (Now - May, 5)
     * Gather information of global states.
     * Trace pack access call chain used by git commands like blame and
  checkout.
     * Try to classify which global variables are updated during pack
access call stack and, therefore, should be protected.
     * Adjust the schedule as needed.


Community Bounding and work on sha1-file.c global states (May, 6 - 26[6])
     * Talk with the community about my then refined plan and ask for
comments.
     * Protect object cache at sha1-file.c (or make it thread-local).
     * Work on other sha1-file.c global states and non-thread-safe
functions.


Work on packfile.c global states (not including delta cache) (May, 27 -
June, 23)
     * Conclude any unfinished work on sha1-file.c from the previous period=
.
     * Protect packfile.c variables (pack_open_windows, pack_open_fds
and etc.) and work on its non-protected functions.


Work on delta cache and other global states (June, 24 - July, 21)
     * Protect delta base cache operations (here we should study whether
to add mutexes to the cache itself or to the underlying hashmap).
     * Protect oid_* functions.
     * Work on sliding window (this is the section I have less knowledge
yet, so should be studied)


Work on bonus and leftovers (July, 22 - August 19)
     * This time will be reserved to finish any leftovers from the other
periods and, if we still have some spare time, work on the bonus items.
     * Note: I also plan to attend DebConf from july 21th to 28th


# Availability

My university vacations start on June 29, but since this is my last year
and I=E2=80=99m attending just two courses plus the teaching assistance, I =
think
it won=E2=80=99t be a problem. Also, the classes start back in early August=
, but
I won=E2=80=99t have any more courses to attend in this next semester. I do=
n=E2=80=99t
have any schedule trips besides DebConf, from July 21th to 28th (let me
know if any other Git community members plan to attend too, please). All
changes in availability will be communicated to the mentors in advance.

# Project Relevance and after GSoC plans

As already pointed out, this project will make it feasible to improve
(or add) parallelism in many Git commands. And that=E2=80=99s what I plan t=
o do
after (or even during) GSoC, mainly with git-blame and git-grep. I=E2=80=99=
m
also trying to form a local community at FLUSP to keep contributing to Git.

Appendix

Patches at Linux Kernel

        staging: iio: ad2s1210: fix 'assignment operator' style checks
        staging:iio:ad2s90: Make read_raw return spi_read's error code
        staging:iio:ad2s90: Make probe handle spi_setup failure
        staging:iio:ad2s90: Remove always overwritten assignment
        staging:iio:ad2s90: Move device registration to the end of probe
        staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and rea=
d_raw
        staging:iio:ad2s90: Check channel type at read_raw
        staging:iio:ad2s90: Add device tree support
        staging:iio:ad2s90: Remove spi setup that should be done via dt
        staging:iio:ad2s90: Add max frequency check at probe
        dt-bindings:iio:resolver: Add docs for ad2s90
        staging:iio:ad2s90: Replace license text w/ SPDX identifier
        staging:iio:ad2s90: Add comment to device state mutex
        staging:iio:ad2s90: Move out of staging


________________
[1] Some of them can be seen here:
https://groups.google.com/a/chromium.org/forum/#!topic/chromium-dev/oYe69Kz=
yG_U
https://bugs.chromium.org/p/git/issues/detail?id=3D18
https://bugs.chromium.org/p/git/issues/detail?id=3D16
https://code.fb.com/core-data/scaling-mercurial-at-facebook/
https://public-inbox.org/git/CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=3DJiA9wX=
ww7eZXQ@mail.gmail.com/
https://public-inbox.org/git/20140213014229.GE4582@vauxhall.crustytoothpast=
e.net/
https://public-inbox.org/git/CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_=
e2zeg@mail.gmail.com/
[2] https://git-scm.com/book/en/v2/Git-Internals-Packfiles
[3]
https://github.com/git/git/blob/master/Documentation/technical/pack-heurist=
ics.txt
[4]  https://i.imgur.com/XmyJMuE.png
[5] https://i.imgur.com/XmyJMuE.png
[6] GSoC=E2=80=99s official start date
