From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: t7800-difftool.sh failure on pu
Date: Mon, 2 Apr 2012 13:09:45 -0400
Message-ID: <CAFouethd9yEVNhX3_m4B3akxTmPh2RS4-NUkakYk3fcjfTB7YA@mail.gmail.com>
References: <4F74A604.3040402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 02 19:09:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEklM-0008Mr-Bp
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 19:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab2DBRJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 13:09:47 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51638 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab2DBRJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 13:09:46 -0400
Received: by iagz16 with SMTP id z16so4347590iag.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nsBZemtfJq5vqJ+wdvxXFc2Ui+pZZ6pVN1nQRaz3y4M=;
        b=cHQFTOgnDkVlN/nnUYtOaxsSGF0OgD8Afsk0JQQxxWJSiD4Plw5SWV1uow3pwRlUwe
         hz1ydrKbslQUVUJobY6/XkRoyRBl5oPXrYF0c8PSc/jRMs8hyk5JEdGwGScJH7+F725f
         3gNsgDA8g9OVklZhx9G4VtiffT/7u8xElkOow8sIJvqjLHGuTA0DbbBYJA5hr6dDvfWe
         cTIf1tR/wDbGFZ6eSAuObgPZS4E/8/zlXghbvMDtx97uYA7zzFMEhKYhYAIM4UcZl+VE
         5eqwBDhIRB4Du4sWNAWpmI9ObHxyUdTq63V/cO4NW4nfhwHsl2FQTx3FcKlksQv+nZHR
         VPjw==
Received: by 10.50.42.132 with SMTP id o4mr6318328igl.41.1333386585950; Mon,
 02 Apr 2012 10:09:45 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Mon, 2 Apr 2012 10:09:45 -0700 (PDT)
In-Reply-To: <4F74A604.3040402@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194539>

Hi Ramsay - thank you for running the tests and trying this out.


On Thu, Mar 29, 2012 at 2:12 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> With the current pu branch, I have t7800.3 (difftool ignores bad --tool values)
> failing on Linux (I haven't tried cygwin or mingw yet). The failure is caused
> by the test for the value of the exit code; for me the exit code is 9 not 1.

This is interesting.  On my Ubuntu box, I am able to run all of t7800
without error.  This has been my primary development platform and the
tests have consistently passed for me on that system.

I have had trouble getting the test suite to run on msysgit.  However,
I just tried the simple test sequence that you demonstrated and found
that I get the same failure on that platform (i.e. "9 Bad file
descriptor").  So it appears that Carp is broken on some platforms.


> I have investigated, briefly, and found *two* alternatives for a fix. ;-)
>
> The first option is to (effectively) revert commit 0440ed72 ("difftool: replace
> system call with Git::command_noisy", 22-03-2012), like so:

Thanks again for spending the time to dig into the problem.  Based on
feedback from Junio and David in later emails, I plan to revert commit
0440ed72.


> The second option is a bit of a mystery, since I don't see why it is necessary
> or why it works! :-P
>
> First take a look at the following:
>
> $ perl -e 'print $!+0, " $!\n";'
> 0
> $ echo $?
> 0
>
> $ perl -e 'use Carp qw(croak); print $!+0, " $!\n";'
> 9 Bad file descriptor
> $ echo $?
> 0

I agree that this is mysterious.  On my Ubuntu box, this Perl
one-liner prints and exits with 0 for me (i.e. no bad file descriptor
error).  However, I was able to replicate the failure on msysgit.
This makes me wonder if other users of Git.pm have had the same
problem.  The primary user appears to be 'git-svn.perl' and its
related tests.  A quick review of those files did not show any mention
of problems with Carp.  Perhaps they simply do not check the exact
exit code on failure?
