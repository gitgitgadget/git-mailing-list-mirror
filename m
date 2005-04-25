From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: git pull issues...
Date: Mon, 25 Apr 2005 23:31:02 +0200
Message-ID: <d4jn91$n4f$1@sea.gmane.org>
References: <118833cc050423142573729ce2@mail.gmail.com>	 <20050423220049.GC13222@pasky.ji.cz> <118833cc05042514076221624d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 25 23:36:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQBFG-0003Hs-U4
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 23:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVDYVjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 17:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVDYVhE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 17:37:04 -0400
Received: from main.gmane.org ([80.91.229.2]:56274 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261225AbVDYVc0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 17:32:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DQB6Q-0002Be-59
	for git@vger.kernel.org; Mon, 25 Apr 2005 23:26:50 +0200
Received: from h65n2fls35o265.telia.com ([217.211.115.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Apr 2005 23:26:50 +0200
Received: from holmsand by h65n2fls35o265.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Apr 2005 23:26:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h65n2fls35o265.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <118833cc05042514076221624d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Morten Welinder wrote:
> On 4/23/05, Petr Baudis <pasky@ucw.cz> wrote:
> 
>>>1. Multiple rsync call might connect to different servers (with
>>>round-robin DNS).  The effect
>>>   will be interesting.  One call, if possible, would be better.
>>
>>If you can do it without overwriting HEAD, please go ahead and send me
>>the patch. :-)
> 
> 
> This ought to work.  It basically saves to a different directory while
> still ignoring
> all the files we have.


I was just looking at the same thing. Not saying this is better, or 
anything, bit it has, perhaps, the slight advantage that downloaded 
objects aren't thrown away, so that a pull can be safely resumed. Also, 
it doesn't download anything from an url that doesn't contain ./HEAD, 
./heads or ./objects. That might be a good thing if you accidentally try 
to pull from, say, kernel.org/pub/...

/dan


Here goes:

Index: gitpull.sh
===================================================================
--- 7de71a831508e51e0985cea173f3f7a7012c82b7/gitpull.sh  (mode:100755 
sha1:6abc7f5c00fd3e082d0a34a238a53b67c38b8a7f)
+++ uncommitted/gitpull.sh  (mode:100755)
@@ -18,7 +18,7 @@
  [ "$name" ] || name=$(cat .git/tracking 2>/dev/null)
  [ "$name" ] || die "where to pull from?"
  uri=$(grep $(echo -e "^$name\t" | sed 's/\./\\./g') .git/remotes | cut 
-f 2)
-[ "$uri" ] || die "unknown remote"
+[ "$uri" ] || die "unknown remote '$name'"

  rembranch=master
  if echo "$uri" | grep -q '#'; then
@@ -38,28 +38,39 @@
  fi


-mkdir -p .git/heads
-rsyncerr=
-rsync $RSYNC_FLAGS -Lr "$uri/heads/$rembranch" ".git/heads/$name" 
2>/dev/null || rsyncerr=1
-if [ "$rsyncerr" ] && [ "$rembranch" = "master" ]; then
-	rsyncerr=
-	rsync $RSYNC_FLAGS -Lr "$uri/HEAD" ".git/heads/$name" | grep -v 
'^MOTD:' || rsyncerr=1
+mkdir -p .git/heads .git/objects .git/tags || die
+pulldir=$(mktemp -td gitpull.XXXXXX)
+[ -d "$pulldir" ] || die "failed to create temp dir"
+ln -s $(pwd)/.git/objects $(pwd)/.git/tags $pulldir || die
+mkdir $pulldir/heads || die
+
+echo pulling $uri
+
+rout=$pulldir/rsync_errors
+rsync $RSYNC_FLAGS -LKrv --whole-file --ignore-existing \
+    --include '/HEAD' --include '/heads/' --include '/tags/' \
+    --include '/objects/' --exclude='/*' \
+    "$uri/." $pulldir 2>$rout || {
+	cat $rout; die "failed to pull from $uri"
+    }
+
+if [ -f "$pulldir/heads/$rembranch" ]; then
+    cp "$pulldir/heads/$rembranch" ".git/heads/$name" || die
+elif [ master = "$rembranch" -a -f $pulldir/HEAD ]; then
+    cp $pulldir/HEAD ".git/heads/$name" || die
+else
+    echo "unable to get the head pointer of branch $rembranch" >&2
+    echo "is $uri a valid git repository?" >&2
+    die "pull failed"
  fi
-[ "$rsyncerr" ] && die "unable to get the head pointer of branch 
$rembranch"

-[ -d .git/objects ] || mkdir -p .git/objects
-# We already saw the MOTD, thank you very much.
-rsync $RSYNC_FLAGS --ignore-existing --whole-file \
-	-v -Lr "$uri/objects/." ".git/objects/." | grep -v '^MOTD:' || die 
"rsync error"
+# TODO: Check that at least the head commit exists.

-# FIXME: Warn about conflicting tag names?
-# XXX: We now throw stderr to /dev/null since not all repositories
-# may have tags/ and users were confused by the harmless errors.
-[ -d .git/tags ] || mkdir -p .git/tags
-rsync $RSYNC_FLAGS --ignore-existing \
-	-v -Lr "$uri/tags/." ".git/tags/." 2>/dev/null | grep -v '^MOTD:' || 
die "rsync error"
+rm -rf $pulldir


+# FIXME: Warn about conflicting tag names?
+
  new_head=$(cat ".git/heads/$name")

  if [ ! "$orig_head" ]; then

