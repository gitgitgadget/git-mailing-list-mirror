From: Csaba Henk <csaba-ml@creo.hu>
Subject: Re: import files w/ history
Date: Fri, 6 Mar 2009 13:29:38 +0000 (UTC)
Message-ID: <slrngr299k.1t4t.csaba-ml@beastie.creo.hu>
References: <slrngqqa4l.1t4t.csaba-ml@beastie.creo.hu> <20090303130046.GA7867@coredump.intra.peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 14:33:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfaAZ-00034B-LN
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 14:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbZCFN35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 08:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbZCFN34
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 08:29:56 -0500
Received: from main.gmane.org ([80.91.229.2]:55371 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbZCFN3z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 08:29:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lfa7a-0006jq-1S
	for git@vger.kernel.org; Fri, 06 Mar 2009 13:29:50 +0000
Received: from www.creo.hu ([217.113.62.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 13:29:50 +0000
Received: from csaba-ml by www.creo.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 13:29:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: www.creo.hu
User-Agent: slrn/0.9.8.1 (FreeBSD)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112436>

On 2009-03-03, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 03, 2009 at 12:54:54PM +0000, Csaba Henk wrote:
>
>> How could I import some files from an unrelated git repo with history?
>
> Just "git pull" from the other repo, which will include all of its
> history. If you want to pretend that the other history contains just a
> subset of the true history, use "git filter-branch" to rewrite it first.

Thanks Jeff, but it didn't work well for a large repo. At least not what
I could carve out myself.

The repo in question is the DragonFlyBSD repository, and I wanted to
cut out the history of sys/dev/disk/vn/vn.c. After reading
git-filter-branch(1) I come up with the following: first I wanted to
select those commits where the file in question was modified. I tried
to use the following filtration:

$ git filter-branch --commit-filter '
   if [ $# -lt 3 ] || git diff --stat $3 $1 | grep -q 'sys/dev/disk/vn/vn\.c'
   then
     git commit-tree "$@"
   else
     skip_commit "$@"
   fi' HEAD

It should select those commits where vn.c differs from the vn.c in the _first_
parent, so probably it's not exactly what I want, but anyway, I went on
to give it a try.

I have even tested this filter script on a small repo and it worked
well. Then I ran it against the Dfly repo, and after 23 hours of
processing I ended up with:

...
23575b3e0b087120b0475ae93c505c72a9779fdb
35ac2f0aa5ac0ca78109781817c524fa354e8691
23575b3e0b087120b0475ae93c505c72a9779fdb
35ac2f0aa5ac0ca78109781817c524fa354e8691
23575b3e0b087120b0475ae93c505c72a9779fdb
35ac2f0aa5ac0ca78109781817c524fa354e8691
23575b3e0b087120b0475ae93c505c72a9779fdb
35ac2f0aa5ac0ca78109781817c524fa354e8691
23575b3e0b087120b0475ae93c505c72a9779fdb
35ac2f0aa5ac0ca78109781817c524fa354e8691
WARNING: Ref 'refs/heads/__rewrite' points to the first one now.

And the result is completely f*cked up.
Neither those two commits which occur repeatedly at the end of the
output, nor the commit at the actual position of the __rewrite brach
has a parent, and the upstream commits from which these were derived
didn't affect vn.c.

  *  *  *

OK, I then tried to do more RTFM and be more clever and efficient, and
find a way to specify directly those commits which affect vn.c. As "git
rev-list" can be invoked like "git rev-list <commit> <path>", and the
synopsis of "git filter-branch" is like

 git filter-branch [options] [--] [<rev-list options>...]

I then gave a try to:

$ git filter-branch --  master sys/dev/disk/vn/vn.c

but no dice -- I got:

  fatal: ambiguous argument 'sys/dev/disk/vn/vn.c': unknown revision or
  path not in the working tree.
  Use '--' to separate paths from revisions
  Could not get the commits

Any idea?

Thanks,
Csaba
