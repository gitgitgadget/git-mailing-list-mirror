From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body headers
Date: Tue, 16 Sep 2014 11:01:05 -0700
Message-ID: <xmqqy4tj30ny.fsf@gitster.dls.corp.google.com>
References: <20140913205751.GA17875@mwanda> <20140913210908.GG6549@mwanda>
	<20140913212504.GA25190@peff.net>
	<20140913225713.GB189120@vauxhall.crustytoothpaste.net>
	<20140914004725.GA28010@peff.net>
	<CAPc5daWxZdi+JTTsznefPk2U+Q8uWWYuBUa-rJA4knDZzwU38w@mail.gmail.com>
	<20140914010120.GA28498@peff.net> <20140914013038.GA5974@peff.net>
	<xmqqha087lwv.fsf@gitster.dls.corp.google.com>
	<xmqq1trc63o8.fsf@gitster.dls.corp.google.com>
	<20140916001948.GC5019@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:01:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTx43-0005qu-Iq
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbaIPSBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 14:01:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58377 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbaIPSBP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 14:01:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4137038402;
	Tue, 16 Sep 2014 14:01:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uzgTGhIQtjbW46tF53VVLAnCoI4=; b=xZRBOj
	0epblcDWQr/7XLFW3rLYXQK9ppiqzE1iMo/MKHqxcy6wvIjVfDHhyZqtjQpn9VF6
	NkWEzoRtbeMFhY5nsS8Bb2bt9ykmO8whrbZdBDIFCu+7pJyWekAXILQRy6wAWgF+
	GIymLrWsd67yTH7nGFgkbxgAY1POHTaLrmexU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m+C2E4/cCZLL1zJIvFw4O59sDWWXQw2f
	MnZpzVMDffR7sOmhZ0TUH2C5NfHyZ+Gxn24SmJufUVFiz2XpSwJg3M2wk/sCy6wb
	M/NqjI/G6SJ4wTqIIxawiKv75ZCbY1ZcfrYOmNYiBN+8b6tp0euvAxO6GNG9nS16
	63uxgqiJBr8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A77F838401;
	Tue, 16 Sep 2014 14:01:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D6F5A38400;
	Tue, 16 Sep 2014 14:01:07 -0400 (EDT)
In-Reply-To: <20140916001948.GC5019@peff.net> (Jeff King's message of "Mon, 15
	Sep 2014 20:19:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6F10067C-3DCB-11E4-A1FD-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257133>

Jeff King <peff@peff.net> writes:

> The only cases that I can think of that would be a problem with this
> strictness are:
>
>   1. Somebody writes format-patch output to a file, reads in the mbox
>      using another program, and then writes out the result (munging the
>      mbox From line). And then pastes the whole thing into their email
>      body.
>
>      I can see the first part happening. But given that it is totally
>      irrelevant _unless_ they then screw up and paste the From line in
>      the body (which is already a corner case), it probably doesn't
>      matter.

Yeah, I tend to agree.

>   2. We change the static From lines that git generates. We can always
>      update the parser, of course, but it may be running a different
>      version of git than the sender.  People with an old git running
>      "git am" would stop skipping past "From" lines in messages from
>      people on newer gits.

I hope that it is not going to happen; the reason we refrain from
ever changing the datestamp has been to keep it constant to help
those who write magic(5), and I do not think we have a reason to
defeat that.

> I think you forgot to "git add" mbox.h. That being said, if we did go
> this route, I do not see any reason to share the code at all. This can
> be purely a mailinfo.c thing.

OK.  A reroll coming today when I find time.
