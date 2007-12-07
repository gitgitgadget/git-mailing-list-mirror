From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add a --nosort option to pack-objects
Date: Fri, 07 Dec 2007 13:25:24 -0800
Message-ID: <7v4peu19kr.fsf@gitster.siamese.dyndns.org>
References: <1197061832-8489-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0kht-0006UH-DP
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbXLGVZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754051AbXLGVZi
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:25:38 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:37938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042AbXLGVZh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:25:37 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D400E14F7;
	Fri,  7 Dec 2007 16:25:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D93F114F4;
	Fri,  7 Dec 2007 16:25:26 -0500 (EST)
In-Reply-To: <1197061832-8489-1-git-send-email-mh@glandium.org> (Mike Hommey's
	message of "Fri, 7 Dec 2007 22:10:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67460>

Mike Hommey <mh@glandium.org> writes:

> The --nosort option disabled the internal sorting used by pack-objects,
> and runs the sliding window along the object list litterally as given on
> stdin.

I think this is a good way to give people an easier way to experiment.

But it makes me wonder if this is disabling too much, and if the list
should be sorted at least by type, as we won't delta different types of
objects against each other.

At the beginning of try_delta(), when we see that the next candidate is
of a different type, we return -1 telling the caller that "No object in
the window will ever be a good delta base for the current object, please
abort".  This relies on the fact that we sort by type first, so I think
one of the following is necessary:
 
 (1) you weaken this check (return 0, saying "This did not delta well but
     do not give up yet"),

 (2) you document this well so that --nosort user will know, or

 (3) you sort --nosort input by type.

>   I would obviously add the appropriate documentation for this flag if this
>   is accepted. I'll also try to send another documentation patch for
>   pack-objects with some information compiled from Linus's explanation to my
>   last message about pack-objects.

I need to rant here a bit.

Sometimes people say "Here is my patch.  If this is accepted, I'll add
documentation and tests".  My reaction is, "Don't you, as the person who
proposes that change, believe in your patch deeply enough yourself to be
willing to perfect it, to make it suitable for consumption by the
general public, whether it is included in my tree or not?  A change that
even you do not believe in deeply enough probably to perfect would not
benefit the general public, so thanks but no thanks, I'll pass."

Fortunately we haven't had this problem too many times on this list.

I would not have minded at all if you said:

	Obviously, appropriate documentation and tests are needed before
	inclusion, but I am sending this out primarily to seek opinions
	from the list to make sure this is going in the right direction,
	iow, this is an RFC.

What bugged me was the phrase "if this is accepted".
