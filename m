Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1AC82047F
	for <e@80x24.org>; Fri,  4 Aug 2017 21:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbdHDVvU (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 17:51:20 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33365 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbdHDVvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 17:51:19 -0400
Received: by mail-pg0-f45.google.com with SMTP id u5so12603278pgn.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2017 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=ITewNeN6j+jhIVGy4x6hNUuxQl0oD1rQ9VusnI/VIkM=;
        b=cfpJ+GxtYwbW9c5Py3XL4MiqpDRZWum9bW6/mVre4krQra0A1pFdBebPzuKqXxgnQu
         mMm8zGLnmTvoQegpHogEKRVTR5UQ83wr1oNHBgojbBxGGKqTN/+F8svQSXlQc7kTbqPm
         Fq0nMjkbk6FE3cVDv7VQBtMRe+ag4dREsAIUTtseifbzeWIoxL0+dI0BuQzMwc9oB9am
         VubbYwZ1a7HZ3ujubOmWFZYMRGgodhLuT8w4w1FQHT3Pu4/QfSidCTJsDOi0XTelke5R
         7z/dHK/ra0SwNa9XxEGiZZ+VWF0hKEiVkxSqsX4n0gPgRG4kfLK5MXC+tbH3WEQqWF9K
         cf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=ITewNeN6j+jhIVGy4x6hNUuxQl0oD1rQ9VusnI/VIkM=;
        b=cq+hcNDXqoKYx5L13p5cxgPHbHUvvV9E36WSlJvntqGiOnofpeFFYYknu7i36YZTZO
         vmTbbp15TySxIPxyAK+7TGx2ORAfGNHmymhyx07q4mXvD31egb9dMsf2HKq2n4UGedMz
         G6CtdIbbM6gNc/WtIqfwi8XBRkAUZYo4VcEIt1xhjkJNa+dDCP1G+mPRpJNA+XFHUNaA
         qybqyvPjYki8MOnln3IvVHKT6shYew84q41o+Ec+vmPywoL9bbKpyHTMG700+hvlilN8
         lek02ZDAPg2hD7cDAk5/V2Y46AZXDU81vdNrVvkqt4riCgHL62Ed3sa6BmXUJVEi1IgX
         b6ZQ==
X-Gm-Message-State: AIVw112O1fQSVt+1dksabABTn1Ts0wx5GcFN8iiReh/G9Gq/pHotDMu1
        KofXrhK5HqDC0IKV+qdEOA==
X-Received: by 10.84.234.8 with SMTP id m8mr4402473plk.1.1501883478590;
        Fri, 04 Aug 2017 14:51:18 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f576:9845:f54c:2038])
        by smtp.gmail.com with ESMTPSA id r9sm4107885pgf.83.2017.08.04.14.51.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Aug 2017 14:51:17 -0700 (PDT)
Date:   Fri, 4 Aug 2017 14:51:13 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, peartben@gmail.com,
        christian.couder@gmail.com
Subject: Partial clone design (with connectivity check for locally-created
 objects)
Message-ID: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After some discussion in [1] (in particular, about preserving the
functionality of the connectivity check as much as possible) and some
in-office discussion, here's an updated design.

Overview
========

This is an update of the design in [1].

The main difference between this and other related work [1] [2] [3] is
that we can still check connectivity between locally-created objects
without having to consult a remote server for any information.

In addition, the object loader writes to an incomplete packfile. This
(i) ensures that Git has immediate access to the object, (ii) ensures
that not too many files are written during a single Git invocation, and
(iii) prevents some unnecessary copies (compared to, for example,
transmitting entire objects through the protocol).

Local repo layout
=================

Objects in the local repo are further divided into "homegrown" and
"imported" objects.

"Imported" objects must be in a packfile that has a "<pack name>.remote"
file with arbitrary text (similar to the ".keep" file). They come from
clones, fetches, and the object loader (see below).

"Homegrown" objects are every other object.

Object loader
=============

The object loader is a process that can obtain objects from elsewhere,
given their hashes, and write their packed representation to a
client-given file.

The first time a missing object is needed during an invocation of Git,
Git creates a temporary packfile and writes the header with a
placeholder number of objects. Then, it starts the object loader,
passing in the name of that temporary packfile.

Whenever a missing object is needed, Git sends the hash of the missing
object and expects the loader to append (with O_APPEND) the object to
that packfile. Git keeps track of the object offsets as it goes, and Git
can use the contents of that incomplete packfile. This is similar to
what "git fast-import" does.

When Git exits, it writes the number of objects in the header, writes
the packfile checksum, moves the packfile to its final location, and
writes a .idx and a .remote file.

Connectivity check
==================

An object walk is performed as usual from the tips (see the
documentation for fsck etc. for which tips they use).

A "homegrown" object is valid if each object it references:
 1. is a "homegrown" object,
 2. is an "imported" object, or
 3. is referenced by an "imported" object.

The references of an "imported" object are not checked.

Performance notes
-----------------

Because of rule 3 above, iteration through every "imported" object (or,
at least, every "imported" object of a certain type) is sometimes
required.

For fsck, this should be fine because (i) this is not a regression since
currently all objects must be iterated through anyway, and (ii) fsck
prioritizes correctness over speed.

For fetch, the speed of the connectivity check is immaterial; the
connectivity check no longer needs to be performed because all objects
obtained from the remote are, by definition, "imported" objects.

There might be connectivity checks run during other commands like
"receive-pack". I don't expect partial clones to use these often. These
commands will still work, but performance of these is a secondary
concern in this design.

Impact on other tools
=====================

"git gc" will need to not do anything to an "imported" object, even if
it is unreachable, without ensuring that the connectivity check will
succeed in that object's absence. (Special attention to rule 3 under
"Connectivity check".)

If this design stands, the initial patch set will probably have "git gc"
not touch "imported" packs at all, trivially satisfying the above. In
the future, "git gc" will either need to expel such objects into loose
objects (like what is currently done for normal packs), treating them
like a "homegrown" object (unreachable, so it won't interfere with
future connectivity checks), or delete them outright - but there may be
race conditions to think of.

"git repack" will need to differentiate between packs with ".remote" and
packs without.

[1] https://public-inbox.org/git/cover.1501532294.git.jonathantanmy@google.com/
[2] https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/
[3] https://public-inbox.org/git/20170803091926.1755-1-chriscool@tuxfamily.org/

