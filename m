From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 0001-Detailed-tools-useful-when-resolving-merge-conflicts.patch
Date: Wed, 20 Aug 2008 22:53:27 -0700
Message-ID: <7vvdxukj6w.fsf@gitster.siamese.dyndns.org>
References: <8f6a00e30808202027s1d481a01q22c5a7444cd03f80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dan Hensgen" <dan@methodhead.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 07:54:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW384-0007f8-Rr
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 07:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbYHUFxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 01:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbYHUFxg
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 01:53:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbYHUFxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 01:53:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D49161582;
	Thu, 21 Aug 2008 01:53:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1DC3B61581; Thu, 21 Aug 2008 01:53:30 -0400 (EDT)
In-Reply-To: <8f6a00e30808202027s1d481a01q22c5a7444cd03f80@mail.gmail.com>
 (Dan Hensgen's message of "Wed, 20 Aug 2008 23:27:32 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7D9A7E1C-6F45-11DD-90C6-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93113>

"Dan Hensgen" <dan@methodhead.com> writes:

> + * Resolve the conflicts.  Edit the working tree files into shape
> +   and 'git-add' to the index.  'git-commit' to seal the deal.

The documentation assumed the user have experience with the usual conflict
markers, and a more detailed explanation than what we currently have is
certainly welcomed.

I however cannot tell who the intended target audience of your description
is, from the order of presentation.

If you primarily target newbies and GUI-minded people, I think mergetool
should be the first one.

On the other hand, for command-line oriented people, you failed to
describe two more common and useful ways.

 - "git diff" itself will show the diff that contains the conflicted part,
   in a three-way diff format.  For example, if you try to merge c48544e
   (gitweb: use new Git::Repo API, and add optional caching, 2008-08-18)
   into c5a00f7 (Merge branch 'master' into next, 2008-08-20), you would
   see something like this:

   $ git diff
   diff --cc t/t9500-gitweb-standalone-no-errors.sh
   index 46ba19b,7f134f5..0000000
   --- i/t/t9500-gitweb-standalone-no-errors.sh
   +++ w/t/t9500-gitweb-standalone-no-errors.sh
   @@@ -54,7 -54,7 +54,11 @@@ gitweb_run () 
           # written to web server logs, so we are not interested in that:
           # we are interested only in properly formatted errors/warnings
           rm -f gitweb.log &&
   ++<<<<<<< HEAD:t/t9500-gitweb-standalone-no-errors.sh
    +	perl -- "$TEST_DIRECTORY/../gitweb/gitweb.perl" \
   ++=======
   + 	"$PERL_PATH" -- "$TEST_DIRECTORY/../gitweb/gitweb.perl" \
   ++>>>>>>> lw/gitweb:t/t9500-gitweb-standalone-no-errors.sh
                   >/dev/null 2>gitweb.log &&
           if grep -q -s "^[[]" gitweb.log >/dev/null; then false; else true; fi
  
   which makes it clear that since the common ancestor, our side (HEAD)
   added the line that begins with "perl", while the branch you are
   merging (lw/gitweb) added the line that begins with "$PERL_PATH".  In
   this case, Lea's change is a pure superset of what our side did, so I'd
   take the latter half as the resolution.

 - "git log --merge -p --left-right <path>" will show the commits on your
   fork and the other branch that touch the paths involved in the merge,
   with explanations why each change was made.  The first entry of the
   output is c48544e (gitweb: use new Git::Repo API, and add optional
   caching, 2008-08-18) that changes "perl" to "$PERL_PATH" and also
   introduces "$TEST_DIRECTORY/" by replacing what used to be "$(pwd)",
   and you can tell it is from Lea's branch by looking at its "commit"
   line with right-pointing-arrow '>' at the beginning:

   commit >c48544e29a0a9ea2f2b4a601cf4977174b53e803
   Author: Lea Wiemann <lewiemann@gmail.com>
   Date:   Mon Aug 18 21:39:49 2008 +0200

   The second entry in the output is bfdbee9 (tests: use $TEST_DIRECTORY
   to refer to the t/ directory, 2008-08-08) with a left-pointing arrow,
   which is mine:

   commit <bfdbee98109c5ad2dbbc392e7eed1ae688acc039
   Author: Junio C Hamano <gitster@pobox.com>
   Date:   Fri Aug 8 02:26:28 2008 -0700

   that only changes "$(pwd)" to "$TEST_DIRECTORY".  By looking at these
   two, you can be sure that taking Lea's change as the superset is the
   right thing to do.

You can of course alternatively look at the original, but I do not think
that should be taught as the first two suggestions before mergetool, plain
"git diff" or "git log --merge".
