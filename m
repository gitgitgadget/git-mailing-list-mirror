Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CB081FD99
	for <e@80x24.org>; Thu, 25 Aug 2016 09:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754049AbcHYJRq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 25 Aug 2016 05:17:46 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:1821 "EHLO edge20.ethz.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbcHYJRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 05:17:04 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 25 Aug
 2016 11:00:44 +0200
Received: from MBX115.d.ethz.ch ([fe80::444b:8481:c05f:ab21]) by
 CAS12.d.ethz.ch ([fe80::7861:4ecb:7c42:cad4%10]) with mapi id 14.03.0301.000;
 Thu, 25 Aug 2016 11:00:48 +0200
From:   "Hedges  Alexander" <ahedges@student.ethz.ch>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Feature Request: Branch-Aware Submodules
Thread-Topic: Feature Request: Branch-Aware Submodules
Thread-Index: AQHR/q8rf5a9HIQAR0yvzVUFQ144Xw==
Date:   Thu, 25 Aug 2016 09:00:47 +0000
Message-ID: <7B5AD16B-9729-453E-839C-2A2FDB07F8E9@student.ethz.ch>
Accept-Language: en-US, de-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [85.3.63.164]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A4574A589D1414DB1F37C340C109438@intern.ethz.ch>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Developers,

First of all, thanks for this great project, it has made my life a lot easier
as a developer!

I'm writing this email to suggest some improvements to git submodules. In my
eyes how git handles submodules could be improved to be more intuitive to a
novice and require less manual management.


Right now updating a submodule in a topic branch and merging it into master
will not change the submodule index in master leading to at least two commit
for the same change (one in any active branch). This happened to me quite a few
times. To a newcomer this behavior is confusing and it leads to unnecessary
commits.


The proposed change would be to have a submodule either ignored or tracked by
the .gitmodules file.
If it is ignored, as for instance after a clone of the superproject, git simply
ignores all files in the submodule directory. The content of the gitmodules
file is then also not updated by git.
If it is not ignored, the .gitmodules is updated every time a commit happens in
the submodule. On branch switches the revision shown in the gitmodules from
that branch is checked out.
This change would have submodules conceptually behave more like files to the
superproject.


Like current behavior, git status would display whether the submodule has
uncommitted changes or is at a new commit. A repository is in a dirty state if
there are changes to the gitmodules file or any tracked submodule is in a dirty
state. Every time a commit happens in a submodule, the parents gitmodules is
updated. Uncommitted changes are not reflected in the parent's gitmodules file.

When the user manually edits the .gitmodules, git switches to that revision
after commit. But the user would have to stash or commit all uncommitted
changes in the submodule first.

When checking out a commit in a submodule, if there is currently a branch
pointing to that commit, HEAD could point to that branch instead (Is there a
case where that doesn't make sense? What about multiple branches pointing to
the commit?). It could also support branch names as references where the branch
(or tag) would be checked out instead.

With git submodule init you could have the submodule tracked. Using deinit
would put the submodule into the ignored state.

And while we're at it, it is quite some work to completely delete a submodule.
You have to manually remove all the associated files in the git repository
(StackOverflow lists 7 steps). Obviously it's not encouraged, as everything
that removes data without recovery method, but it should be possible.
git submodule rm --force could remove the repository and the associated nested
.git tree. git submodule rm could keep the .git directory but move it to another
location.

The behavior of git submodule sync and git submodule update would stay the same.


Migrating existing repositories to the new behavior should be quite straight
forward. Submodules that are not init'ed yet would be ignored. All others
behave accordingly to the new rules. Maybe a message with a note about the
changes could be displayed by the appropriate git-submodule commands or even by
git status.


An alternative considered was to have submodules decoupled stronger from the
superproject. That would mean having the .gitmodules only tracked by master and
leaving the other behaviors unchanged. For consistency one could do the same
thing for the .gitignore.

The drawback of this option are obviously no per branch submodules, if you want
to experiment with external libraries, topic branches would not be the place to
go. Also there would be a lot of intricacies that would have to be worked out.


I couldn't find any discussions on the initial implementation of git-submodule
or any previous proposals related to this in nature due to gmane being down
right now and the mailing list archives on the other sites are not great for
searching. So please excuse me if I'm bringing up already discussed stuff.

Until now I only worked on projects with few submodules. I expect the
proposed changes to have a larger effect on projects containing lots of
submodules. So it would be nice if maybe somebody with experience working on
projects with lots of submodules could weigh into the discussion.


Best Regards,
Alexander Hedges



