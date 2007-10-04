From: "Jan Wielemaker" <wielemak@science.uva.nl>
Subject: Re: git-cvsserver commit trouble BUG+Work-around
Date: Thu, 4 Oct 2007 13:18:59 +0200 (CEST)
Message-ID: <46823.146.50.26.20.1191496739.squirrel@webmail.science.uva.nl>
References: <200710031348.50800.wielemak@science.uva.nl>
    <200710032325.55128.wielemak@science.uva.nl>
    <Pine.LNX.4.64.0710032311480.28395@racer.site>
    <200710040927.03977.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Johannes Schindelin" <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 13:21:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdOm5-0001AJ-Rz
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 13:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbXJDLTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 07:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbXJDLTH
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 07:19:07 -0400
Received: from smtp.science.uva.nl ([146.50.4.84]:46922 "EHLO
	smtp.science.uva.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbXJDLTF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 07:19:05 -0400
Received: from webmail.science.uva.nl [146.50.4.91]
          by smtp.science.uva.nl with ESMTP (sendmail 8.11.6p2/config 11.38).
          id l94BIx414580; Thu, 4 Oct 2007 13:18:59 +0200
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Received: from localhost ([127.0.0.1])
        (SquirrelMail authenticated user wielemak)
        by webmail.science.uva.nl with HTTP;
        Thu, 4 Oct 2007 13:18:59 +0200 (CEST)
In-Reply-To: <200710040927.03977.wielemak@science.uva.nl>
User-Agent: SquirrelMail/1.4.6-rc1
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59938>


>> Other reasons for the failure could be:
>>
>> 	- your user does not have write access
>
> Definitely ok (also put an strace -o logfile git-cvsserver "$@" script
> around it.  No alarming permission or non-existence errors).
>
>> 	- the uid under which git-cvsserver runs has no write access
>
> See above
>
>> 	- you found an error that only triggers with your repo
>
> Great!  Its so damn simple and and tried with three repos created
> in three different ways, that I'm either extremely unlucky or many
> more should be faced with this or nobody uses git-cvsserver.

Finally getting at what is either a bug in git-show-ref or
git-cvsserver.  I retried the whole lot using git-1.5.3.4:

<create initial repository>
	% Created /home/jan/tmp/test/, added a file README with some text
	% git-init
	% git-add .
	% git-commit

<create bare one for sharing>
	% cd /home/git
	% mkdir test.git
	% cd test.git
	% git --bare init --shared
	% git --bare fetch /home/jan/tmp/test master:master
	% git-config gitcvs.enabled 1
	% git-config gitcvs.logfile `pwd`/cvs.log
	% touch cvs.log
	% chmod g+w cvs.log
	% chgrp -R eculture .

<checkout>

	% export CVS_SERVER=git-cvsserver
	% cvs -d:ext:jan@localhost:/home/git/test.git co HEAD
	% cd HEAD
	% emacs README
	% cvs commit -m test
	cvs [commit aborted]: end of file from server (consult above messages if
any)

Same user, so we should not have permission rights. Indeed, the trouble
is here: git-cvsserver, near line 1203:

    my $parenthash = `git show-ref -s refs/heads/$state->{module}`;

$state->{module} is -of course- HEAD. git show-ref -s  refs/heads/HEAD
indeed gives no output. git show-ref -s refs/heads/master works just
fine.  HEAD in the repo says:

gollem (test.git) 2_> cat HEAD
ref: refs/heads/master

I guess this link must be picked up by either git-cvsserver or
git-show-ref. Right? Anyway, if I add the line marked + to
git-cvsserver, cvs commit and cvs add operations appear to work (I
assume only if I work on the HEAD).

    $ENV{GIT_INDEX_FILE} = $file_index;

+   $state->{module} = "master";

    # Remember where the head was at the beginning.

Thanks for the comments. Really worrying is that such a big flaw can be
in stable git and remain their for at least 3 patch levels unnoticed.

Will someone take care of this and fix it properly in the right place
instead of this dirty hack?

	Thanks --- Jan
