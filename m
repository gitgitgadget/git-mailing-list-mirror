From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH (topgit) 1/2] Implement setup_pager just like in git
Date: Thu, 8 Jan 2009 01:00:27 +0300
Organization: St.Petersburg State University
Message-ID: <20090107220027.GA4946@roro3>
References: <20090107144432.GC831@artemis.corp> <cover.1231254832.git.kirr@landau.phys.spbu.ru> <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net> <20090107112754.GA15158@roro3> <36ca99e90901070624p2c102f3ey392ef813db9f9187@mail.gmail.com> <cover.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net> <20090107112754.GA15158@roro3> <200901071324.57222.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jan 07 23:00:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKgSE-0008AQ-An
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 23:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbZAGV7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 16:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbZAGV7R
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 16:59:17 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1316 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbZAGV7P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 16:59:15 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 1AD0317B65E; Thu,  8 Jan 2009 00:59:12 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LKgRv-0002Mv-Up; Thu, 08 Jan 2009 01:00:27 +0300
Content-Disposition: inline
In-Reply-To: <20090107151000.GR12275@machine.or.cz> <20090107144432.GC831@artemis.corp> <36ca99e90901070624p2c102f3ey392ef813db9f9187@mail.gmail.com> <200901071324.57222.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104837>

On Wed, Jan 07, 2009 at 01:24:44PM +0100, Thomas Rast wrote:
> Kirill Smelkov wrote:
> > On Tue, Jan 06, 2009 at 09:32:03PM +0100, martin f krafft wrote:
> > > I find this very confusing. Why not simply
> > > 
> > >   TG_PAGER="${GIT_PAGER:-}"
> > >   TG_PAGER="${TG_PAGER:-$PAGER}"
> > > 
> > > ?
> > 
> > I find it confusing too, but this is needed because they usually do
> > something like this
> > 
> >     $ GIT_PAGER='' <some-git-command>
> > 
> > to force it to be pagerless.
> [...]
> > So I think it would be better to preserve the same semantics for `tg
> > patch` callers, though it's a pity that it's hard (maybe I'm wrong ?) to
> > see whether an env var is unset.
> 
> Admittedly I haven't really studied your patch, but the ${} constructs
> can in fact tell empty from unset:
> 
>   $ EMPTY=
>   $ unset UNDEFINED
>   $ echo ${UNDEFINED-foo}
>   foo
>   $ echo ${UNDEFINED:-foo}
>   foo
>   $ echo ${EMPTY-foo}
> 
>   $ echo ${EMPTY:-foo}
>   foo
> 
> 'man bash' indeed says
> 
>   When not performing substring expansion, bash tests for a parameter
>   that is unset or null; omitting the colon results in a test only for
>   a parameter that is unset.
> 
> So I suppose you could use
> 
>   ${GIT_PAGER-${PAGER-less}}
> 
> or similar.

Good eyes, thanks!

I'll rework it.


On Wed, Jan 07, 2009 at 03:24:02PM +0100, Bert Wesarg wrote:
> On Wed, Jan 7, 2009 at 12:27, Kirill Smelkov <kirr@landau.phys.spbu.ru> wrote:
> > Martin, thanks for your review.
> > +       # atexit(close(1); wait pager)
> > +       trap "exec >&-; rm "$_pager_fifo"; rmdir "$_pager_fifo_dir"; wait" EXIT
> I think you need to escape the double quotes.

Good eyes -- corrected and thanks!


On Wed, Jan 07, 2009 at 04:10:00PM +0100, Petr Baudis wrote:
> On Wed, Jan 07, 2009 at 02:27:54PM +0300, Kirill Smelkov wrote:
> > >From 2193b7c703c2d31c8739eec617b8c0e8c1d09b79 Mon Sep 17 00:00:00 2001
> > From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> > Date: Tue, 6 Jan 2009 17:56:37 +0300
> > Subject: [PATCH (topgit) v2] Implement setup_pager just like in git
> > 
> > setup_pager() spawns a pager process and redirect the rest of our output
> > to it.
> > 
> > This will be needed to fix `tg patch` output in the next commit.
> > 
> > Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> 
> But you never use it...?

What do you mean?

It is used in the next patch as posted in original series:

http://marc.info/?l=git&m=123125495000600&w=2

For completeness, I'll include both patches in this email.

> > ---
> >  tg.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 54 insertions(+), 0 deletions(-)
> > 
> > diff --git a/tg.sh b/tg.sh
> > index 8c23d26..bf9cf5c 100644
> > --- a/tg.sh
> > +++ b/tg.sh
> > @@ -243,6 +243,60 @@ do_help()
> >  	fi
> >  }
> >  
> > +## Pager stuff
> > +
> > +# isatty FD
> > +isatty()
> > +{
> > +	tty -s 0<&$1
> > +}
> > +
> > +# setup_pager
> > +# Spawn pager process and redirect the rest of our output to it
> > +setup_pager()
> > +{
> > +	isatty 1 || return 0
> > +
> > +	# TG_PAGER = GIT_PAGER | PAGER
> > +	# (but differentiate between GIT_PAGER='' and unset variables)
> > +	# http://unix.derkeiler.com/Newsgroups/comp.unix.shell/2004-03/0792.html
> > +	case ${GIT_PAGER+XXX} in
> > +	'')
> > +		case ${PAGER+XXX} in
> > +		'')
> 
> I'm pretty sure there's been a nice trick for this, but I can't remember
> it at all now.

Already corrected to ${GIT_PAGER-${PAGER-less}}, thanks to Thomas.

> > +			# both GIT_PAGER & PAGER unset
> > +			TG_PAGER=''
> > +			;;
> > +		*)
> > +			TG_PAGER="$PAGER"
> > +			;;
> > +		esac
> > +		;;
> > +	*)
> > +		TG_PAGER="$GIT_PAGER"
> > +		;;
> > +	esac
> > +
> > +	[ -z "$TG_PAGER"  -o  "$TG_PAGER" = "cat" ]  && return 0
> > +
> > +
> > +	# now spawn pager
> > +	export LESS=${LESS:-FRSX}	# as in pager.c:pager_preexec()
> > +
> > +	_pager_fifo_dir="$(mktemp -t -d tg-pager-fifo.XXXXXX)"
> > +	_pager_fifo="$_pager_fifo_dir/0"
> > +	mkfifo -m 600 "$_pager_fifo"
> > +
> > +	"$TG_PAGER" < "$_pager_fifo" &
> > +	exec > "$_pager_fifo"		# dup2(pager_fifo.in, 1)
> > +
> > +	# this is needed so e.g. `git diff` will still colorize it's output if
> > +	# requested in ~/.gitconfig with color.diff=auto
> > +	export GIT_PAGER_IN_USE=1
> > +
> > +	# atexit(close(1); wait pager)
> > +	trap "exec >&-; rm "$_pager_fifo"; rmdir "$_pager_fifo_dir"; wait" EXIT
> > +}
> 
> Frankly, I would have been just much happier if something like git
> pager--helper would be provided for external tools to use. Seeing how it
> gets reimplemented like this just pains me greatly.

After we settle on implementation, would it make sense to include this
setup_pager into git-sh-setup?

I propose we include this stuff into tg.sh first, so that topgit would
work correctly with previous versions of git.

> On Wed, Jan 07, 2009 at 03:44:32PM +0100, Pierre Habouzit wrote:
> > On Wed, Jan 07, 2009 at 11:27:54AM +0000, Kirill Smelkov wrote:
> > > isatty()
> > > {
> > > 	tty -s 0<&$1
> > > }
> > 
> > why not test -t 0 ? I'm not sure it's POSIX though.
> 
> It's SUS for many issues already it seems.

Pierre and Petr - thanks for the info. Yes, `test -t $fd` looks better.


Here is improved patch:

Changes since v1:

 o Simplify TG_PAGER setup  (thanks to Thomas Rast)
 o Properly escape "        (thanks to Bert Wesarg)
 o Simpler isatty           (thanks to Pierre Habouzit & Petr Baudis)


(interdiff)

diff --git a/tg.sh b/tg.sh
index bf9cf5c..b64fc3a 100644
--- a/tg.sh
+++ b/tg.sh
@@ -248,7 +248,7 @@ do_help()
 # isatty FD
 isatty()
 {
-	tty -s 0<&$1
+	test -t $1
 }
 
 # setup_pager
@@ -257,25 +257,9 @@ setup_pager()
 {
 	isatty 1 || return 0
 
-	# TG_PAGER = GIT_PAGER | PAGER
-	# (but differentiate between GIT_PAGER='' and unset variables)
-	# http://unix.derkeiler.com/Newsgroups/comp.unix.shell/2004-03/0792.html
-	case ${GIT_PAGER+XXX} in
-	'')
-		case ${PAGER+XXX} in
-		'')
-			# both GIT_PAGER & PAGER unset
-			TG_PAGER=''
-			;;
-		*)
-			TG_PAGER="$PAGER"
-			;;
-		esac
-		;;
-	*)
-		TG_PAGER="$GIT_PAGER"
-		;;
-	esac
+	# TG_PAGER = GIT_PAGER | PAGER | less
+	# NOTE: GIT_PAGER='' is significant
+	TG_PAGER=${GIT_PAGER-${PAGER-less}}
 
 	[ -z "$TG_PAGER"  -o  "$TG_PAGER" = "cat" ]  && return 0
 
@@ -295,7 +279,7 @@ setup_pager()
 	export GIT_PAGER_IN_USE=1
 
 	# atexit(close(1); wait pager)
-	trap "exec >&-; rm "$_pager_fifo"; rmdir "$_pager_fifo_dir"; wait" EXIT
+	trap "exec >&-; rm \"$_pager_fifo\"; rmdir \"$_pager_fifo_dir\"; wait" EXIT
 }
 
 ## Startup


From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Petr Baudis <pasky@suse.cz>
Cc: Git Mailing List <git@vger.kernel.org>
Bcc: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Implement setup_pager just like in git

setup_pager() spawns a pager process and redirect the rest of our output
to it.

This will be needed to fix `tg patch` output in the next commit.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>

---
 tg.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/tg.sh b/tg.sh
index 8c23d26..b64fc3a 100644
--- a/tg.sh
+++ b/tg.sh
@@ -243,6 +243,44 @@ do_help()
 	fi
 }
 
+## Pager stuff
+
+# isatty FD
+isatty()
+{
+	test -t $1
+}
+
+# setup_pager
+# Spawn pager process and redirect the rest of our output to it
+setup_pager()
+{
+	isatty 1 || return 0
+
+	# TG_PAGER = GIT_PAGER | PAGER | less
+	# NOTE: GIT_PAGER='' is significant
+	TG_PAGER=${GIT_PAGER-${PAGER-less}}
+
+	[ -z "$TG_PAGER"  -o  "$TG_PAGER" = "cat" ]  && return 0
+
+
+	# now spawn pager
+	export LESS=${LESS:-FRSX}	# as in pager.c:pager_preexec()
+
+	_pager_fifo_dir="$(mktemp -t -d tg-pager-fifo.XXXXXX)"
+	_pager_fifo="$_pager_fifo_dir/0"
+	mkfifo -m 600 "$_pager_fifo"
+
+	"$TG_PAGER" < "$_pager_fifo" &
+	exec > "$_pager_fifo"		# dup2(pager_fifo.in, 1)
+
+	# this is needed so e.g. `git diff` will still colorize it's output if
+	# requested in ~/.gitconfig with color.diff=auto
+	export GIT_PAGER_IN_USE=1
+
+	# atexit(close(1); wait pager)
+	trap "exec >&-; rm \"$_pager_fifo\"; rmdir \"$_pager_fifo_dir\"; wait" EXIT
+}
 
 ## Startup
 
-- 
tg: (8c77c34..) t/setup-pager (depends on: master)


Second patch which uses setup_pager:


>From 1b723ebf740c58bc25ac97eff0a31b07373d8d1e Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Date: Tue, 6 Jan 2009 18:03:21 +0300
Subject: [TopGit PATCH] tg-patch: fix pagination

Previously, when I was invoking `tg patch` the following used to happen:

1. .topmsg content was sent directly to _terminal_
2. for each file in the patch, its diff was generated with `git diff`
   and sent to *PAGER*
3. trailing 'tg: ...' was sent to terminal again

So the problem is that while `tg patch >file` works as expected, plain
`tg patch` does not -- in pager there is only a part of the whole patch
(first file diff) and header and trailer are ommitted.

I've finally decided to fix this inconvenience, and the way it works is
like in git -- we just hook `setup_pager` function in commands which
need to be paginated.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 tg-patch.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index a704375..dc699d2 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -24,6 +24,9 @@ done
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit-controlled branch"
 
+
+setup_pager
+
 git cat-file blob "$name:.topmsg"
 echo
 [ -n "$(git grep '^[-]--' "$name" -- ".topmsg")" ] || echo '---'
-- 
1.6.1.48.ge9b8


Thanks,
Kirill
