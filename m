From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] t9700-perl-git.sh: Fix a test failure on cygwin
Date: Fri, 29 Aug 2008 21:56:55 +0100
Message-ID: <48B86297.7080204@ramsay1.demon.co.uk>
References: <48B5984B.4020901@ramsay1.demon.co.uk> <7vd4jup800.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Lea Wiemann <lewiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 23:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZBIV-0008Gn-Rz
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 23:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbYH2VNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 17:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbYH2VND
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 17:13:03 -0400
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:44085 "EHLO
	anchor-post-37.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755757AbYH2VNC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Aug 2008 17:13:02 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.69)
	id 1KZBH9-0004M4-Nm; Fri, 29 Aug 2008 21:13:00 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vd4jup800.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94328>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>
>> This patch fixes the t9700 test failure on cygwin. Don't ask me to
>> explain why the original test.pl fails on cygwin, but passes on Linux!
>>
> Curious.
> 
> What does this give you:
> 
> 	$ cd t
>         $ sh t9700-perl-git.sh -v
> 
> with the attached patch?  
[snip]
> For me, cwd() is the same as Cwd->cwd (this is from Perl 5.8.8); perhaps
> it behaves differently on Cygwin?
> 

Yes, sorry, I should have spent a few minutes explaining the cause of the
bug and why the patch fixes it; my bad!

(I was in a bit of a hurry; I had just re-booted twice in quick succession,
once into Linux so that I could pull the patch over to test it there, before
going back to Windows, in order to format-patch and send it to the ML. Yes
it is a PITA 8-)

I haven't tried your patch because, well, I already know what it will say!

Once I determined that the problem must be in the following four lines
of the t/t9700/test.pl script:

17 our $repo_dir = "trash directory";
18 our $abs_repo_dir = Cwd->cwd;
19 die "this must be run by calling the t/t97* shell script(s)\n"
20     if basename(Cwd->cwd) ne $repo_dir;

then the problem and the solution was immediately obvious. Well, maybe that is
overstating it slightly. After all, I still indulged in a spot of "printf
debugging" just to make sure! I'm sure you can imagine what it looked like ;-)
[BTW, the reason it was obvious, is that I have met this problem *too many*
times in the past, so I'm "attuned" to it. Don't worry, I will dispense with
the rant this time :-P]

I won't repeat that here, but offer a quick script:

    $ cat test-cwd.pl
    use Cwd;

    print "cwd():      ", cwd(),      "\n";
    print "Cwd::cwd(): ", Cwd::cwd(), "\n";
    print "Cwd->cwd:   ", Cwd->cwd,   "\n";
    $
on cygwin:
    $ perl test-cwd.pl
    cwd():      /home/ramsay
    Cwd::cwd(): /home/ramsay
    Usage: Cwd::cwd() at test-cwd.pl line 5.
    $
and on Linux:
    $ perl test-cwd.pl
    cwd():      /home/ramsay
    Cwd::cwd(): /home/ramsay
    Cwd->cwd:   /home/ramsay
    $

So it is clear, the problem is caused by the "method invocation syntax".
Among other things, this mechanism auto-magically inserts a new (in this
case only) first parameter which represents the "class" Cwd to the cwd()
"method-call".

So, do a "perldoc Cwd" and take a look at the example usage. So is cwd()
a method of the Cwd class, or is it a function in the Cwd namespace?
Exactly, hence the patch. (Well, some may prefer to see the Cwd::cwd()
syntax used instead. Dunno)

So, the bug is inappropriate use of the method invocation syntax.
But that didn't explain the difference in behaviour on the two platforms,
hence my "Don't ask me to explain ..." comment.

Now it just so happens that I have the source code to perl v5.8.8 in my
home directory (no really!) on Linux, so I spent a little time rooting
around to try and explain it.

The changelog type files, perl-5.8.8/Changes and perl-5.8.8/ext/Cwd/Changes
didn't show much of interest.  The module impl. in perl-5.8.8/lib/Cwd.pm was
an interesting read but didn't explain it. Then I bumped into the cygwin
specific file perl-5.8.8/cygwin/cygwin.c, part of which I include below:

---perl-5.8.8/cygwin/cygwin.c:139-157---
/* see also Cwd.pm */
static
XS(Cygwin_cwd)
{
    dXSARGS;
    char *cwd;

    if(items != 0)
	Perl_croak(aTHX_ "Usage: Cwd::cwd()");
    if((cwd = getcwd(NULL, -1))) {
	ST(0) = sv_2mortal(newSVpv(cwd, 0));
	free(cwd);
#ifndef INCOMPLETE_TAINTS
	SvTAINTED_on(ST(0));
#endif
	XSRETURN(1);
    }
    XSRETURN_UNDEF;
}
------

So, that explains it.

ATB,

Ramsay Jones

P.S. I'm sure someone will say that "the real bug here" is that the cygwin
platform should support the method invocation syntax just like all the
other platforms. Well, I guess I don't really care that much. But If you
were to push me, I would tend to go the other way, and say the other platforms
should not allow an incorrect invocation to go unnoticed!
Whatever.
