From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH (topgit) 1/2] Implement setup_pager just like in git
Date: Wed, 7 Jan 2009 14:27:54 +0300
Organization: St.Petersburg State University
Message-ID: <20090107112754.GA15158@roro3>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru> <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@suse.cz
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 12:28:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKWZy-0008PC-R0
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 12:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbZAGL0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 06:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZAGL0l
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 06:26:41 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:4111 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZAGL0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 06:26:40 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id D53D717B65E; Wed,  7 Jan 2009 14:26:38 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LKWZm-00059m-IE; Wed, 07 Jan 2009 14:27:54 +0300
Content-Disposition: inline
In-Reply-To: <20090106203203.GA11274@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104787>

Martin, thanks for your review.

I'll too reply inline:

On Tue, Jan 06, 2009 at 09:32:03PM +0100, martin f krafft wrote:
> Thanks, Kirill, for the patches. A couple of comments inline. I hope
> Petr has a chance to look too.
> 
> also sprach Kirill Smelkov <kirr@landau.phys.spbu.ru> [2009.01.06.1616 +0100]:
> > +# isatty FD
> > +isatty()
> > +{
> > +	tty -s 0<&$1 || return 1
> > +	return 0
> > +}
> 
> You don't need any of the return statements. Functions' return
> values are the return values of the last commands they execute.

Agree, I'll rework isatty to be just

isatty()
{
	tty -s 0<&$1
}

> Since we are not using set -e, just "tty -s 0<&$1" in the body will
> have the same effect.

We _are_ using `set -e` in tg.sh:

http://repo.or.cz/w/topgit.git?a=blob;f=tg.sh;h=8c23d26b9a62ddcc1869bb70299862c32edd4403;hb=HEAD#l254

And also I think `tty -s 0<&$1` is a bit obscure, so maybe it is still
better to put it into a function with well-known name such as isatty?

> 
> > +	# TG_PAGER = GIT_PAGER | PAGER
> > +	# http://unix.derkeiler.com/Newsgroups/comp.unix.shell/2004-03/0792.html
> > +	case ${GIT_PAGER+XXX} in
> > +	'')
> > +		case ${PAGER+XXX} in
> > +		'')
> > +			# both GIT_PAGER & PAGER unset
> 
> I find this very confusing. Why not simply
> 
>   TG_PAGER="${GIT_PAGER:-}"
>   TG_PAGER="${TG_PAGER:-$PAGER}"
> 
> ?

I find it confusing too, but this is needed because they usually do
something like this

    $ GIT_PAGER='' <some-git-command>

to force it to be pagerless.

For example in git-rebase.sh:

http://repo.or.cz/w/git.git?a=blob;f=git-rebase.sh;h=ebd4df3a0e821ddcfd1eabfcaac17f854e172a85;hb=HEAD#l415

And other places.


So I think it would be better to preserve the same semantics for `tg
patch` callers, though it's a pity that it's hard (maybe I'm wrong ?) to
see whether an env var is unset.

I'll add additional note about why this is needed.


> 
> > +     [ -z "$TG_PAGER"  -o  "$TG_PAGER" = "cat" ]  && return 0
> 
> What if I set my pager to /bin/cat? But I suppose then there's just
> a wasted FIFO and process, nothing big.

Yes. I'd drop "cat" from here completely, but since I was mimicing
pager.c I left it:

http://repo.or.cz/w/git.git?a=blob;f=pager.c;h=f19ddbc87df04f117cd5e39189c8322fd5f29d68;hb=HEAD#l55

I'm ok with dropping cat. Should we?

> > +	_pager_fifo="$(mktemp -t tg-pager-fifo.XXXXXX)"
> > +	rm "$_pager_fifo" && mkfifo -m 600 "$_pager_fifo"
> 
> There's a race condition here. I can't see a real problem with it,
> though, nor do I know of a better way.

Yes I know and agree here is a race.

But netheir did I knew how to overcome this (I though we'll need mkfifo
to support creating fifos with temp names, but mkfifo lacks support for
this)

The real problem here is that in bash, it's hard to get such constructs
going without fifos at all -- just using pipes like we would do in C,
because:

    exec >file

redirects the rest of current process output to file, but

    exec |less

does _not_ redirect the rest of the current process output through pipe
to less.

Likewise

    exec > >(less)

works (process redirection), but is a bashishm, so = not an option for
us.

Fortunately Adeodato suggested to use `mktemp -d`, so this is reworked
to:

    _pager_fifo_dir="$(mktemp -t -d tg-pager-fifo.XXXXXX)"
    _pager_fifo="$_pager_fifo_dir/0"
    mkfifo -m 600 "$_pager_fifo"

+ appopriate cleanup.

> > +	"$TG_PAGER" < "$_pager_fifo" &
> > +	exec > "$_pager_fifo"		# dup2(pager_fifo.in, 1)
> > +
> > +	# this is needed so e.g. `git diff` will still colorize it's output if
> > +	# requested in ~/.gitconfig with color.diff=auto
> > +	export GIT_PAGER_IN_USE=1
> > +
> > +	# atexit(close(1); wait pager)
> > +	trap "exec >&-; rm $_pager_fifo; wait" EXIT
> 
> Consistency: $_pager_fifo is not passed as a quoted string to rm
> here. In the unlikely event that $TMPDIR contains a space, this
> would fail.

Thanks, corrected.

> I definitely want Petr's opinion on this before I integrate it.

Ok, let's wait what Petr says. Here is improved patch:

Changes since v1:

 o isatty() simplified
 o added a note about different meaning of GIT_PAGER='' and unset
   GIT_PAGER
 o fixed race wrt to mkfifo creation
 o fixed potential whitespace problem in "$_pager_fifo" cleanup


(interdiff)

diff --git a/tg.sh b/tg.sh
index 51a82af..bf9cf5c 100644
--- a/tg.sh
+++ b/tg.sh
@@ -248,8 +248,7 @@ do_help()
 # isatty FD
 isatty()
 {
-	tty -s 0<&$1 || return 1
-	return 0
+	tty -s 0<&$1
 }
 
 # setup_pager
@@ -259,6 +258,7 @@ setup_pager()
 	isatty 1 || return 0
 
 	# TG_PAGER = GIT_PAGER | PAGER
+	# (but differentiate between GIT_PAGER='' and unset variables)
 	# http://unix.derkeiler.com/Newsgroups/comp.unix.shell/2004-03/0792.html
 	case ${GIT_PAGER+XXX} in
 	'')
@@ -283,8 +283,9 @@ setup_pager()
 	# now spawn pager
 	export LESS=${LESS:-FRSX}	# as in pager.c:pager_preexec()
 
-	_pager_fifo="$(mktemp -t tg-pager-fifo.XXXXXX)"
-	rm "$_pager_fifo" && mkfifo -m 600 "$_pager_fifo"
+	_pager_fifo_dir="$(mktemp -t -d tg-pager-fifo.XXXXXX)"
+	_pager_fifo="$_pager_fifo_dir/0"
+	mkfifo -m 600 "$_pager_fifo"
 
 	"$TG_PAGER" < "$_pager_fifo" &
 	exec > "$_pager_fifo"		# dup2(pager_fifo.in, 1)
@@ -294,7 +295,7 @@ setup_pager()
 	export GIT_PAGER_IN_USE=1
 
 	# atexit(close(1); wait pager)
-	trap "exec >&-; rm $_pager_fifo; wait" EXIT
+	trap "exec >&-; rm "$_pager_fifo"; rmdir "$_pager_fifo_dir"; wait" EXIT
 }
 
 ## Startup


>From 2193b7c703c2d31c8739eec617b8c0e8c1d09b79 Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Date: Tue, 6 Jan 2009 17:56:37 +0300
Subject: [PATCH (topgit) v2] Implement setup_pager just like in git

setup_pager() spawns a pager process and redirect the rest of our output
to it.

This will be needed to fix `tg patch` output in the next commit.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 tg.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/tg.sh b/tg.sh
index 8c23d26..bf9cf5c 100644
--- a/tg.sh
+++ b/tg.sh
@@ -243,6 +243,60 @@ do_help()
 	fi
 }
 
+## Pager stuff
+
+# isatty FD
+isatty()
+{
+	tty -s 0<&$1
+}
+
+# setup_pager
+# Spawn pager process and redirect the rest of our output to it
+setup_pager()
+{
+	isatty 1 || return 0
+
+	# TG_PAGER = GIT_PAGER | PAGER
+	# (but differentiate between GIT_PAGER='' and unset variables)
+	# http://unix.derkeiler.com/Newsgroups/comp.unix.shell/2004-03/0792.html
+	case ${GIT_PAGER+XXX} in
+	'')
+		case ${PAGER+XXX} in
+		'')
+			# both GIT_PAGER & PAGER unset
+			TG_PAGER=''
+			;;
+		*)
+			TG_PAGER="$PAGER"
+			;;
+		esac
+		;;
+	*)
+		TG_PAGER="$GIT_PAGER"
+		;;
+	esac
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
+	trap "exec >&-; rm "$_pager_fifo"; rmdir "$_pager_fifo_dir"; wait" EXIT
+}
 
 ## Startup
 
-- 
1.6.1.48.ge9b8



Thanks,
Kirill
