From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Sun, 30 Dec 2007 22:46:22 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0712302145500.13593@iabervon.org>
References: <477822C3.9060002@gbarbier.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-567638827-1199070674=:13593"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Mon Dec 31 04:47:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9Bc8-0001ew-9t
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 04:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbXLaDq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 22:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbXLaDqZ
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 22:46:25 -0500
Received: from iabervon.org ([66.92.72.58]:43743 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbXLaDqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 22:46:25 -0500
Received: (qmail 1931 invoked by uid 1000); 31 Dec 2007 03:46:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Dec 2007 03:46:22 -0000
In-Reply-To: <477822C3.9060002@gbarbier.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Content-ID: <alpine.LNX.1.00.0712302217010.13593@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69384>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-567638827-1199070674=:13593
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.1.00.0712302217011.13593@iabervon.org>

On Sun, 30 Dec 2007, Grégoire Barbier wrote:

> Hi everybody.
> 
> I've just subscribed to the list, therefore I think it should be rude not to
> introduce myself. My name is Grégoire Barbier (non french-speaking people
> should call me Greg and don't bother with non-ascii characters), I'm working
> mainly as a consultant (using Powerpoint and wearing a tie) but have some
> personal and professional interest in programming, especially about
> middlewares. BTW I apologize for my poor english.
> 
> I'm using Git for a rather short time but enough to fall in love with it. For
> a few days I'm trying to use it over webdav, that is over http/https with
> write (push) access. As for me, the main rationale to use http(s) rather than
> git or ssh is to get through corporate firewalls, otherwise I would probably
> not bother with webdav.

In general, we've been able to either get through firewalls with ssh or 
it's all in the same VPN. So it's kind of unloved at this point. People 
poke at it occasionally, but mostly in the context of other fixes, I 
think.

> With 1.5.3.6 and 1.5.4-rc2, I encounter severe issues that make me think that
> http-push is not totally ready for production. That's why I would like to have
> a discussion with some of you that use and maintain it, to see what I can do
> to improve it or to help you improve it.
> 
> Here are some issues I encountered:
> - http-push does not release locks when failing due to syntax error (e.g. if
> one types "git push" instead of "git push origin master")
> - http-push freezes with no message with urls not terminated by a slash
> - http-push does not create directory for the object (objects/xx/) and if the
> directory exists, it does not actually push objects without having
> USE_CURL_MULTI defined (which is not the compilation default)
> 
> I've starting to look at the source code and make some little improvements,
> but I feel that I should rather discuss with you to understand why there are
> two rather independant modes in http-push (USE_CURL_MULTI or not) and what is
> the real target (I don't want to work twice, neither to mess up the work of
> someone else that would be currently reorginzing this part of the code).

I think the issue is the CURL_MULTI library code is either not supported 
or is broken in versions of curl that many distros still ship, but we can 
do a lot better with it, so the duplicate implementation is plausibly 
worthwhile.

One thing I personally thought would be worthwhile would be to separate 
out the logic for sending stuff like the fetching logic is in 
walker.{c,h}, and include the necessary methods in struct walker. There 
were people interested in sftp (for the case where you can get ssh through 
firewalls, but you aren't allowed to install programs on the file server 
and git isn't installed system-wide).

One thing that's worth doing when looking at the code is using "git blame" 
to find out where the lines you're changing came from, and "git log 
<hash>" to find out what the person writing them was trying to do. This 
will also turn up the people who've been working in the area, who you 
might want to cc, since they'll be good reviewers.

	-Daniel
*This .sig left intentionally blank*
--1547844168-567638827-1199070674=:13593--
