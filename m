From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: t7006 sometimes hangs in cronjobs on OS X
Date: Fri, 11 Feb 2011 20:03:21 -0600
Message-ID: <20110212020321.GA24629@elie>
References: <201102091538.46594.trast@student.ethz.ch>
 <20110209190900.GA8314@sigill.intra.peff.net>
 <201102092016.55078.trast@student.ethz.ch>
 <201102092122.19178.trast@student.ethz.ch>
 <20110209205056.GA2083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 12 03:03:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po4pl-0007L4-Fm
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 03:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120Ab1BLCDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 21:03:32 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62472 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab1BLCDb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 21:03:31 -0500
Received: by ywo7 with SMTP id 7so1338675ywo.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 18:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=u9935eGG6b5awOycg0cJrS9sfwBss3I1Kayy8WkaS/Q=;
        b=ke1OteM2yX82yYzXL2kuQUXCoMxeZH6ZjoJvFy/WTcYv1DyKsyb3Zo2YUSKH1KN+oq
         CTbiSTHi7i7qZglBYjExdcfaNX1bZPw7Z/Rbn6pVf3wp2ZzBuWAB6DHlEOr2iZfQkDHd
         sqRpnUkjGHDADrms/SZ24B3IJUTBaxYSoCwIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sukAxI4TAm7SYHUi8G8zRE5fdKrM+2z2XnwMI0m/1i429nbF4LBRjfJP+T8ZFn3UMD
         89B9qlyxYdKY3qxI4ZUKq8jFUf71yE9FhWfMEYtbrPBrjVryimzWX8iIsb7WmOYaAl+E
         z+IRPfMZjzox/pzqMONEvG1Gx1tHS0W8/C+L0=
Received: by 10.150.195.19 with SMTP id s19mr1410959ybf.437.1297476210938;
        Fri, 11 Feb 2011 18:03:30 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id w24sm145640ybk.21.2011.02.11.18.03.28
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 18:03:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110209205056.GA2083@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166589>

Jeff King wrote:

> Yeah, it is probably stuck in some syscall. You could try instrumenting
> your test-terminal.perl like:
>
> diff --git a/t/test-terminal.perl b/t/test-terminal.perl
> index ee01eb9..1755017 100755
> --- a/t/test-terminal.perl
> +++ b/t/test-terminal.perl
> @@ -55,11 +55,15 @@ sub copy_stdio {
>  	defined $pid or die "fork failed: $!";
>  	if (!$pid) {
>  		close($out);
> +		print STDERR "child: pumping stderr\n";
[...]

Nice, I can reproduce this (kernel = Darwin 10.5.0, using Apple's perl
5.10.0).  With

	while ./test-terminal.perl echo hi >out.$i 2>&1
	do
		i=$(($i + 1))
		echo $i
	done

I get:

	$ cat out.28 
	child: pumping stdout
	child: pumping stderr
	hi
	child: done pumping stdout

Instrumenting Copy.pm, I can see that we are stuck in sysread.

	31984: child: pumping stdout
	31984: enter copy loop.
	31984: time to read 4096...
	31986: child: pumping stderr
	31984: read returns with 4
	31984: about to write "hi
	"
	31984: pump 4 - 0, result = 4
	31984: time to read 4096...
	31986: enter copy loop.
	31986: time to read 4096...
	31986: read returns with 0
	31986: about to write ""
	31986: done!
	31986: successful return.
	31986: copy returns with 1 errno=
	31986: child: done pumping stderr

Redirecting stderr by using 'xsendfile("elsewhere", $err);' avoids
trouble.  Asking stderr and stdout to go to different places, like so:

	./test-terminal.perl echo hi >out.$i 2>err.$i

does not avoid trouble.  Sometimes output includes some streams of
null bytes, which makes me suspect something awry in the kernel.
