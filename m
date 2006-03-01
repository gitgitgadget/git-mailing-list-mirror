From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Wed, 1 Mar 2006 21:54:16 +0100
Message-ID: <200603012154.16509.Josef.Weidendorfer@gmx.de>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <Pine.LNX.4.64.0603010935201.22647@g5.osdl.org> <7virqyf094.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 21:55:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEYLG-0004zC-Pg
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 21:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWCAUyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 15:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbWCAUyc
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 15:54:32 -0500
Received: from mail.gmx.de ([213.165.64.20]:40624 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751147AbWCAUyb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 15:54:31 -0500
Received: (qmail invoked by alias); 01 Mar 2006 20:54:23 -0000
Received: from p549692CD.dip0.t-ipconnect.de (EHLO linux) [84.150.146.205]
  by mail.gmx.net (mp036) with SMTP; 01 Mar 2006 21:54:23 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7virqyf094.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17011>

On Wednesday 01 March 2006 20:11, Junio C Hamano wrote:
> The latter at first sounds sane, but it has a subtle issue,
> which was what bitten me previously between heads/ and tags/.
> In that broken version, if you have a head called "dead" and a
> tag with the same name, neither was taken ("they are not unique,
> so do not take either!") and we ended up finding an object whose
> SHA1 name began with those two bytes 0xDE 0xAD.  I do not think
> this has happened in the field, fortunately, but it would have
> been quite hard to diagnose.
> 
> So if we were to do it, I would say do the latter, but be very
> careful to make sure you fail the whole get_sha1() when you bail
> out of the "try possible prefixes" codepath because of
> ambiguity.

Yes.
Any ambiguity is a source of confusion and user error. Better
bail out. If it is not a performance problem, it would be better
to integrate the check for abbreviated object name into the
ambiguity analysis, and not have 2 stages of searching.
It probably would be a good idea to print out the ambigous names
with the error message, so that you can copy&paste the correct
full name afterwards.

If we go for the .git/refs/remotes/... and have an ambiguity becaues
of remote shortcut names, a error message pointing at a "git-rename-remote"
command would be handy, allowing the user to cleanup the namespace.

> There may be other issues involved, but I wouldn't 
> know -- I reverted the "do not take either if they are
> ambiguous between heads/ and tags/" patch primarily because of
> the reason from the above paragraph, but also did not want to
> deal with any other potential issues to keep my sanity ;-).

I think the real problem here is that names like "dead" can be interpreted
as abbreviated object name. When you introduce such a name as head or tag,
you have a potential ambiguity which can get real at any time.
Perhaps it would be good to print out a warning when the user is about to
create a head or tag name which can be interpreted as abbreviated object name?

Josef
