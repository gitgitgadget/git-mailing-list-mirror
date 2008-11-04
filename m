From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git send-email: allow any rev-list option as an 
 argument.
Date: Mon, 03 Nov 2008 17:04:27 -0800
Message-ID: <7vej1sti78.fsf@gitster.siamese.dyndns.org>
References: <1225450632-7230-3-git-send-email-madcoder@debian.org>
 <1225471925-2750-1-git-send-email-madcoder@debian.org>
 <20081102043523.GE5261@coredump.intra.peff.net>
 <20081102093907.GF4066@artemis> <20081102180220.GA5726@sigio.intra.peff.net>
 <20081103091513.GC13930@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 02:06:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxANS-0005oT-FY
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 02:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041AbYKDBEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 20:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYKDBEs
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 20:04:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbYKDBEr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 20:04:47 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DF6F378084;
	Mon,  3 Nov 2008 20:04:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8D30B7807C; Mon,  3 Nov 2008 20:04:34 -0500 (EST)
In-Reply-To: <20081103091513.GC13930@artemis.corp> (Pierre Habouzit's message
 of "Mon, 03 Nov 2008 10:15:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 92BAD268-AA0C-11DD-A39F-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100019>

Pierre Habouzit <madcoder@debian.org> writes:

> As a summary, I'd say that I like both (1) and (3) because those are
> handy, short, and either completely or mostly backward compatible. My
> way would be to go down (1) and add a alias.s-e = !git send-email -F in
> my .gitconfig.
>
> What do you think ?

I wonder if we can do this even without an explicit -F.

What command line arguments does send-email take, and what options would
we want to give the underlying format-patch?  Can't you sift them without
ambiguity?

The current syntax is:

    git send-email <flags>... <file|dir>...

I am wondering if we can just extend it to:

    git send-email <flags>... <<file|dir>...|rev>

E.g. we should be able to parse this out:

    git send-email --to git@vger.kernel.org -M --suppress-cc=all origin

and notice "--to git@vger.kernel.org" and "--suppress-cc" are for
send-email, guess "-M" (or anything that is outside the current
send-email's vocabulary) is meant for format-patch, and if there is no
file or directory called "origin" then decide that the user wants to run
format-patch, and act as a front-end as if the user did:

	git format-patch -o tmp.$$ -M origin &&
        ... perhaps do your --annotate and --compose here by launching
        ... the editor...
        git send-email --to git@vger.kernel.org --suppress-cc=all tmp.$$ &&
	rm -fr tmp.$$

If you happen to have a file or a directory called origin, it would be
safer for users if the command errored out asking for disambiguation.  The
user can either say "./origin" or "origin^0" to disambiguate between them.

Hmm?
