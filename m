From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Security problem
Date: Thu, 15 Jun 2006 23:27:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606152300460.5498@g5.osdl.org>
References: <200606151709.22752.lan@academsoft.ru> <200606161054.46813.lan@academsoft.ru>
 <Pine.LNX.4.64.0606152137410.5498@g5.osdl.org> <200606161237.21997.lan@academsoft.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 08:27:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr7o5-0005Yx-M9
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 08:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWFPG1i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 02:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWFPG1i
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 02:27:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751079AbWFPG1h (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 02:27:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5G6RSgt015217
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Jun 2006 23:27:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5G6RRe0008718;
	Thu, 15 Jun 2006 23:27:28 -0700
To: Alexander Litvinov <lan@academsoft.ru>
In-Reply-To: <200606161237.21997.lan@academsoft.ru>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21932>



On Fri, 16 Jun 2006, Alexander Litvinov wrote:
>
> > Well, they may not be "safe" - you just need to work a _lot_ harder to
> > corrupt a pack-file in any interesting manner. And again, git-fsck-objects
> > would pick up any such thing going on.
>
> As it shown in pack-objects.c, each object have stored sha1, almost the same 
> as file rename.

Yes and no.

The index file has the stored sha1 (and in that sense you can do almost 
the same thing as a file rename by just modifying the index file).

But when we actually transfer a pack over from one place to another (ie a 
clone or a push), we don't even transfer the index file. Instead, the 
index file gets re-generated at the other end.

That's pretty much an on-going theme in most of git - trying to avoid 
having metadata, if that can instead of calculated directly.

So again, a "rsync" or a "http" thing that just gets the index and 
pack-files directly _as_files_, will actually also download a corrupt 
file. The git native protocol is much harder to fool.

git-fsck-objects actually verifies the pack-files and index files in 
several ways:

 - both the pack-file and the index-file actually contain a SHA1 checksum 
   of themselves, so any accidental corruption will be picked up (but if 
   somebody is able to get at the filesystem, they can obviously 
   re-calculate the SHA1 and update the checksum too)

 - the index file also contains the SHA-1 of the pack-file (and that is 
   then part of the checksum of the index file), again to avoid accidental 
   corruption or mixing of index and pack-files.

 - fsck checks all of these internal SHA-1 checksums, and verifies basic 
   information (ie number of objects must match etc)

 - each object in the index file is unpacked, and its SHA-1 is 
   re-calculated and checked against what the index file claimed.

So exactly as with individual objects, the pack-files are actually 
verified, and on (native-mode) transfer, the names of individual files are 
never actually transferred, rather they are re-calculated from the raw 
contents at the receiving end.

The pack-files then have a few additional sanity-checks of their own that 
should help pinpoint at least the accidental kind of corruption.

But no, the SHA1 checksums of the pack-files are not checked by normal 
operations. That would be deadly - trying to check the SHA1 hash of a 
pack-file obviously would involve reading it all in, something normal 
operations actually try to avoid (normal ops use the index exactly in 
order to only read the parts they need).

Perhaps most importantly, after fsck has checked the SHA-1's of each 
individual object, it will also do a full reachability check. That, in 
many ways, is even more important than checking that each object name 
matches its contents (ie there's no missing history either, and the 
"tips" of the repository end up basically validating all the rest).

So again, the thing is set up so that doing a full fsck actually does a 
_lot_ of integrity checking.

But in the absense of explicit fsck, we do trust the data, even if the 
actual _transfer_ of data will recalculate SHA-1's.

> >  - if you corrupt the repository, subsequent clones (or even pulls) from
> >    the corrupt repository simply won't work if you use the native
> >    protocol, because the native protocol doesn't actually trust anything
> >    but the actual contents (so if the contents won't match, then neither
> >    will the SHA1 names). So the corruption is pretty strictly limited to
> >    the _one_ repository that the attacker had write access to.
>
> As I understand sent pack file will contains actial SHA-1 of objects. And any 
> hack will be cleary visible.

No, as mentioned, the actual SHA-1's won't ever be sent, so what happens 
is that if the repository on the sending side was hacked, the _sending_ 
side may never even realize it (since it's not necessarily checking the 
SHA-1's), but the receiving side will only ever see the raw data, and as 
such, it won't ever even _see_ the "false hidden names", because it will 
generate a whole new index that purely depends on the data.

And maybe that's exactly what you meant - yes, the hack will be clearly 
visible, because the names will now be the "real" ones. You can't hide 
things by using a false name.

> >    So there's a pretty fundamental "corruption containment" part there.
> ...
> Situation with evil repo is clear to me: you can turst only to trusted commit 
> identified by SHA-1

Yes. Exactly.

And once you have a reason to trust a commit, everything you can reach 
from that commit is also trustworthy, assuming it passes fsck. IOW, you 
only really need to trust the head(s) in your repository.

> > But yeah, I actually still personally do a fair number of
> > "git-fsck-objects". I've never found anything that way since very early on
> > (and back then, the real problem was rsync getting objects that weren't
> > reachable), but I still do it. It makes me feel happier.
>
> As the result: Always fsck repo after pull/clone !

Well, even better, try to avoid pulling from untrusted sources in the 
first place ;)

But yes, fsck is actually fairly fast if you do incremental pulls and 
repack your repository. To help you do this, there's two modes to fsck: 
there's the "full mode", which goes through _everything_, including 
pack-files, and there's the "fsck only lose objects", which is the common 
one.

So for example, let's say that you only ever repack your repository 
locally when it's been "known good" (in fact, repacking in itself will 
generally find almost all of the problems that fsck can find, since a full 
repack will obviously do the reachability analysis as part of just the 
preparatory work). That means that you only ever need to do the quick 
default "light fsck" after a pull, since an incremental pull (with the 
native protocol) will have unpacked all the pulled objects.

So "fsck after each pull" is not something we do by default, but if you 
keep your repo fairly packed, doing so manually (or by just scripting 
things) won't even really slow you down, because it will only ever need to 
check incrementally - the stuff you've re-packed it doesn't need to check 
(assuming you can now trust your local filesystem).

So git certainly gives you the option to be really anal, and doesn't even 
make it needlessly hard or expensive, even with large repositories.

			Linus
