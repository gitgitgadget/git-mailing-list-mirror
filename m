From: Petr Baudis <pasky@suse.cz>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 14:05:19 +0100
Message-ID: <20060119130519.GB28365@pasky.or.cz>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com> <cda58cb80601170932o6f955469y@mail.gmail.com> <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net> <43CF739F.2030204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Franck <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 14:04:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzZSS-0006pT-Qd
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 14:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbWASNEC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 08:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWASNEB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 08:04:01 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59027 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161186AbWASNEB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 08:04:01 -0500
Received: (qmail 22782 invoked by uid 2001); 19 Jan 2006 14:05:19 +0100
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <43CF739F.2030204@op5.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14904>

Dear diary, on Thu, Jan 19, 2006 at 12:10:23PM CET, I got a letter
where Andreas Ericsson <ae@op5.se> said that...
> Junio C Hamano wrote:
> >Franck <vagabon.xyz@gmail.com> writes:
> >
> >
> >>I'm wondering why the "grafts" files is not involved during
> >>push/pull/clone operations ?
> >
> >
> >Commit ancestry grafting is a local repository issue and even if
> >you manage to lie to your local git that 300,000th commit is the
> >epoch, the commit object you send out to the downloader would
> >record its true parent (or parents, if it is a merge), so the
> >downloader would want to go further back.  And no, rewriting
> >that commit and feeding a parentless commit to the downloader is
> >not an option, because such a commit object would have different
> >object name and unpack-objects would be unhappy.
> 
> I'm a bit curious about how this was done for the public kernel repo. 
> I'd like to import glibc to git, but keeping history since 1972 seems a 
> bloody waste, really.

FWIW, with the ELinks GIT repository we just started from scratch and
then converted the old CVS repository, and provided this script in
contrib/grafthistory.sh:


#!/bin/sh
#
# Graft the ELinks development history to the current tree.
#
# Note that this will download about 80M.

if [ -z "`which wget 2>/dev/null`" ]; then
  echo "Error: You need to have wget installed so that I can fetch the history." >&2
  exit 1
fi

[ "$GIT_DIR" ] || GIT_DIR=.git
if ! [ -d "$GIT_DIR" ]; then
  echo "Error: You must run this from the project root (or set GIT_DIR to your .git directory)." >&2
  exit 1
fi
cd "$GIT_DIR"

echo "[grafthistory] Downloading the history"
mkdir -p objects/pack
cd objects/pack
wget -c http://elinks.cz/elinks-history.git/objects/pack/pack-0d6c5c67aab3b9d5d9b245da5929c15d79124a48.idx
wget -c http://elinks.cz/elinks-history.git/objects/pack/pack-0d6c5c67aab3b9d5d9b245da5929c15d79124a48.pack

echo "[grafthistory] Setting up the grafts"
cd ../..
mkdir -p info
# master
echo 0f6d4310ad37550be3323fab80456e4953698bf0 06135dc2b8bb7ed2e441305bdaa82048396de633 >>info/grafts
# REL_0_10
echo 43a9a406737fd22a8558c47c74b4ad04d4c92a2b 730242dcf2cdeed13eae7e8b0c5f47bb03326792 >>info/grafts

echo "[grafthistory] Refreshing the dumb server info wrt. new packs"
cd ..
git-update-server-info


So you checkout the ELinks repository and if you want the full history
you just run this script and it does everything for you.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
