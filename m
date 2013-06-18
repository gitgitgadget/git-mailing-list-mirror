From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] rebase: write better reflog messages
Date: Tue, 18 Jun 2013 13:35:47 -0700
Message-ID: <7va9mn40nw.fsf@alter.siamese.dyndns.org>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
	<1371581737-10013-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 22:36:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up2dD-0000uT-G1
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 22:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933044Ab3FRUfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 16:35:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33689 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932644Ab3FRUfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 16:35:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8FD929EC9;
	Tue, 18 Jun 2013 20:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=9q5dwjSUW76gPC9ZDoqNReYgIZI=; b=oIqfXnRg8G0JX4zOZz+z
	+sxY1HIXxp7DOFmZX2H+gfiDt5MNPYO/ZkPyRwYDEwUamUUNr+ISrcWRYPKFNKFu
	o2kjU/7SpFCBlvioILEokSbg4HDCacgZfd4fk4JHSYwqM6u182fc2thx0DJgnMuf
	NJ+rfa3+hf0LHFO3PvwrLEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=F9Tk24TzqXc4Ew07QeIAbiNbgDB23l+nGuNEWtGSvxNeJy
	PR43nr6aon2Wv2EFlcAvJiYUjH/uoaKuwXbmUZ95YVQFWcAhbZDi5Q+9/gk9iJiK
	MD2ulKwKu/dj/IBXquvAp3J4Yp/G5PgVNVeFmLNwVCn3uHPqOxfo49WJz9Yxw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD90B29EC8;
	Tue, 18 Jun 2013 20:35:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2487129EC7;
	Tue, 18 Jun 2013 20:35:49 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A92CF15C-D856-11E2-BBE8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228312>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Now that the "checkout" invoked internally from "rebase" knows to honor
> GIT_REFLOG_ACTION, we can start to use it to write a better reflog
> message when "rebase anotherbranch", "rebase --onto branch",
> etc. internally checks out the new fork point.  We will write:
>
>   rebase: checkout master
>
> instead of the old
>
>   rebase
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

So the approach taken by this round is to change everybody's
assumption so far that they can start from a clean and usable
GIT_REFLOG_ACTION when creating their own message, and stop
depending on what is left in GIT_REFLOG_ACTION.

That would certainly allow this patch to leave whatever cruft in
GIT_REFLOG_ACTION, because everybody else will now create the value
to be assigned to that variable from scratch based on a new and
different variable.  All existing "everybody else" is converted to
adjust to the new reality.

A one-shot assignment "VAR=VAL git checkout" is sometimes cumbersome
to arrange, especially when what calls the "git checkout" is wrapped
in a shell function like "output", I think this is an OK approach.

If we are adopting that convention, however, the new variable that
holds the name of the overall program, base_reflog_action, needs to
be a bit more prominently documented in the code, to let the other
people know that is the new convention to follow.

Something like...

	# Use this as the prefix when setting and exporting
        # GIT_REFLOG_ACTION variable.
	base_reflog_action=am

And the fact that we are declaring the new convention and expecting
everybody to stick to it should be in the log message.

Thanks.
