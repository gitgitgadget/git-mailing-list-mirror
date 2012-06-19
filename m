From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix ranges with git-show
Date: Tue, 19 Jun 2012 14:11:53 -0700
Message-ID: <7vhau7ypk6.fsf@alter.siamese.dyndns.org>
References: <d3e839101b031a7208e74a0b6e22d343d5a093e9.1340136145.git.trast@student.ethz.ch> <a598bb8c20221679e295caa743197c86219eda68.1340136145.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:12:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh5iT-0005lL-TC
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 23:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab2FSVL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 17:11:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195Ab2FSVL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 17:11:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 967029A85;
	Tue, 19 Jun 2012 17:11:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iEHzuxxOlJDS+MZHPJKonetcTR8=; b=qaU/yz
	yM73yyHParE+J3A/ge8cBkLIUnTcTO1xP4OswkvNYJe5chrMsshQRFDz3LQDIAKF
	I0qhxItCBd5XYOKVQhZNrYtsINV057QgS/ZiDDfjlAylWsVLAVCjx291Nld2n6rj
	n+efnDAkfiM+G5e5fQG4BKAlMSJ4+1E6Ffrts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F/WqIrd3pAX441chDsNI+p8dom12vO8j
	myBnEXYEL4oi95GCODyVC+LjudSjfW2/TxqjNH95uw2FH55MsdZu4aPoVoPsRYR2
	EJtd836zpZVT6fMji34ZA7+AlYrOyjWUWTv7U69zqT4fY4AyNZoAkbpNwCmmPzSN
	GDCYxSra3qQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D15A9A84;
	Tue, 19 Jun 2012 17:11:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E21909A80; Tue, 19 Jun 2012
 17:11:54 -0400 (EDT)
In-Reply-To: <a598bb8c20221679e295caa743197c86219eda68.1340136145.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 19 Jun 2012 22:04:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65B74B38-BA53-11E1-9075-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200245>

Thomas Rast <trast@student.ethz.ch> writes:

> As explained in the previous commit, git-show's DWIM walking mode
> fails with ranges where propagating the UNINTERESTING marks is needed
> for correctness.

Finally ;-)

Another bad thing about the Linus's walking hackery is it depends on
the order of parameters (e.g "show maint master..next" and "show
master..next maint" gives us vastly different results).

> To fix this issue, use a new strategy for of dealing with commits:
> handle everything else first, then pass all commits to a single
> revision walker "in bulk".  This keeps the UNINTERESTING commits and
> correctly shows all ranges.

In other words, do not implement a half-hearted revision walking
itself, but let the proper call to cmd_log_walk() take care of the
walking.  Good.

> Sadly we can use this only when actually walking.

I do not think it is sad at all.  If we were told to walk, we should
walk just like "git log" does, and otherwise we just show them one
by one.  It might be even cleaner if we separate the command line
parsing and showing into separate phases, instead of the current
loop structure of parsing one object and deciding how to show.

How about doing it this way without applying your 2/2?

Among your new tests:

	git show ^side3 annotated

which is equivalent to

	git show side3..annotate

must change, as it is not asking to show individual objects (in
other words, I think the test expects a wrong thing), but everything
else should work as expected (I didn't check).

diff --git a/builtin/log.c b/builtin/log.c
index 56bc555..9ea2eb7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -451,6 +451,9 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	opt.tweak = show_rev_tweak_rev;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 
+	if (!rev.no_walk)
+		return cmd_log_walk(&rev);
+
 	count = rev.pending.nr;
 	objects = rev.pending.objects;
 	for (i = 0; i < count && !ret; i++) {
