From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special
 case
Date: Fri, 4 Sep 2009 14:33:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909041323170.4605@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org> <alpine.DEB.1.00.0909041232500.4605@intel-tinevez-2-302> <7vk50fugpn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 14:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjXyz-0006tl-Iz
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 14:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbZIDMd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 08:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755862AbZIDMd1
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 08:33:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:56915 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755920AbZIDMd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 08:33:26 -0400
Received: (qmail invoked by alias); 04 Sep 2009 12:33:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp034) with SMTP; 04 Sep 2009 14:33:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FRmJ+1zVFHlINkacU6/L4Vd0JB06U3W/f7OSama
	n8rT6V1kS+Kzak
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vk50fugpn.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127726>

Hi,

On Fri, 4 Sep 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The special case is "http://" and "https://" which might indicate foreign 
> > VCS repositories.
> >
> > In all other cases, I am afraid that you are complicating the glove.
> >
> > Remember: the whole purpose of the "foreign VCS" helpers is user 
> > convenience.
> 
> Sorry, but you completely lost me here.

My point was that the ambiguity _only_ applies to http:// and https:// 
URLs, as you illustrated yourself:

> Here are two URLs that follows your "user convenience" principle.
> 
> 	http://example.xz/repos/frotz.git/
> 	http://example.xz/repo/frotz/trunk/

There is no ambiguity about hg://, svn://, etc.  None.

Some "URLs" do not look like "URLs" at all, e.g. :ext:user@host:/module 
for CVS repositories.  I haven't really thought about a convenient way to 
specify these, but I could imagine that indeed something like 
"cvs::ext:usr@host:/module" would make sense, and still be an intuitive 
interface that does not break down with "git clone".

Likewise, I imagine that "svn::http://example.xz/repo/frotz/trunk" (or 
even "svn::std::http://example.xz/repo/frotz") are not _too_ unintuitive.

But my real point still stands: "git clone hg://example.xz/repos/blub" 
should Just Work.

Oh, and I definitely do not want to expose an _implementation detail_ such 
as "we use cURL" in the name of the remote helper.  That would just be bad 
style in my book.

> How do you tell, without relying on .git and trunk, the former is a git 
> repository and wants the dumb walker transport to fetch from, while the 
> latter is probably a svn and you would either use "svn checkout", or use 
> "git clone" on it via the svn helper?
> 
> Well, you don't.
> 
> One possible "convenient user interface" would be to say
> 
> 	svn+http://example.xz/repo/frotz/trunk/
> 
> (or use :: instead of + as the helper-name separator, as we agreed not to
> decide on it)

Now that you mention it, the main issue was the ambiguity that

	svn:/path/to/repo

should actually be an ssh "URL".  But I think that the simple fact that a 
"://" in the URL (and if that is not sufficient, something like a 
"<vcs>::" prefix) make non-ssh URLs distinct enough to decide robustly 
what type the URL is.

> This would give us
> 
>  (1) it is clear that it literally is what you would give to git and
>      trigger the svn helper; and
> 
>  (2) to people who know how canonical git URLs with foreign helper are
>      spelled, it also is clear that you can use "svn checkout" on
>      everything after "svn+" in it.

The only problem is that you cannot use "git-remote-svn+http" as helper, 
as "+" are not valid filename characters on Windows.  However, you could 
have a "git-remote-svn" handling both "svn://" and "svn+" prefixes.

> Compared to that, if you do not have any such prefix, how would that be 
> more convenient to the users?

Indeed, I made myself misunderstood.  I think that for _a lot_ of 
repository URLs, there are naturally distinctive-enough prefixes.  IMHO we 
should make use of that, for a substantially improved user experience (as 
opposed to, say, the user experience for unfortunate CVS users who would 
like to establish a git-svn-like workflow).

Summary: I think that for most URLs, "<protocol>://" is enough to tell 
which helper to call ("http://" means Git, tough).

For those URLs, where this is not sufficient, a "<vcs>+" should be good 
enough, or if you really want, "<vcs>::".  As the helper gets the complete 
URL, it can figure out how to proceed from here, without any need for 
core Git to know how.

Ciao,
Dscho
