From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add a basic idea section for git-blame.
Date: Thu, 08 Apr 2010 01:00:13 -0700
Message-ID: <7vmxxe74s2.fsf@alter.siamese.dyndns.org>
References: <1270709490-19163-1-git-send-email-struggleyb.nku@gmail.com>
 <1270709490-19163-2-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 10:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzmf9-0002xN-OG
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 10:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab0DHIA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 04:00:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab0DHIAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 04:00:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1C4BA8632;
	Thu,  8 Apr 2010 04:00:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z/4kCE8wrRDwvWQLRX86bef4XEY=; b=GZqJRp
	VHFExPQ0H6gRQBCS8pOOYtIk1JPneTZ6VhwifKVwjEMeke88wN99KUG+1uH7xb8U
	DGQHn6/zJrSLVGJZJdPqCZoAlOnjOH3sCmKz0K5Xv09csTBwSVp6WuUBEHBnX6az
	eZyEktE/mOd2C//CZ8cl1j2U1p6qHZn1TmjN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aW6favJMK1qv44P5++JKse+Bbeag2iXt
	lKf7qSRtBaNZzuodjl2Uls0fS2l3pY+OlU11ll9cQ00z3oK6kRajqL67Nb4K3Ks5
	4THL3i/IQhtacKnrLB/MFLZJAjALmqQT92Xj/rqRizs7bYJA6ad1IlWmYDO4vqrG
	9dZE6Bi30as=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A468FA8631;
	Thu,  8 Apr 2010 04:00:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA9AAA862F; Thu,  8 Apr
 2010 04:00:14 -0400 (EDT)
In-Reply-To: <1270709490-19163-2-git-send-email-struggleyb.nku@gmail.com> (Bo
 Yang's message of "Wed\,  7 Apr 2010 23\:51\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C5FB937A-42E4-11DF-B58D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144343>

Bo Yang <struggleyb.nku@gmail.com> writes:

> +A call to `git-blame <rev> -- <file>` works as follows:
> +
> +- Look at `git diff <rev>^ <rev>` to see what the commit did.
> +
> +- Discard all `-` lines in the diff, since they are no longer part of
> +  `<file>`.
> +
> +- Take blame for all `+` lines; i.e., the newly added lines according
> +  to the diff are attributed to `<rev>`.

I hate to say it, but this is horrifying; it works quite the other way
around.

The name of the game is not "take blame by looking at the diff to see what
we introduced"; it is "avoid taking blame at all cost, by looking at the
diff to see what we might have inherited from our parents".

A description closer to the truth would be:

 - Look at output of "git diff <rev>^$n <rev>" for each parent ($n runs
   from 1 to number of parents);

 - Ignore all +/- lines.  The context ' ' lines and lines outside of diff
   hunks are known to have been inherited from $n-th parent and they are
   not our fault.  We can happily pass blame for these lines to our
   parent.

 - Do the above for all the parents.  We (grudgingly) take blame for lines
   that we failed to find corresponding lines in our parents.

The -M option affects what happens between the second and the third step.
We try to see if the lines that we did not pass blame to <rev>^$n might
have come from <rev>^$n by running diff between the remainder and the blob
in <rev>^$n *again*.  This lets us catch code movement within the blob,
hence the name of the option -M.

The -C option affects the choice of the blob in <rev>^$n.  Usually, we
internally run an equivalent of "git diff -M <rev>^$n <rev>" to notice
that the file F that we are analyzing used to be called F' in $n-th
parent, and run the diff against it, but -C allows us to check with paths
other than that, and additional -C enlarges the search space.  This is to
notice code movement (with a single -C) or copies (with more -Cs) across
paths.

For illustrated description, read the classic:
 
    http://thread.gmane.org/gmane.comp.version-control.git/28826

Almost all the hits in the first page from this query would help, too:

http://search.gmane.org/?query=On+blame%2Fpickaxe&author=Junio+C+Hamano&group=gmane.comp.version-control.git&sort=revdate&DEFAULTOP=and&[=2&xP=blame%09pickaxe&xFILTERS=Gcomp.version-control.git-Ac-Ahamano-Ajunio---A
