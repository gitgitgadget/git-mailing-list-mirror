From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Oct 2012, #09; Mon, 29)
Date: Fri, 02 Nov 2012 21:33:14 +0000
Message-ID: <50943C1A.4090706@ramsay1.demon.co.uk>
References: <20121029102114.GA14497@sigill.intra.peff.net> <5092C234.9000307@ramsay1.demon.co.uk> <CAEUsAPb7hUViLn7V7v65r6mOqRHr+180ynRX8K9t3nuJVyePfg@mail.gmail.com> <20121102094259.GA28414@sigill.intra.peff.net> <20121102095632.GA30221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 22:40:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUOyF-000356-8o
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 22:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086Ab2KBVjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 17:39:53 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:36912 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754685Ab2KBVjw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 17:39:52 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 10A414005A0;
	Fri,  2 Nov 2012 21:39:50 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 04818400590;	Fri,  2 Nov 2012 21:39:49 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Fri,  2 Nov 2012 21:39:47 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121102095632.GA30221@sigill.intra.peff.net>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208973>

Jeff King wrote:
> On Fri, Nov 02, 2012 at 05:43:00AM -0400, Jeff King wrote:
> 
>> Yeah, I think that is it. IIRC, Ramsay is on cygwin, and I noticed this
>> in perl 5.16's POSIX.xs:
>>
>> [...]
>>    * (4) The CRT strftime() "%Z" implementation calls __tzset(). That
>>    * calls CRT tzset(), but only the first time it is called, and in turn
>>    * that uses CRT getenv("TZ") to retrieve the timezone info from the CRT
>>    * local copy of the environment and hence gets the original setting as
>>    * perl never updates the CRT copy when assigning to $ENV{TZ}.
>> [...]
>> I wonder if Ramsay has an older perl that does not do this special
>> hackery right. I'll see if I can dig up where it first appeared.

Hmm, sorry for not specifying this upfront, but this failure is on Linux. ;-)
(Linux is my main platform, but I like to keep cygwin working because it has
kept me sane on Windows ever since (about) 1995 ...)
"Stranger in a strange land" ;-)

This test is skipped on cygwin because I don't have cvs (or cvsps) installed
on cygwin. (I have cvs-1.11.1p1.tar.gz and cvsps-2.2b1.tar.gz lying around
on cygwin, so I could probably build them from source and do some testing if
you would like me too. Just let me know.)

This test is skipped on MinGW because cvsps is not installed. (I have just
tried building cvsps, but there are compilation errors ...).

I'm using perl v5.8.8 on Linux.

> It looks like that code went into perl 5.11.
> 
> I wonder, even with this fix, though, if we need to be calling tzset to
> reliably update from the environment. It sounds like it _should_ happen
> automatically, except that if the CRT is calling the internal tzset, it
> would not do the perl "grab from $ENV" magic. Calling tzset would make
> sure the internal TZ is up to date.
> 
> Ramsay, what happens with this patch on top?

This patch fixes the test for me.

Thanks!

ATB,
Ramsay Jones

> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index ceb119d..4c44050 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -24,11 +24,12 @@ use File::Basename qw(basename dirname);
>  use Time::Local;
>  use IO::Socket;
>  use IO::Pipe;
> -use POSIX qw(strftime dup2 ENOENT);
> +use POSIX qw(strftime tzset dup2 ENOENT);
>  use IPC::Open2;
>  
>  $SIG{'PIPE'}="IGNORE";
>  $ENV{'TZ'}="UTC";
> +tzset();
>  
>  our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
>  my (%conv_author_name, %conv_author_email, %conv_author_tz);
> @@ -855,8 +856,10 @@ sub commit {
>  	}
>  
>  	$ENV{'TZ'}=$author_tz;
> +	tzset();
>  	my $commit_date = strftime("%s %z", localtime($date));
>  	$ENV{'TZ'}="UTC";
> +	tzset();
>  	$ENV{GIT_AUTHOR_NAME} = $author_name;
>  	$ENV{GIT_AUTHOR_EMAIL} = $author_email;
>  	$ENV{GIT_AUTHOR_DATE} = $commit_date;
> .
> 
