From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/2] submodule: drop the top-level requirement
Date: Thu, 18 Apr 2013 15:56:18 +0100
Message-ID: <20130418145617.GA2278@serenity.lan>
References: <cover.1365364193.git.john@keeping.me.uk>
 <cover.1365539059.git.john@keeping.me.uk>
 <4a6394e9e7124c2ad5a3ce232dc746e85cb1c600.1365539059.git.john@keeping.me.uk>
 <CALkWK0==bnrRJDk1daANoZOOVLwZOPM+YhwOZs7yimoYBoyXyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 16:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USqGJ-0001Pn-5o
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 16:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967450Ab3DRO4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 10:56:31 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:53824 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965740Ab3DRO43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 10:56:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 7306760659B;
	Thu, 18 Apr 2013 15:56:29 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mw7H+zbEHldZ; Thu, 18 Apr 2013 15:56:29 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 5E8146064E0;
	Thu, 18 Apr 2013 15:56:19 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0==bnrRJDk1daANoZOOVLwZOPM+YhwOZs7yimoYBoyXyA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221662>

On Thu, Apr 18, 2013 at 08:16:42PM +0530, Ramkumar Ramachandra wrote:
> John Keeping wrote:
> > Use the new rev-parse --prefix option to process all paths given to the
> > submodule command, dropping the requirement that it be run from the
> > top-level of the repository.
> 
> Yay!
> 
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 79bfaac..bbf7983 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -112,6 +115,7 @@ resolve_relative_url ()
> >  #
> >  module_list()
> >  {
> > +       eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
> 
> Nit: Why not use "--" to disambiguate between options and arguments,
> like you showed in your intended usage?

Erm... it does.  What's before "$@"?

Ah, you mean after "set".  In this case, rev-parse will keep the "--" we
supply to it, so we get that from there and do not want to give set an
extra one.

> So, this essentially converts all the paths specified in "$@" to
> toplevel-relative paths.  Beautiful, as this is practically the only
> change you require in each function.
> 
> > +       sm_path="$wt_prefix$sm_path"
> 
> Wait, isn't sm_path the value of submodule.<name>.path in .gitmodules?
>  Why does it need to be prefixed?

I think you've lost too much context here.  This is in cmd_add and at
this point sm_path holds the argument supplied by the user, which we
must adjust as it will be relative to the current directory.

We should probably be testing for an absolute path here though.

> > @@ -942,6 +948,7 @@ cmd_summary() {
> >         fi
> >
> >         cd_to_toplevel
> > +       eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
> 
> Um, what about other functions?  Yeah, it looks like all of them
> except this one call module_list().

Exactly.  Apart from this and cmd_add everything uses module_list.

> > diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> > index ff26535..7795f21 100755
> > --- a/t/t7400-submodule-basic.sh
> > +++ b/t/t7400-submodule-basic.sh
> > @@ -212,6 +212,23 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
> >         test_cmp empty untracked
> >  '
> >
> > +test_expect_success 'submodule add in subdir' '
> > +       echo "refs/heads/master" >expect &&
> > +       >empty &&
> 
> Nit: Use : >empty.  It's clearer.
> 
> > +       (
> > +               mkdir addtest/sub &&
> 
> Why is the mkdir inside the subshell?  The next statement (cd) onwards
> should be in the subshell, to save you cd'ing back.
>
> > +               cd addtest/sub &&
> > +               git submodule add "$submodurl" ../realsubmod3 &&
> > +               git submodule init
> > +       ) &&
> > +
> > +       rm -f heads head untracked &&
> 
> Huh?  What is this in the middle?  The next statement (call to
> inspect) write-truncates them anyway, so this is unnecessary.

I just followed the surrounding tests here.  I think it's better for
follow the pattern of the surrounding code here than get this one test
perfect.  A cleanup can follow on top if someone wants to do it.
