From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: Skip unknown "extra arg" information
Date: Thu, 04 Jun 2009 17:50:07 -0700
Message-ID: <7vbpp3tsg0.fsf@alter.siamese.dyndns.org>
References: <20090604220824.GT3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 02:50:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCNdQ-0007os-5q
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 02:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbZFEAuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 20:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZFEAuH
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 20:50:07 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34948 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbZFEAuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 20:50:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090605005007.RGOD17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 4 Jun 2009 20:50:07 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 00q71c00A4aMwMQ030q728; Thu, 04 Jun 2009 20:50:07 -0400
X-VR-Score: -300.00
X-Authority-Analysis: v=1.0 c=1 a=86Vp4Fqyi4EA:10 a=0a0hY8H0wKQA:10
 a=oAYF_C9AAAAA:8 a=iKYaXlt2pSHn4UarqeMA:9 a=92yVUlQQKQfs69XX_ucA:7
 a=MjeGVzFW3kf5Eh09kJt0COeXVkAA:4 a=R0wQ3QzoQ0IA:10
X-CM-Score: 0.00
In-Reply-To: <20090604220824.GT3355@spearce.org> (Shawn O. Pearce's message of "Thu\, 4 Jun 2009 15\:08\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120731>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If we don't recognize an extra arg supplied hidden behind the
> command, we should skip it and look at the next extra arg, in
> case we recognize the next one.
>
> For example, we currently don't recognize the "user=" extra arg,
> but we should still be able to start this connection anyway:

I do not necessarily agree 100% with that argument.

When there is a room for "protocol negotiation", it is clear that somebody
asking for what we said we do not support is bogus, and we should reject.

Unfortunately, there is no room in the protocol for git-daemon to announce
its capabilities, so the initial exchange can only be "unilaterally ask
and hope for the best" from the client's point of view.

However, in such a protocol exchange, there should be a way for a client
to say "if you do not understand this request, it is _NOT_ OK to continue,
pretending as if I never asked for it; instead please disconnect to avoid
doing any further harm".

We do something similar in the index extension.  In that area, obviously
there is no way for the writer who writes the index file to negotiate with
the reader who will later read from the index to know what the reader can
understand.  Extension sections are marked with section names, whose case
allows the reader to tell if it is Ok to simply ignore the section, or
understanding of the section contents is required for the proper operation
by the reader.  Perhaps we should be doing something similar.

>  perl -e '
>    $s="git-upload-pack /.git\0user=me\0host=localhost\0";
>    printf "%4.4x%s",4+length $s,$s
>  ' | ./git-daemon --inetd --base-path=`pwd` --export-all
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>
>  This should go in maint.

In its current form, I do not think so.  Rejecting unknown is safer and
maint is about safety, not about feature.  Setting a precedent to accept
anything unknown will make it harder to later say "the server must
understand extension tokens that begin with uppercase".  It always is
easier to start stricter and then later loosen the rules in a controlled
way.

>  daemon.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index daa4c8e..a9a4f02 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -411,14 +411,13 @@ static char *xstrdup_tolower(const char *str)
>  static void parse_extra_args(char *extra_args, int buflen)
>  {
>  	char *val;
> -	int vallen;
>  	char *end = extra_args + buflen;
>  
>  	while (extra_args < end && *extra_args) {
> +		int arglen = strlen(extra_args);
>  		saw_extended_args = 1;
>  		if (strncasecmp("host=", extra_args, 5) == 0) {
>  			val = extra_args + 5;
> -			vallen = strlen(val) + 1;
>  			if (*val) {
>  				/* Split <host>:<port> at colon. */
>  				char *host = val;
> @@ -432,10 +431,10 @@ static void parse_extra_args(char *extra_args, int buflen)
>  				free(hostname);
>  				hostname = xstrdup_tolower(host);
>  			}
> -
> -			/* On to the next one */
> -			extra_args = val + vallen;
>  		}
> +
> +		/* On to the next one */
> +		extra_args += arglen + 1;
>  	}
>  
>  	/*
> -- 
> 1.6.3.1.333.g3ebba7
