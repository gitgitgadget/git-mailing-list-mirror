From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Makefile: work around ksh's failure to handle
 missing list argument to for loop
Date: Mon, 05 Jul 2010 11:18:16 -0700
Message-ID: <7vy6dpyeqf.fsf@alter.siamese.dyndns.org>
References: <80typu1ozt.fsf@tiny.isode.net>
 <8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil> <4C30D4D5.3020900@drmicha.warpmail.net> <4C31796E.9050109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	git@vger.kernel.org, PWalker752@aol.com, newsletter@dirk.my1.cc,
	bruce.stephens@isode.com, Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 20:18:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVqFi-0002li-So
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 20:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab0GESSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 14:18:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab0GESSj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 14:18:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9560AC101D;
	Mon,  5 Jul 2010 14:18:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+pwAO/hvVYlorbtgtunGD9wq+NI=; b=DdKQHd
	wxizSJlJfV/HXfJDwIPpuA7Sf4KyHWDdLWuVpXTn0aYtyDbhY7X1SpKdj6OsWCBO
	XMQ5ka3ltUzv/RwStlh+rcax68O13x7abeA/KXelOsHbTmIQZZf/oRFm95Juz6h1
	VTQle+iCJIJx6KRow73z9rs2FQXD7Ryenjw2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IAaIPoz6KqbMbS+QMmTYEfbP7euVqOAs
	RnZ9ZamA0I6aN1DKX2aDx6cDI7naJWDKR70MIBA22adDegaMVq64DCvW3oNQj5b6
	wGFzNSae3E0p3e26ud3GVQLwv8d2S+fR3AHPMgTgUVMrVPaxpju6BsPjN6xqpEiG
	9qMYSFs1K3k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 105AFC1014;
	Mon,  5 Jul 2010 14:18:29 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A3B2C100E; Mon,  5 Jul
 2010 14:18:18 -0400 (EDT)
In-Reply-To: <4C31796E.9050109@viscovery.net> (Johannes Sixt's message of
 "Mon\, 05 Jul 2010 08\:19\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B5F04E04-8861-11DF-8D77-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150282>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Before the test for emptyness can happen, the complete statement must be
> parsed, but ksh finds a syntax error in the statement and, therefore,
> cannot even begin to execute the statement. (ksh doesn't follow POSIX in
> this regard, where this would not be a syntax error.)

I had to stare at Brandon's patch that was essentially:

-    for p in $(FOO); do echo $$p; done
+    foo=$(FOO); for p in $$foo; do echo $$p; done

and the above two doesn't look like there should be any difference; your
explanation makes quite a lot of sense but that's arcane.  I doubt I will
be able to justify and explain the latter construction without consulting
your message I am responsing to, if somebody asks "why do we assign $(FOO)
to a shell variable and then iterate over it?" 6 months from now.

It might make sense to use $(foreach) instead of rolling our own loop in
the shell to avoid glitches like this.

 Makefile |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 9aca8a1..8bbb574 100644
--- a/Makefile
+++ b/Makefile
@@ -2085,13 +2085,13 @@ endif
 		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
 	  done; } && \
-	{ test x"$(REMOTE_CURL_ALIASES)" = x || \
-		{ for p in $(REMOTE_CURL_ALIASES); do \
-		$(RM) "$$execdir/$$p" && \
-		ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
-		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
-		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
-	  done; } ; } && \
+	$(foreach p,$(REMOTE_CURL_ALIASES), \
+		{ \
+		$(RM) "$$execdir/$p" && \
+		ln "$$execdir/git-remote-http$X" "$$execdir/$p" 2>/dev/null || \
+		ln -s "git-remote-http$X" "$$execdir/$p" 2>/dev/null || \
+		cp "$$execdir/git-remote-http$X" "$$execdir/$p" || exit; \
+		} && ) : \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-gitweb:
