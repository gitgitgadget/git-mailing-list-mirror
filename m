From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/83] builtin/apply: extract line_by_line_fuzzy_match() from match_fragment()
Date: Tue, 26 Apr 2016 13:20:38 -0700
Message-ID: <xmqqbn4wf7ft.fsf@gitster.mtv.corp.google.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-6-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kYi0seMF12+Y4VxHBJxTh9wo4LUw0A50PYRvZEBvj6SBA@mail.gmail.com>
	<CAP8UFD228joDLyomvae7rVs02TuTbmEHerwWvH=VR+FE-YFLRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:20:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9TU-0001V6-2n
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbcDZUUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:20:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752568AbcDZUUm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:20:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6029F15F28;
	Tue, 26 Apr 2016 16:20:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sDRjOEP9E2JIXnbwP514S8DQu04=; b=TaP2Vq
	N354YN+/bKddsrOc49Bw/NL4H1mxX66/IvFXgtrDTvcAhWHjMN7hthV0oWU0XVF3
	PVakqMcJRKxvs9qtCwKLSnd0oUr3HbPB1foqEGBipYuio67iZJJiMzy+o/altpKN
	dP2pnneMIOfc7x3eJksM9RAMkU/xQ5P+Bo7Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G6T0yWWuF+ADyXW9Mx/vq8LdeXpkrlG7
	RssQ5KrzN5JN9/Rk7R0ax+Dy4/S3dTjymordx18nawdlKji6d0fmpjSNzdZq7lL+
	QutdGCBz2TaQ4xeBOX39HnJRJQJqnXi6s7Anpa7RyMP6skzEcQG3wtnkRCi95h/+
	1z/YwjMG+TE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 578B715F27;
	Tue, 26 Apr 2016 16:20:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9028215F25;
	Tue, 26 Apr 2016 16:20:39 -0400 (EDT)
In-Reply-To: <CAP8UFD228joDLyomvae7rVs02TuTbmEHerwWvH=VR+FE-YFLRA@mail.gmail.com>
	(Christian Couder's message of "Tue, 26 Apr 2016 18:15:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57ECC1C4-0BEC-11E6-BDA7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292659>

Christian Couder <christian.couder@gmail.com> writes:

>> It's not clear why we need to declare buf here? Oh wait it is. It's just
>> moved from the start of the function. But why do it in this patch?
>> It seems unrelated to the general intent of the patch. No need to reroll
>> for this nit alone, it just took me a while to figure out it was an unrelated
>> thing.
>
> Yeah, I agree it's a bit unrelated. But rather than add another patch
> to an already long series just for this,...

Isn't not doing the unrelated move at all a more sensible
alternative, if that change does not deserve its own place in the
series after all?
