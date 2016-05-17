From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/12] attr: (re)introduce git_check_attr() and struct git_attr_check
Date: Mon, 16 May 2016 22:06:11 -0700
Message-ID: <xmqqr3d1xoho.fsf@gitster.mtv.corp.google.com>
References: <20160516210545.6591-1-gitster@pobox.com>
	<20160516210545.6591-10-gitster@pobox.com>
	<CAPig+cR5ksdATefkYkG7-+a_nK0w+Fdu8ae-Z4=PTp8yAYhiQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 17 07:06:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2XD2-0001Nw-1U
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 07:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbcEQFGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 01:06:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932369AbcEQFGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 01:06:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 12FED1CA20;
	Tue, 17 May 2016 01:06:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ESiXgE7lztRi18oR3toSBUGirwU=; b=oLq1TF
	+qlEV8Cg/OERvikJIj6/HhcQeQy9H2p2KJ7fBRdMNvoMZHKa6dUWBD0IyFTifNoR
	40qaVDbuzKFZdrfJqWg1CeTfIpWOQxniWPzwZnpA0qurGfc0ovxbcsiknYJAEx+Q
	sBefQwV/2JjJuWtkV797q202gu+ziLl53LCUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YzjkaVVfOysPPSsJ+qKoPQ/BVnFtpoE+
	/8016Fg0rAWR4w6uSKVQhWb0aDIAIrcgEslDwqN71CKeQTXlZVAPiZ50qSTRd0lG
	ocEno2D4gxjUV+Yne/toX2h0tDsPmaKObf8b2DpmvmpbfgNwq8+FPZZgiEm3LzaM
	wfPxSHXqw40=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B7DA1CA1F;
	Tue, 17 May 2016 01:06:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 810DC1CA1D;
	Tue, 17 May 2016 01:06:13 -0400 (EDT)
In-Reply-To: <CAPig+cR5ksdATefkYkG7-+a_nK0w+Fdu8ae-Z4=PTp8yAYhiQQ@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 17 May 2016 00:19:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13D6AF20-1BED-11E6-B6B3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294856>

Eric Sunshine <sunshine@sunshineco.com> writes:

> This field is unused, and git_attr_check_initl() neglects to
> initialize it (if it is intended to be used in the future).

There are two patterns to use the new API:

 - initl() variant is "initialize it once, never extend"; it is very
   much deliberate.  This is used by the majority of current
   callers, that know that they want a fixed set of attributes and
   can say what attributes they want upfront.

 - alloc then append variant will use the usual ALLOC_GROW() pattern
   with nr/alloc.
