From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 4-way diff (base,ours,theirs,merged) to review merge results
Date: Sun, 26 Feb 2012 01:05:14 -0800
Message-ID: <7vd392ezhx.fsf@alter.siamese.dyndns.org>
References: <jicafn$gnj$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 10:06:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1a3a-00013N-BB
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 10:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab2BZJF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 04:05:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311Ab2BZJFS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 04:05:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2CCA48C6;
	Sun, 26 Feb 2012 04:05:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3HTBJX5GQfQ+rGJo0XUJ9b8WYnQ=; b=CkpTKe
	GACM0EDwj58ApsqmLwAIzDRGnU/SZQp7aCbd0p3WiAd24LeZeJe1C5htS/TGsd4T
	VtAHKsc/JtPXKR3iOcBCwrXXtjiIYshUr/GqSkx1xC7yGU1ITLgPSWI/T2sFqD7B
	EpAYuuMICkeN+asyVURjdudrZ/l8rodGR6qVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nr2kaAo6Stw0LHRTySV32W+/+pnbgqEu
	mz8WFLjhxPGArsXsPIq7rRCaAnLUf1n/axuKT3lKUKj9l8BD2YJTPBEW5nezyB2j
	iPxIk0zIuzBJqAAH0wsG4azV5b7y/5YQrRXRazZDkkgwx1J8uyPJwh7XPC/UzRdH
	kNg7YvlRtk4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAA2F48C5;
	Sun, 26 Feb 2012 04:05:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6175648C3; Sun, 26 Feb 2012
 04:05:16 -0500 (EST)
In-Reply-To: <jicafn$gnj$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Sat, 25 Feb 2012 21:55:37 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFE037CE-6058-11E1-AAA8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191557>

"Neal Kreitzinger" <neal@rsss.com> writes:

> ....  What is the 
> best way to display a 4-way diff of merge-base, "ours", "theirs", and 
> "merged" after a merge completes so you can review the "merged" results for 
> correctness?

Ahh, sorry.  While everything I wrote in my previous reply is correct with
respect to what happens _during_ a merge until you resolve it, I did not
realize that you were asking how to view a merge _after_ it is made.

For a two-parent merge $M, "git show --cc $M" runs a three-way diff
between $M (merge result), $M^1 (the first parent) and $M^2 (the other
parent) and the combined diff it shows is equivalent to:

  $ git diff --cc $M $M^1 $M^2

Notice the order of parameters. Unlike a normal "diff A B" to ask the
command to explain how the state B is reached from state A, you give the
result $M and ask the command to explain how it was reached from other
states.

So in a similar way, running

  $ git diff --cc $M $M^1 $M^2 $(git merge-base $M^1 $M^2)

should show a combined patch that explains the state at $M relative to the
states recorded in its parents and the merge base.

I've never tried it myself, though, as I never needed such an operation.

You can try a trivial example with 4d9e079, which merges 583c389 ec7ff5b
and has conflicts in cache.h

$ git show 4d9e079 -- cache.h
Output omitted; you can see it is the same as the next one for yourself.

$ git diff --cc 4d9e079 583c389 ec7ff5b -- cache.h
diff --cc cache.h
index 3a8e125,24732e6..422c5cf
--- a/cache.h
+++ b/cache.h
@@@ -1177,7 -1176,7 +1177,8 @@@ extern void setup_pager(void)
  extern const char *pager_program;
  extern int pager_in_use(void);
  extern int pager_use_color;
 +extern int term_columns(void);
+ extern int decimal_width(int);
  
  extern const char *editor_program;
  extern const char *askpass_program;

One side adds term_columns, the other side adds decimal_width.

$ git diff --cc 4d9e079 583c389 ec7ff5b \
    $(git merge-base 583c389 ec7ff5b) -- cache.h
diff --cc cache.h
index 3a8e125,24732e6,9bd8c2d..422c5cf
--- a/cache.h
+++ b/cache.h
@@@@ -1177,7 -1176,7 -1176,6 +1177,8 @@@@ extern void setup_pager(void)
   extern const char *pager_program;
   extern int pager_in_use(void);
   extern int pager_use_color;
 ++extern int term_columns(void);
+ +extern int decimal_width(int);
   
   extern const char *editor_program;
   extern const char *askpass_program;

The third column is a diff between $M and $(git merge-base $M^1 $M^2); the
resulting two new lines are indeed shown as additions against the merge
base.
