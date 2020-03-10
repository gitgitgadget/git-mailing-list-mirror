Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590A6C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 14:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E609222C3
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 14:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgCJOXk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 10 Mar 2020 10:23:40 -0400
Received: from elephants.elehost.com ([216.66.27.132]:41427 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgCJOXj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 10:23:39 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 02AENXV6062926
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Mar 2020 10:23:34 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc:     <git@vger.kernel.org>
References: <010b01d5ee87$09be74d0$1d3b5e70$@nexbridge.com> <20200310110008.GA3122@szeder.dev>
In-Reply-To: <20200310110008.GA3122@szeder.dev>
Subject: RE: [Breakage] t0410 - subtests report unable to remove non-existent file.
Date:   Tue, 10 Mar 2020 10:23:26 -0400
Message-ID: <010b01d5f6e7$79dd4440$6d97ccc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ/UBngYX6OnNnd+Z5jrW9SBATD0QD+EjEOpuc8iSA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 10, 2020 7:00 AM, SZEDER Gábor wrote:
> On Fri, Feb 28, 2020 at 05:32:57PM -0500, Randall S. Becker wrote:
> > Starting at t0410, subtest 5 (missing ref object, but promised, passes
> > fsck), on the NonStop L-series platform, we are seeing errors like the
> > following:
> >
> > not ok 5 - missing ref object, but promised, passes fsck #
> > #               rm -rf repo &&
> > #               test_create_repo repo &&
> > #               test_commit -C repo my_commit &&
> > #
> > #               A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
> > #
> > #               # Reference $A only from ref
> > #               git -C repo branch my_branch "$A" &&
> > #               promise_and_delete "$A" &&
> > #
> > #               git -C repo config core.repositoryformatversion 1 &&
> > #               git -C repo config extensions.partialclone "arbitrary
> > string" &&
> > #               git -C repo fsck
> > #
> >
> > With verbose output as follows:
> 
> Try to run tests with '-x' tracing enabled for additional info about what's
> going on, and thus potentially additional clues about what might go wrong.
> 
> > Initialized empty Git repository in /home/ituglib/randall/git/t/trash
> > directory.t0410-partial-clone/repo/.git/
> > [master (root-commit) 9df77b9] my_commit
> >  Author: A U Thor <author@example.com>
> >  1 file changed, 1 insertion(+)
> >  create mode 100644 my_commit.t
> > Enumerating objects: 1, done.
> > Counting objects: 100% (1/1), done.
> > Writing objects: 100% (1/1), done.
> > Total 1 (delta 0), reused 0 (delta 0)
> > a391e3e0447189aa0050c8f206462a1b0530a34a
> > rm: cannot remove
> > 'repo/.git/objects/a3/91e3e0447189aa0050c8f206462a1b0530a34a': No
> such
> > file or directory
> 
> So this failing 'rm' happens inside the 'promise_and_delete' helper function,
> which does  the following, simplified a bit for the purpose of this discussion:
> 
>   promise_and_delete () {
>           HASH=$(git -C repo rev-parse "$1") &&
>           <...>
>           git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
>           <...>
>           delete_object repo "$HASH"
>   }
> 
> The failing 'rm' is in the 'delete_object_repo' helper function.
> The 'pack_as_from_promisor' does the following:
> 
>   pack_as_from_promisor () {
>           HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
>           >repo/.git/objects/pack/pack-$HASH.promisor &&
>           echo $HASH
>   }
> 
> Notice that both 'promise_and_delete' and 'pack_as_from_promisor' set the
> $HASH variable.  This is usually not an issue, because
> 'pack_as_from_promisor' is invoked in a pipe, and thus most shells execute it
> in a subshell environment.
> 
> However, apparently 'ksh' doesn't run this helper function in a subshell
> environment, and the value set in 'pack_as_from_promisor'
> overwrites the value set in its caller, thus 'promise_and_delete' ends up
> trying to delete a non-existing object (it's the SHA1 of a packfile).
> 
> See the trimmed/annotated '-x' output with 'ksh' from t0410.5:
> 
>   + promise_and_delete 383670739c2f993999f3c10911ac5cb5c6591523
>   + git -C repo rev-parse 383670739c2f993999f3c10911ac5cb5c6591523
> # Setting $HASH in 'promise_and_delete':
>   + HASH=383670739c2f993999f3c10911ac5cb5c6591523
>   + git -C repo tag -a -m message my_annotated_tag
> 383670739c2f993999f3c10911ac5cb5c6591523
>   + pack_as_from_promisor
>   + git -C repo rev-parse my_annotated_tag
>   + git -C repo pack-objects .git/objects/pack/pack
>   Enumerating objects: 1, done.
>   Counting objects: 100% (1/1), done.
>   Writing objects: 100% (1/1), done.
>   Total 1 (delta 0), reused 0 (delta 0)
> # Setting $HASH in 'pack_as_from_promisor', and overwriting its value # in
> the caller:
>   + HASH=a391e3e0447189aa0050c8f206462a1b0530a34a
>   + 1> repo/.git/objects/pack/pack-
> a391e3e0447189aa0050c8f206462a1b0530a34a.promisor
>   + echo a391e3e0447189aa0050c8f206462a1b0530a34a
>   a391e3e0447189aa0050c8f206462a1b0530a34a
>   + git -C repo tag -d my_annotated_tag
>   + 1> /dev/null
> # Using the new value in the caller:
>   + delete_object repo a391e3e0447189aa0050c8f206462a1b0530a34a
>   + sed -e 's|^..|&/|'
>   + echo a391e3e0447189aa0050c8f206462a1b0530a34a
>   + rm repo/.git/objects/a3/91e3e0447189aa0050c8f206462a1b0530a34a
>   rm: cannot remove
> 'repo/.git/objects/a3/91e3e0447189aa0050c8f206462a1b0530a34a': No
> such file or directory
> 
> Note, however, that 'ksh' is not utterly wrong in doing so, because POSIX
> does allow this behavior: POSIX 2.12 Shell Execution Environment, the last
> paragraph of the section:
> 
>   "each command of a multi-command pipeline is in a subshell
>    environment; as an extension, however, any or all commands in a
>    pipeline may be executed in the current environment."
> 
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.ht
> ml#tag_18_12
> 
> So apparently 'ksh' implements this extension.
> 
> The trivial fix would be to mark $HASH as 'local' in both helper functions, but
> this would not help 'ksh', of course, as it doesn't support 'local'.  However,
> since we use more and more 'local's in our testsuite, 'ksh' might be
> considered a lost cause anyway.
> 
> Or we could rename these HASH variables to something more specific to
> prevent this name collision, e.g. PACK_HASH in 'pack_as_from_promisor'.
> 
> Note that there are tests in t0410 that set and use the $HASH variable
> outside of these helper function, and, worse, there is a test that uses the
> $HASH variable set in the previous test.  Luckily, none of those tests use
> 'promise_and_delete' or 'pack_as_from_promisor'.

I think we are going to consider ksh a lost cause. We have to move to bash because the ksh implementation does not support a large enough environment to run all of the tests, so are now running with:

make SHELL=/usr/coreutils/bin/bash

t0410 passes using bash so we'll stick with that rather than trying to patch ksh that won't run properly inside make as of 2.25.0 (we hit the environment size limit).

Thanks for the response.

Regards,
Randall

