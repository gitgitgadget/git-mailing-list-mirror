From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 06/16] t3700: sleep for 1 second, to avoid
 interfering with the racy code
Date: Fri, 10 Aug 2012 00:51:29 +0200
Message-ID: <20120809225128.GA5127@tommy-fedora.scientificnet.net>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-7-git-send-email-t.gummerer@gmail.com>
 <7vsjc023sr.fsf@alter.siamese.dyndns.org>
 <20120807165947.GD913@tgummerer>
 <7vr4rhrvfm.fsf@alter.siamese.dyndns.org>
 <7vmx25rtj5.fsf@alter.siamese.dyndns.org>
 <20120809131932.GD25671@tommy-fedora.surfnet.iacbox>
 <7vehngovox.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 00:52:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szbae-0004jU-N7
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 00:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759876Ab2HIWvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 18:51:45 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63724 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759873Ab2HIWvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 18:51:44 -0400
Received: by weyx8 with SMTP id x8so622197wey.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+1OWSvzOWnLDCrN10n5CS1PzrUNoA0nSYarFrdrzrmI=;
        b=cD2J/V7U6BS74FfIyd0Vm3zdcjyTY9cBk3HOmMK1ed5aTVeVRcbsf7vj93N5DyVQa9
         WEGlvdIGdLw4PGc5sHs+VTL3u+ZOU7yV7He7x9JIsBbE6T1cAcA6t7v+LraVm+6fr21d
         IfhFxiQtRRvLm1VjQmyND4GqOJOv6hUh/LJX0NOsJBF/6MQk9jLhVXlvZ3es4bqGIHsB
         mUDPMPL14WwyJuoqqp6KnwtdjOWkm7e31unmeMPb08o6Ug7wYg/lx2TDod5tGY+13Dp3
         DiJ65PLr6Mr8lT+pow4iFkrtlvQrUfDazKpwRFEdY0DnPJuxCr2wIluzZ7c3pCmdj4wC
         yBLg==
Received: by 10.180.84.1 with SMTP id u1mr397299wiy.15.1344552702356;
        Thu, 09 Aug 2012 15:51:42 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id o2sm6290606wiz.11.2012.08.09.15.51.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Aug 2012 15:51:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vehngovox.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203185>

On 08/09, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > On 08/08, Junio C Hamano wrote:
> >> ...
> >> Let me ask the same question in a more direct way.  Which part of
> >> this test break with your series?
> >> 
> >>         test_expect_success 'git add --refresh with pathspec' '
> >>                 git reset --hard &&
> >>                 echo >foo && echo >bar && echo >baz &&
> >>                 git add foo bar baz && H=$(git rev-parse :foo) && git rm -f foo &&
> >>                 echo "100644 $H 3	foo" | git update-index --index-info &&
> >> 	# "sleep 1 &&" in the update here ...
> >>                 test-chmtime -60 bar baz &&
> >>                 >expect &&
> >>                 git add --refresh bar >actual &&
> >>                 test_cmp expect actual &&
> >> 
> >>                 git diff-files --name-only >actual &&
> >>                 ! grep bar actual&&
> >>                 grep baz actual
> >>         '
> >> 
> >> We prepare an index with bunch of paths, we make "foo" unmerged, we
> >> smudge bar and baz stat-dirty, so that "diff-files" would report
> >> them, even though their contents match what is recorded in the
> >> index.
> >
> > After getting confused a bit myself, I now think here is the problem.
> > The v5 code smudges baz when doing git add --refresh bar.  Therefore
> > baz isn't considered stat-dirty by the code, but a racily smudged entry
> > and therefore its content gets checked, thus not showing up in
> > git diff-files.
> 
> So in short, the breakage is the last one among the three choices I
> gave you in my message you are responding to.  The user asked to
> refresh "bar" so that later diff-files won't report a false change
> on it, but "baz" effectively ends up getting refreshed at the same
> time and a false change is not reported.

Exactly.

> That "breakage" is, from the correctness point of view, not a
> breakage.  As the primary purpose of "refreshing" is to support
> commands that want to rely on a quick ce_modified() call to tell
> files that are modified in the working tree since it was last added
> to the index---you refresh once, and then you call such commands
> many times without having to worry about having to compare the
> contents between the indexed objects and the working tree files.
> 
> But from the performance point of view, which is the whole point of
> "refresh", the behaviour of the new code is dubious.  If the user is
> working in a large working tree (which automatically means large
> index, the primary reason we are doing this v5 experiment), the user
> often is working in a deep and narrow subdirectory of it, and a path
> limited refresh (the test names a specific file "bar", but imagine
> it were "." to limit it to the directory the user is working in) may
> be a cheap way not to bother even checking outside the area the user
> currently is working in.

That's true, but once we have the partial reader/writer, we do not
bother checking outside the area the user is currently working in
anyway.

Also and probably more importantly, this will only affect a *very*
small number of entries, because timestamps outside of the directory
in which the user is working in are rarely updated recently and
thus racy.

> Also, smudging more entries than necessary
> to be checked by ce_modified_check_fs() later at runtime may mean
> that it defeats the "refresh once and then compare cheaply many
> times" pattern that is employed by existing scripts.

The new racy code also calls ce_modified_check_fs() only if the size
and the stat_crc are not changed.  It's true that ce_modified_check_fs()
can be called multiple times, when match_stat_crc() is called, but that
could be solved by adding an additional flag CE_IS_MODIFIED, which
indicates that ce_modified_check_fs() was already run.

> Is the root cause really where the "racily-clean so smudge to tell
> later runtime to check contents" bit goes?  I am hoping that the
> issue is not coming from the difference between the current code and
> your code when they decide to "smudge", what entries they decide to
> "smudge" and based on what condition.

I just gave it a try using a CE_SMUDGED flag, instead of the mtime
as smudge marker, which which this test works without any problems.
It doesn't work the other way round, the test as the test doesn't
break when using mtime as smudge marker in v2, because we do the
ce_modified_check_fs() test earlier.
