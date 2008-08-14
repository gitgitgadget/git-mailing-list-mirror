From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-daemon: make the signal handler almost a no-op
Date: Wed, 13 Aug 2008 17:09:12 -0700
Message-ID: <7v1w0sjw47.fsf@gitster.siamese.dyndns.org>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl>
 <20080813084331.30845.74788.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Aug 14 02:10:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTQQC-0001qt-9n
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 02:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbYHNAJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 20:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYHNAJX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 20:09:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756868AbYHNAJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 20:09:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7064A58863;
	Wed, 13 Aug 2008 20:09:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6289858861; Wed, 13 Aug 2008 20:09:14 -0400 (EDT)
In-Reply-To: <20080813084331.30845.74788.stgit@aristoteles.cuci.nl> (Stephen
 R. van den Berg's message of "Wed, 13 Aug 2008 10:43:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3EBA3A12-6995-11DD-A5C2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92295>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> by exploiting the fact that systemcalls get interrupted by signals;
> and even they aren't, all zombies will be collected before the next
> accept().

Dscho may want to say something about "even they aren't..." part, after he
comes back to the keyboard.

> Fix another error() -> logerror() call.

which should have been in 1/3, I suppose.

> @@ -1036,10 +1034,7 @@ int main(int argc, char **argv)
>  	gid_t gid = 0;
>  	int i;
>  
> -	/* Without this we cannot rely on waitpid() to tell
> -	 * what happened to our children.
> -	 */
> -	signal(SIGCHLD, SIG_DFL);
> +	child_handler(0);

Why?

child_handler() logically is a two step process:

 * We are just informed that somebody died; let's do something about the
   corpse;

 * On some systems we need to rearm signals once they fired, so let's do
   that if necessary.

With your change, the first part happens to be almost no-op, but I do not
think it justifies this hunk.

After all, we might even want to do something like:

	static void child_handler(int signo)
        {
        	if (USE_SYSV_SIGNAL_SEMANTICS)
                	signal(SIGCHLD, child_handler);
	}

and have the compiler optimize out the signal rearming with

	cc CFLAGS=-DUSE_SYSV_SIGNAL_SEMANTICS=0

on suitable platforms in the future.  But you still want the initial
signal set-up to happen unconditionally.

At this point, we aren't informed by the system that somebody died, and we
would want to arm the signal regardless of the platform's signal semantics.

The rest of the patch looked sane, although I did not read it very
carefully.

Thanks.
