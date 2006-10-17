From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 13:45:31 +0200
Message-ID: <200610171345.32313.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 13:45:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZnNl-00030X-73
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 13:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423103AbWJQLpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 07:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423129AbWJQLpI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 07:45:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:11115 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423103AbWJQLpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 07:45:05 -0400
Received: by ug-out-1314.google.com with SMTP id o38so960614ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 04:45:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aFyfAH+Dyed/YRxKpy4tAKGgAp2i8AF9M2nFICqnJT22jr3II84dhpd/eGag0w9kOeSr29AUuJcy8PguFGP4up/RS5j3rnORJ0xXf4jhuY76kyJkCqoOZa0/uaymqXfCNP4FXlHpOyXr+wXcsCzZckyyHJFeRmdhOPvl0Su1GCA=
Received: by 10.67.29.12 with SMTP id g12mr9627555ugj;
        Tue, 17 Oct 2006 04:45:03 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id 29sm32590uga.2006.10.17.04.45.02;
        Tue, 17 Oct 2006 04:45:02 -0700 (PDT)
To: Matthieu Moy <Matthieu.Moy@imag.fr>
User-Agent: KMail/1.9.3
In-Reply-To: <vpqejt76vgz.fsf@ecrins.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29060>

Matthieu Moy wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> - you can use a checkout to maintain a local mirror of a read-only
>>>   branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).
>>
>> In git you can access contents _without_ checkout/working area.
> 
> Bazaar can do this too. For example,
> "bzr cat http://something -r some-revision" gets the content of a file
> at a given revision. But that's not what Aaron was refering to.

Git cannot do that remotely (with exception of git-tar-tree/git-archive 
which has --remote option), yet. But you can get contents of a file 
(with "git cat-file -p [<revision>:|:<stage>:]<filename>"), list 
directory (with "git ls-tree <tree-ish>") and compare files or 
directories (git diff family of commands) without need for working 
directory.
 
AFAICT working area is required _only_ to resolve conflicts during 
merge.

> In Bazaar, checkouts can be two things:
> 
> 1) a working tree without any history information, pointing to some
>    other location for the history itself (a la svn/CVS/...).
>    (this is "light checkout")
> 
> 2) a bound branch. It's not _very_ different from a normal branch, but
>    mostly "commit" behaves differently:
>    - it commits both on the local and the remote branch (equivalent to
>      "commit" + "push", but in a transactional way).
>    - it refuses to commit if you're out of date with the branch you're
>      bound to.
>    (this is "heavy checkout")

In git by default in the top directory of working area you have .git 
directory which contains whole repository (object database, refs (i.e. 
branches and tags), information which branch is current, index aka. 
gitcache, configuration, etc.). You can share object database locally 
(which includes network filesystem).

You can have .git (usually <project>.git then) directory without working 
area.

And you can symlink (and in the future "symref"-link) .git directory.

> In both cases, this has the side effect that you can't commit if the
> "upstream" branch is read-only. That's not fundamental, but handy.

There was proposal to allow for tracking branches to be marked 
read-only, but it was not implemented yet.

But git has reverse check: it forbids (unless forced by user) to fetch 
into branch which has local changes (does not fast-forward). This make 
sure that no information is lost.

The idea is that you fetch changes into tracking branch (e.g. 'master' 
branch of some parent remote repository into 'origin' or 
'remotes/<repository name>/master' branch); you don't commit changes to 
such branch. You do your own work either on 'master' branch, then merge 
(typically using "git pull") corresponding 'origin' tracking branch, or 
use separate private feature branch and use rebase after fetch.

[...]
> The more fundamental thing I suppose is that it allows people to work
> in a centralized way (checkout/commit/update/...), and Bazaar was
> designed to allow several different workflows, including the
> centralized one.

Git is designed for distributed workflows, not for centralized one.
All repositories are created equal :-)

-- 
Jakub Narebski
ShadeHawk on #git and #revctl
Poland
