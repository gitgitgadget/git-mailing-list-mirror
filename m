From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Filename quoting / parsing problem
Date: Fri, 01 Jan 2010 12:01:19 -0800
Message-ID: <7vr5q9lhm8.fsf@alter.siamese.dyndns.org>
References: <201001011844.23571.agruen@suse.de>
 <7vws01li4c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Fri Jan 01 21:01:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQngk-0007op-MJ
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 21:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab0AAUB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 15:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969Ab0AAUB3
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 15:01:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab0AAUB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 15:01:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E091E8D587;
	Fri,  1 Jan 2010 15:01:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6S1LVuip6wfks1uPV12fVmVX9Ls=; b=I3Ye9G
	uYd/PuqibHFTdZM7zg//Gwl9f6ubInzdaoKlWqnWfb7LWSsJGu2nUkWWt3u1Qt/K
	Z8nxpsnhIqFKiWHzItPMOuL6JQ834uXj5CMoHWauaZbcdvP1AraWsoYCIf/x1gNV
	MWIXI6BdsRLSPllITfQD5nW/94TH1QK29A0Po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bLLjqEj6OXeb4B9+3nQBFRKGGia6DSvo
	O8QWaOJA6uFnMw3Tw2qWnSJGeQS7ERpAPf8jz98I6/cRWObeTib2LYYbBI78htuP
	Nc6bXrzYfOrhw99+zbP1qX9SpWpnfMEj269VGSapRnVgmDDBjjpiLcbU61UAyNyy
	bZ0jmUdQGcU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE1B28D586;
	Fri,  1 Jan 2010 15:01:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E598F8D585; Fri,  1 Jan
 2010 15:01:20 -0500 (EST)
In-Reply-To: <7vws01li4c.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 01 Jan 2010 11\:50\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6FF326DE-F710-11DE-9A4E-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136010>

Junio C Hamano <gitster@pobox.com> writes:

> I used "cat -e" to make it easier to see that "c file " not only has SP in
> it but it has trailing space.  Let's try the result.
> 
>         $ git diff --cached | cat -e
>         diff --git "a/a\001file" "b/a\001file"$
>         new file mode 100644$
>         index 0000000..e69de29$
>         diff --git a/b file b/b file$
>         new file mode 100644$
>         index 0000000..e69de29$
>         diff --git a/c file  b/c file $
>         new file mode 100644$
>         index 0000000..e69de29$
>         $ git diff --cached >P.diff
> 
> And as you described, "b file" and "c file " are not quoted and they do
> not have ---/+++ lines.
> 
> But observe this:
> ...
> We are now back in the state without any of these files, and P.diff records
> a patch to recreate these three files, one with quoting and the other two
> without.
> 
>         $ git apply --index P.diff
>         $ git ls-files -s | cat -e
>         100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       "a\001file"$
>         100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       b file$
>         100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       c file $
>         100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       hello$
> 
> This demonstrates that The claim below is false, doesn't it?
> 
> > Not parseable:
> >     diff --git a/baz  b/baz 
> >     new file mode 100644
> >     index 0000000..e69de29
> 
> Both "b file" and "c file " are parsed by "git apply" perfectly fine.

Having said all that, I don't think we would mind a change to treat a
pathname with trailing SP a bit specially (iow, quoting "c file " in the
above failed attempt to reproduce the issue).  A pathname with SP in it is
an eyesore but is a fact of life outside of sane world, but a quoted
pathname is an even worse eyesore.  A pathname with trailing SP would be
much less common and is more likely to be corrupted by MUA and cut & paste;
with quoting we can protect them a bit better.
