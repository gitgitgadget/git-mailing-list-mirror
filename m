Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DE491F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 18:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394429AbfJPSw2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 14:52:28 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51615 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbfJPSw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 14:52:26 -0400
Received: from localhost (unknown [1.186.12.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4F7FD24000C;
        Wed, 16 Oct 2019 18:52:23 +0000 (UTC)
Date:   Thu, 17 Oct 2019 00:22:21 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Gui: Branch->create currently fails...
Message-ID: <20191016185221.hufjb4uavacumbmc@yadavpratyush.com>
References: <bfe78474-0eb9-fc5e-1371-3b055308169a@iee.email>
 <20191008000003.qlulu5ie36eij4uq@yadavpratyush.com>
 <e0b45696-7945-4b7d-62e7-bff46eb8129a@iee.email>
 <20191013185007.hogizh23jomaswzx@yadavpratyush.com>
 <fccde9f3-7c5c-f8fb-1af2-bd56f48f7877@iee.email>
 <20191014175747.llstv7oxba2c23qy@yadavpratyush.com>
 <dc8a9b93-a2e7-4fbf-0ea7-f1a855f4b926@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc8a9b93-a2e7-4fbf-0ea7-f1a855f4b926@iee.email>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/10/19 11:11PM, Philip Oakley wrote:
> On 14/10/2019 18:57, Pratyush Yadav wrote:
> > > list "refs/heads/MSVC-README" [list "commit"
> > > "056fb95c8e983ec07e9f5f8baa0b119bf3d13fed" [concat "" "Philip Oakley"]
> > > [reformat_date [concat "" "Sun May 19 22:33:37 2019 +0100"]]
> > > "compat/vcSegmentation fault
> > > 
> > > 
> > > Not exactly the same, but almost. Ends the same place, with as similar short
> > > line.
> > > This is run inside the bash that is started directly by the git-for-windows
> > > sdk start icon. (Target: C:\git-sdk-64\git-bash.exe   Stat in:
> > > C:/git-sdk-64/)
> > > 
> > > so looks to be MSYS2/bash related.
> > Ah, so it is an upstream issue. I guess we can just report it and wait
> > for them to fix it.
> I'd missed the final 'Segmentation fault' on the last line in the bash
> output that wasn't there for the captured file.
> 
> That was repeatable in re-testing.
> But failed if I changed the $fmt string to a plain text 500 char string
> ("1234567890123...").
> 
> I've still to trim down the complicated $fmt string to see if I can see
> where that seg fault starts (i.e. some form of MVCE), so that it can be
> investigated.
> Possibly should check if the --tcl flag actually invokes any tcl! Otherwise
> it's fully in the Git/G-f-W zone.

A quick look tells me '--tcl' does not invoke any Tcl. It is just used 
to output properly formatted strings for Tcl. The option sets the value 
of 'format.quote_style' in for-each-ref (builtin/for-each-ref.c:33). 
That value is later indirectly ends up being used in the function 
ref_filter.c::quote_formatting.

The Tcl code we execute comes from the long $fmt string, which is built 
in git-gui/choose_rev.tcl:133-147. `for-each-ref` just fills in the 
placeholder values, properly formatting them for use in Tcl.

As an experiment, you can try removing '--tcl' from the `for-each-ref` 
command that segfaults, just to be sure. It would probably output 
invalid Tcl, but since we don't do anything with that output, it doesn't 
really matter, and would let us know if '--tcl' is really the culprit.

> ...
> Just rebuilt (I hope) the Windows Subsystem for Linux (WSL) with git v2.23.0
> installed and got:
> 
> list "refs/heads/MSVC-README" [list "commit"
> "056fb95c8e983ec07e9f5f8baa0b119bf3d13fed" [concat "" "Philip Oakley"]
> [reformat_date [concat "" "Sun May 19 22:33:37 2019 +0100"]]
> "compat/vcbuild/README: clean/update 'vcpkg' env for Visual Studio updates"]
> [list "" "" "" [reformat_date ""] ""]
> munmap_chunk(): invalid pointer

A quick Google search tells me munmap_chunk() is probably related to an 
invalid pointer being freed. Either a double free or a free on a pointer 
not allocated by malloc or something similar.

> Aborted (core dumped)
> root@Philip-Win10:/mnt/c/git-sdk-64/usr/src/git#
> 
> 
> That said, haven't got the gitk and git gui to work yet on the WSL because
> it doesn't like the tcl/tk.
> 
> It's a bit of a hole digging exercise.

-- 
Regards,
Pratyush Yadav
