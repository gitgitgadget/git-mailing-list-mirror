From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Ignoring commits when merging
Date: Tue, 17 Aug 2010 20:59:47 -0500
Message-ID: <20100818015947.GA19632@burratino>
References: <AANLkTi=B9gsroJS_6SRqa2CLQOed2UguxN7KiFtFWL8t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Strauch <mike.strauch@hannonhill.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 04:01:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlXy7-0001Hu-KY
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 04:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456Ab0HRCB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 22:01:27 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37627 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab0HRCBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 22:01:25 -0400
Received: by qwh6 with SMTP id 6so6702495qwh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 19:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=30VKCtypmwyrfwKYsPWRgeN4RhECNcigPM/H68okquU=;
        b=Ws+8euV1CvZ+GB8d2YOgeGoEfxx0fWmMWE0VkoG90VEeJgVBxGe1S7cMrkzQC8dwLJ
         G04UZpUKXiC38MZ2mrgzKdYxlCv3HIa2DxP3I+2wy3TgpfbrNdfDYHseYNkGphBicm09
         R7pOv9jXVG/Rb0BbWTL9D07x4arDAiGGqbN1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=A0Dbwc+qmFWyq8NLCFIDoHEZ1DPQeA7tSGXp2lG0TWJ/++T4xtINNJCrZ3DICQCidc
         c04Jc1XV4Rbkpx4UDg2Nz4isadTwSpUD5LJKdD25yK+Cpfz4oPqLuwe1hDgwelXX6Dex
         DyjwrNhtDw+4vOM7sAYbMbRcPzMAVsd3m2ntE=
Received: by 10.229.1.143 with SMTP id 15mr59356qcf.287.1282096884855;
        Tue, 17 Aug 2010 19:01:24 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r1sm9573366qcq.22.2010.08.17.19.01.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 19:01:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=B9gsroJS_6SRqa2CLQOed2UguxN7KiFtFWL8t@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153802>

Hi,

Mike Strauch wrote:

> I'm fairly new to git and I'm trying to figure out the best way to
> ignore certain commits when merging one branch into another.

An interesting question.  The answer (as so often) depends on what
you want to do.  "man 7 gitworkflows" might help.

Below I will pretend you are trying to backport some changes to a more
stable branch; others may chime in with other scenarios.

First, a general hint: when using git and similar systems, it is
generally best if each merged result is somehow "better" than all of
its parents.  I will give an example below of what can go wrong if
this invariant is violated.

Merging to a maintenance branch
-------------------------------

Suppose given a history like this (1):

 o --- v1.0 [maint]
           \
            feature --- feature --- bugfix --- bugfix [master]

Development has been happening on the "master" branch and now you
want to merge back the relevant fixes to make a new point release,
something like the following:

[*] o --- v1.0 ------------------------------------ v1.1 [maint]
              \                                    /
               master-only feature --- bugfix --- M [master]

  "a dangerous history"

Let's consider what that would mean.  Someone builds some new
work off of maint:

 o --- v1.0 --- v1.1 --- o ... o --- A [someone]
               /

What happens when you pull the "someone" branch into master?  The
relevant piece of history looks like this:

        v1.1 --- o ... o --- A [someone]
       /
  ... M --- new development --- ... --- B [master]

When you try to pull A into B, git runs a three-way merge to
apply the changes from the someone branch after the branch point (M)
on the master branch.  In particular, the changes from M to v1.1
are pulled in.  The main change from M to v1.1 is to drop a
bunch of features.  So by pulling from someone, you lose features
on the master branch.

So a merge like [*] that drops desirable changes is generally not
a good idea.

Cherry-picking to a maintenance branch
--------------------------------------

As a result, starting from a history like (1), there is only one
choice: cherry-pick only the bugfixes, so the new features are not
incorporated into the history of the maint branch.

 $ git checkout maint
 $ git cherry-pick bugfix1 bugfix2

Afterwards, it is best to merge the maint branch into master, so
later changes on the maint branch can be merged into master more
easily.  Usually despite the duplicate changes will not result in
conflicts.

 $ git checkout master
 $ git merge maint
 $ git diff HEAD^
 $ : looks good
 $ git push public maint master

If there are conflicts, no need to worry: make sure that "master"
really includes all desirable changes from maint and merge with
strategy ours instead.

 $ git reset --merge
 $ git merge -s ours maint

Writing a new bugfix
--------------------

Suppose you have an idea for a new bugfix.  As discussed above, if
you write it directly on top of master, when it is time to apply
it to maint it will need cherry-picking.  If you base the patch
on maint, you can avoid that:

 $ git checkout -b bugfix maint
 ... hack hack hack ...
 $ make test
 $ : looks good
 $ git checkout master
 $ git merge bugfix
 $ make test
 $ git push public bugfix master

 v1.1 [maint] --- X [bugfix]
     \             \
      o --- ... --- N [master]


Once the patch gets enough testing from users of master, it is
time to apply it to maint.

 $ git checkout maint
 $ git merge bugfix
 $ make test
 $ git checkout master
 $ git merge maint
 $ git push public maint master

 v1.1 ----------- X [maint]
     \             \
      o --- ... --- N [master]

One benefit of this approach is that during development, the patch
is tested against the maintenance branch, which is incidentally
probably where it is most important that it get testing.

Hope that helps,
Jonathan
