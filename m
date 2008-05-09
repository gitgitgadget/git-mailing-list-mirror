From: Brandon Casey <drafnel@gmail.com>
Subject: Re: git gc & deleted branches
Date: Fri, 9 May 2008 01:41:30 +0000 (UTC)
Message-ID: <loom.20080509T011318-478@post.gmane.org>
References: <48235D99.2040407@nrlssc.navy.mil> <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de> <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home> <20080508211734.GA819@sigill.intra.peff.net> <48236F69.2060900@nrlssc.navy.mil> <20080508213107.GA1016@sigill.intra.peff.net> <48237344.6070405@nrlssc.navy.mil> <20080508214454.GA1939@sigill.intra.peff.net> <48237650.5060008@nrlssc.navy.mil> <20080508224827.GA2938@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:42:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuHd4-0001dJ-EC
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 03:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934680AbYEIBlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 21:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbYEIBlo
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 21:41:44 -0400
Received: from main.gmane.org ([80.91.229.2]:40322 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763589AbYEIBln (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 21:41:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JuHcA-0005gk-Va
	for git@vger.kernel.org; Fri, 09 May 2008 01:41:39 +0000
Received: from m0b1b5e42.tmodns.net ([66.94.27.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 May 2008 01:41:38 +0000
Received: from drafnel by m0b1b5e42.tmodns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 May 2008 01:41:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.94.27.11 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080418 Ubuntu/7.10 (gutsy) Firefox/2.0.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81584>

Jeff King <peff <at> peff.net> writes:

> 
> On Thu, May 08, 2008 at 04:53:20PM -0500, Brandon Casey wrote:
> 
> > > Yes. You would have to use the pack mtime. But of course you would have
> > > to actually _leave_ them in a pack, or they would just keep getting
> > > added to the new pack.
> > 
> > I had the impression that unreachable objects would not be packed. Maybe it
> > was more of an assumption.
> 
> Look in builtin-pack-objects.c:1981-1982. We basically just say "if it's
> in a pack now, then it should go into the new pack."
> 
> -Peff
> 


Here's what I was thinking (posted using gmane):

diff --git a/git-repack.sh b/git-repack.sh
index e18eb3f..064c331 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -30,7 +30,7 @@ do
        -n)     no_update_info=t ;;
        -a)     all_into_one=t ;;
        -A)     all_into_one=t
-               keep_unreachable=--keep-unreachable ;;
+               keep_unreachable=t ;;
        -d)     remove_redundant=t ;;
        -q)     quiet=-q ;;
        -f)     no_reuse=--no-reuse-object ;;
@@ -78,9 +78,6 @@ case ",$all_into_one," in
        if test -z "$args"
        then
                args='--unpacked --incremental'
-       elif test -n "$keep_unreachable"
-       then
-               args="$args $keep_unreachable"
        fi
        ;;
 esac
@@ -116,7 +113,15 @@ for name in $names ; do
                echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
                exit 1
        }
-       rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
+       rm -f "$PACKDIR/old-pack-$name.idx"
+       test -z "$keep_unreachable" ||
+         ! test -f "$PACKDIR/old-pack-$name.pack" ||
+         git unpack-objects < "$PACKDIR/old-pack-$name.pack" || {
+               echo >&2 "Failed unpacking unreachable objects from old pack"
+               echo >&2 "saved as old-pack-$name.pack in $PACKDIR."
+               exit 1
+       }
+       rm -f "$PACKDIR/old-pack-$name.pack"
 done
 
 if test "$remove_redundant" = t
@@ -130,7 +135,18 @@ then
                  do
                        case " $fullbases " in
                        *" $e "*) ;;
-                       *)      rm -f "$e.pack" "$e.idx" "$e.keep" ;;
+                       *)
+                               rm -f "$e.idx" "$e.keep"
+                               if test -n "$keep_unreachable" &&
+                                  test -f "$e.pack"
+                               then
+                                       git unpack-objects < "$e.pack" || {
+                                               echo >&2 "Fail AVOID GMANE WRAP"
+                                               exit 1
+                                       }
+                               fi
+                               rm -f "$e.pack"
+                       ;;
                        esac
                  done
                )


Is the first invocation of unpack-objects necessary? pack-objects has created
a pack which hashes to the same name of a pack we already have, and we replace
the original with the new one. Is that what is happening? They will be identical
right?

Of course this won't set the timestamp on the created objects based on the
timestamp of the pack file, but this was easy. Setting the timestamp would be
proper, but what's another two weeks. Besides, for those users not manually
running git-gc, this code path won't even be executed until there are enough
pack files for git-gc to add -A to the repack options.

Then, for git-gc it should be enough to just always use -A with repack when
manually running it. Then --prune can be deprecated.

-brandon
