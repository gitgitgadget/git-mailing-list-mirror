From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] commit-queue: LIFO or priority queue of commits
Date: Mon, 10 Jun 2013 16:23:31 -0700
Message-ID: <7vd2rteej0.fsf@alter.siamese.dyndns.org>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-3-git-send-email-gitster@pobox.com>
	<20130610052500.GD3621@sigill.intra.peff.net>
	<7vwqq2l9cz.fsf@alter.siamese.dyndns.org>
	<20130610181557.GA2084@sigill.intra.peff.net>
	<7v1u89iyla.fsf@alter.siamese.dyndns.org>
	<20130610185907.GD2084@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 11 01:23:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmBR4-0000T2-5S
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 01:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab3FJXXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 19:23:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485Ab3FJXXd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 19:23:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C393271CF;
	Mon, 10 Jun 2013 23:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=90XKMOCQMKj7yqwNyqKWwLgp848=; b=aAIzpf
	ZlLl9pse2SNJHWPt4n0L5qm2qJWsIFwLr2B9MYvVO3ZqE1uEKgQBaHo+WvQh18Bf
	3ZDH2xXITOsr1+2wlk3mvilu+BIcADgnn/4YK8/17THi/w1pZZhg97IThvHluGNh
	DsN6s2c/AZo5v6fLvo4jd1wmgFmDZ6B3gvsAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=chC2BQm6+EfT4NxeRlOKHq60yexkxt/+
	ILN0RFp5dzPHjQS3b/yRZr2G9ShK0zKORY10OMWhxhbzNJCMaLDWPKZ190P90W7v
	4gy4Ei3k9+A7YRpaQTW/1rhWHqggP7yVIxjiRcEc+sUUV66WGKyUObUC0W8YiY9Q
	7ha2wQB60Xc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 115F3271CD;
	Mon, 10 Jun 2013 23:23:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 777E3271CB;
	Mon, 10 Jun 2013 23:23:32 +0000 (UTC)
In-Reply-To: <20130610185907.GD2084@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Jun 2013 14:59:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C41643B6-D224-11E2-ADD1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227401>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 10, 2013 at 11:56:33AM -0700, Junio C Hamano wrote:
>
>> > or similar. I didn't change the name, either. It may be silly to call it
>> > "commit_queue" still since it is now more general. I simply called mine
>> > "queue" (I wanted "pqueue", but that conflicted with globals defined by
>> > OpenSSL; yours is a more general queue anyway, so maybe that is a good
>> > name).
>> 
>> I agree that it makes sense not to call it either commit-queue or
>> pqueue.  While at it, the filenames should probably be moved as
>> well, no?
>
> Yeah, definitely. I left all of that as an exercise for you, since the
> name change will involve a lot of fallout in the other patches.

OK, I pushed out a result of some renaming and rebasing.  Notable
changes are:

 - The data and API is called prio-queue and they live in prio-queue.[ch];

 - The test script is also named test-prio-queue.c, to leave the
   door open for other kinds of queue;

 - For now, record_author_date() does the obvious read-sha1-file and
   free; and

 - The comparison callback's function signature had three "void *",
   so they are named in the header file now.  Also two "thing"
   pointers are marked as "const void *".

I may have flipped the comparison < vs <= as well.

Thanks.
