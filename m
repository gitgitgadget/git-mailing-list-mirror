From: David Kastrup <dak@gnu.org>
Subject: Re: How to use git-svn to clone from a mirror?
Date: Tue, 05 Jun 2007 08:41:02 +0200
Message-ID: <86r6oqoqdd.fsf@lola.quinscape.zz>
References: <86hcpq8qjz.fsf@lola.quinscape.zz> <85myzfsqji.fsf@blr-RHarinath.blr.novell.com> <Pine.LNX.4.64.0706041906570.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 08:41:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvSjj-0004q4-Vp
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 08:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbXFEGlj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 02:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757482AbXFEGlj
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 02:41:39 -0400
Received: from main.gmane.org ([80.91.229.2]:36676 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457AbXFEGli (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 02:41:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HvSjK-0006Uj-Uh
	for git@vger.kernel.org; Tue, 05 Jun 2007 08:41:22 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 08:41:22 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 08:41:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:QrBEkWN+NrA336Jmv6faWWZN+YI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49164>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 4 Jun 2007, Raja R Harinath wrote:
>
>> David Kastrup <dak@gnu.org> writes:
>> 
>> > I have used something like
>> >
>> > git-svn clone -T trunk -b branches -t tags file:///tmp/rsync-mirror
>> >
>> > to clone an rsync mirror of an SVN repository.  Now I want to have 
>> > fetch revert to pulling from the upstream repository in future. 
>> > However, if I change the respective line in .git/config to 
>> > svn://the.svn.link/whatever, git-rebase will fetch the right updates, 
>> > but then says that it can't work with the objects in the git 
>> > repository.
>> >
>> > Changing the config back will make git-rebase -l work.
>> >
>> > So what would be the right procedure to shift the SVN source from an
>> > rsync mirror to the original, without git-svn breaking?
>> 
>> I think you'll have to
>> 
>> -------------8<------------
>>   # remove stored revision db, since we're going to change all the commit ids
>>   rm .git/svn/git-svn/.rev_db.*
>> 
>>   # rewrite git-svn-id: lines
>>   cg-admin-rewritehist \
>> 	--msg-filter \
>> 	'sed "s,file:///tmp/rsync-mirror,svn://the.svn.link/whatever,"'
>> 
>>   # recreate new revision db, and fetch updates, if any
>>   git-svn rebase
>> -------------8<------------
>
> <shameless plug>
> 	Or you use the just-rewritten version of it, git-filter-branch.
> </shameless>

Well, part of the reason I worked from an rsynced copy was to be able
to repeat the experiment by just wasting a few hours of time each
time, without wasting more bandwidth.

What I arrived at was to use
git-svn init -T trunk -t tags -b branches
  --rewrite-root svn://tug.org/texlive file:///mirror/texlive
git-svn fetch --all
[edit .git/config and replace the url and rewrite-root lines with a
 single url line pointing to the root]
git-reset --hard   [don't ask me why]
and afterwards fetches worked online.

I liked the commit messages when using --no-metadata better than with
--rewrite-root, but I found no way to get the resulting archive
operative for git-svn rebase afterwards.

Could someone explain to me why git needs to know the upstream URL
history, whether by --rewrite-root or rewrite-hist or
git-filter-branch?

I find this rather hard to understand, so I would like to get an idea
where this fits naturally into the overall design of git, and how it
makes sense.

Thanks,

-- 
David Kastrup
