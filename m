From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/selftest] hash-object: don't rely on order of --stdin, -w
 arguments
Date: Wed, 13 Feb 2008 15:25:11 -0800
Message-ID: <7v8x1oo2w8.fsf@gitster.siamese.dyndns.org>
References: <20080213190338.7393.qmail@d70c5cbe18d4bd.315fe32.mid.smarden.org>
 <7v7ih8pre6.fsf@gitster.siamese.dyndns.org>
 <20080213224941.18121.qmail@c0fdbb95c1b5f1.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 00:26:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPQzR-0002C6-1l
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 00:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923AbYBMXZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 18:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbYBMXZb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 18:25:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920AbYBMXZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 18:25:29 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F79E3A53;
	Wed, 13 Feb 2008 18:25:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 5616B3A51; Wed, 13 Feb 2008 18:25:19 -0500 (EST)
In-Reply-To: <20080213224941.18121.qmail@c0fdbb95c1b5f1.315fe32.mid.smarden.org> (Gerrit
 Pape's message of "Wed, 13 Feb 2008 22:49:41 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73827>

Gerrit Pape <pape@smarden.org> writes:

> Fix 'git hash-object --stdin -w' to actually write the object, just as
> 'git hash-object -w --stdin' does.
>
> Reported by Josh Triplett through
>  http://bugs.debian.org/464432
>
> Signed-off-by: Gerrit Pape <pape@smarden.org>

Thanks.  I think the patch itself is a good fix to the old
design mistake we made.

However, I would _really_ like to see something like the
following mentioned in the proposed commit log message for
discussion:

    This regresses the use case of running:

        $ git hash-object --stdin Makefile <cache.h

    to obtain hash values for cache.h and then Makefile.  It
    used to report the object names in order, but now it always
    processes --stdin at the end.  It is not an issue if
    everything is file (i.e. "git hash-object cache.h Makefile"
    is an easy replacement), but if existing scripts used the
    option to read from a pipe, this might become problematic.

    Similarly, when typing from terminal:

        $ git hash-object --stdin --stdin
        foo
        ^D
        bar
        ^D

    used to work, but not anymore.  The latter however should
    not be something we need to worry about.  It is an insane
    usage.

Granted, we _should have_ prevented such insane usages (the
second one is definitely insane and not so useful, and the first
one is but to a much lessor degree).  We _should have_ forced
scripted users to do these with two separate invocations of "git
hash-object", by refusing more than one --stdin and --stdin with
filename on the command line.  But we didn't, and this earlier
design mistake has already been in the field for a long time.
People may have been depending on the existing misbehaviour.

So I am Ok with the patch, and I strongly suspect that we should
even detect more than one --stdin and --stdin with filename on
the command line to reject the usage your saner version behaves
differently from before, instead of accepting and silently doing
an unexpected thing.

But at the same time I would really like our commit messages,
and Release Notes that is based on these commit messages, to be
_candid_ about our previous mistakes and the incompatibility we
are incurring to the existing users.

> +test_expect_success \
> +    'git hash-object -w --stdin saves the object' \
> +    'echo foo | git hash-object -w --stdin &&
> +    test -r .git/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99 &&
> +    rm -f .git/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99'

I'd feel better if tests outside t0000 did not hardcode the
actual values, like this:

	obname=$(echo foo | git hash-object -w --stdin) &&
        ob=$(expr "$obname" : "\(..\)") &&
        name=$(expr "$obname" : "..\(.*\)") &&
        test -f ".git/objects/$ob/$name"
