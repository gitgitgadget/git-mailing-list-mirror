From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Filter-branch's "move tree to subdirectory" example fails with
 BSD sed?
Date: Mon, 16 Apr 2012 10:03:03 -0700
Message-ID: <7vr4vnwqwo.fsf@alter.siamese.dyndns.org>
References: <20120414160028.GD1012@gmail.com> <4F89CF11.7060309@kdbg.org>
 <20120416152737.GB14724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Christopher Tiwald <christiwald@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:03:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJpKj-00045U-A3
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 19:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285Ab2DPRDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 13:03:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902Ab2DPRDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 13:03:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64B3067DD;
	Mon, 16 Apr 2012 13:03:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LJT4SS3jcdJtfnEGvCn4Bo1MkUs=; b=w/jX1W
	rmbF4G/mGDk5VKrLcNxuc4Q2okCIe91DieRY2yv9wd7hn9SFKM2q91VQmG6sCw4o
	2xGrFE/iQRiDJGSbNMVI9VDFaMT+cfbX6Jw5PzjPISYxTkI8y+jbGcruXJrv3gPf
	8lvLxNGW5K+8aaNu+Hvymm08FL+bnOkEltwCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ayobjbe1qz3v/lbmYLNroKQZUW6aHdco
	E7i5rGGnF63JvlqQAAqsbmAj/CAh9vvSIbBbryfEAYdyveNOoYsdlw3On4NJaodw
	N66WlQPtHHfZgR7UsCQfFWcO6p6zOnL8Z+UBXRbgk2Uzfm+ej34M7jrUciBKPgKV
	2wMenw0jYoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 448AF67DC;
	Mon, 16 Apr 2012 13:03:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF16C67DA; Mon, 16 Apr 2012
 13:03:04 -0400 (EDT)
In-Reply-To: <20120416152737.GB14724@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 16 Apr 2012 11:27:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08422698-87E6-11E1-83ED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195665>

Jeff King <peff@peff.net> writes:

> I wish we could also get rid of the temporary index. It exists solely
> for the side effect of removing the existing entries (otherwise, you get
> both "foo" and "newsubdir/foo" in the resulting history). It would be
> nice if there was some flag to update-index to say "before you do
> anything, clear the existing index" (or I guess, "don't bother reading
> the existing index"). And then result could look like:
>
>   git filter-branch --index-filter '
>     git ls-files -sz |
>     perl -0pe "s{\t}{\tnewsubdir/}" |
>     git update-index --from-scratch -z --index-info
>   ' HEAD
>
> which is IMHO much easier to read and understand.

Wouldn't "git read-tree --prefix=newsubdir/" suffice without the pipeline?
I.e.

        git filter-branch --index-filter '
		rm -f "$GIT_INDEX_FILE"
                git read-tree --prefix=newsubdir/ "$GIT_COMMIT"
	' HEAD
