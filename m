Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD581F4C1
	for <e@80x24.org>; Sun, 13 Oct 2019 18:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfJMSuN (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 14:50:13 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:42827 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfJMSuM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 14:50:12 -0400
Received: from localhost (unknown [1.186.12.3])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C1D1C240004;
        Sun, 13 Oct 2019 18:50:09 +0000 (UTC)
Date:   Mon, 14 Oct 2019 00:20:07 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Gui: Branch->create currently fails...
Message-ID: <20191013185007.hogizh23jomaswzx@yadavpratyush.com>
References: <bfe78474-0eb9-fc5e-1371-3b055308169a@iee.email>
 <20191008000003.qlulu5ie36eij4uq@yadavpratyush.com>
 <e0b45696-7945-4b7d-62e7-bff46eb8129a@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0b45696-7945-4b7d-62e7-bff46eb8129a@iee.email>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/19 09:34PM, Philip Oakley wrote:
> Hi Pratyus,
> On 08/10/2019 01:00, Pratyush Yadav wrote:
> > On 07/10/19 11:02PM, Philip Oakley wrote:
> > > I'd never used the Branch:Create before (this is via mouse) and it threw an
> > > error, which appears to be repeatable, so I'm reporting it at the moment so
> > I'm afraid I can't reproduce it. I tested by creating a worktree of
> > git.git by running:
> > 
> >    git worktree add ../git-2
> > 
> > Then I opened git-gui in the worktree and clicked the "Create" option
> > under the "Branch" menu.
> > 
> > The dialog opened just fine, which I assume is what your error is. But
> > just to be sure, I created a branch too, and that also works pretty
> > well.
> > 
> > Same behaviour with a "normal" branch, which is not inside a worktree.
> > 
> > So is there anything else in your setup that would cause this problem?
> > 
> > > I don't forget ...
> > > (I'm chasing down other issue at the moment ;-)
> > > 
> > > This is with the version 0.21.GI git version 2.23.0.windows.1 Tcl/Tck 8.6.9
> > > 
> > > 
> > > missing "
> > > missing "
> > >      while executing
> > > "list "refs/heads/redo-v0" [list ""
> > >      ("eval" body line 1)
> > >      invoked from within
> > > "eval $line"
> > >      (procedure "_new" line 87)
> > >      invoked from within
> > > "_new $path 0 $title"
> > >      (procedure "::choose_rev::new" line 2)
> > >      invoked from within
> > > "::choose_rev::new $w.rev [mc "Starting Revision"]"
> > >      (procedure "branch_create::dialog" line 35)
> > >      invoked from within
> > > "branch_create::dialog"
> > >      (menu invoke)
> > Looking at the log, the culprit seems to be the line:
> > 
> >    set line [eval $line]
> > 
> > over at lib/choose_rev.tcl:159. The $line comes from reading the output
> > of a call to `git for-each-ref` with '--tcl' passed in. Looking at the
> > man page for 'for-each-ref', the description of the option is:
> > 
> >    --shell, --perl, --python, --tcl
> >      If given, strings that substitute %(fieldname) placeholders are
> >      quoted as string literals suitable for the specified host language.
> >      This is meant to produce a scriptlet that
> >      can directly be `eval`ed.
> > 
> > So this might possibly me an upstream bug.
> > 
> > If I had to guess a fix, I'd suggest trying to wrap the $line in
> > lib/choose_rev.tcl:159 in quotes like so:
> > 
> >    set line [eval "$line"]
> > 
> > If this doesn't fix it, see if you can find out which $line is causing
> > problem by printing the variable before 'eval'ing it by adding a:
> > 
> >    puts "$line"
> > 
> > before the call to eval.
> > 
> I've tried both parts and seen that this looks like some form of buffer
> overrun or size limit

Looks like it, but I'm not sure if that is on our end.
 
> with the mods I ran:
> $ git gui > branch_create.txt
> 
> which produced the 'same' error missing ", but with a slightly different
> fragment.
> 
> The branch_create.txt file is size 1.43 MB (1,502,103 bytes) (from the
> windows explorer file properties dialog..)
> opening in Notepad++ it's 4900 lines long with the final line trucated at
> col 188 (shorter than other lines). There is an empty line 4901 (CRLF)

Yeah, that's a lot of refs! On my git.git clone, I get 1299 lines, and I 
have git.git, my fork of git.git, and gitster in my remotes.
 
> the last two lines are:
> list "refs/heads/branch-patterns" [list "commit"
> "b2453cea29b58f2ec57f9627b2456b41568ba5da" [concat "" "Philip Oakley"]
> [reformat_date [concat "" "Tue May 28 20:22:09 2019 +0100"]] "squash! doc
> branch: provide examples for listing remote tracking branches"] [list "" ""
> "" [reformat_date ""] ""]
> list "refs/heads/MSVC-README" [list "commit"
> "056fb95c8e983ec07e9f5f8baa0b119bf3d13fed" [concat "" "Philip Oakley"]
> [reformat_date [concat "" "Sun May 19 22:33:37 2019 +0100"]] "compat/vc
> 
> the file starts with 1018 lines of refs/tags before listing the refs/remotes
> and finally the refs/heads.
> 
> The repo is my local Git repo with multiple remotes (git.git, G-f-W, ggg,
> junio, gitster, dscho, t-b, tboeg, me), so plenty of refs there!
> 
> So it does look to be specific to repos with a large number of refs/tags,
> refs/remotes, and refs/heads.
> 
> something for the back-burner?

I'm not sure why or where a buffer overflow would occur. We don't store 
the whole output directly in a variable. Instead, we store each line 
from the pipe coming in from `git for-each-ref` in $line, so that's a 
few hundred characters at most. The rest of the data stays in the pipe, 
which the OS should handle, and I don't think a few MBs should cause 
trouble.

If I had to guess, I'd suspect either an internal Tcl limit, or 
something with Tcl pipes.

Just to be sure it is a git-gui/Tcl issue and not an upstream git.git 
issue, can you run:

  fmt='list %(refname) [list %(objecttype) %(objectname) [concat %(taggername) %(authorname)] [reformat_date [concat %(taggerdate) %(authordate)]] %(subject)] [list %(*objecttype) %(*objectname) %(*authorname) [reformat_date %(*authordate)] %(*subject)]'
  
  git for-each-ref --tcl --format="$fmt" --sort=-taggerdate refs/heads refs/remotes refs/tags

and see if the output contains that truncated line? If it does, then 
that means the bug is in git-for-each-ref. Note that this is bash 
syntax, and I did a test run on Linux. Do adjust it for Windows and your 
shell if needed.

Other than that, I don't really see a clear fix. So looks like something 
for the back burner.

-- 
Regards,
Pratyush Yadav
