From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] git-p4 tests: refactor, split out common functions
Date: Sun, 18 Sep 2011 14:48:43 -0700
Message-ID: <7v7h55cyis.fsf@alter.siamese.dyndns.org>
References: <20110918012634.GA4578@arf.padd.com>
 <20110918012713.GA4619@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:49:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5PEV-0004UU-05
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649Ab1IRVst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 17:48:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932255Ab1IRVss (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 17:48:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12E6D42A0;
	Sun, 18 Sep 2011 17:48:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tjy5rMRRySESt+UhP/EoWSk/JBA=; b=i1cCit
	DWrZqxIEpUfUqjOvWJUmWQRsuhlm/omK6MC/Zqdw7QjK1y8cX/W4dEdpq5/q4h8F
	9OEliIfL3cJHH08Fi0hNLIEWD+tyY2/h6ZRTCS8sKp3lK4u89Tb8wTnp0O3TlFDi
	PoLh3+422+0NPQAGtjLxR/8Jj0BGADyNg1Oi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mMMDdsrRFEWj3RjiuzmEQmQUAnjq7X69
	zvTWMLSehLo4YGBu0pPFXEbxM+cIxuqqTaqochHZd9goDdVvoPAHgACD2681npUt
	EVbeJW++xGG2G6dCBNewfVUfsoZbGAJajxoGUCljvBnMaP86XimOFmpqvvxJZG31
	RDH49yqcHyo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A086429F;
	Sun, 18 Sep 2011 17:48:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36FF0429E; Sun, 18 Sep 2011
 17:48:45 -0400 (EDT)
In-Reply-To: <20110918012713.GA4619@arf.padd.com> (Pete Wyckoff's message of
 "Sat, 17 Sep 2011 21:27:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB8ED564-E23F-11E0-BEDB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181648>

Pete Wyckoff <pw@padd.com> writes:

> Introduce a library for functions that are common to
> multiple git-p4 test files.
>
> Separate the tests related to detecting p4 branches
> into their own file, and add a few more.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>  t/lib-git-p4.sh          |   55 ++++++++++++
>  t/t9800-git-p4.sh        |  108 ++---------------------
>  t/t9801-git-p4-branch.sh |  221 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 283 insertions(+), 101 deletions(-)
>  create mode 100644 t/lib-git-p4.sh
>  create mode 100755 t/t9801-git-p4-branch.sh

I take that you meant "coding style" by "generic test beauty" in the cover
letter, so here are some minor nitpicks.

> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> new file mode 100644
> index 0000000..dbc1499
> --- /dev/null
> +++ b/t/lib-git-p4.sh
> @@ -0,0 +1,55 @@
> +#
> +# Library code for git-p4 tests
> +#
> +
> +. ./test-lib.sh
> +
> +( p4 -h && p4d -h ) >/dev/null 2>&1 || {
> +	skip_all='skipping git-p4 tests; no p4 or p4d'
> +	test_done
> +}
> +
> +GITP4=$GIT_BUILD_DIR/contrib/fast-import/git-p4
> +P4DPORT=10669

What happens when tests are run in parallel (make -j or prove --jobs) and
9800 and 9801 are run at the same time?

> +export P4PORT=localhost:$P4DPORT
> +export P4CLIENT=client
> +
> +db="$TRASH_DIRECTORY/db"
> +cli="$TRASH_DIRECTORY/cli"
> +git="$TRASH_DIRECTORY/git"
> +
> +start_p4d()
> +{

Prevalent style in t/ and scripted part of Git in general is to begin a
shell function like this, with SP on both sides of () and opening brace
on the same line.

	start_p4d () {

> +	mkdir -p "$db" &&
> +	p4d -q -d -r "$db" -p $P4DPORT &&
> +	mkdir -p "$cli" &&
> +	mkdir -p "$git" &&
> +	cd "$cli" &&
> +	p4 client -i <<-EOF
> +	Client: client
> +	Description: client
> +	Root: $cli
> +	View: //depot/... //client/...
> +	EOF
> +}
> +
> +kill_p4d()
> +{
> +	pid=`pgrep -f p4d` &&
> +	test -n "$pid" &&

It is unfortunate that you have to use pgrep. I am unfamiliar with p4, but
do you have any control how p4d is started during this test? If the first
use of client automagically starts p4d without your control, that would be
harder to arrange, but the point I am getting at is that if you know when
you start p4d yourself and that is the only p4d process you use, you
should be keep its pid in $TRASH_DIRECTORY somewhere and replace these
with

	pid=$(cat "$TRASH_DIRECTORY/p4d_pid") &&
        kill -0 "$pid"

to see if that daemon is still alive. 

You call kill_p4d at the very beginning of t9800; what instance of p4d are
you trying to kill? Who could have started it? For you to be able to kill
(and nobody sane would be running the test suite as "root", I hope), it
would be your process, but would it be possible that you are doing some
other important thing using p4 that is not related to git-p4 development
or testing at all, perhaps listening to a port different from 10669? Would
it be necessary to kill that other p4d to run these tests in a predicatable
and reproducible environment?

I would very much more prefer if at the very beginning you started p4d at
the port assigned for the test and fail the test if it cannot start for
whatever reason. Perhaps the reason you cannot start a p4d is because a
stale p4d instance is hanging around from previous round of test, and if
that is the case, then that is the bug we need to fix in the _previous_
test, not something we want to sweep under the rug by killing it during
this round of test.

> +	for i in {1..5} ; do

That {1..5} does not pass POSIX shells, such as /bin/dash.

	for i in 1 2 3 4 5
	do
		...

> +	    test_debug "ps wl `echo $pid`" &&
> +	    kill $pid 2>/dev/null &&
> +	    pgrep -f p4d >/dev/null || break &&

You are saying "all of these things would hold true if we attempt to kill
it and it still is alive" with the chain of "&&" up to that last pgrep,
and then with "||", you say "otherwise we do not have to keep sending the
signal to it anymore". But the extra "&&" after "break" is unneeded and
misleading.

> +	    sleep 0.2

That 0.2 does not look like a non-negative decimal interger like POSIX
wants to have.

> +	done &&
> +	rm -rf "$db" &&
> +	rm -rf "$cli"
> +}
> +
> +cleanup_git() {
> +	cd "$TRASH_DIRECTORY" &&
> +	rm -rf "$git" &&
> +	mkdir "$git"
> +}
> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> index 01ba041..bb89b63 100755
> --- a/t/t9800-git-p4.sh
> +++ b/t/t9800-git-p4.sh
> @@ -2,40 +2,16 @@
>  
>  test_description='git-p4 tests'
>  
> -. ./test-lib.sh
> +. ./lib-git-p4.sh
>  
> +test_expect_success 'start p4d' '
> +	kill_p4d || : &&
> +	start_p4d &&
> +	cd "$TRASH_DIRECTORY"
>  '

Don't "chdir" around in the test, and worse yet hide some "cd" in helper
functions. The seemingly unnecessary "cd $TRASH_DIRECTORY" at the end,
which may not even happen if start_p4d fails, is because start_p4d has a
hidden "cd" somewhere (which in turn may or may not run depending on where
in the && chain you have a failure).

One way to keep the test cleaner is to do the helper functions like the
following, so that the callers do not have to worry about where they end
up with:

	start_p4d () {
		mkdir -p "$db" "$cli" "$git" &&
                p4d -q -d -r "$db" -p "$P4DPORT" &&
		(
			cd "$cli" &&
			p4 client -i <<-EOF
			...
			EOF
		)
	}

>  test_expect_success 'add p4 files' '
>  	cd "$cli" &&
>  	echo file1 >file1 &&
>  	p4 add file1 &&
>  	p4 submit -d "file1" &&
>  ...
>  	cd "$TRASH_DIRECTORY"
>  '

The same issue here.

	test_expect_success 'add p4 files' '
		(
			cd "$cli" &&
			echo file1 >file1 &&
			...
		)
	'
