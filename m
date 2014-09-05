From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: git rebase: yet another newbie quest.
Date: Fri, 5 Sep 2014 11:41:59 -0400
Message-ID: <20140905154159.GB1510@thunk.org>
References: <87a96ecqe9.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 17:42:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPveK-00083f-PL
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 17:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbaIEPmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 11:42:04 -0400
Received: from imap.thunk.org ([74.207.234.97]:40239 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051AbaIEPmC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 11:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=W7IA9pVBaemE8sV4RrzthP+2d6WWorbO2dbrHfVm38Q=;
	b=AS6ScSNdWSSd1RhfgHU+RL8YZCmpDWnebQ2WfByt9lZon/f//OmKRp6/3ZVQKhG6pGsRoqhlkBWv8shoNkaJyE1+da7KcMAi1xB5+lBvFbUyqiaKv0jDkiD5mi97ikA3NlXgIKasTWfYua2sd4hih0PdD9+n2ISmZaGW03vA08Q=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1XPveC-0006n9-F0; Fri, 05 Sep 2014 15:42:00 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 8F16958044E; Fri,  5 Sep 2014 11:41:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87a96ecqe9.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256510>

I'm not going to say what you *should* have done, since it's not clear
whether anything close to what you were doing is a supported workflow.
But I can tell you what I *do* myself.  Personally, I vastly distrust
git pull --rebase.

So in general, my pulls are all the equivalent of "git pull
--ff-only", and if I want to rebase the topic branch (which in
general, is a bad idea to do regularly; I will generally not do it at
all until I'm almost done).  So I'll branch the topic branch off of
origin (which tracks origin/master, typically):

git checkout -b topic1 origin
<hack hack hack>
git commit
    .
    .
    .


Then I might do something like this to do a build:

git fetch origin ; git branch -f origin origin/master    # this is optional
git checkout -B build origin
git merge topic1
git merge topic2
    ...
<make>

In general, I will only rebase a topic branch when it's needed to fix
a serious conflcit caused by significant changes upstream.  And in
that case, I might do something like this:

git checkout topic1
git rebase origin/master
<make>
<make check>


This basically goes to a philosophical question of whether it's
simpler to tell users to use a single command, such as "git pull
--rebase", or whether to tell users to use a 2 or 3 commands that
conceptually much more simple.  Personally, I type fast enough that I
tend to use simple commands, and not try to use things like automated
branch tracking.  That way I don't have to strain my brain thinking
about things like "fork points".  :-)

OTOH, some people feel that it's better to make things like "git pull
--rebase" work and do the right thing automatically, because
<competing DSCM> allows you to do it in a single command.  And indeed,
if you use "git pull --rebase" without any topic branches, it works
fine.  But then when you start wanting to do things that are more
complicated, the automated command starts getting actually harder and
more confusing (at least in my opinion).  

I don't know if a workflow involving topic branches was even expected
to work with "git pull --rebase", and if so, how to set things up so
that they do work smoothly.  All I know is that the issue never arises
with me, because it's rare that I use git pull, let alone git pull
--rebase.  That's because I usually like to take a quick look at what
I've pulled (using gitk, or git log) before do the merge operation.

If I'm doing a pull from a repo that I control, and so I think I'm
sure I know what's there, I might skip the "git fetch", and do a "git
pull --ff-only" instead.  But in general I prefer to do the merging
separate from the pull operation.

Cheers,

						- Ted

P.S.  There is a separate, and completely valid discussion which is
how to prevent a newbie from falling into a same trap you did.  I'll
defer that discussion to others...
