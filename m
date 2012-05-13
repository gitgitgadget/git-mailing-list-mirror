From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Git commit path vs rebase path
Date: Sun, 13 May 2012 23:58:41 +0100
Message-ID: <4FB03CA1.4030703@ramsay1.demon.co.uk>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>	<4FA8BBB0.1080406@viscovery.net>	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>	<4FA8C5DB.5060002@viscovery.net>	<CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>	<7vhavqwqpz.fsf@alter.siamese.dyndns.org>	<7v1umuwpo9.fsf@alter.siamese.dyndns.org>	<CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>	<4FAC047A.4010001@ramsay1.demon.co.uk> <CAAXzdLXbYp5YW9cZXxmRJk0MP=6PU897f4nuTe4ipLqk+EH9PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 01:01:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SThnQ-0002Bt-Qz
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 01:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab2EMXBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 19:01:44 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:56588 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753214Ab2EMXBo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2012 19:01:44 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SThnK-0005K7-WZ; Sun, 13 May 2012 23:01:43 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <CAAXzdLXbYp5YW9cZXxmRJk0MP=6PU897f4nuTe4ipLqk+EH9PQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197758>

Steven Penny wrote:
> Ramsay Jones wrote:
>> I would rather define a script; it can then be used independently of git.
> 
> So your suggestion is to have git-sh-setup.sh account for MinGW, which is its
> current state, but not account for Cygwin?

I wasn't specifically suggesting that no; I was suggesting that I prefer to
fix the problem with a script on cygwin. (Again, the script can be used
independently of git)

BTW, Johannes, earlier you said commit be39048 ("git-sh-setup.sh: Add an pwd()
function for MinGW", 17-04-2012) would fix the problem on MinGW; I'm not so
sure it will. I haven't actually tested it, so don't take my word for it. ;-P
(See below for an explanation of my doubts)

>> Personally, I don't have this specific problem because I use (the cygwin
>> version of) vim. (does anybody actually use notepad?)
> 
> If you had read carefully, you would have noticed that I mentioned more than
> notepad. As well Notepad2, and Notepad++, etc.

Yes, I did notice that you mentioned more than notepad ...

>> I mostly, but not exclusively, use cygwin tools on cygwin. For example I
>> use win32 versions of doxygen, ghostscript, tex (MikTex 2.7), graphviz etc.
>> However, the makefiles which drive those tools use relative paths ...
> 
> This convo is not about what tools _you_ use, but about the current
> incompatibility with several native windows text editors.

OK.

So, yes, I didn't give your patch a look; sorry about that. Let's take a look
now (quoting from earlier email):

> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> > index 7b3ae75..ba198d2 100644
> > --- a/git-sh-setup.sh
> > +++ b/git-sh-setup.sh
> > @@ -260,6 +260,11 @@ case $(uname -s) in
> >  		return 1
> >  	}
> >  	;;
> > +*CYGWIN*)
> > +    pwd () {
> > +        builtin cygpath -m
> > +    }
> > +    ;;
> >  *)
> >  	is_absolute_path () {
> >  		case "$1" in
> > 
> > http://github.com/svnpenn/git/commit/692bc

I haven't actually tried to apply or test your patch, so take the
following with a pinch of salt ...

I don't think this will work because:

    - cygpath is not a bash builtin, so bash *should* simply issue
      an error something along the lines of "not a shell builtin".

    - cygpath requires an input path

So, I would have expected the body of the pwd function to be something like:

    cygpath -m "$PWD"

or maybe

    cygpath -m "$(builtin pwd)"

(Again, I'm just typing into my mail client, so not tested ...)

Also note that the MinGW pwd() uses a shell builtin and so, unlike the above,
does not suffer any fork+exec overhead.

If we fix the above, then another problem (*which MinGW shares*) is that the
pwd() function is defined *after* the code that sets $GIT_DIR from which the
rebase state directory name is derived (see git-sh-setup.sh lines 223-239).

Note that cygwin git will create the various inputs (commit template say) with
lf only line endings; so the windows text editor you use must be able to cope
with such an input. (I think the PSEdit editor will cope just fine).

Similar comments apply to all other external programs launched by git (for
example, external diff/merge tools, clean/smudge filters ...).

HTH

ATB,
Ramsay Jones
