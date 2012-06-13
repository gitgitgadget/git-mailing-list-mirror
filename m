From: Ilya Dogolazky <ilya.dogolazky@nokia.com>
Subject: Re: git-p4: commits are visible in history after 'git p4 clone',
 but not a single file present
Date: Wed, 13 Jun 2012 09:58:16 +0300
Message-ID: <4FD83A08.6070208@nokia.com>
References: <4FD5C263.9010307@nokia.com> <CAE5ih79Lgc8vF0v=vTGZSwASsGwQWs2Q7h_AkW67RBfi-R=DCA@mail.gmail.com> <4FD6440C.7090900@nokia.com> <4FD67530.1090002@diamand.org> <4FD70DEB.7040506@nokia.com> <20120612222431.GA13427@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: ext Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 08:58:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SehXK-000611-4U
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 08:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab2FMG6c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 02:58:32 -0400
Received: from smtp.nokia.com ([147.243.1.48]:49366 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313Ab2FMG6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 02:58:31 -0400
Received: from [10.162.252.161] (essapo-nirac252161.europe.nokia.com [10.162.252.161])
	by mgw-sa02.nokia.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id q5D6wH4m004137;
	Wed, 13 Jun 2012 09:58:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120612222431.GA13427@padd.com>
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199874>

Hi Pete !

06/13/2012 01:24 AM, ext Pete Wyckoff =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:
> Fascinating.  So //kalma/xxx/yyy is a depot hosted in a p4d that runs
> on your local box, but //xxx/yyy is the depot name hosted in
> the company's p4d?

No. But now I think I understand, what I did wrong. There is no p4d=20
running on my own machine. "kalma" in this case is the name of the so=20
called "perforce client" I tried to use. And I think my error was to=20
express "please use perforce client 'kalma' to access depot '//xxx/yyy'=
"=20
by the string "//kalma/xxx/yyy", which is wrong. I'm pretty sure it was=
=20
not quite my own idea to do so, probably I misunderstood some piece of=20
documentation somewhere.

> I'm completely confused that //kalma/xxx/yyy even appeard to work
> at all.  Will be interested to see your P4PORT setting when using
> that repo.

And I think I understand now, why "//kalma/xxx/yyy" appeared to work: i=
t=20
took all the commits, but as I wanted to have something beginning with=20
"kalma" I got no files, because everything begins with "xxx" (and coupl=
e=20
of other names, none of them is equal to 'kalma'). Does this explanatio=
n=20
seem reasonable?

> Ooh.  You're using the shiny new "streams" feature in p4,
> I think.  Can you play with "p4 stream" to see if one is
> defined on //xxx or //xxx/yyy?.

Yes, alas I have to use it. Now I re-defined my "client" settings,=20
included the stream there and started from the beginning. Here is what =
I=20
did:

$ p4 client (and edit opened file .....)
Client xexe1 saved.
$ P4CLIENT=3Dxexe1 p4 sync
//xxx/yyy/zzz/readme.txt#1 - added as /x/data/tmp/xexe/yyy/zzz/readme.t=
xt
$ P4CLIENT=3Dxexe1 git p4 clone //xxx/yyy@all ~/xexe1
Importing from //xxx/yyy into /home/ilya/xexe1
Initialized empty Git repository in /home/ilya/xexe1/.git/
Doing initial import of //xxx/yyy/ from revision #head into=20
refs/remotes/p4/master
$ cd ~/xexe1
$ vim zzz/readme.txt (and edit it)
$ git commit zzz/readme.txt

Until now everything worked fine, so now is time to submit the changes=20
on readme.txt file ("rebase" is not needed, as no changes happened yet=20
since I cloned).

$ P4CLIENT=3Dxexe1 git p4 submit
Error: Cannot locate perforce checkout of //xxx/yyy/ in client view

This message comes from git-p4 script somewhere around line 1276 and I=20
don't understand its meaning.

Then I tried to set git-p4.useclientspec to "true" and I got the messag=
e:
$ P4CLIENT=3Dxexe1 git p4 submit
Can't handle %n wildcards in view: //xxx/yyy/zzz/somefile%%1

This "%%1" is visible in client config (as opened in editor during=20
execution "P4CLIENT=3Dxexe1 p4 client"), but I have not added it by=20
myself: this line [and many other similar lines in View: section] was=20
added after I set "Stream: //xxx/yyy" there. The beginning of View:=20
section looks like this now:

//xxx/yyy/zzz/... //xexe1/zzz/...
-//xxx/yyy/zzz/somefile%%1 //xexe1/zzz/somefile%%1

(yes, it begins with '-' and there are many other lines beginning with=20
'-', but this one is the only one containing '%%')

What do you think, is it now something wrong with git-p4 or is it again=
=20
something wrong in my setup?

Cheers,

Ilya
