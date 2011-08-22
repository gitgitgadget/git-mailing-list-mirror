From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/1] git-clone: fix relative path problem in the
 alternates
Date: Mon, 22 Aug 2011 14:57:17 -0700
Message-ID: <7vliulun2a.fsf@alter.siamese.dyndns.org>
References: <1314003957-9455-1-git-send-email-jason77.wang@gmail.com>
 <7v7h65w9d7.fsf@alter.siamese.dyndns.org>
 <7vzkj1uqpa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 23:57:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvcUp-0005Vx-7U
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 23:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab1HVV5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 17:57:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab1HVV5V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 17:57:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA095447C;
	Mon, 22 Aug 2011 17:57:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KRHU8vR+foerSxSvPrfGzEHXQ+k=; b=IVUBNs
	T0OW0Upi2RidW5x7M3IdNAl7efU7dPXx2T5ptza+BofMHxTJL/C3YrKZmPnzhrtb
	YIW5B/z8byMx+uGW2rZ8aRqV96Px2dVNnOaDp1CVJECmrz56IkYh7obvDSnl/StG
	51tetrkCy4Xq3G+JIH2bDLSe02czSb37+2lQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W9OrqmGFoD2A+MF1rDNJSlM5K4DDsoap
	95PmsX9kRh3ZGDQKtbokLKHHFUPLzXCHeaXYSQb88g9NGBNbIk4VQcbg/S7UT1ah
	bhDp9JR/lyq2ihPRqVC6b3wXD0qjbGuwY+2rLdYN5FidFfxRMyzbrpu7AgypnQrC
	zkra4EfgkRA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B16A5447B;
	Mon, 22 Aug 2011 17:57:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E58B447A; Mon, 22 Aug 2011
 17:57:19 -0400 (EDT)
In-Reply-To: <7vzkj1uqpa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 22 Aug 2011 13:38:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4B609FA-CD09-11E0-908F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179894>

Junio C Hamano <gitster@pobox.com> writes:

> While at it, we may probably want to update the command option handling so
> that you can give more than one --reference= parameters.

Geez. There appear to be more bugs in the existing code.

If you

 - specify --reference;
 - the source of the clone is a local directory;
 - you do not specify --shared; and
 - the source of the clone has its own alternates

we end up exercising this call flow:

	init_db();
        setup_reference();
        -> add_to_alternates_file();
           This writes objects/info/alternates in the new repository
	clone_local();
        -> copy_or_link_directory(src/objects, dst/objects);
           -> copy_or_link_directory(src/objects/info, dst/objects/info);
              -> unlink(dst/objects/info/alternates);
                 link(src/objects/info/alternates, dst/objects/info/alternates);

and lose the --reference given from the command line.

The problem you are trying to address is a valid one, but it needs to be
fixed by teaching copy-or-link-directory that objects/info/alternates is
special. We need a more proper fix than "just let the recursive copy do a
possibly wrong thing and then patch it up if it is wrong", which is the
approach taken by your patch.
