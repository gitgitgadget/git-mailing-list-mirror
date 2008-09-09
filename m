From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain
Date: Mon, 8 Sep 2008 23:25:00 -0500
Message-ID: <5d46db230809082125v3ac7e36cx2cfd02fdfba0e987@mail.gmail.com>
References: <20080906150723.GA31540@dervierte>
	 <m38wu5p9q4.fsf@localhost.localdomain>
	 <e06498070809060912q2f7ed0cflb02e3efc7b81976e@mail.gmail.com>
	 <200809062101.28672.jnareb@gmail.com>
	 <5d46db230809072045u7ade2d62i514aac49149a463d@mail.gmail.com>
	 <e06498070809081805l46ff295du69d8c9a2cc0ef59a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Steven Walter" <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 06:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcunu-0003qJ-Ja
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 06:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbYIIEZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 00:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbYIIEZE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 00:25:04 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:58203 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbYIIEZB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 00:25:01 -0400
Received: by gxk9 with SMTP id 9so9483777gxk.13
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 21:25:00 -0700 (PDT)
Received: by 10.150.225.10 with SMTP id x10mr22610239ybg.207.1220934300238;
        Mon, 08 Sep 2008 21:25:00 -0700 (PDT)
Received: by 10.150.57.11 with HTTP; Mon, 8 Sep 2008 21:25:00 -0700 (PDT)
In-Reply-To: <e06498070809081805l46ff295du69d8c9a2cc0ef59a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95333>

On Mon, Sep 8, 2008 at 8:05 PM, Steven Walter <stevenrwalter@gmail.com> wrote:
> On Sun, Sep 7, 2008 at 11:45 PM, Govind Salinas
> <govind@sophiasuchtig.com> wrote:
>>>> To my knowledge, Pyrite does not support plugins.
>>
>> Depends on what you mean by plugins.  There is a way to load what I call
>> extensions that you can use to add commands or modify the way existing
>> commands operate.  It is crude at the moment but it works.  I have a
>> proof of concept extension/plugin that adds different ways of specifying
>> revisions.  I assume you mean something similar.
>
> That pretty well describes what I mean by a plugin system.  Does your
> system allow anything other than commands to be overridden?  Do your
> commands ever call other commands, and if so, will the overridden
> method be called in that case?
>

Yes, but this is where it gets crude.  There are several things that happen.

You get an on_load() call that happens when the extension is loaded.  You
can use that to add a command.  You also get  an on_before_command()
and on_after_command() that get called when you might expect, you can
use this to do anything from alter command line parameter to post-
processing etc.  After that you have to hook methods, python makes this
pretty easy.  There is a known hook point by convention in every command,
after that you have to know what you want to hook in the particular command.

> Yap's plugin system is pretty nice (IMHO), but it was designed almost
> exclusively as a means to an end: the svn plugin.  With the svn
> plugin, "yap clone" will accept an SVN url as readily as a git URL,
> and the result it what you would expect if you had a git URL:  a
> full-history git clone of the svn repository with all branches and
> tags.  Obviously, the svn clone would be much slower than the
> equivalent git command, but that's the price one pays in interacting
> with svn.  However, this "yap" repo can then be cloned, and all the
> svn meta-information will be present in the new repository.  This
> means that the new repository can immediately be used for pushing
> commits back to the original svn repository without any additional
> configuration.  Additionally, you can use an svn revision anywhere a
> git committish can be used.
>

You should be able to use the plugin system I have to hook the clone
command and run something different in the event that you have a svn
URL.  You would probably do this on_before_command.  This was
actually something someone brought up in a pyrite thread a while
back.  That should not be complicated.

> In a yap "yap-svn" clone, "svn" appears as just another remote.  "yap
> push svn foo" does the expected thing.  Likewise for fetching and
> updating.  In theory a similarly parallel interface could be provided
> to other SCMs.  Facilitating users who track SVN repositories with git
> was one of the majors goals of the yap project, and I encourage users
> who do so to give yap a try.
>
>> I am currently not doing much work on the command line interface since
>> people seemed to object to my ideas.  Instead I am focusing on the gui
>> instead.  Since you say you are not going to keep the command lines
>> compatible, what do you intend to do differently?
>
> The command-line interface has been my primary focus, as that is what
> I and my co-workers usually use.  The interface that yap has now is
> intended to be more orthogonal and "safer" than the standard git
> porcelain.  By "safer" I mean that yap will not perform an operation
> that cannot be readily reversed without explicit confirmation (an "-f"
> flag, for instance).  For example, the closest equivalent to "git
> reset --hard" in yap is "yap point."  yap point fails if there are any
> uncommitted changes (staged or unstaged), or if it would create
> "dangling commits" that can no longer be referenced by a ref (unless
> "-f" is given).  On the orthogonal side, "yap" provides
> commit/uncommit as a pair, as well as stage/unstage.  They are small
> things, but small things can make a big improvement in user experience
> (especially if it keeps you from killing uncommitted changes you had
> forgotten about).

I had some very different ideas along the lines of reducing the number of
commands (where the commands do something similar just DWIM rather
than force me to remember or read docs on different commands), making
commands look similar to commands from other SCMs (revert should do
what it does for me in all the other SCMs that I have used, which is to
checkout the HEAD copy into the working directory) and improve
usability (WTF does ".." mean vs "..." and why is it different for different
commands, etc).  Perhaps we can talk and see if there is enough room for
both our goals.

A further goal of mine is to eventually help with the libgit project so that git
operations can be done from inside they python process rather than a
fork and exec.  This is an optimization, but it can also be used to get rid
of any scripting that remains in git, making it possible to have git on
windows without MSYS or cygwin.  Pyrite is very ambitious, as you might
tell from how long it has been taking me to do it.

-Govind
