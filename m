From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: t7006 sometimes hangs in cronjobs on OS X
Date: Sat, 12 Feb 2011 02:37:44 -0600
Message-ID: <20110212083731.GB5182@elie>
References: <201102091538.46594.trast@student.ethz.ch>
 <20110209190900.GA8314@sigill.intra.peff.net>
 <201102092016.55078.trast@student.ethz.ch>
 <201102092122.19178.trast@student.ethz.ch>
 <20110209205056.GA2083@sigill.intra.peff.net>
 <20110212020321.GA24629@elie>
 <20110212051239.GA31606@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 12 09:38:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoAzQ-0008LA-GM
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 09:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606Ab1BLIhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 03:37:55 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57651 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1BLIhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 03:37:54 -0500
Received: by iyj8 with SMTP id 8so3185696iyj.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 00:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xzgyEMarEqSLY28KQUzL9sXc9gUjSi3h+lg85CjfqhQ=;
        b=q5PNi4XPhYMW7FSX0DRBZR2Vgj2bdDRUfchaiHXjoHIOQSATZLSKUn8JJJ1eIMUcYi
         0E62wXWjMAoMrY8Ej0qExqt5VKlTcIQTvwknhHrCnLZrRd3ccHupv9HMJctYRwKID2JA
         HuONgR2IJSfqfvCrFJQTZmpPheklwOe+/CHYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=t1zvVS7CzPHKBVG/c6lYE9j51J+DqhdleCqpfsDodvYkpr3o8DzYfBJ4wBeKXhR8ea
         CmB5+bqPd2eAYAXPPEjNlZ1OD6VhkbWhFNlhVbwlcP7MVGXjzrViYwrBI4PKbmYzbFV1
         0wARF+ZF1yOJjD9M2fc7wMLCEkP0CZFgUM01A=
Received: by 10.42.172.198 with SMTP id o6mr1908312icz.132.1297499873602;
        Sat, 12 Feb 2011 00:37:53 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id i16sm295027ibl.18.2011.02.12.00.37.48
        (version=SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 00:37:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110212051239.GA31606@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166603>

Jeff King wrote:

>   1. In your Copy.pm log above, it says read gives it 4 characters. But
>      "hi\n" has only 3.

Yes, it's "hi\r\n".

> I would first try this patch:
[...]
> +++ b/t/test-terminal.perl
> @@ -15,6 +15,7 @@ sub start_child {
>  		open STDOUT, ">&", $out;
>  		open STDERR, ">&", $err;
>  		close $out;
> +		close $err;
>  		exec(@$argv) or die "cannot exec '$argv->[0]': $!"

Good idea.  No change, alas (and likewise with the change to close
the pty master in the child).  It seems I have some reading to do.

Jonathan

> and then try this more drastic one:
[...]
> --- a/t/test-terminal.perl
> +++ b/t/test-terminal.perl
> @@ -12,9 +12,12 @@ sub start_child {
[...]
> @@ -69,7 +72,7 @@ if ($#ARGV < 1) {
>  }
>  my $master_out = new IO::Pty;
>  my $master_err = new IO::Pty;
> -my $pid = start_child(\@ARGV, $master_out->slave, $master_err->slave);
> +my $pid = start_child(\@ARGV, $master_out, $master_err);

Runs through ~1000 iterations instead of 100 before hanging.

> Also, I don't know what kind of support you have for stuff like lsof,
> but in theory we should be able to get a hung process, find the open
> descriptor for the pty using lsof, match that descriptor with the other
> end of the pty, and then see which processes have that pty still open.

Trial 1
~~~~~~~
 PID 49145 (which has successfully pumped stdout):

  0	/dev/ttys001
  1 write-only	out.1707
  2 write-only	out.1707
  3	/dev/ptmx	@ offset 4
  5 write-only	debug.log

 PID 49147 (which is stuck in sysread trying to read stderr):

  0	/dev/ttys001
  1 write-only	out.1707
  2 write-only	out.1707
  5 write-only	debug.log
  6	/dev/ptmx	@ offset 0

Trial 2
~~~~~~~
 PID 51091 (which is stuck in sysread trying to read stdout):

  0	/dev/ttys001
  1 write-only	out.2017
  2 write-only	out.2017
  3	/dev/ptmx	@ offset 4
  5 write-only	debug.log

 PID 591093 (which successfully pumped stderr) is a zombie

(echo was a zombie in both cases.)

>> Redirecting stderr by using 'xsendfile("elsewhere", $err);' avoids
>> trouble.
>
> That seems doubly weird, since you are changing the _output_, not the
> input. But the input is what is causing the hang.

False alarm --- after about 2500 iterations it hangs.  Probably just
changed the timing.

>> Sometimes output includes some streams of null bytes, which makes me
>> suspect something awry in the kernel.
>
> Yuck.

Was my mistake --- apparently I was writing files with holes.  Now I
send debug output to a separate file with O_APPEND and it hasn't
happened again.
