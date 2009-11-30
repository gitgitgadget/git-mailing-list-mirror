From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 11:59:23 +0100
Message-ID: <200911301159.23383.johan@herland.net>
References: <20091130075221.GA5421@coredump.intra.peff.net>
 <7vr5rgv1lr.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911300156l7f8dbe55p7da26540b0360773@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 11:59:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF3yl-0000IK-7j
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 11:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbZK3K7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 05:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbZK3K7X
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 05:59:23 -0500
Received: from smtp.getmail.no ([84.208.15.66]:59438 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751301AbZK3K7X (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 05:59:23 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTX00CF75716750@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Nov 2009 11:59:25 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTX00FSZ56Z5Z40@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Nov 2009 11:59:25 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.30.104532
User-Agent: KMail/1.12.3 (Linux/2.6.31-ARCH; KDE/4.3.3; x86_64; ; )
In-reply-to: <fabb9a1e0911300156l7f8dbe55p7da26540b0360773@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134091>

On Monday 30 November 2009, Sverre Rabbelier wrote:
> Heya,
> 
> On Mon, Nov 30, 2009 at 09:49, Junio C Hamano <gitster@pobox.com> wrote:
> > Sorry, I don't understand that.  With that reasoning, isn't having a
> > single git package, be it python or not, even easier?  Why would
> > anybody want a separate egg that includes everything that _happen_ to
> > be written in Python in the first place?  It doesn't make sense at all
> > from packaging point of view to me.
> 
> Because that's the recommended way to create a python package, create
> a new directory, put the files in it, and distribute it.
> 
> > A separate egg per remote-helper that you can pick and choose which
> > ones to install and which ones to leave out would make perfect sense,
> > exactly the same way that distros already split git into "git-core",
> > "git-svn", etc., though.  Your "git-hg" may consist of a single egg and
> > perhaps some other supporting code, and people who want to convert away
> > from legacy Hg repository may want to install it, but it is entirely up
> > to them if they also want to install "git-cvs" that is implemented as a
> > remote-helper that happens to be written in Python, no?
> 
> Yes, fair enough, but we don't do that for any other files in git.git.
> The packagers do so, sure, but a different concern. The reason we want
> to distribute the git_remote_helpers package is so that
> git-remote-hg.py, which lives in git.git/ and is installed as
> git-remote-hg can say "from git_remote_helpers.hg import export".
> 
> The only reason this is needed in the first place is because we can't
> just add the python files to libgit.a or embed it in git-remote-hg
> statically, python does not support that. That is the only reason we
> need to distribute the package, which is why we need a separate
> directory.
> 
> That is, if I've understood Johan's reasoning and intention correctly.

Yes, you have. I'll repeat the history of this to hopefully clarify:

I first created a "git-remote-cvs.py" script (originally under a different 
name, but that is not important), that was transformed (essentially copied) 
to "git-remote-cvs" by the build process. This script was large and 
unwieldy, however, and I found it more maintainable to split it into several 
python scripts. So I created a "git_remote_cvs", and put the supporting 
scripts in there.

Now, in order for the smaller "git-remote-cvs" executable to do its job, it 
needed to import the supporting scripts at runtime, so I decided to make a 
python egg from the "git_remote_cvs" subdir, that would be installed using 
Python's infrastructure. This, I deemed, was the safest way to ensure that 
the "git_remote_cvs" scripts were always available at runtime.

Next, Sverre started his "git-remote-hg.py" script, and found that he could 
re-use some of the scripts in the "git_remote_cvs" package. He therefore 
(with my blessing) refactored this subdir into the "git_remote_helpers" 
subdir/package that is currently under discussion. Hence, this subdir is 
meant to contain the support scripts for remote helper written in Python, 
both common support scripts, and support scripts specific to each remote 
helper. So far, only the common code is there, but we expect the Hg and CVS 
helpers to add scripts to the "hg" and "cvs" subsubdirs, respectively.

END_OF_HISTORY

Just to clarify, Git remote helpers does not live in the 
"git_remote_helpers" subdir. The subdir (which is installed as a Python 
library package) does not contain anything resembling a complete remote 
helper. Instead, the remote helper scripts live as regular scripts in the 
git.git root dir, and (like any other git program) are turned into 
executables by the build process. The difference is that two of the remote 
helpers currently being developed (Sverre's "git-remote-hg", and my "git-
remote-cvs") are written in Python, and (want to) share some common 
supporting code currently located in the "git_remote_helpers" subdir.

We _could_ split up the "git_remote_helpers" package into a "git-remote-hg"-
specific package, and a "git-remote-cvs"-specific package, but that would 
mean either having two copies of the current support code. Alternately, we 
could create a _third_ package containing the common support code, that each 
of our hg/cvs support packages would in turn depend on. I don't think we 
want to go there, at least not yet.

Also, to prevent this misunderstanding, we could create a "python" subdir in 
git.git, and move the "git_remote_helpers" into there. However, it would 
slightly complicate (at least) the git-remote-cvs.py script which currently 
exploits the "coincidence" that the subdir has the same name as the 
corresponding python package, and is therefore testable in both its unbuilt 
and built state.


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
