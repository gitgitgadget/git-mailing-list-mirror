From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 1 Aug 2007 18:03:50 -0400
Message-ID: <20070801220350.GD28106@thunk.org>
References: <200708010216.59750.jnareb@gmail.com> <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org> <7vodhrby6f.fsf@assigned-by-dhcp.cox.net> <20070801092428.GB28106@thunk.org> <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:04:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMIg-0006HG-I6
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbXHAWEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbXHAWEL
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:04:11 -0400
Received: from THUNK.ORG ([69.25.196.29]:58155 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbXHAWEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:04:09 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IGMQp-00043M-Jm; Wed, 01 Aug 2007 18:12:40 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IGMII-0003vD-UH; Wed, 01 Aug 2007 18:03:50 -0400
Content-Disposition: inline
In-Reply-To: <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54481>

On Wed, Aug 01, 2007 at 03:15:25AM -0700, Junio C Hamano wrote:
> > So would you accept a patch which adds a git-config variable which
> > specifies whether or not local clones should use hard links by default
> > (defaulting to yes), and which adds a --no-hard-links option to
> > git-clone to override the config option?
> 
> Are you suggesting to make -l the default for local, in other
> words?  I personally do not make local clone often enough that I
> am not disturbed having to type extra " -l" on the command line.

Yeah, essentially, with a git-config option (and comand-line option)
to override the default for those people who are "squeamish" about git
clone -l.  Linus's suggestion of using file:// as a way to indicate
non-local also makes a lot of sense to me.

> Perhaps if the destination is local,
> 
>          - if -s is given, just set up alternates, do nothing else;

As I understand it, the main objection with making -s the default is
surprising result that could happen if you do a git-prune in the base
repository which causes objects which are borrowed from the base
repository via .git/objects/info/alternates, right?

What if git clone -s appended the repository which is borrowing
objects via alternates to a file located in the base repository,
.git/objects/info/shared-repos?

Then git-prune could also use the refs marked in each of the
downstream repositories that are sharing objects with base repository
and not make those objects go away.  That way, git-gc --prune won't do
anything surprising to any shared repositories, since it will scan
those shared repositories automatically.  Would that be considered
acceptable?  That way you can get instant clones even on filesystems
that don't support hard links, such as Windows systems.

The way I would suggest doing it is once we implement support for
.git/objects/info/shared-repos is to do the following with git-clone
by default:

   	* If the source repo is specified via a file:// URL, per Linus's
          suggestion, do the clone via copying.

	* If the source repo is specified via a local pathname, and
          .git/objects/info/shared-repos in the source repository is
          writeable by the user who is doing the clone, then do a
          clone -s.

	* If the above fails, try clone -l

	* If the above fails, do a clone via copying over a new pack

Would this be acceptable?  Patches to do the following should be
fairly easy to whip up.  Obviously this wouldn't be for 1.5.3.  :-)

       	       	    	 	   	- Ted
