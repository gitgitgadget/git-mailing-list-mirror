From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Build in clone
Date: Tue, 26 Feb 2008 12:36:51 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802261128360.19024@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-125312335-1204044431=:19024"
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 18:37:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU3kA-0004mq-Cl
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 18:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763613AbYBZRgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 12:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763617AbYBZRgy
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 12:36:54 -0500
Received: from iabervon.org ([66.92.72.58]:35312 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763609AbYBZRgx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 12:36:53 -0500
Received: (qmail 12615 invoked by uid 1000); 26 Feb 2008 17:36:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2008 17:36:51 -0000
In-Reply-To: <200802260321.14038.johan@herland.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Content-ID: <alpine.LNX.1.00.0802261158380.19024@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75154>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-125312335-1204044431=:19024
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.1.00.0802261158381.19024@iabervon.org>

On Tue, 26 Feb 2008, Johan Herland wrote:

> Other than the failing tests, it seems to work fairly well. I've been
> playing around with it for a few minutes, and on a test repo I have with
> 1001 branches and 10000 tags, it cuts down the runtime of a local git-clone
> from 25 seconds to ~1.5 seconds. (simply by eliminating the overhead of
> invoking git-update-ref for every single ref) :)

Good to hear. A certain amount of the point is performance, and I've only 
got relatively simple repositories on Linux to test with, where everything 
is too fast to tell anyway.

> I've tried to test this by diffing a cloned repo against an equivalent
> clone done by the old script. Below I pasted in a few immediate fixes I
> found. With these fixes, the only remaining diff between the clones is
> that refs/remotes/origin/HEAD used to be a symbolic ref (with no reflog),
> but is now a "regular" ref (with reflog).

I think that's just a call to the wrong function (and a lack of very very 
explicit documentation).

> The fixes are, in order of importance:
> - Call git_config(git_default_config) in order to properly set up
>   user.name and user.email for reflogs (This BREAKS test #9 in
>   t1020-subdirectory.sh. Have yet to figure out why)

I should have read email last night; I could have identified a bunch of 
the odd errors for you, but you've figured most of them out by now.

I need to look into the config system further; things should be configured 
such that the local config is in the new directory and the global config 
is unchanged. If no environment variable is set and pwd is a certain way, 
git_config_set() will write to the wrong file.

> - Fix "clone from $repo" reflog messages (using strbufs; something tells
>   me more of this code would benefit from using strbufs)

Most likely. I think Kristian wrote most of this before strbuf existed or 
something of the sort.

> - Høgsberg's name should be in UTF-8 (not sure if this will survive this
>   mail)

It is for me; I bet it didn't survive the mail from me to you. (That is, 
your mailer got my UTF-8 message and converted it to Latin-1 on export, 
and so applying it gave a Latin-1 ø in your tree, which you changed to 
UTF-8, and then your mailer again thought your patch was changing 
one Latin-1 character to two, and sent the patch like that.)

> - The two whitespace errors you mentioned
> 
> I'm sorry that my patch below sucks from a style POV. Feel free to ignore.
> Will redo when it's not in the middle of the night.

I haven't gotten to the level of style in this code myself, so no worries 
there. :) And whitespace noise is welcome at this point, since I'm still 
incorporating changes and evaluating the resulting state, instead of 
evaluating the changes themselves.

	-Daniel
*This .sig left intentionally blank*
--1547844168-125312335-1204044431=:19024--
