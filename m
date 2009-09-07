From: Benjamin Buch <benni.buch@gmx.de>
Subject: Re: Deleted folder keeps showing up?
Date: Mon, 7 Sep 2009 10:17:05 +0200
Message-ID: <53F9526D-E31D-4027-8871-8468AB476E6D@gmx.de>
References: <34230C98-81B8-4DC8-846F-8B6FA2A022DA@gmx.de> <4AA0C4A2.5040405@drmicha.warpmail.net> <8E56979B-5D85-4844-A492-8149EE9E9B2F@gmx.de> <7vfxb3yuma.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:17:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZPe-0001FR-M0
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbZIGIRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbZIGIRJ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:17:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:55810 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751959AbZIGIRI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:17:08 -0400
Received: (qmail invoked by alias); 07 Sep 2009 08:17:09 -0000
Received: from pd95b3d32.dip0.t-ipconnect.de (EHLO [192.168.10.108]) [217.91.61.50]
  by mail.gmx.net (mp017) with SMTP; 07 Sep 2009 10:17:09 +0200
X-Authenticated: #10686235
X-Provags-ID: V01U2FsdGVkX1+PDbhP6KaPaYOCujj1xWxn6WKySL0JXl0HQtN7dt
	OtGBXZrmyk1U3V
In-Reply-To: <7vfxb3yuma.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127900>

Hi Junio,

thanks for the explanation!

It made things a lot clearer for me.
And I think that could be exactly what happened
and the reason why I couldn't reproduce the 'error'.

-benjamin

Am 04.09.2009 um 10:36 schrieb Junio C Hamano:

> Benjamin Buch <benni.buch@gmx.de> writes:
>
>> Strangely, I can't reproduce the error  today.
>
> If a branch has dir/file tracked, and another branch does not have
> anything tracked in dir/ directory at all, then switching from the  
> former
> branch to the latter can remove dir/ only when you do not have any
> untracked files in there when you switch.  Otherwise dir/ must stay
> behind to keep the untracked files.
>
> You can see it by a simple experiment.
>
>    $ rm -fr trial
>    $ mkdir trial
>    $ cd trial
>    $ git init
>    $ >elif
>    $ git commit -m initial
>    $ git branch lacksdir
>    $ mkdir dir
>    $ >dir/file
>    $ git add dir/file
>    $ git commit -m add-dir-file
>
> Now, after this set-up, your 'master' has dir/file and 'lacksdir' does
> not have anything tracked in dir/ directory.
>
> Observe:
>
>    $ git checkout lacksdir
>    $ find ??*
>    elif
>    $ git checkout master
>    $ find ??*
>    dir
>    dir/file
>    elif
>    $ >dir/garbage
>    $ git checkout lacksdir
>    $ find ??*
>    dir
>    dir/garbage
>    elif
>
> If switching to 'lacksdir' removed the dir/ directory, whatever was  
> in the
> untracked file dir/garbage will be lost.  In the above exercise, I  
> named
> it garbage, so a casual reader might get a false impression that it  
> should
> be thrown away, but in real life workflow, it often happens that
>
> (1) you start doing some interesting experimental changes, while on
>     'master';
>
> (2) you realize that this change does not belong to 'master', but  
> belongs
>     to some other branch, perhaps 'lacksdir';
>
> (3) you switch to the branch, to keep working.
>
> Remember that, in git, your uncommitted changes to the index and the  
> work
> tree do not belong to the branch.  They try to follow you across  
> branch
> switching.  Since untracked new files are something potentially you  
> might
> want to add after branch switching, we do not remove them.  And  
> because we
> choose not to remove dir/file, even though the commit at the tip of  
> the
> lacksdir branch does not have anything tracked in dir/ directory, we
> cannot remove it from the work tree.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
