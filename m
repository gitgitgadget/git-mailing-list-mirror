From: Theodore Tso <tytso@mit.edu>
Subject: Re: mercurial to git
Date: Tue, 6 Mar 2007 16:54:59 -0500
Message-ID: <20070306215459.GI18370@thunk.org>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 22:55:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOhcn-0005A2-9S
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 22:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbXCFVzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 16:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbXCFVzG
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 16:55:06 -0500
Received: from thunk.org ([69.25.196.29]:57903 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030310AbXCFVzE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 16:55:04 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HOhiC-0003LF-Jd; Tue, 06 Mar 2007 17:00:48 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HOhcZ-0000AR-Ra; Tue, 06 Mar 2007 16:54:59 -0500
Content-Disposition: inline
In-Reply-To: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41596>

On Tue, Mar 06, 2007 at 09:06:29PM +0000, Rocco Rutte wrote:
> 
> attached are two files of take #1 of writing a hg2git converter/tracker 
> using git-fast-import. It basically works so use at your own risk and 
> send patches... :)

I was actually thinking about doing this too, but apparently you beat
me too it.  :-)

> The performance bottleneck is hg exporting data, as discovered by people 
> on #mercurial, the problem is not really fixable and is due to hg's 
> revlog handling. As a result, I needed to let the script feed the full 
> contents of the repository at each revision we walk (i.e. all for the 
> initial import) into git-fast-import. This is horribly slow. For mutt 
> which contains several tags, a handfull of branches and only 5k commits 
> this takes roughly two hours at 1 commit/sec. My earlier version not 
> using 'deleteall' and feeding only files that changed took 15 minutes 
> alltogether, git-fast-import from a textfile 1 min 30 sec.

Hmm.... the way I was planning on handling the performance bottleneck
was to use "hg manifest --debug <rev>" and diffing the hashes against
its parents.  Using "hg manifest" only hits .hg/00manifest.[di] and
.hg/00changelog.[di] files, so it's highly efficient.  With the
--debug option to hg manifest (not needed on some earlier versions of
hg, but it seems to be needed on the latest development version of
hg), it outputs the mode and SHA1 hash of the files, so it becomes
easy to see which files were changed relative to the revision's
parent(s).

Once we know which files we need to feed to git-fast-import, it's just
a matter of using "hg cat -r <rev> <pathname>" to feed the individual
changed file to git-fast-import.  For each file, you only have to
touch .hg/data/pathane.[di] files.  So this should allow us to feed
input into git-fast-important without needing to feed the full
contents of the repository for each revision.

The other thing that I've been working in my design is how to make the
converter to be bidrectional.  That is, if a changelog is made on the
hg repository, it should be possible to push it over to the git
repository, and vice versa, if there are changes made in the git
repository, it should be possible to push it back to git.  

In order to do this it becomes necessary to special case the .hgrc
file, and in fact we need to make sure that the .hgrc file does *not*
show up in the git repository, but the contents of the .hgrc file
needs to be stored in the state file that lives alongside the git and
hg repositories.

Regards,
						- Ted
