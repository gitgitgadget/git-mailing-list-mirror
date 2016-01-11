From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 11:35:38 -0800
Message-ID: <xmqqmvsbx62d.fsf@gitster.mtv.corp.google.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
	<1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
	<xmqqh9ikxbv7.fsf@gitster.mtv.corp.google.com>
	<20160111192844.GD10612@hank>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 20:35:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIiFk-0000Si-SZ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933313AbcAKTfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:35:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757379AbcAKTfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:35:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D6FA63A324;
	Mon, 11 Jan 2016 14:35:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=laG1dZas0IIUuFID9OYlGhE/5Zo=; b=p5E9FO
	4eRh8aLoVQ9GAp589ltvLxyHaY+9t5z4KawOqnaZKfza58Gi3sxM3k3DaUoXr3WI
	Jpt74biiFHufE31xKd0wvH0XesV5RY3oA9CsSK5yxI9l7W20QehcRvJgF/lz82AH
	mWwFaG9eiHEkhHYhwsiLQqYCRyuZmn33yM7vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=umPIbxFe/ojZ3F4T6c9XWTfsgJxmQMDA
	g/z4r66xOPwSMzNpGaDzdt7+Jxz5GUmsl4Goi3kAnvBCS3cFcozm/mz3WOOhMBWy
	7WlU8UkhOYoPzCHfj6pZmrzwCMbTsRh1EsmpKWHlZiGx2TJE2IYtsjsSeJ0UJQ+H
	ciNCVx70IWI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD89B3A323;
	Mon, 11 Jan 2016 14:35:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4990B3A322;
	Mon, 11 Jan 2016 14:35:39 -0500 (EST)
In-Reply-To: <20160111192844.GD10612@hank> (Thomas Gummerer's message of "Mon,
	11 Jan 2016 20:28:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7E99A18E-B89A-11E5-ACA9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283701>

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> > +#define GREP_NO_INDEX_EXPLICIT 1
>> > +#define GREP_NO_INDEX_IMPLICIT 2
>>
>> I am not sure this is the best way to do this.  For things like
>> this, the usual pattern is to initialize "no_index" to an "unknown"
>> value, allow "--no-index" to toggle it to true (by the way, I think
>> we should reject "--no-no-index", but that is a separate topic), and
>> then after command line parsing finishes, tweak the no_index if it
>> is still "unknown".
>
> The reason for this (and the change in 02/03) is so we can distinguish
> whether there is an explicit no-index or not for the error messages.
> I think it would be okay to have more generic error messages
> ("--cached or --untracked cannot be used without index" and
> "--untracked or no index mode cannot be used with revs").  What do you
> think?

I can understand that you need three states (--no-index given
explicitly from the command line, we fall back to --no-index when we
found we are in a diretory not under control by Git, and we do want
to use the index) to be able to give different messages between the
first two cases.

The usual way we do that is by making the variable tristate (which I
outlined in the previous message, initialize use_index to -1
"unspecified" and then fix it up when it is left unspecified after
you check the config and the command line option).

I however fail to see why that necessitates to change use_index to
no_index, making the code harder to follow by introducing double
negation.
