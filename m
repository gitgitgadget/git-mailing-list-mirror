From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Moved files and merges
Date: Mon, 5 Sep 2005 08:47:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509050825170.3568@evo.osdl.org>
References: <4318E754.9000703@zytor.com> <7vek87djat.fsf@assigned-by-dhcp.cox.net>
 <7vek867e29.fsf@assigned-by-dhcp.cox.net> <7vy86erntu.fsf@assigned-by-dhcp.cox.net>
 <20050903190500.GB8379@mars.ravnborg.org> <7voe7arlqk.fsf@assigned-by-dhcp.cox.net>
 <20050903220355.GA1895@mars.ravnborg.org> <7v64thl248.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509041329340.23242@iabervon.org> <7vvf1gejjf.fsf@assigned-by-dhcp.cox.net>
 <431C6167.4070703@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 17:49:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECJCX-0007hr-AT
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 17:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVIEPrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 11:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVIEPrq
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 11:47:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34215 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932222AbVIEPrp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 11:47:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j85FlPBo015755
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Sep 2005 08:47:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j85FlLZN015553;
	Mon, 5 Sep 2005 08:47:23 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <431C6167.4070703@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8097>



On Mon, 5 Sep 2005, H. Peter Anvin wrote:
> 
> It would also hade the somewhat interesting possibility that one could 
> "remove and recreate" a file and have it exist as a different entity. 
> That probably needs to be a user option.

It's a totally broken model. Really.

You think it solves issues, but it just creates more bugs and problems 
than it solves.

Trust me. The whole point of git is that "content is the only thing that 
matters", and that there isn't any other meta-data. If you break that 
fundamental assumption, everything git does so well will break. 

I think we've already shown that the "content matters" approach works.  I
claim that the git rename tracking works better than any other SCM out 
there, _exactly_ because it doesn't make the mistake of trying to track 
anything but content.

The "moved + modified files" is not anything special. The current 
automatic merger may not handle it, but that's not because it _can't_ 
handle it, it's because it tries to be simple and efficient. 

And because it's so _incredibly_ fast for all the normal cases, you can 
now spend some effort on figuring out renames dynamically for the few 
cases where it fails. Does it do so now? No. Would adding UUID's help? 
Hell no. It would be just an unmitigated disaster.

Exactly the same way "git-diff-tree" can figure out renames, a merge 
algorithm can figure them out. 

Right now, we have two stages in merges: we try the trivial merge first
(pure "git-read-tree"), and when that fails, we try the automatic 3-way
merge. The fact that we don't have a third (and fourth, and fifth) merge
algorithm for when those two trivial merges happen to not work is _not_ an
indication that the "contents only" approach doesn't work - it's just an
indication of the fact that 99.9% of all merges are trivial, and they
should be optimized for.

So the next step is _not_ to do UUID's, it's to notice that merge errors 
happened, and try to figure out why. Right now we just give up and say 
"sort it out by hand". That's actually a perfectly valid approach even in 
the presense of moved files - it's a bit painful, but once you _do_ sort 
it out and commit the merge, especially if you can push the merge back (so 
that both sides then agree on the final rename), future merges will be 
trivial again - ie you won't have to go through it over and over again.

Of course, if you don't push it back, but keep the two trees separate and 
keep on modifying files that have different names in the other repository, 
you'll keep on getting into the situation that the trivial merge doesn't 
work. So we _do_ want to get an automated "phase 3" (and maybe 4..) merge 
that can figure out renames, but the point here is that it's something we 
_can_ figure out.

For example, one way of doing it is to just do the exact merge we do now,
and then look at the files that didn't merge. Do a cross-diff between such
files and new/deleted files (if not _exactly_ the way we do for "git diff
-M", then at least it's exactly the same concept), and try to do a
three-way merge where the base/first/second pairs don't have the same
name.

For example, let's say that you have the common commit A, and file "x",
and two paths (B and C) where B has renamed the file "x" to "y", and C has
modified file "x". You end up with the schenario that our trivial merge
fails to handle, and right now we give up, and don't help the user very
much at all. But the _solution_ is not to change "read-tree" to know about
renames, nor is it to make git keep any new data. The solution is to just 
make phase 3 say:

 - "Automatic merge failed, trying rename merge"
 - go through all files that exist in C but not in B (or vice versa), and 
   pair them up with all files that exist in B but not in C (or vice
   versa) and see if _they_ can be handled as a three-way merge. And 
   exactly the same way that we do the rename detection, we may want to
   find the "optimal pairing" by looking at the distance between the
   files.

Notice? This will automatically handle the "renamed in one branch, 
modified in another" case. In fact, if the renamer modified it too, that's 
not a problem at all - the three-way merge will work exactly the same way 
it does now with the case of a non-moved "modified in both" files.

Problem solved. Without complicating the trivial (and very common) cases, 
and without introducing any new metadata that is fundamentally impossible 
to maintain (and it _is_ fundamentally impossible to maintain, because it 
has nothing to do with the contents of the files, so patches etc will by 
definition break it).

		Linus
