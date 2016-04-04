From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 13/16] ref-filter: allow porcelain to translate messages in the output
Date: Mon, 04 Apr 2016 09:12:40 -0700
Message-ID: <xmqq7fgd73pj.fsf@gitster.mtv.corp.google.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
	<1459330800-12525-14-git-send-email-Karthik.188@gmail.com>
	<xmqqa8lfsk5e.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQjxmVHuXc0fZioe9OLi9vjNwgHQq-8vf1opWxbuedM9Q@mail.gmail.com>
	<vpqa8l9ztmd.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 04 18:13:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an77c-0007AA-Fc
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 18:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572AbcDDQMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 12:12:44 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755249AbcDDQMn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 12:12:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C29F4E4E1;
	Mon,  4 Apr 2016 12:12:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k11astf6bBdgfhFfaA2psS/BoZo=; b=CyISKv
	avWpG0Piyv8wNBBOP1iqTThWGAxjh4LxpRTlwm4mfv344TONrO0S2ExQO04+Nac/
	/N9AMrkPRLyYKo93/1WbqqAwCYci+ZvXl0XCk9kTv2mn73wXm3db8y/ciU9/Lqii
	Y0pbJFtkyjr5GXOvmak9k1suZDjC3JtHlQq+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EWJARO14ytTPpyHiXuIlgbZwbtQ7UpLo
	MP2t1Laqeqant1NQee7lMq+W1/vgsBwMAAmQYYVLJmFjfz141EiLZ1NgLhEKN/Hb
	dlChG26wMzAzDJ8wRr4RZpdgapZLiNlPPiHmAVcfZd/FEGDl4Fe6yvwfEaJNJZix
	J/cz6SVj5xE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 320464E4E0;
	Mon,  4 Apr 2016 12:12:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8369F4E4DC;
	Mon,  4 Apr 2016 12:12:41 -0400 (EDT)
In-Reply-To: <vpqa8l9ztmd.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	04 Apr 2016 10:05:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0EC9F30E-FA80-11E5-8F04-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290694>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I'm not sure how important it is in this case, but it was in the case of
> setup_unpack_trees_porcelain which I took inspiration from when we
> discussed this (actually, in setup_unpack_trees_porcelain, there's isn't
> any translation even in porcelain).

OK, so paraphrase:

In the most general case, we might want to have one code to issue
different messages between plumbing and Porcelain; further, for
Porcelain messages may or may not want to be translated.

But I suspect that all Porcelain messages should be translatable
in general, so there probably is a room for simplification.

The single macro P_() approach was done without knowing that this
codepath wanted the distinction between the plumbing and Porcelain.

> Note that this can be worked around later by adding another function like
>
>         static const char *get_message(const char *porcelain, const char *plumbing)
>         {
>                 return use_porcelain_msg ? porcelain : plumbing;
>         }
>
> to be called with get_message(_("this ref was gone"), "gone") or so.

Yes, I think that would be a way to do this properly.  And we do not
have a separate "here is the list of all translatable messages"
table, which is a big plus.

> In summary: both would work. No strong opinion from me, but I slightly
> prefer the version in the patch (i.e. the one I suggested IIRC) to
> Junio's version.

Yup.
