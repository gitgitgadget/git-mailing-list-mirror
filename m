From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] remove prefix argument from pathspec_prefix
Date: Tue, 06 Sep 2011 12:58:16 -0700
Message-ID: <7vaaah8muf.fsf@alter.siamese.dyndns.org>
References: <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
 <1315132921-26949-1-git-send-email-drizzd@aon.at>
 <1315132921-26949-2-git-send-email-drizzd@aon.at>
 <7vmxeh8pf4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 21:58:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R11ms-0007Ai-9S
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 21:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab1IFT6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 15:58:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691Ab1IFT6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 15:58:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DD594C06;
	Tue,  6 Sep 2011 15:58:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v8iIbp3Z69yWyVkM79sutiIUnMI=; b=eiyvjA
	cZkdWJzz7sdlFzmjmdcytzQLfmQOk6F5QGjT5AHGpvylKRrcozxM7OQMoW8bvMwM
	HqtNCtMQxfLAgubefs3r8ELZr4x6AjgCYEh9r/0b8qGjsCl8rnHpyIhFh9rxCQRo
	z4bQm+ZN1tPrMy3XjcQ/CGV32HJa+oQukRGok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZArLaW3NmE2gqSmWmuCxCcOamjdjwSc/
	B7+tcbJq76GGHPiCWGrAgDowW7GWOMArACFWQn1NhD5+Zs8KGQHS9xVRJ9cLMxiJ
	jYm5ay7P0V1LspVJtx2dAXVslG7ftK7uxObRh6c7vwOOLfYq3gOSVDnaAwukk2Az
	oFAiJPteWrI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C7E4C05;
	Tue,  6 Sep 2011 15:58:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF5214C04; Tue,  6 Sep 2011
 15:58:19 -0400 (EDT)
In-Reply-To: <7vmxeh8pf4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 06 Sep 2011 12:02:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9188BFC6-D8C2-11E0-9C71-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180826>

Junio C Hamano <gitster@pobox.com> writes:

> Is it because we no longer ever return "prefix" we pass in which is a
> pointer to a constant memory region to begin with?
>
> We also didn't free() in the earlier code (because we do not know if it
> can be freed) and leaking xmemdupz() if the function didn't return the
> "prefix", but now you plugged the small leak. Isn't it something you
> should advertise?

Nah, the leak is not necessarily plugged in all callers anyway, so scratch
that part. I've rewritten it like this:

commit 5879f5684cfe8a38326b4ffd078f96e35c68e640
Author: Clemens Buchacher <drizzd@aon.at>
Date:   Sun Sep 4 12:41:59 2011 +0200

    remove prefix argument from pathspec_prefix
    
    Passing a prefix to a function that is supposed to find the prefix is
    strange. And it's really only used if the pathspec is NULL. Make the
    callers handle this case instead.
    
    As we are always returning a fresh copy of a string (or NULL), change the
    type of the returned value to non-const "char *".
    
    Signed-off-by: Clemens Buchacher <drizzd@aon.at>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
