From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree Ready #2
Date: Mon, 20 Feb 2012 23:37:52 -0600
Message-ID: <87ehtowxu7.fsf@smith.obbligato.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
	<8739acra5j.fsf@smith.obbligato.org>
	<20120215050855.GB29902@sigill.intra.peff.net>
	<87sjicpsr1.fsf@smith.obbligato.org>
	<87ty2ro1zf.fsf@smith.obbligato.org>
	<20120220205346.GA6335@sigill.intra.peff.net>
	<7vd399jdwc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 06:40:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RziSi-0004XE-RV
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 06:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab2BUFkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 00:40:21 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:50070 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752612Ab2BUFkU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 00:40:20 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1RziSy-0006jW-QO; Mon, 20 Feb 2012 23:40:45 -0600
In-Reply-To: <7vd399jdwc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 20 Feb 2012 15:14:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > Jeff King <peff@peff.net>
    writes: > > It sounds like the simplest and cleanest would be to treat it
    as if its > current version came as a patch submission, cook it just like
    any other > topic in 'pu' down to 'next' down to eventually 'master', with
    the usual > review cycle of pointing out what is wrong and needs fixing followed
    by a > series of re-rolls. [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- --------------- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191134>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
> It sounds like the simplest and cleanest would be to treat it as if its
> current version came as a patch submission, cook it just like any other
> topic in 'pu' down to 'next' down to eventually 'master', with the usual
> review cycle of pointing out what is wrong and needs fixing followed by a
> series of re-rolls.

Ok, but we will preserve the history via the subtree merge, yes?

> The total amount of change does not look too bad, either:

Yes, it's a fairly small tool.

> It does look like it needs to start its life in contrib/ if we were to put
> this in git.git. 

That sounds good to me.  It should get a good shakedown before graduating.

> I haven't looked at the script fully, but it has an issue from its
> first line, which is marked with "#!/bin/bash".  It is unclear if it
> is infested by bash-isms beyond repair (in which case "#!/bin/bash" is
> fine), or it was written portably but was marked with "#!/bin/bash"
> just by inertia.  A patch that corresponds to the above diffstat
> immediately shows many style issues including trailing eye-sore
> whitespaces.

Ok.

> It seems that it is even capable of installing from contrib/subtree, so
> keeping it in contrib/ while many issues it may have gets fixed would not
> hurt the original goal of giving the script more visibility.

Right, I intentially designed it that way.

> The change to t/test-lib.sh should be made independent of this topic, I
> would think.

Ok, I'll propose those changes separately.  They are a prerequisite for
a git-subtree that is easily testable while in contrib.

> ----------------------------------------------------------------
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index e28d5fd..c877a91 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -55,6 +55,7 @@ unset $(perl -e '
>  		.*_TEST
>  		PROVE
>  		VALGRIND
> +                BUILD_DIR
>  	));
>  	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
>  	print join("\n", @vars);
> @@ -924,7 +925,15 @@ then
>  	# itself.
>  	TEST_DIRECTORY=$(pwd)
>  fi
> -GIT_BUILD_DIR="$TEST_DIRECTORY"/..
> +
> +if test -z "$GIT_BUILD_DIR"
> +then
> +    echo Here
> +	# We allow tests to override this, in case they want to run tests
> +	# outside of t/, e.g. for running tests on the test library
> +	# itself.
> +        GIT_BUILD_DIR="$TEST_DIRECTORY"/..
> +fi
>  
>  if test -n "$valgrind"
>  then
> ----------------------------------------------------------------
> This change deserves its own justification.

I'll put a patch together with a more extensive explanation.  Basically,
tests run outside of the top-level t/ directory don't work because there
are all sort of assumptions in test-lib.sh about where they live.  There
are comments in test-lib.sh indicating that it should support tests in
other directories but I could not make it work out of the box.

> After looking at the history of subtree branch there, however, I agree
> that it would not help anybody to have its history in my tree with log
> messages like these (excerpt from shortlog output):
>
>       update todo
>       Some todo items reported by pmccurdy
>       todo
>       Docs: when pushing to github, the repo path needs to end in .git
>       todo
>       todo^
>       todo
>       todo: idea for a 'git subtree grafts' command

Ok, these are Avery's commits.  I don't know that I have enough context
to improve the logs but I will look throught revisions and try to figure
things out.  Avery, could you be of any help here?  It sounds like we
need more descriptive log messages.

                               -Dave
