From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list/log: document logic with several limiting
 options
Date: Wed, 12 Sep 2012 10:25:52 -0700
Message-ID: <7vbohbdufz.fsf@alter.siamese.dyndns.org>
References: <b23f3c547358b79731c7a25d9ac496138e6ab74d.1347374615.git.git@drmicha.warpmail.net> <7vsjaoil6d.fsf@alter.siamese.dyndns.org> <50509171.9060604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 12 19:26:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBqhQ-0001HH-D0
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 19:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988Ab2ILRZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 13:25:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280Ab2ILRZy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 13:25:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 420B58487;
	Wed, 12 Sep 2012 13:25:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GJmad6GMkOJ0kORk3PH9IrG+oFo=; b=waxbLv
	ebGfQG86Otc9a/F9nGufECpbR99MBYfvK2aPutjxN1tzDqc+Ym98nU5qdt5Cs7i8
	L90/HhrNmEGSIkAwfyrQ8/9RYWoyepN+PNd1APwSC5RLXRyRDus630r6PhDmKQXc
	kccSShmBBraeDiSavHH5i8AEjm3dFVLAO3ZNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cOwjUnPR+LqAZD40t0D2PqDEg19IJFB5
	J67QEWrBFOI4CgYexbb4s9BWO8DxH8cv12jIsQBmCu4Xy6M0oJed9DwsCs/ceuB2
	j2u599Ra8CRwDrXrZaHoU8ZxsEtL93Q2d4VwO/XR5iA75MPn4+0uOpIyT6v4Obsd
	slRZtrTDUzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3041A8486;
	Wed, 12 Sep 2012 13:25:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B5B78485; Wed, 12 Sep 2012
 13:25:53 -0400 (EDT)
In-Reply-To: <50509171.9060604@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 12 Sep 2012 15:43:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7A093A0-FCFE-11E1-AD60-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205310>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> It was introduced in 0ab7befa with a clear meaning (AND everything),
> then the general logic (without --all-match) was modified in 80235ba7
> (to take headermatch AND (all greps ORed)), and 5aaeb733 finally made
> multiple authors resp. committers get ORed among each other. All of this
> in an attempt to make the standard usage most useful, of course. As a
> consequence, --all-match does not influence multiple --author options at
> all (contrary to the doc), e.g.
>
> I don't see any of this reflected in the doc, though. I noticed only by
> reading t/t7810-grep.sh. Before that, I had only gone by my own testing
> which didn't reveal the multiple author multiple special casing effect.
>
> I guess I'll have to wrap my head around the current implementation a
> few more times before trying to describe the status quo in the
> documentation...

This is what I used to use when adding these generalized grep
boolean expressions.

With this applied, you can try things like these:

    $ git log --grep=regexp --grep=nosuch --all-match >/dev/null
    $ git log --grep=regexp --grep=nosuch --author=Michael >/dev/null

For example, "--all-match --grep=regexp --author=Michael --author=Linus" turns
into

    [all-match]
    (or
     pattern_body<body>regexp
     (or
      (or
       pattern_head<head 0>Linus
       pattern_head<head 0>Michael
      )
      true
     )
    )

that says "body must have 'regexp' in it, and authored by either
Linus or Michael".

The semantics of "--all-match" is different from "--and" (which,
together with "--or", ")", and "(", is not availble to rev-list
command line parser primarily because "--not" is not available).
After applying all the "or"-ed terms, it checks the top-level nodes
that are "or"-ed and makes sure all of them fired (possibly and
usually on different lines).
