From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Git's Perl scripts can fail if user is configured for perlbrew
Date: Mon, 29 Dec 2014 14:40:39 +0100
Message-ID: <54A159D7.5010307@web.de>
References: <54A085D1.8060407@blackperl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "Randy J. Ray" <rjray@blackperl.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 14:40:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5aZ7-0006yV-ID
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 14:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbaL2Nks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 08:40:48 -0500
Received: from mout.web.de ([212.227.17.12]:54741 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbaL2Nkr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 08:40:47 -0500
Received: from [192.168.2.107] ([84.164.64.14]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LbrZ2-1XOrpQ246m-00jLRN; Mon, 29 Dec 2014 14:40:44
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54A085D1.8060407@blackperl.com>
X-Provags-ID: V03:K0:z1WeJhO28QVGON5crS+7ze0GchItdLEFbLVxEl4g9guaNDy0are
 dgFBiLBz28ItUzi5jjWWIIoZGe2C6YZAlOIv+iJ2dCB2QW2M7dtGBHCiW8KX6XiSTulJJot
 /r9HoNIbJJ0KvF5jcERlkon50krUctCWVtWd0MAkXRok95PBQK50k38lELjfkAtx6TiEbWL
 hia/ipuJRQfneHJaqboSQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261861>

On 2014-12-28 23.36, Randy J. Ray wrote:
> I use git on MacOS via homebrew (http://brew.sh/), and a custom Perl installation built and managed via perlbrew (http://perlbrew.pl/). At some point, commands like "git add -i" broke. I say "at some point", because I'm not a git power-user and I only just noticed it this week.
> 
> I am running Git 2.2.1 with a perlbrew'd Perl 5.20.1. When I would run "git add -i" (or "git add -p"), it would immediately die with a signal 11. Some poking around showed that those git commands that are implemented as Perl scripts run under /usr/bin/perl, and also prefix some directories to the module search-path. The problem stems from the fact that, when you are using perlbrew, you also have the PERL5LIB environment variable set. The contents of it lay between the git-provided paths and the default contents of @INC. When the Git module is loaded, it (eventually) triggers a load of List::Util, whose C-level code fails to load because of a version mismatch; you got List::Util from the paths in PERL5LIB, but it doesn't match the version of perl from /usr/bin/perl.
> 
> After poking around and trying a few different things, I have found that using the following line in place of "#!/usr/bin/perl" solves this problem:
> 
>     #!/usr/bin/env perl
> 
> This can be done by defaulting PERL_PATH to "/usr/bin/env perl" in Makefile.
> 
> I don't know enough about the overall git ecosystem to know if this would have an adverse effect on anything else (in particular, Windows compatibility, but then Windows probably isn't having this issue in the first place).
> 
> I could just create and mail in the one-line patch for this, but I thought it might be better to open it up for some discussion first?
> 
> Randy

Having problems with different perl installations is not an unknown problem
in Git, I would say.

And Git itself is prepared to handle this situation:

In Makefile I can read:
# Define PERL_PATH to the path of your Perl binary (usually /usr/bin/perl).

(What Git can not decide is which perl it should use, the one pointed out by $PATH or /usr/bin/perl.)

What does  
"type perl" say ?

And what happens when you build and install Git like this:
PERL_PATH=/XX/YY/perl make install

-----------
Are you thinking about changing
ifndef PERL_PATH
	PERL_PATH = /usr/bin/perl
endif
-- into --
ifndef PERL_PATH
	PERL_PATH = $(shell which perl)
endif
---

At first glance that could make sense, at least to me.
