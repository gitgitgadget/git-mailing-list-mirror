From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/22] lockfile: allow new file contents to be written while retaining lock
Date: Wed, 02 Apr 2014 10:26:50 -0700
Message-ID: <xmqq38hvwskl.fsf@gitster.dls.corp.google.com>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
	<1396367910-7299-23-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:39:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeT3-0000xS-Fd
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbaDBR05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 13:26:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37700 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758860AbaDBR04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 13:26:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B80D4784B8;
	Wed,  2 Apr 2014 13:26:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zsFyL+K3S7W+kNHym00AWRpgRvo=; b=LWbq0Y
	NA0bwXkIEqDp8Zn4woJxfXpMPPoLpDBu/R0KxeiRrBB38Odtqi+TaEtKulpM1rhf
	SVh+DLZNApx6muSGtABB3cb0+PVEt3zw2K2SUE8XQH3lp/7tjxM8pVJxqgxjs5PA
	iSzQV7YPGNsLVat0hgVTzubatvyGWMmnLYIog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mapSaN81JesUIuj2aLfMpe0ubgLUEnkd
	dSkYx0Gq65ajxevBLGWf4yq8Aj5DB9Fi93gFXM/nGSOEj+LuGhM+QcfAJwlA5/1S
	HkoKwWYzj4DlMk6LsHdVtgCb5VyzO1LocZfsj23Eq+n2WrhLTBaghB9SnMg+6jEK
	2QKYLAptHok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ED15784B6;
	Wed,  2 Apr 2014 13:26:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72B17784B2;
	Wed,  2 Apr 2014 13:26:52 -0400 (EDT)
In-Reply-To: <1396367910-7299-23-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 1 Apr 2014 17:58:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FAF4C38A-BA8B-11E3-B03E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245690>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +static int open_staging_file(struct lock_file *lk)
> +{
> +	strbuf_setlen(&lk->staging_filename, lk->filename.len);
> +	strbuf_addstr(&lk->staging_filename, ".new");
> +	lk->fd = open(lk->staging_filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
> +	if (lk->fd < 0) {
> +		return -1;
> +	}

All the other "if (lk->fd < 0)" calls reset_lock_file(lk).  Is it an
intentional omission that this one does not?

If so, please drop the extraneous {} around the single "return -1"
statement.

I also share the same puzzlement in Peff's review.
