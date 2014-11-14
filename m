From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] Allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 15:21:07 -0800
Message-ID: <20141114232106.GA6527@google.com>
References: <1415995993-70879-1-git-send-email-blume.mike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	dborowitz@google.com
To: Mike Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 00:21:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpQB4-0005eH-Ec
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 00:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935370AbaKNXVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 18:21:14 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:55318 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933574AbaKNXVN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 18:21:13 -0500
Received: by mail-ig0-f169.google.com with SMTP id hn18so601914igb.4
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 15:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tPX0u4YBrnHZNVST2a4g7emSBE2xthFvf81/MylWuKo=;
        b=BO8VIU8fS1wKP1RDgCydrxhEQPn26rcXIa+gCTBVAwXHXbnFmq72o9O7AN6ETC4u0V
         L4LgMIJsIu4oWwkYSUkm+Q0w/ODxtfToXZ2KdPnu59Fn9qYHt0bC1GuCY7hZTR5s1cHz
         3LrpIEYCcfNlz3FkWUKVLKEs8+q/zNe1RcUjde+gm4aTZNxHJ5ilPm3W10tDOTbXqFBS
         PylWG8xCf6xAGPSUgufhsBqxHjeGEjx4XkyWizp2ImtX0U1OKG//nx5g5iKKkHn5CQbQ
         XhKb+IiIxDDM4bbC+RRDN7mAsmuI6k51+NikaAKU9j413cdMs9ltjzx9YXSuII9VeFvc
         iX7w==
X-Received: by 10.42.128.81 with SMTP id l17mr14291548ics.8.1416007272972;
        Fri, 14 Nov 2014 15:21:12 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a875:b2b9:165d:cb33])
        by mx.google.com with ESMTPSA id q17sm8777327ioe.21.2014.11.14.15.21.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Nov 2014 15:21:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1415995993-70879-1-git-send-email-blume.mike@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Mike Blume wrote:

> TTY tests were previously skipped on all Mac OS systems because of a
> bug where reading from pty master occasionally hung. This bug has since
> been found not to be reproducible under Mac OS 10.9 and 10.10.1.
>
> Therefore, run TTY tests under Mac OS 10.9 (Mavericks) and higher.

*puzzled* Testing on Yosemite with the following script[1]

	perl -MIO::Pty -MFile::Copy -e '
	       for (my $i = 0;; $i++) {
		       my $master = new IO::Pty;
		       my $slave = $master->slave;
		       if (fork == 0) {
			       close $master or die "close: $!";
			       open STDOUT, ">&", $slave or die "dup2: $!";
			       close $slave or die "close: $!";
			       exec("echo", "hi", $i) or die "exec: $!";
		       }
		       close $slave or die "close: $!";
		       copy($master, \*STDOUT) or die "copy: $!";
		       close $master or die "close: $!";
		       wait;
	       }
	'

still seems to hang eventually (after 61 iterations when my officemate
tried it), reproducing the bug.

Do you get a different result?

The bug was originally found in an autobuilder that would run the test
suite when new versions were pushed to check for regressions.  Even if
the hang only happened 0.1% of the time, that would get the
autobuilder stuck after a while, which was how the problem got
noticed.

Thanks,
Jonathan

[1] https://rt.cpan.org/Public/Bug/Display.html?id=65692
