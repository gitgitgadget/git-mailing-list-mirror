From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: commits are visible in history after 'git p4 clone', but
 not a single file present
Date: Tue, 12 Jun 2012 18:24:31 -0400
Message-ID: <20120612222431.GA13427@padd.com>
References: <4FD5C263.9010307@nokia.com>
 <CAE5ih79Lgc8vF0v=vTGZSwASsGwQWs2Q7h_AkW67RBfi-R=DCA@mail.gmail.com>
 <4FD6440C.7090900@nokia.com>
 <4FD67530.1090002@diamand.org>
 <4FD70DEB.7040506@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Ilya Dogolazky <ilya.dogolazky@nokia.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 00:24:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeZVw-000868-DO
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 00:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab2FLWYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 18:24:36 -0400
Received: from honk.padd.com ([74.3.171.149]:40572 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807Ab2FLWYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 18:24:35 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 850BB2C1E;
	Tue, 12 Jun 2012 15:24:34 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9BB5231382; Tue, 12 Jun 2012 18:24:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4FD70DEB.7040506@nokia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199868>

ilya.dogolazky@nokia.com wrote on Tue, 12 Jun 2012 12:37 +0300:
> Hi Luke!
> 
> > #!/bin/sh
> > export P4PORT=localhost:1234
> > mkdir db cli
> > ( cd db && p4d & )
> > sleep 2
> > ( cd cli && EDITOR=: p4 client && date >foo.c &&
> >   p4 add foo.c && p4 submit -d 'x' )
> > git-p4 clone //depot@all
> 
> I installed p4d on my machine and executed the above script.
> It works, the file foo.c is visible in the copy and one line patch
> is visible by "git log -p". Everything is fine!
> 
> Then I realize, that the "git-p4" call in your script is
> communicating with the p4 daemon directly, which is much more simple
> setup than I tried to use before. Then I changed the clone command:
> instead of
>  $ git p4 clone //kalma/xxx/yyy@all
> I now tried
>  $ git p4 clone //xxx/yyy@all
> after setting P4PORT etc to point to the company's perforce server.
> And it worked!

Fascinating.  So //kalma/xxx/yyy is a depot hosted in a p4d that runs
on your local box, but //xxx/yyy is the depot name hosted in
the company's p4d?

> Then I even tried
> $ git p4 clone //xxx@all
> And it worked too (creating a huge git repository with the whole project).
> 
> Until today I tried to use the following setup: first clone the
> whole perforce repository with p4 command line client to my machine
> ('kalma' is its name) and then make a git repository by "git-p4
> clone" from this intermediate location (and it seems I did something
> wrong there: files were visible in the intermediate location after
> the first step, but not in the end location after git-p4). I read it
> somewhere in documentation claiming that it's the only way to use
> git-p4. But now I see, that it seems not to be necessary. Please
> clarify, is it okay to skip this intermediate location and use
> git-p4 in the same way as your script does?

I'm completely confused that //kalma/xxx/yyy even appeard to work
at all.  Will be interested to see your P4PORT setting when using
that repo.

> And another question, probably connected to above: Now I did this:
> $ git p4 clone //xxx/yyy@all
> $ cd yyy/zzz
> $ edit readme.txt (which was already present there)
> $ git commit readme.txt
> $ git p4 rebase (Current branch master is up to date)
> $ git p4 submit
> 
> That last step failed with following messages:
> Submitting change 20073
> ... //xxx/yyy/zzz/readme.txt -  warning: cannot submit from
> non-stream client
> No files to submit.
> Submit failed -- fix problems above then use 'p4 submit -c 20073'.

Ooh.  You're using the shiny new "streams" feature in p4,
I think.  Can you play with "p4 stream" to see if one is
defined on //xxx or //xxx/yyy?.

Could be that the work-around is to use "p4 client" to
set the "Stream" field.  This p4 forum post talks about
using "p4 client -s -S ...".

http://forums.perforce.com/index.php?/topic/1139-seeding-streams-from-existing-depots-failed/

which is explained at the bottom of this section:

http://www.perforce.com/perforce/doc.current/manuals/p4guide/06_codemgmt.html#1066766

If you can help us understand the problem a bit better,
a reasonable fix might be to detect this situation in
git-p4 and at least explain how to fix it.  Since git-p4
does not create the client used for submit, we don't have
much control over its settings.

		-- Pete
