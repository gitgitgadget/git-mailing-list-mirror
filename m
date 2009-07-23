From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Thu, 23 Jul 2009 10:41:31 +0200
Message-ID: <200907231041.32567.trast@student.ethz.ch>
References: <20090723074104.GI4750@laphroaig.corp>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 10:42:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTtsg-0006iY-8K
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 10:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbZGWIlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 04:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbZGWIlm
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 04:41:42 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:34844 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424AbZGWIlk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 04:41:40 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Jul 2009 10:41:38 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Jul 2009 10:41:38 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.23-0.1-default; KDE/4.2.96; x86_64; ; )
In-Reply-To: <20090723074104.GI4750@laphroaig.corp>
X-OriginalArrivalTime: 23 Jul 2009 08:41:38.0420 (UTC) FILETIME=[64D26340:01CA0B71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123859>

Pierre Habouzit wrote:
> One of my most frequent use case for git-add -p is when I had an intense
> debug session with quite a lot of debug() traces added. I then want only
> to select the hunks corresponding to the bugfixes and throw away the debug
> ones.
> 
> With this new operation, instead of not staging hunks I don't want and
> will eventually undo, I can just undo them.

This is what 'git checkout --interactive -- $file' or 'git reset
--interactive --hard' would accomplish, if they existed.  I wonder if
there would be a way to avoid yet more command letters, and instead
have "modes" that affect what happens with hunks you said 'y' to.  For
example:

  add -p		apply --cached
  undo -p		apply -R
  unstage -p		apply -R --cached
    [with hunks coming from diff --cached obviously]

(I picked 'undo' and 'unstage' semi-randomly, but it's not, after all,
an 'add' operation any more and the user doesn't need to know that the
program doing this is in fact git-add--interactive.)

> +       u - do not stage this hunk and revert it

you're overloading terminology a bit too much for my taste.  It has
nothing to do with what git-revert does, and we shouldn't confuse
people more about that.

>  Documentation/git-add.txt |    1 +
>  git-add--interactive.perl |   38 ++++++++++++++++++++++++++++++--------

Tests?

> @@ -693,6 +693,7 @@ sub split_hunk {
>  			ADDDEL => 0,
>  			POSTCTX => 0,
>  			USE => undef,
> +			UNDO => undef,
>  		};

Why not fold this into a single field?  It could, say, take values 0,
1, or '-R'.  It could probably be renamed to ACTION, but USE would be
fine if you want to avoid the code churn.  Then you shouldn't need
_completely_ separate handling during application.

> @@ -1149,6 +1152,10 @@ sub patch_update_file {
>  			elsif ($line =~ /^n/i) {
>  				$hunk[$ix]{USE} = 0;

+				$hunk[$ix]{UNDO} = 0;

and similarly for [yad] too, on the grounds that the user can go back
and change his choices with [KJ].  Of course that is not necessary if
you go the ACTION way outlined above.

> +	if (@undo) {
> +		my $fh;
> +
> +		open $fh, '| git apply -R';

This probably needs a --recount to cope with the case where the hunk
headers became stale/invalid through user [e]diting.

> +		for (@{$head->{TEXT}}, @undo) {
> +			print $fh $_;
> +		}
> +		if (!close $fh) {
> +			for (@{$head->{TEXT}}, @undo) {
> +				print STDERR $_;
> +			}
> +		}
> +		refresh();
> +	}

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
