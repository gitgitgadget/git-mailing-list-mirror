From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sat, 26 May 2007 19:53:24 -0300
Message-ID: <4658BA64.2050904@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <Pine.LNX.4.64.0705262318190.4648@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 27 00:55:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs5Ad-0000Gx-S5
	for gcvg-git@gmane.org; Sun, 27 May 2007 00:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbXEZWza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 18:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbXEZWza
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 18:55:30 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:2544 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbXEZWz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 18:55:29 -0400
Received: from [192.168.1.102] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4QMtOKg025992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2007 00:55:26 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0705262318190.4648@racer.site>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48502>

Johannes Schindelin escreveu:
>>> * git version reports just:
>>>
>>> 	git version -dirty
>>>
>>> Since git-gui parses the output of git version, but does not expect it
>>> to be of this format, and fails with an error message that it cannot
>>> parse the version.
>> My biggest problem is that the makefiles of git are an unmitigated
>> disaster, and there seems to be little interest in solving this
>> problem. For example, my suggestion to introduce autoconf was met with
>> derision.
> 
> Well, I would not call it derision. But many people have had bad 
> experience with that big mess which is autoconf, so we were more than 
> reluctant to do it.

autoconf is not that big a mess, but it is a macrolanguage, which does
come with its pitfalls.  Automake and libtool are the messy things,
and I prefer to stay away from them as far as possible.

The point of autoconf is to generate a hyper-portable script that
deals with all the different flavors of shell breakage.  For the user
it simplifies compiling packages enormously, which IMO should be the
guiding concern if you like to have users.

For a pretty run-of-the-mill tool like git (dependency wise), it
should be easy to write a working configure.in.

My favorite approach is: use autoconf to generate

 - config.h
 
 - config.make

All settings that force recompile should be in config.h, and standard
C methods to track dependencies will take care of the recompilation
when anything changes.  The main Makefile includes config.make, and
contains all configurable settings. The Makefile only needs to be
edited by developers. Require GNU Make so you can write sane
makefiles.

Instead, we have a Makefile that relies on an esoteric combination of
perl and shell scripting inside Makefiles.

Also, the Makefile says.

  # Shell quote (do not use $(call) to accommodate ancient setups);

I think it would be better to have a clearly defined list of optional
and required dependencies with version numbers, and then stand by
that.  For example, Make uses a completely autoconf/libtool based
compile process, and is easy to compile. I think it would be
reasonable to require a recent make, say 3.80, and then use its
features. 

> In the meantime, we do have a configure.ac, though. In general, you do not 
> have to run it, but you can if "make" does not work out of the box.
> 
> I have to admit that it is unclear to me what are the problems with the 
> Makefile with regards to gub. I think I will just bite the apple, and 
> download that beast to try it myself.

>From what I recall, it tries to be too clever in detecting changes 
of the make command line, forcing a recompile (possibly with erroneous paths)
during the 

  make install

I might be mistaken, though. I tried to get something up as fast as
possible.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
