From: Andreas Ericsson <ae@op5.se>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 11:07:01 +0200
Message-ID: <4DB92E35.4010402@op5.se>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>	<4DB80747.8080401@op5.se>	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>	<4DB82D90.6060200@op5.se>	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>	<20110427194233.GA16717@gnu.kitenet.net>	<7vwrif5q93.fsf@alter.siamese.dyndns.org>	<20110427220748.GA19578@elie> <BANLkTikSsoCP_d34wdBHX=r336zJSHSWEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:07:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNC7-0007dJ-JF
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379Ab1D1JHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 05:07:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53087 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab1D1JHX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:07:23 -0400
Received: by bwz15 with SMTP id 15so2116053bwz.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:07:21 -0700 (PDT)
Received: by 10.204.26.200 with SMTP id f8mr2946790bkc.99.1303981640464;
        Thu, 28 Apr 2011 02:07:20 -0700 (PDT)
Received: from vix.int.op5.se (m83-186-240-35.cust.tele2.se [83.186.240.35])
        by mx.google.com with ESMTPS id q25sm885298bkk.22.2011.04.28.02.07.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 02:07:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <BANLkTikSsoCP_d34wdBHX=r336zJSHSWEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172325>

On 04/28/2011 12:32 AM, Jon Seymour wrote:
> On Thu, Apr 28, 2011 at 8:08 AM, Jonathan Nieder<jrnieder@gmail.com>  wrote:
>> Junio C Hamano wrote:
> 
>> Or is the idea to blindly install (a symlink to) git-work to $(git
>> --exec-path)/ rather than a place on the $PATH?  In this case, I would
>> be a little worried.  How will the helper deal with uninstallation and
>> with namespace conflicts?  (On the $PATH, these are expected problems
>> and I'd expect each user has some way of dealing with them already.)
> 
> I see 'git pm activate' managing symbolic links in a directory
> dedicated to the purpose (.e.g. ~/.git-pm/activated).
> 

Why not just flip executable bits on commands in the git directory?
That way, built-ins can't be disabled no matter what you type, and the
list of out-of-core helpers will be kept shorter.

Either way, the "activate" thing requires you to maintain state of
downloaded extensions that aren't part of the core package. I'd say
it's safe to assume that anything downloaded is supposed to be active
and deactivating it is done by means of uninstalling it.

> One thing 'git pm activate' could do is check that the commands
> exported by the 'gitwork' descriptor do not conflict with what is
> already activated.
> 
> If the user has done something like:
> 
>      git clone https://repo/gitwork.git ~/hub/gitwork
> 
> and then:
> 
>      git activate pm ~/hub/gitwork
> 
> the symbolic links would be established to ~/hub/gitwork, wherever
> that happens to be.
> 
> If the user has done:
> 
>     apt-get install gitwork
> 
> then given a package-manager adapter for apt-get, it could extract the
> .gpm file from the list of installed files, and resume activation from
> there. Ultimately, the end result is the same ~/.git-pm/activated is
> updated, it has always been on the paths it needs to be.
> 
> If the descriptor did have a list of exported commands (e.g. git-work,
> git-base, git-atomic, git-test), then a global registry could use this
> list of exported commands to detect conflicts early - at package
> registration time which might help avoid grief down the track.

But seriously. Don't you see how complex this is? If you want to make
things easier for people, put up a website or a database somewhere and
ship a (very, very small) addon with core git that just goes to fetch
that list and present it to users upon request. The list should contain
3 fields and 3 fields only.
1. Short name of extension (must be unique)
2. Url for where to get the extension
3. Free-form text, containing info of why anyone would want to use it,
   preferrably in the style of git.git commit messages so the brief
   description is the first line and the full info comes later.

Then your extension manager becomes really straightforward and can
easily be extended over time to also uninstall applications.

This assumes that git core itself can provide paths for where the
user wants man-pages and whatnot, ofcourse, but such a patch is so
trivial anyone who's seen code in any language can easily hack it
up blindfolded. Even for versions that doesn't support it, the man-
pages of any extension can be guessed from the --exec-path or just
ignored and all of them put into /usr/share/man or whatever the path
might be on the system we're on, so long as the extension manager
remembers where they ended up. This could easily be handled by the
extension itself creating a manifest file after it's done installing
which is stashed away by the extension manager.

A decent first step would be to have "git pm list" just show
what extensions are available, what they do and where to get them.

However, that info could just as easily be distributed to users by
letting "git help" or something print a link to a wiki page and by
letting extension devs know about some officially blessed way of
installing and uninstalling extensions properly. Once all extensions
use that same way and there are more than a small handful of
extensions, the idea of having a script download and automagically
install those extensions will probably be opened up again, but by
then with more than a single user backing it up with a request that
it be implemented (without showing any code).

Shipping a bunch of extensions with git core or making distro package
maintainers ship them as deactivated by default makes absolutely no
sense what so ever. Shipping a (very small) extension manager with
git that aids users obtaining more extensions makes sense when there's
a proper flora of them rather than just a few.

Either way, it's time to put your money where your mouth is and show
us some code that does what you think is a good idea.

If I were you, I'd start with the blindfolded patch mentioned above
and then follow up with a configurable directory where git will
search for additional commands, with a sensible default in the
user's home directory (.git-plugins, perhaps?).

Let conflicts go hang for now. They will be thoroughly frowned upon
by the community anyway, since providing any sort of help for the
command "git fniggle" will be totally impossible if there are 100
different implementations of it.
 
With those two patches in place in core git (which I'm fairly sure
Junio won't reject out of hand given his opinions in this thread),
coding up the "make install" part of extensions become trivial and
starting on the real extension manager becomes at least possible for
both types of core git users, namely:
1. Those who get core git from yum/brew/apt-get
2. Those who build it from sources.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
