From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [RFC] Introduce Git.pm
Date: Wed, 21 Jun 2006 18:03:02 -0700
Message-ID: <7v64iuxard.fsf@assigned-by-dhcp.cox.net>
References: <20060622003546.17760.23089.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 03:03:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtDbA-0005pw-ED
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 03:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWFVBDF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 21:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWFVBDE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 21:03:04 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:12431 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030475AbWFVBDD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 21:03:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622010302.ZRCI12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 21:03:02 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060622003546.17760.23089.stgit@machine.or.cz> (Petr Baudis's
	message of "Thu, 22 Jun 2006 02:35:46 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22293>

Petr Baudis <pasky@suse.cz> writes:

> Currently Git.pm just wraps up exec()s of Git commands, but even that
> is not trivial to get right and various Git perl scripts do it in
> various inconsistent ways. And things will get much more interesting
> when we get to XS-izing libgit.

We would probably need some moderate to major surgery before
doing that depending on which parts.  Worrisome are object layer
that holds onto parsed objects and keeps flag bits from the
previous runs, and lockfile that are cleaned up via atexit() --
there may be others.

> @@ -618,6 +622,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
>  	@FLAGS='$(TRACK_CFLAGS)'; \
>  	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
>  		echo 1>&2 "    * new build flags or prefix"; \
> +		echo 1>&2 "    * $$FLAGS != `cat GIT-CFLAGS 2>/dev/null`"; \
>  		echo "$$FLAGS" >GIT-CFLAGS; \
>              fi
>  

Offtopic; do people mind if we drop $GIT_VERSION from
TRACK_CFLAGS?  Every time I switch branches or make a new commit
it ends up rebuilding everything needlessly.

>  sub current_branch {
> -	my ($bra) = qx{git-symbolic-ref HEAD};
> +	my ($bra) = $repo->generic_oneline('symbolic-ref', 'HEAD');
>  	chomp($bra);
>  	$bra =~ s|^refs/heads/||;
>  	if ($bra ne 'master') {

Your *_oneline chomps so chomp($bra) is not needed anymore, I think.

In any case, this is an excellent move to clean things up.
Various implementations of qx{} will be all in one place so
ActiveState folks would have easier time adjusting things to
their environment.

> +require Exporter;

Not "use"?

> +# Methods which can be called as standalone functions as well:
> +@EXPORT_OK = qw(generic generic_oneval generic_vocal);

I am not sure generic_xxx is a good name.  Perhaps command_xxx?

Also as you say in the comment, "vocal" sounds a bit funny.
I wonder if we can use wantarray to detect the case where the
caller wants _no_ value, and do the "not piping" optimization in
that case.
