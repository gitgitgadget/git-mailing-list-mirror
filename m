Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A03D1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 20:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeHTXWw (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 19:22:52 -0400
Received: from arcturus.uberspace.de ([185.26.156.30]:39146 "EHLO
        arcturus.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTXWw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 19:22:52 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2018 19:22:51 EDT
Received: (qmail 16240 invoked from network); 20 Aug 2018 19:59:10 -0000
Received: from localhost (HELO neithernut.Speedport?W?921V?1?39?000) (127.0.0.1)
  by arcturus.uberspace.de with SMTP; 20 Aug 2018 19:59:10 -0000
Date:   Mon, 20 Aug 2018 19:59:29 +0200
From:   Julian Ganz <neither@nut.email>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Matthias Beyer <mail@beyermatthias.de>
Subject: [RFC] Git enumerations
Message-ID: <20180820195929.58444ae0@neithernut.Speedport_W_921V_1_39_000>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi list,

I'm a co-author of the git-dit tool [1] discussed in the thread

    git-bug: Distributed bug tracker embedded in git

on this mailing list. Partly motivated by Jonathan Nieder's call for
more collaboration, I'd like to request comments on a functionality
which I originally planned on introducing as a git-dit internal
feature.


# Problem statement:

Especially with tools like git-dit or git-bug, we often list OIDs,
usually of commits, and additional data. For example, `git dit list -a`
may print something like the following (`-a` is for abbreviated ids):

8640a6b (Mon Dec 19 17:11:14 2016) Implement "subscribe" functionality
ae058fd (Fri Dec 16 10:35:40 2016) Add features to dit-{list,show} to show statuses

For viewing the details of the first issue, you would invoke the "show"
subcommand with the respective (possibly abbreviated) id. You generally
either have to re-type or copy&paste this id. The first option tends to
get on one's nerves, since the IDs have to be unambiguous for the
repository. The second may disturb your workflow (since you have to
grab your mouse) or may not be possible (e.g. plain TTY).

So it would be nice if you could just identify them via a plain number.
For the output of `git log --oneline --decorate` and similar commands,
we already have something similar: each commit shown can generally be
addressed via some-ref~some-number. So you can, more or less, inspect
those without copying IDs. For listing issues with git-dit, it's not
that easy, since the issues are generally not connected.


# Solution using symbolic refs

When printing a list of disconnected objects addressable through OIDs,
we would generate an enumeration on the fly. For each entry, we then
store a symbolic ref reflecting the enumeration in some namespace
(e.g. "refs/enumeration/1", "refs/enumeration/2", ...). Obviously, each
symbolic ref would point to the respective entry's OID. Essentially, we
have persisted the list printed by the first command.

Other subcommand of the tool would contain some minimal logic for
detecting and choosing such an enumeration (e.g. "2") in the place of
an OID.

This may have additional benefits for some tools, since we can also
review a previously printed list. This is especially interesting if
generating the list is costly.


# Additional tweaks

Instead of plain numbers, the symbolic refs could also contain an
optional prefix. `git dit list`, for example could generate
enumerations like "i1", "i2", ... while `git dit show` (which prints
"messages") would generate "m1", "m2", "m3", ... This would support
workflows like:

 * view the list of open issues
 * inspect an issue
 * show that (exact) list of issues again
 * inspect the next, ...

Alternatively, one could start using namespaces within
"refs/enumeration", but imo this would hurt the usability in most cases.


# Integration

As stated initially, I originally planned on introducing this as an
internal feature to git-dit. However, I realized that other tools may
also benefit from such enumerations. Hence, I'm thinking about
providing by a third-party library as well as a minimal tool/subcommand
for managing (e.g. clearing) enumerations.


Regards,
Julian

[1] https://github.com/neithernut/git-dit
