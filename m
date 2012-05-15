From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Git commit path vs rebase path
Date: Tue, 15 May 2012 18:32:10 +0100
Message-ID: <4FB2931A.1080504@ramsay1.demon.co.uk>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>	<4FA8BBB0.1080406@viscovery.net>	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>	<4FA8C5DB.5060002@viscovery.net>	<CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>	<7vhavqwqpz.fsf@alter.siamese.dyndns.org>	<7v1umuwpo9.fsf@alter.siamese.dyndns.org>	<CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>	<4FAC047A.4010001@ramsay1.demon.co.uk> <CAAXzdLXbYp5YW9cZXxmRJk0MP=6PU897f4nuTe4ipLqk+EH9PQ@mail.gmail.com> <4FB03CA1.4030703@ramsay1.demon.co.uk> <4FB09FF2.70309@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Penny <svnpenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 15 19:32:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SULbi-00084m-S6
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 19:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966092Ab2EORcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 13:32:18 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:34798 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966054Ab2EORcR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 13:32:17 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1SULbb-0003VC-ja; Tue, 15 May 2012 17:32:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4FB09FF2.70309@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197844>

Johannes Sixt wrote:
> Am 5/14/2012 0:58, schrieb Ramsay Jones:
>> BTW, Johannes, earlier you said commit be39048 ("git-sh-setup.sh: Add an pwd()
>> function for MinGW", 17-04-2012) would fix the problem on MinGW; I'm not so
>> sure it will. 
> 
>> [...] problem (*which MinGW shares*) is that the
>> pwd() function is defined *after* the code that sets $GIT_DIR from which the
>> rebase state directory name is derived (see git-sh-setup.sh lines 223-239).
> 
> Good catch!
> 
> Nevertheless, if I set GIT_EDITOR to "notepad", 'git rebase -i' works to
> some degree. Leaving aside that it does not understand LF line endings, it
> opens the git-rebase-todo file; I can edit and save it. That is, it looks
> like a usable Windows style path was passed to Notepad. (This is with
> MinGW git, of course.)
> 

I was about to, confidently, proclaim that it should fail when
you run that rebase from a subdirectory ... Unfortunately, it
seems to work! *ahem*

The reason I was confident, is simply that I have seen this
pattern:

    p= ...some path...
    p=$(cd "$p" && pwd)

many times while debugging scripts on MinGW, so I 'know' that if
p is initially a relative path, then the result is an absolute
windows path. For example, while cwd is /home/ramsay/git then:

    .git => C:/msysgit/msysgit/home/ramsay/git/.git

Whereas if p is initially an absolute windows path, then the result
is a POSIX-like path, viz:

    C:/msysgit/msysgit/home/ramsay/git/.git => /usr/home/ramsay/git/.git

If you combine that with the behaviour of 'git rev-parse', thus:

    $ cd /home/ramsay/git
    $ git rev-parse --git-dir
    .git
    $ cd xdiff
    $ git rev-parse --git-dir
    C:/msysgit/msysgit/home/ramsay/git/.git
    $

you should see "git rebase -i" invoking the editor with a POSIX
path.

[BTW, I have noticed that I sometimes get different behaviour when
I type this stuff into an interactive shell. :(]

Anyway, a bit of debugging shows that I was right, kinda! :-D

I placed a "set -x" in git-sh-setup (line 222) just before the code
to set up GIT_DIR and ran git-rebase like so:

    $ cd /home/ramsay/git
    $ GIT_EDITOR=false ./bin-wrappers/git rebase -i master uname >ttt 2>&1
    $ cd xdiff
    $ GIT_EDITOR=false ../bin-wrappers/git rebase -i master uname >sss 2>&1
    $ diff ../ttt sss | more

which showed that in the subdirectory case, git was indeed invoking
the editor with a POSIX-like path. (The output files, ttt and sss, show
some other interesting/odd behaviour).

['uname' is an old branch of mine that, currently, is based on v1.7.10]

The reason it works, despite the above, is clear if you now run:

    $ GIT_EDITOR=args ../bin-wrappers/git rebase -i master uname

    ...

    +++ git var GIT_EDITOR
    ++ GIT_SEQUENCE_EDITOR=args
    ++ eval args '"$@"'
    +++ args /usr/home/ramsay/git/.git/rebase-merge/git-rebase-todo
    argv[0] = 'C:\msysgit\msysgit\home\ramsay\bin\args.exe'
    argv[1] = 'C:/msysgit/msysgit/home/ramsay/git/.git/rebase-merge/git-rebase-todo'

    ++ die_abort 'Could not execute editor'
    ++ rm -rf /usr/home/ramsay/git/.git/rebase-merge
    ++ die 'Could not execute editor'
    ++ die_with_status 1 'Could not execute editor'
    ++ status=1
    ++ shift
    ++ echo 'Could not execute editor'
    Could not execute editor
    ++ exit 1

[I'm sure you can guess what the args program looks like!]

So, the msys "path munging" of program arguments saves the day!

HTH

ATB,
Ramsay Jones
