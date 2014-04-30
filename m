From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/32] read-cache: split-index mode
Date: Wed, 30 Apr 2014 06:57:27 -0700
Message-ID: <xmqq38guj4xk.fsf@gitster.dls.corp.google.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
	<1398682553-11634-18-git-send-email-pclouds@gmail.com>
	<xmqq1twhnkbz.fsf@gitster.dls.corp.google.com>
	<CACsJy8BEJdA+d5DL94n4o3FRphs9bNPhX9oKK3MmOfTTBY=f9Q@mail.gmail.com>
	<xmqqiopskq1o.fsf@gitster.dls.corp.google.com>
	<CACsJy8Da=n+kh8_bUkJ11-dK09A6zOMnhBQJCsPCWcCJ2mY0pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 16:00:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfV3u-00036Z-O6
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 16:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759156AbaD3OA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 10:00:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759141AbaD3OAX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 10:00:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 322397F915;
	Wed, 30 Apr 2014 10:00:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pfjS5W2OtUiyhlYy1+A+BQqn8Eg=; b=FfApoS
	UEWQcDdfVHtKmSyY35tY4qoK2AkQNGinPcPbxN1q5HstnaBVnQPyvI1bPd4Wq0qJ
	h7Zv04/pL7SSnpFAGfaDUbCLqPLxf++i2MvfCg+vsAiGkXrMZo6WhCFSG7GGUp5n
	tQvYj1OYk/t275ZgQcaRd5vUfAz1boZaWXmwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sXgLDgmMJWjyUVjZBsb8MuxEnSK2/ROL
	j3fwFAb0Zngc8+3Kyyv0CSpxBL6mzaBiPikOB4GTFGKGyyqNKn0uBzg1c/jm13D1
	UyUQdee/SlfSefVRFA8fj4ERHYllUd8Rn/zftU63AXQBIVpzWBDkjFX0ZBGteyvB
	XbxwqQoZAM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12CD67F914;
	Wed, 30 Apr 2014 10:00:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC1227F7F7;
	Wed, 30 Apr 2014 09:57:28 -0400 (EDT)
In-Reply-To: <CACsJy8Da=n+kh8_bUkJ11-dK09A6zOMnhBQJCsPCWcCJ2mY0pw@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 30 Apr 2014 05:45:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5E0F9A8C-D06F-11E3-AB61-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247712>

Duy Nguyen <pclouds@gmail.com> writes:

> when no entry is reused). I kinda hope to avoid that.

I see.

> Speaking about
> reusing cache_entry, we won't be able to share cache_entry because
> when it's freed in replace_index_entry, or remove_index_entry_at in
> the main index, we need to locate the same entry in the shared index
> as well and remove that stale pointer. Without sharing, we nearly
> double memory usage from the beginning.

Yeah, the point being to have most of the entries come from the base
one, it is expected the real one and the saved base one will be
mostly the same, so sharing is really necessary.
