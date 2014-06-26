From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Thu, 26 Jun 2014 14:21:00 -0700
Message-ID: <xmqqzjgz2wqr.fsf@gitster.dls.corp.google.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
	<53A84077.4010200@ramsay1.demon.co.uk>
	<xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
	<53A99FEB.5040808@ramsay1.demon.co.uk>
	<xmqq61joamcc.fsf@gitster.dls.corp.google.com>
	<vpq1tubinbx.fsf@anie.imag.fr>
	<xmqqpphv4hu6.fsf@gitster.dls.corp.google.com>
	<53AC724E.3090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 23:21:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0H6Y-00088e-KS
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 23:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbaFZVVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 17:21:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64743 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbaFZVVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 17:21:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EE11226ED;
	Thu, 26 Jun 2014 17:21:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WxQgiO438w9VsKu6EPnRdKQMVeg=; b=BbQjyL
	fsupQWAW5f5cfanrt9gwPX7y9JxmAAkGKdST66zMdtjUP9F+8XscKxk6lG9jJZcI
	FWTcFT2EikCONz1XqLkcRiJu3YmeRZcx7bsp9tGKXIpo7Cpex2r6KjfFAGU49kYb
	ZEq73JNsymv/tUIylI2ID5NfyWpJeFHSo4na8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oKT3HYEW84YRjpHnl47DYwxn4+XwIGYg
	w8YGjUSAiqlwzZsBD6+V4asmFrXv7Cad+Fn/DZl3vlzH9ObCFym+tLewUfglaxYV
	lHKZOeCPXsYpH+hfJl3v9TSHEUzZejcWRAAnww7FwzX8aWuC836bBqqxu5bp8TOQ
	8iw3xvxzYbI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 646E0226EC;
	Thu, 26 Jun 2014 17:21:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 70C2D226E7;
	Thu, 26 Jun 2014 17:20:56 -0400 (EDT)
In-Reply-To: <53AC724E.3090106@gmail.com> (Karsten Blees's message of "Thu, 26
	Jun 2014 21:19:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C2FB3462-FD77-11E3-9893-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252527>

Karsten Blees <karsten.blees@gmail.com> writes:

>> Because I had an experience under my belt of a painful refactoring
>> of "the_index" which turned out to be not just a single array, I
>> simply suspect that the final data structure to represent a "set of
>> config-like things" will not be just a single hashmap, hence I do
>> prefer to have one layer of abstraction "struct config_set", which
>> would contain a hashmap and possibly more.  Doesn't "is the hashmap
>> initialized" bit belong there, for example?
>
> Would an additional
>
>   int hashmap_is_initialized(constr struct hashmap *map)
>   {
>     return !!map->table;
>   }
>
> API help? (Note that hashmap_free() already does memset(0), so the
> usual notion of "zero memory means unitialized" applies).

It may remove the need for the separate "hashmap_initialized" bit
that was implemented as a file-scope global in the patch.

I however am not convinced that it will be the _only_ thing other
than the hashmap we would need to use to keep track of the in-core
"set of config-like things", and usually a blanket statement "these
are the only thing we would ever need" tends not to hold for long,
so...
