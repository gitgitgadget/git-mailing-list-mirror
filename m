From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git clone error
Date: Wed, 1 Aug 2007 09:19:51 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708010846360.3582@woody.linux-foundation.org>
References: <C2D5F3B2.2B00%denbuen@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <denbuen@sandia.gov>
X-From: git-owner@vger.kernel.org Wed Aug 01 18:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGGwD-0007qO-3z
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 18:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913AbXHAQUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 12:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755793AbXHAQUd
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 12:20:33 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56138 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755773AbXHAQUc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 12:20:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l71GJvUs019197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Aug 2007 09:19:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l71GJpp0004623;
	Wed, 1 Aug 2007 09:19:52 -0700
In-Reply-To: <C2D5F3B2.2B00%denbuen@sandia.gov>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54447>



On Wed, 1 Aug 2007, Denis Bueno wrote:
> 
> Indeed:
> 
>     scripts[10] > git fsck --full
>     error: b28b949a1a3c8eb37ca6eefd024508fa8b253429: object corrupt or missing
>     missing blob b28b949a1a3c8eb37ca6eefd024508fa8b253429
> 
> Fortunately, it's the only one.

Ok. That's the "easy" case, although the fact that the file went missing 
in the first place is certainly worrisome. 

I think you said you were using OS X - have you seen crashes or are you 
using something like the experimental ZFS support?

Memory and disk corruption is also a possibility, so running fsck (I have 
*no* idea how you do that under OS X, but I bet others on the list know) 
is a good idea.

Also, *if* you actually have the file

	.git/objects/b2/8b949a1a3c8eb37ca6eefd024508fa8b253429

and it's not just missing entirely, please move it out, ie do something 
like

	mv .git/objects/b2/8b949a1a3c8eb37ca6eefd024508fa8b253429 ~/corrupt-object

You want to move it away from the .git/objects directory in any case, 
because if it exists (but is corrupted), git will never overwrite it with 
the non-corrupted version. And you don't want to just delete it, because 
I'd love to see exactly *what* the corruption was.

> > There are certainly ways to figure out what that object _should_ be,
> > though. For example, if that object is the only corrupted entry, and it's
> > a blob (ie pure data object), what you can generally do is still use the
> > repo (as long as you avoid that particular blob), and do things like
> > 
> > git log --raw -r --no-abbrev
> 
>     scripts[11] > git log --raw -r --no-abbrev | grep b28b949a1a3c8eb37ca6eefd024508fa8b253429
>     :100755 100755 b28b949a1a3c8eb37ca6eefd024508fa8b253429 9dbd5bb59198ab59e1850f838f2ed27c77364cde M      condor/condor-uninstall.sh
>     :000000 100755 0000000000000000000000000000000000000000 b28b949a1a3c8eb37ca6eefd024508fa8b253429 A      condor/condor-uninstall.sh

Ok, great. So it's the very first version of "condor/condor-uninstall.sh".

If you can find that original version, great. If not, you can get the 
*second* version by doing

	git cat-file blob 9dbd5bb59198ab59e1850f838f2ed27c77364cde > second-version

and if you remember what your changes were, try to just edit that back to 
the exact thing it was in the first version, if you can (note that by 
"exact", I do mean *exact*. Whitespace and all).

> When you say "re-generate", do you mean `git add <file> ; git commit
> <file>`?  Or something a bit more clever?  I suspect you actually meant the
> latter, since you suggest recreating it *exactly*.

Actually you can literally just do 

	git add my-regenerated-file

and it would do the right thing. But it also changes your index, so a 
better way would often be to do

	git hash-object -w <filename>

which will take any random file, and hash it into the object database.

So if you were able to re-generate the original, you should now have a 
*non*corrupted .git/objects/b2/8b949a1a3c8eb37ca6eefd024508fa8b253429 
file, and git-fsck will be happy again!

And after that, I'd really like to see both the corrupt and the 
non-corrupt object, to try to figure out what the corruption is.

> If I just recreate a version I'm happy with, can I add that to the repo and
> go from there?

Well, it's not so much a version _you_ are happy with: you'd have to be 
able to re-create the exact old version (with the exact same SHA1), in 
order for git to be happy.

> No such luck, but I'll back up my repos in the future.  Any hint on what
> might have caused this kind of corruption?  That repo was created on my
> laptop and only edited there; it's not a clone from some other machine.
> It's possible that I have Ctrl-C'd some git operation in the past -- could
> that have caused it?

No, things like Ctrl-C are safe: we create new objects by writing them to 
a temporary file, and then using an atomic rename() operation on them 
(actually, a "link() + unlink()", but we fall back to "rename()" if that 
fails - some filesystems cannot link files between directories).

So the only way to get corruption is literally with a broken filesystem, 
or memory corruption. Of course, if the OS's "rename()" is broken, and 
isn't atomic (ie if it's "copy + delete" operation).

Of course, git bugs could do this, but quite frankly, this is (a) very 
simple code, and (b) we really haven't had bugs in this area.

Git does end up finding corruption that other VCS's don't. The strong 
hashes and the fact that fsck (and, in fact, even simple operations like 
clone) will check every single hash, means that single-bit corruption gets 
noticed (and is a fatal error) every time. Other SCM's? Not so much.

			Linus
