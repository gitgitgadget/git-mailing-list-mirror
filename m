From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Portability: returning void
Date: Tue, 29 Mar 2011 18:49:55 -0500
Message-ID: <20110329234955.GB14578@elie>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 01:50:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4ifv-0003Fk-Nm
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 01:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab1C2XuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 19:50:07 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33539 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab1C2XuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 19:50:06 -0400
Received: by gxk21 with SMTP id 21so305004gxk.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=x1gdDnlQCyKqspiCHTkNh/iTYWQwLD/+BZejfZJPklg=;
        b=X3xQ+W9hhHXy/HMCcQ03NN42R5A50jMo1Y+S+p01qjWEyOYbaQWaInhrWI+myiMhX0
         oxB8S8k/981vD5e/uBJdgIxs09MdNn9JU6AX82p+RK9rK3dOIvknYDoevcuQp6hQCybg
         c/H4uKJIJkIPSe8zmtP1yfIN84C/VerETlE84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U2t6D/xXr1FMgOqUFDNh5sEEbSBXhOIZqHOI6L/ua1Uo+4JAh4agajaQ5324CoDERu
         zKXI9teHd+6iJtCK+Qbgk7vdvJWcE9e8wAOtuj8/aOwayBE8XK/e6tMKCQmBgpbARpAd
         mRDK0+AV2iglmkDrXzbdgkGaBCP0aipjQpsEk=
Received: by 10.150.58.4 with SMTP id g4mr862304yba.155.1301442605251;
        Tue, 29 Mar 2011 16:50:05 -0700 (PDT)
Received: from elie (adsl-76-206-232-54.dsl.chcgil.sbcglobal.net [76.206.232.54])
        by mx.google.com with ESMTPS id p28sm2122415ybk.0.2011.03.29.16.50.01
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 16:50:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110329221652.GB23510@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170338>

Jeff King wrote:

> The problem is that the sleeps hang around for 100 seconds, and they are
> connected to the test script's stdout. It works to run "./t0081-*"
> because bash sees the SIGCHLD and knows the script is done. But the
> prove program actually ignore the SIGCHLD and waits until stdout and
> stderr on the child are closed.

Strange.  Why would prove tell its children to ignore SIGCHLD and
SIGTERM?

> Double-weird is that if you "strace" the prove process, it will still
> hang. But if you "strace -f", it _won't_ hang.

Well, it hangs for me. :)  The strangest aspect is that after 100
seconds, all is well again, which suggests that there's more happening
than an unreaped process.

After lowering the sleep to 15 seconds:

| kill: 19422
| bash(19422)---sleep(19424)
|
| ok 3 - 0-length read, no input available
[...]
| kill: 19431
| bash(19431)---sleep(19434)
| ok 5 - 1-byte read, no input available
[...]
| kill: 19438
| bash(19438)---sleep(19441)
| 
| ok 6 - long read (around 8192 bytes)
[...]
| # passed all 13 test(s)
[...]
| 19398 18:31:12 exit_group(0)            = ?
| 19397 18:31:12 <... select resumed> )   = ? ERESTARTNOHAND (To be restarted)
| 19397 18:31:12 --- SIGCHLD (Child exited) @ 0 (0) ---
| 19397 18:31:12 select(8, [4 6], NULL, NULL, NULL <unfinished ...>

The test script exits, but "prove" is stuck in select and does not
want to start reaping yet.  So presumably the test script's children
are adopted by init.  We wait around 13 seconds, and then:

| 19424 18:31:25 <... nanosleep resumed> NULL) = 0
| 19424 18:31:25 close(1)                 = 0
| 19424 18:31:25 close(2)                 = 0
| 19424 18:31:25 exit_group(0)            = ?
| 19422 18:31:25 <... wait4 resumed> 0x7fff65d1ee6c, 0, NULL) = ? ERESTARTSYS (To be restarted)
| 19422 18:31:25 --- SIGTERM (Terminated) @ 0 (0) ---

The first sleep wakes up and dies.  The corresponding subshell
wakes up, reaps the child, and finally accepts SIGTERM.

| 19434 18:31:26 <... nanosleep resumed> NULL) = 0
[...]
| 19438 18:31:26 --- SIGTERM (Terminated) @ 0 (0) ---

Likewise for the second and third sleeps.

| 19397 18:31:26 <... select resumed> )   = 2 (in [4 6])
| 19397 18:31:26 read(4, "", 65536)       = 0
| 19397 18:31:26 read(6, "", 65536)       = 0
| 19397 18:31:26 wait4(19398, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 19398

Now "prove" wakes up again.

The analagous experiment for dash, mksh, etc shows that their
subshells exec()'d /bin/sleep so the SIGTERM reaches sleep right
away with no trouble.
