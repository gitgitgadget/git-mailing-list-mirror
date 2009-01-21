From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add valgrind support in test scripts
Date: Tue, 20 Jan 2009 19:12:19 -0500
Message-ID: <20090121001219.GA18169@coredump.intra.peff.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:13:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPQj3-0005VT-7a
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 01:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757312AbZAUAMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 19:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757135AbZAUAMV
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 19:12:21 -0500
Received: from peff.net ([208.65.91.99]:53969 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756371AbZAUAMV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 19:12:21 -0500
Received: (qmail 5569 invoked by uid 107); 21 Jan 2009 00:12:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Jan 2009 19:12:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2009 19:12:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106545>

On Tue, Jan 20, 2009 at 04:04:28PM +0100, Johannes Schindelin wrote:

> +else
> +	# override all git executables in PATH and TEST_DIRECTORY/..
> +	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
> +	mkdir -p "$GIT_VALGRIND"

Isn't this mkdir unnecessary, since it is actually part of the
repository (i.e., there is a gitignore there already).

However, I think it makes more sense to put the symlink cruft into
"$GIT_VALGRIND/bin". That way you can clean up the cruft very easily. In
which case you do need to "mkdir" that directory.

> +	OLDIFS=$IFS
> +	IFS=:
> +	for path in $PATH:$TEST_DIRECTORY/..
> +	do
> +		ls "$TEST_DIRECTORY"/../git "$path"/git-* 2> /dev/null |

Why aren't these both "$path"/ ?

But more importantly, do we really need to bother overriding the whole
$PATH? In theory, we aren't calling anything git-* that isn't in
"$TEST_DIRECTORY/..". And while it might be nice to catch it if we do,
it seems like detecting that is totally orthogonal to running valgrind,
and we get different behavior from valgrind versus not. And I think the
two should be as similar as possible (with the obvious except of
actually, you know, running valgrind).

> +			base=$(basename "$file")
> +			test ! -h "$GIT_VALGRIND"/"$base" || continue
> +
> +			if test "#!" = "$(head -c 2 < "$file")"
> +			then
> +				# do not override scripts
> +				ln -s ../../"$base" "$GIT_VALGRIND"/"$base"
> +			else
> +				ln -s valgrind.sh "$GIT_VALGRIND"/"$base"
> +			fi

It would be nice to actually detect errors. But you have to
differentiate between EEXIST and other errors, which is a pain. And you
can't use "ln -sf" because it isn't atomic.

Copying would solve that (provided you copied to a tempfile and did
an atomic rename). Or writing this snippet as a C helper.

> --- /dev/null
> +++ b/t/valgrind/valgrind.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +
> +base=$(basename "$0")
> +
> +exec valgrind -q --error-exitcode=126 \
> +	--leak-check=no \
> +	--suppressions="$GIT_VALGRIND/default.supp" \
> +	--gen-suppressions=all \
> +	--log-fd=4 \
> +	--input-fd=4 \
> +	$GIT_VALGRIND_OPTIONS \
> +	"$GIT_VALGRIND"/../../"$base" "$@"

Hm. My version had to do some magic with the GIT_EXEC_PATH, but I think
that is because I didn't set GIT_EXEC_PATH in the first place. If yours
works (and I haven't really tested it -- I remember it being a real pain
in the butt to make sure valgrind was getting called from every code
path), then I like your approach much better.

-Peff
