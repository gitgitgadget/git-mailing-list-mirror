From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Tue, 03 Jul 2012 12:38:10 -0700
Message-ID: <7vipe4vdnh.fsf@alter.siamese.dyndns.org>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
 <7vsjd9wkek.fsf@alter.siamese.dyndns.org>
 <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
 <20120703180439.GC3294@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "jonsmirl\@gmail.com" <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 21:38:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm8va-0006J6-M8
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 21:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933445Ab2GCTiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 15:38:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932693Ab2GCTiN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 15:38:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92C2E8A68;
	Tue,  3 Jul 2012 15:38:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3SGIfIRJFVJTHYQjroAXrgL9fqE=; b=UZZJNN
	PWbCSbiCf5+nZ704UJ1OHZcS5EaKs7PFGWHBjZowJnaGBFRddean7p/xXfwGyAXO
	f+8H1eMNMssZkL+zsHi7baL8Bfr0kfhdhXQjAqctnc7Ux3GPl0lhRYMSx0lZuke+
	eQTJ0Fq0OiATFOggxnIdORkSrGfiIXkuVB//M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V1PxvI3McP124dIgrtONbK6vw4izSPDH
	1naPsZsIdG/68DYg/tiUpsEBb0Am6yzRfy9qRfQN6upmefehEk5lX9pkbu7+hsmX
	Xtyzinj301cs2E/RbKlWcY5kxOEWtbvjdUquDRUUbnro/TNtZ4aStu7hjq+orUl1
	hoR6kAzDO4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87FAC8A67;
	Tue,  3 Jul 2012 15:38:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16F428A66; Tue,  3 Jul 2012
 15:38:11 -0400 (EDT)
In-Reply-To: <20120703180439.GC3294@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Jul 2012 14:04:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0076626-C546-11E1-99BD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200937>

Jeff King <peff@peff.net> writes:

> Instead, we can just be more succinct and say "we can't
> delete this because we couldn't find it". So before:
>
>   $ git push origin :bogus
>   error: unable to push to unqualified destination: bogus
>   The destination refspec neither matches an existing ref on the remote nor
>   begins with refs/, and we are unable to guess a prefix based on the source ref.
>   error: failed to push some refs to '$URL'
>
> and now:
>
>   $ git push origin :bogus
>   error: unable to delete 'bogus': remote ref does not exist
>   error: failed to push some refs to '$URL'

This is telling a truth ($GIT_DIR/refs/bogus does not exist) but not
the whole truth; while I tend to agree that it is better than the
original (especially with ", and we are unable to guess..." part),
given that the above request would delete refs/tags/bogus or
refs/heads/bogus if they existed on the "origin", I am a bit worried
that it may send an incorrect message to novice users.

    unable to delete 'bogus': no branch or tag with that name

might allay my worries, but I am not extremely happy with that
wording, either.

> I think this would help. I used "remote ref does not exist"
> because that is the simplest explanation for the user.
> However, given that we will try to push a fully qualified
> ref that does not exist, a more accurate message might
> "destination refspec did not match" or something similar.  I
> prefer the former, though, as it less arcane.

Yeah, I do understand why you phrased that way, but still..
