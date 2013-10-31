From: Junio C Hamano <gitster@pobox.com>
Subject: [BUG?] "error: cache entry has null sha1"
Date: Thu, 31 Oct 2013 10:11:49 -0700
Message-ID: <xmqqeh719xgq.fsf_-_@gitster.dls.corp.google.com>
References: <20131031063451.GA5513@sigill.intra.peff.net>
	<20131031063626.GB5812@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 18:12:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbvmn-0003vs-RF
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 18:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab3JaRLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 13:11:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab3JaRLx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 13:11:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87A514CC5F;
	Thu, 31 Oct 2013 13:11:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qrrZzh3Nti0ecS+3cIskz56h0yw=; b=t4762f
	X5GEx36PwPjjv16O6dT0CMEjMHmlt7fRX7aoe59aBWX7TRgzcnlLtevBQXTDZ79C
	lUqWFsYbzwmaYrWm696dhS3CjHcZGHH4RWqsh6fx122qWw5PMGIvCPMUTQhn0474
	9ZYzpfCD1iGwzHT2QUXHK1bzZhjqrr5tkYSDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vXezZCF9fnIxKiXtDmoH3eRDHHygSTz9
	xHf9PxCDzEtfw3Iwf2/GvuC9B7SCbsPpjguAp7UMN3Gtfpfz3VKAOPjJmWEG9fQC
	qxt7ctmJc+7gY6h+44Fp00C2dkvaT4/OG/59t9tol0a8Q2sGYIozRwOMXavmJKQp
	N3gq61LOfsM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BC4D4CC5E;
	Thu, 31 Oct 2013 13:11:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7B374CC5C;
	Thu, 31 Oct 2013 13:11:51 -0400 (EDT)
In-Reply-To: <20131031063626.GB5812@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 31 Oct 2013 02:36:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 88E1F89E-424F-11E3-9B9E-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237129>

This is totally unrelated to this thread, but I am seeing a strange
error from the "let's make sure we won't write null sha1" code we
added recently.  This reproduces reliably for me, even in a freshly
cloned repository without previous rerere records:

 - Check out v1.8.4.1

   $ git checkout v1.8.4.1^0

   at this point your HEAD should be detached.

 - Apply the first patch from this series

   $ git am -3 20131031063530.GA5812@sigill.intra.peff.net

 - Apply the second patch from this series

   $ git am -3 20131031063626.GB5812@sigill.intra.peff.net

   Up to this point things should advance smoothly

 - Attempt to apply the second patch _again_.

   $ git am -3 20131031063626.GB5812@sigill.intra.peff.net

   This should detect a no-op, but somehow leaves things in a
   conflicted state.  I haven't looked into what is wrong, but this
   message is not about this failure.

 - Try to discard

   $ git am --abort
   error: cache entry has null sha1: remote-curl.c
   fatal: unable to write new index file

   This should not happen, no?

"git reset --hard" will remove the funnies, but still...
