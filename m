From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git clone error
Date: Tue, 31 Jul 2007 19:38:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707311924590.4161@woody.linux-foundation.org>
References: <C2D525CB.2A81%denbuen@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <denbuen@sandia.gov>
X-From: git-owner@vger.kernel.org Wed Aug 01 04:39:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG47B-0005en-NO
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 04:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbXHACjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 22:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756015AbXHACjF
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 22:39:05 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56304 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755937AbXHACjE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 22:39:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l712cSKu017191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 Jul 2007 19:38:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l712cMFl002999;
	Tue, 31 Jul 2007 19:38:22 -0700
In-Reply-To: <C2D525CB.2A81%denbuen@sandia.gov>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.18__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54399>



On Tue, 31 Jul 2007, Denis Bueno wrote:
> 
> I'm a new git user (actually a darcs convert) and am running into a weird
> problem on a small and simple repository.  The error I see is:
> 
>     git[14] > git clone /Volumes/work/scripts/
>     Initialized empty Git repository in /tmp/git/scripts/.git/
>     remote: Generating pack...
>     Done counting 80 objects.
>     remote: error: unable to unpack b28b949a1a3c8eb37ca6eefd024508fa8b253429 header
>     fatal: unable to get type of object b28b949a1a3c8eb37ca6error: git-upload-pack: git-pack-objects died with error.
>     fatal: git-upload-pack: aborting due to possible repository corruption on the remote side.
>     remote: aborting due to possible repository corruption on the remote side.
>     fatal: early EOF
>     fatal: index-pack died with error code 128
>     fetch-pack from '/Volumes/work/scripts/.git' failed.

Well, it says so, but the most likely issue really is that there is 
"corruption on the remote side".

Please do

	cd /Volumes/work/scripts
	git fsck --full

which I would guess will almost certainly talk about some kind of problems 
with that object "b28b949a1a3c8eb37ca6eefd024508fa8b253429". And possibly 
more.

The "unable to unpack .. header" problem would at a guess be a totally 
corrupted loose object. You should have a file named

	.git/objects/b2/8b949a1a3c8eb37ca6eefd024508fa8b253429

and it sounds like that file is corrupt. So far, apart from a CRLF 
conversion bug (that you wouldn't have triggered on OS X anyway), I think 
every single time we've seen that, it's been a real disk or memory 
corruption.

Trying to restore corrupt objects can be quite hard, since git stores them 
in a compressed format, and so git single-bit errors are very detectable 
(that's kind of the point of having cryptographically secure hashes!), but 
they are very much not fixable, unless you can find the original data that 
*resulted* in that object some way (in another clone of the git 
repository, or in a backup).

There are certainly ways to figure out what that object _should_ be, 
though. For example, if that object is the only corrupted entry, and it's 
a blob (ie pure data object), what you can generally do is still use the 
repo (as long as you avoid that particular blob), and do things like

	git log --raw -r --no-abbrev

and you'll see the git history with all blobs named with their SHA1's. 
Then you can just search for that b28b949.. name, and you'll see exactly 
which file (in which version) it was, and if you can just find a backup of 
that file (or re-create it *exactly* from previous versions and your 
memory of it), you can re-generate the git object and thus save your 
repository.

Of course, a much easier option tends to be to just have a backup 
repository that has that object in it, and then you can literally just 
copy that b28b949 object over.

In short: git basically guarantees that it will *find* all corruption, but 
it doesn't do backups for you. Backups are easy to do (cloning), and git 
also makes incremental backups trivial (ie just do "git fetch" or "git 
push"), but git won't do backups for you unless you ask for them that way.

			Linus
