From: Junio C Hamano <gitster@pobox.com>
Subject: Re: extra headers in commit objects
Date: Wed, 03 Feb 2010 12:42:08 -0800
Message-ID: <7vwryugifz.fsf@alter.siamese.dyndns.org>
References: <20100203174041.GC14799@spearce.org>
 <alpine.LFD.2.00.1002031311010.1681@xanadu.home>
 <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com>
 <20100203192612.GD14799@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 21:42:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncm3P-0002Au-4N
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843Ab0BCUmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:42:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827Ab0BCUmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:42:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E248E9683D;
	Wed,  3 Feb 2010 15:42:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zRAW7zbP3aOPfQ1nZbwa6UNEoMI=; b=gheLET6b210r++UGZVjmRcx
	8x82WpavtVZAN67EZNTymWWEpCsWNs+rwuZ5K46NmDpLc5Kd4KGg3y/cPb257Q6T
	h1lLXPeyz85k3Yh0BVZ7biTtNbdAZ/SXHuRMzapKYP2dkAryM9DaDjVTS9pNqWru
	O3bcqDv1iYSibjiRKIaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=j4iUtDbf8X/BCziuwGTcOfGm2MHaffk8X3Rat+0M9nBwOUOcU
	pwKYdqDBmvsGKNukqkUehbK3uURsnscNcq8tnvMzVFqBWsbKkZ8fZAVj7AQX8gC3
	5Z6xbNAYqVYywXF3H5iqhzQYsNkaL7owVgRpMXodOuEH4Vt/Bp2uxbVnD0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0B159683A;
	Wed,  3 Feb 2010 15:42:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9634B96837; Wed,  3 Feb
 2010 15:42:10 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D04BC9C-1104-11DF-BA37-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138892>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> As I understand it, the current stance is:
>
> 1) A compliant Git implementation ignores any headers it doesn't
>    recognize that appear *after* the optional "encoding" header.

I first read the above to mean that you need to add encoding if you want
to throw in other garbage.

I would say "*after* the mandatory 'tree', 'parent' (0 or more), 'author',
and 'committer' headers that must appear in this order", for clarity.

> 2) A compliant Git implementation does not produce any additional
>    headers in a commit object, because other implementations cannot
>    perform any machine based reasoning on them.
>
> 3) All implementations would (eventually) treat all headers equally,
>    that is they all understand what author, committer, encoding are
>    and process them the same way.  Any new headers should equally
>    be fully cross-implementation.

These are very important points.

In your made-up example you added "bug" (presumably to mean "fixes this
bug") and "message-id" ("am-ed from this message").  The latter might make
sense, but the former does not belong to the header, as it is not a
statement of the fact.

Forcing people to say "this fixes" at the commit time means you do not
allow mistakes---it may turn out to be an incorrect or non fix later.
When you are amending the commit to say "this does not really fix it", you
would want to lose the old "bug" header, but you would want to keep the
"message-id" one.  There simply is not enough hint as to which ones must
be carried across amending in the "we allow people to randomly throw extra
headers into the commit object" model.  It is not a model--it is chaos.

Also it wouldn't be obvious to other people what got changed while
comparing two commits (before and after the amend) if the information is
hidden in the header.  The right place for that kind of information is in
the log message (if the nature of the information is for everybody to see)
or in notes.

Another major difference between extra random headers and notes is that
the former changes the commit's object name, and if it is due to "random
headers", it means you are breaking the object model for no good reason.

Introducing extra headers needs to be done _very_ carefully after thinking
things through, judging the pros and cons.  Even though we kept the format
open to allow us to extend the format to add essential statement of fact
that we can make at the commit time (e.g. "encoding"), I do not foresee us
adding any official extra headers in near future.
