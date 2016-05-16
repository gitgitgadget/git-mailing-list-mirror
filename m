From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] pathspec: record labels
Date: Mon, 16 May 2016 11:52:10 -0700
Message-ID: <xmqq8tz93kf9.fsf@gitster.mtv.corp.google.com>
References: <20160513231326.8994-1-sbeller@google.com>
	<20160513231326.8994-6-sbeller@google.com>
	<xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZsVH3mE0zXu9wSWgit3QZ_CiKZqg-TQdyWnZw6D9=Cgw@mail.gmail.com>
	<xmqqlh393nuv.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbN_pzAVeAa-St_KRs60SbURTfKKP0v+do_+MK7orTkTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 16 20:52:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Nco-0002nN-Pg
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbcEPSwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:52:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754054AbcEPSwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:52:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DDD4C1C3E5;
	Mon, 16 May 2016 14:52:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QIxiIib/zFOmzKmTZg4qQU1l6SE=; b=ZEl/NZ
	CpVnSPN+Fg8ZCXW4smiF/f25c9Wp9W4mIk059lo/pmGM5DsjSLEGLG2M2e+swYkM
	Z3PIYbY8w24ZIAaFDBo8jHm0GCa0S6qoGJK8LprNZnlTaUSk+lLbe6r19MuyWuRl
	Cb8VYouvNpjtdOtp1Gb7k4OPFcxwEXlTjKu6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FAFY3DJf4JEU6DvLX5zRrJ3tjScTnoVy
	BUM+si6Yxw8p/9kMjhJ21VdHxJWihE/MEbTilhIvYzWkh7qgmGAsML4AycOscxPe
	PJRg81bRABrPhHYqN4bVZWH8p91rpdo3ePlv61iYFaZ+5mfqT4FD/LOUne7bwlIn
	I7V06Av0GtM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D40B71C3E4;
	Mon, 16 May 2016 14:52:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D1D61C3E2;
	Mon, 16 May 2016 14:52:12 -0400 (EDT)
In-Reply-To: <CAGZ79kbN_pzAVeAa-St_KRs60SbURTfKKP0v+do_+MK7orTkTg@mail.gmail.com>
	(Stefan Beller's message of "Mon, 16 May 2016 10:46:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4CC3AB7C-1B97-11E6-B0DD-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294776>

Stefan Beller <sbeller@google.com> writes:

> So "warn and ignore" for data from .gitattributes and die for
> commandline arguments? That makes sense.

Yes.

On the "command line" front, because we may want to give different
meanings to these two entries in the future:

        :(label=-doc)Documentation/
	:(label=!doc)Documentation/

we should diagnose -doc (FALSE) as an error, not treating it as the
same as !doc (UNSET).  And we should warn and ignore -doc (FALSE) in
.gitattributes.  Yes, ignoring it would be more or less equivalent
to treating it as UNSET, but because we may use -doc (FALSE) for a
better purpose later, we should still warn.

> Ok, so here is the warn-and-ignore code:
>
>
>         if (ATTR_TRUE(check.value))
>                 ret = 1; /* has all the labels */
>         else if (ATTR_FALSE(check.value)) {
>                 warning(_("Path '%s': Label must not be false. Treat
> as if no label was set"), path);
>                 ret = 0;

s/Treat as if .../The -label may be used differently in future
versions of Git, so do not use it/;

But if we are going in the direction of :(attr:crlf=auto), all this
discussion is moot, isn't it?  I haven't formed a firm opinion on
this, but it sure does sound tempting, doesn't it?
