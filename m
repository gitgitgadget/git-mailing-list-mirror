From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 11:42:49 -0800
Message-ID: <xmqqa910cax2.fsf@gitster.dls.corp.google.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
	<xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
	<xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
	<20150130181153.GA25513@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 20:43:04 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHHT1-0001nv-IJ
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 20:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760549AbbA3Tmx (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 14:42:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752555AbbA3Tmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 14:42:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0641F315F5;
	Fri, 30 Jan 2015 14:42:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AswEAN+6oo4JDOe2yPKw2f0Fw00=; b=PlSaLE
	LlIW6fyugNk/aQpoZkYoW6G4Ra5M0yYzHajLJj9tJFE7B2Gn12vrGmHps2lgW/tl
	1EYpehZAzTCHlCmi+CYGRmuFczSrIyE2UJqIg/MahxL+BO0p1VtJnjeILNuzb/qJ
	/gSfsATX6v62ZOPJvZzgmgV01KCpoxcQndHq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZUaxTaMYRYz6w9XafeyKrJEGmV9tSE6U
	Pz/uTZMMFthphNwpn5VZfiPBvnXXRF2x7tsUegdXIYlKzeRZ9bIFvgJaz4tOINFr
	adT7Tr+/wh+EUbEV3z9U8wC2MXyTCnZBBkO4p6mr2WiZsUbjkuSv6X0anFBOId/y
	GP+sFIkyMUY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0FB0315F1;
	Fri, 30 Jan 2015 14:42:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 651AA315EF;
	Fri, 30 Jan 2015 14:42:50 -0500 (EST)
In-Reply-To: <20150130181153.GA25513@peff.net> (Jeff King's message of "Fri,
	30 Jan 2015 13:11:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2CACFBB6-A8B8-11E4-9F12-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263189>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 29, 2015 at 12:45:22PM -0800, Junio C Hamano wrote:
>
>> +	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
>> +		return error(_("affected file '%s' is beyond a symbolic link"),
>> +			     patch->new_name);
>
> Why does this not kick in when deleting a file?

Half-written logic, forgotten to be revisited (i.e. "ok, anything
that is not delete we can check new_name, so do that first, later
we'd deal with deletion patch and I think the way to do so is by
checking old_name, but let's make sure this case works first").

Thanks for catching.
