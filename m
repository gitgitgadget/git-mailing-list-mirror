From: John Keeping <john@keeping.me.uk>
Subject: Re: git status takes 30 seconds on Windows 7. Why?
Date: Wed, 27 Mar 2013 18:46:57 +0000
Message-ID: <20130327184657.GP2286@serenity.lan>
References: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
 <vpqr4j0rccf.fsf@grenoble-inp.fr>
 <CAFT1WNxm0Kx9vHx+NB92_tZV6KsVhefiVXa-K69YbWOkpCXSgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jim Kinsman <jakinsman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 19:47:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKvNr-0002PX-Ai
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623Ab3C0SrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:47:06 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:60886 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab3C0SrF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:47:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 99FF622BA3;
	Wed, 27 Mar 2013 18:47:04 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RZX6qBwth+Va; Wed, 27 Mar 2013 18:47:04 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id BBCC922F4F;
	Wed, 27 Mar 2013 18:46:59 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAFT1WNxm0Kx9vHx+NB92_tZV6KsVhefiVXa-K69YbWOkpCXSgA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219301>

On Wed, Mar 27, 2013 at 01:15:43PM -0500, Jim Kinsman wrote:
> The only anti-virus I have installed is Microsoft Security Essentials
> I turned off and it was still the same:
> $ cat /usr/bin/gitstatus
> start_time=`date +%s`
> git status && echo run time is $(expr `date +%s` - $start_time) s
> 
> 
> $ gitstatus
> # On branch test
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       modified:   orgoptions.php
> #       modified:   update_import_contacts.php
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> run time is 10 s

That doesn't seem hugely surprising to me.  I have a moderately sized
repository (3047 files, although it's Java so there are some deep trees)
and I get the following (Vista on a reasonably old laptop, best of 3,
Git version 1.8.1.msysgit.1):

$ time git ls-files >/dev/null

real	0m0.047s
user	0m0.015s
sys	0m0.015s

$ time git status >/dev/null

real	0m2.715s
user	0m0.000s
sys	0m0.031s


I'm not sure the "user" and "sys" times are correct, but the "real"
times feel right.  By comparison, on Linux on a much newer machine (so
not much of a comparison) on the same repository:

$ time git status >/dev/null

real	0m0.347s
user	0m0.171s
sys	0m0.167s


I think the simple reality is that Git was written with the assumption
that stat is cheap and that isn't really the case on Windows, where the
filesystem cache doesn't seem to do that well with this.  It may be that
Git's Windows compatibility code could do be made more efficient but I
know nothing about that, although a quick look in compat/mingw.c
indicates that Git does already use its own stat implementations in
place of the MSys ones in search of speed.


John
