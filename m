From: Petr Baudis <pasky@suse.cz>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 14:05:30 +0100
Message-ID: <20060211130530.GR31278@pasky.or.cz>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org> <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net> <5C03F8F8-656F-48B0-825C-DE55C837F996@codefountain.com> <43EDA3D0.7090204@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Craig Schlenter <craig@codefountain.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 11 14:05:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7uR6-0004OC-OK
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 14:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWBKNFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 08:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWBKNFH
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 08:05:07 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3506 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751418AbWBKNFF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 08:05:05 -0500
Received: (qmail 27532 invoked by uid 2001); 11 Feb 2006 14:05:30 +0100
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Content-Disposition: inline
In-Reply-To: <43EDA3D0.7090204@gorzow.mm.pl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15941>

Dear diary, on Sat, Feb 11, 2006 at 09:44:00AM CET, I got a letter
where Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> said that...
> Craig Schlenter wrote:
> > On 11 Feb 2006, at 7:48 AM, Junio C Hamano wrote:
> > It would be nice if the "partial pack" or whatever that has been
> > downloaded at the time of the breakage could be re-used and
> > things could start "from that point onwards" or the bits that were
> > already received could be unpacked. Comments?
> 
> It even already works on plain http repos with git fetch.
> (e.g. WineHQ repository)
> Why git protocol doesn't support it?

Because it works totally different. When downloading from plain HTTP
repos, you are just downloading files from the remote repository and it
is easy to pick up wherever you left (and last night, I just added a
possibility to Cogito to resume an interrupted cg-clone by just cd'ing
inside and running cg-fetch, as is; it's pretty neat) - you just resume
downloading of the file you downloaded last, and don't download again
the files you already have.

But the native git protocol works completely differently - you tell the
server "give me all objects you have between object X and head", the
object will generate a completely custom pack just for you and send it
over the network. The next time you fetch, you just ask for a pack
between object X and head again, but the head can be already totally
different. What we would have to do is to check for interrupted
packfiles before fetching, attempt to fix them (cutting out the
incomplete objects and broken delta chains, if applicable), and then
tell the remote side to skip those objects; but that may not be easy
because there can be a lot of "loose fibres". Another way would be to
just tell the server "if head is still Y, start sending the pack only
after N bytes". *shudder*

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
