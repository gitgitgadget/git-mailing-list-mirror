From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/22] read-cache: add index reading api
Date: Mon, 08 Jul 2013 16:09:11 -0700
Message-ID: <7vk3l0y7hk.fsf@alter.siamese.dyndns.org>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
	<1373184720-29767-6-git-send-email-t.gummerer@gmail.com>
	<7va9lx100l.fsf@alter.siamese.dyndns.org> <874nc4rewd.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 01:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwKYY-00047F-LU
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 01:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab3GHXJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 19:09:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42611 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753403Ab3GHXJO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 19:09:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E93A2F353;
	Mon,  8 Jul 2013 23:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uWHTsaGda51aJBJZef8RbotqA0I=; b=oPDXy6
	0/FyqV9JwvFKkHZXx5PWYHukEJl/7vZ7K5XGws85CezsVjWQwBc/G95CLsIfiRmM
	bO5ldiKCtNXV69v+nmqZjK0d44PYU5Q9IU9CLLHkHgLVJ0C1ccly0DdBILuFu49Q
	Db0JurJyby92/vh4QMD7R0Qfw+fL+VmcoSxQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I10iJqo4ko2KERbPqDHmqR30zvzgJGYI
	yOkENJcboVDnFlpIspfNFZTGOZP99ycObltS5+JLcYpv658PIl8zeZCYpUW4wrvb
	B+Eu7h97398NnFYpqKCpa7zLTMFSO1a3DEIucxynuqrSXWJ0VPeS9rh55A/7Ogzj
	gZYjKIUCOTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34AA22F352;
	Mon,  8 Jul 2013 23:09:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA7802F350;
	Mon,  8 Jul 2013 23:09:12 +0000 (UTC)
In-Reply-To: <874nc4rewd.fsf@gmail.com> (Thomas Gummerer's message of "Mon, 08
	Jul 2013 22:10:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 672DE568-E823-11E2-A549-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229900>

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> The reader often needs to rewind the read-pointer partially while
>> walking the index (e.g. next_cache_entry() in unpack-trees.c and how
>> the o->cache_bottom position is used throughout the subsystem).  I
>> am not sure if this singly-linked list is a good way to go.
>
> I'm not very familiar with the unpack-trees code, but from a quick look
> the pointer (or position in the cache) is always only moved forward.

I am more worried about o->cache_bottom processing, where it
currently is an index into an array.

With your ce->next_in_list_of_read_entries change, a natural rewrite
would be to point at the ce with o->cache_bottom, but then that
would mean you cannot in-place replace the entries like we used to
be able to in an array based implementation.

But your series does not seem to touch unpack-trees yet, so I may be
worried too much before it becomes necessary.
