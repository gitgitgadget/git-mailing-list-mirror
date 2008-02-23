From: Sam Vilain <sam@vilain.net>
Subject: Re: Interrupted git-svn dcommit, now I get segmentation faults
Date: Sat, 23 Feb 2008 16:18:22 +1300
Message-ID: <47BF907E.2090904@vilain.net>
References: <loom.20080221T062522-821@post.gmane.org>	 <47BDD096.7040606@vilain.net>	 <4e2a3a120802220113q4df473c0xcaad4760aea7f49b@mail.gmail.com> <4e2a3a120802220120s36fcdd31i9d0a18800d0a0349@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "C. E. Ball" <ceball@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Feb 23 04:17:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSkt8-0003Bc-O9
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 04:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811AbYBWDQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 22:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756093AbYBWDQq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 22:16:46 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:50964 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755997AbYBWDQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 22:16:44 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id B39A7FD44E; Sat, 23 Feb 2008 16:16:34 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 535D121CEDE;
	Sat, 23 Feb 2008 16:16:29 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <4e2a3a120802220120s36fcdd31i9d0a18800d0a0349@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74792>

C. E. Ball wrote:
> On Fri, Feb 22, 2008 at 5:13 PM, C. E. Ball
> <ceball@users.sourceforge.net> wrote:
>>>  If you get stuff like that you can move the git-svn state out of the
>>  >  way, and re-run git-svn fetch; it will rebuild the metadata.
>>  >
>>  >   $ mv .git/svn .git/svn.bad
>>  >   $ git-svn fetch
>>  >
>>  >  Not a fix I know, but might work for you ;)
>>
>>  Thank you very much, that did work for me!
> 
> Please ignore my previous email - I was in the wrong place on my
> filesystem! Sorry about that.
> 
> After following your suggestion on my broken repository, I still get
> the same error (a segmentation fault just after the commit is
> successfully sent to svn) when I 'git-svn dommit'.
> 
> Any other suggestions?

Well this is where the fun starts.  Make sure you're on a new version of
git - latest stable or built from "master" if possible.  Start perl (or
even debugperl if you have one built with debug symbols) with gdb, and
get it to run git-svn and use "bt" to get a backtrace when you get the
fault.

  $ gdb /usr/bin/debugperl
  ...
  > run ~/bin/git-svn dcommit
  ...
  --- SEGV ---
  > bt

That's the default place to start looking for clues.  Otherwise it's a
pretty much open-ended problem ... you would have to figure out (perhaps
using the perl debugger, perhaps using test cases) what triggers it,
what's not passing the correct thing to the SVN API, whether it's a
version-specific SVN bug, etc.  It's certainly not very common which
makes me suspect the SVN::Core bindings and/or the stack beneath that
part of it.  The SVN API is ... fragile, and the codebase is bulky and
poorly thought out.  So, you get weird behaviour like the exception
handler has to die() or you get a segfault, etc.

If that seems too daunting, perhaps just respond with the versions of
everything you are using (eg perl -MSVN::Core -le 'print
$SVN::Core::VERSION', git --version etc) find out if it's specific to
the repository you're committing to, or (if you can) your system, etc,
and perhaps someone else will have a better clue.

Good luck,
Sam.
