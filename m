From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be sha1 based
Date: Fri, 28 Mar 2014 11:36:13 -0700
Message-ID: <xmqqtxai9nmq.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>
	<xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>
	<20140325092215.GB3777@mini.zxlink>
	<xmqq4n2mmarr.fsf@gitster.dls.corp.google.com>
	<20140326195201.GB16002@mini.zxlink>
	<xmqq1txoiqzj.fsf@gitster.dls.corp.google.com>
	<20140327142438.GE17333@mini.zxlink>
	<xmqq1txneavo.fsf@gitster.dls.corp.google.com>
	<53351C1B.6040609@viscovery.net>
	<xmqq4n2ickx4.fsf@gitster.dls.corp.google.com>
	<5335B57B.4080606@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@navytux.spb.ru>, kirr@mns.spb.ru,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 19:36:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTbdn-0004rR-R2
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 19:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbaC1SgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 14:36:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbaC1SgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 14:36:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 494DA778CD;
	Fri, 28 Mar 2014 14:36:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X72seT9TG+U/zdn1vA6rrZLM6x8=; b=tcsmEE
	iDuvugbn5R3SewIRd0Gthj7Jf2oHwxIwEvxYfs8lvdsEIUR3PtnqdIkZAsla2akQ
	gIzxVUkL4w2j2EOTBqq8MuRAmByhO9ZKhQ2IKRfijtr5MwFsUQ0XsD1oOTkPQ+4a
	UZoCgL85mm6TXw+NkfLcbOTJEjzCVdP2K+jzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RHkXFW1dKLbg7kkvo/Ki1yED2lZ14jEb
	MTDpv1MxofyKxp9kAMIlMe7qfB7WShJCI/OysfzTElSG1ixCaVBq1XLKDGChokXJ
	f2c5oVJP/6bKp21Pe4wrJV4odd+dSTgWtxXYud91llog91EDPsn4g7K4T8Cd1BrL
	sp9Y/lubiwk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32A54778C8;
	Fri, 28 Mar 2014 14:36:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 489D4778C5;
	Fri, 28 Mar 2014 14:36:15 -0400 (EDT)
In-Reply-To: <5335B57B.4080606@kdbg.org> (Johannes Sixt's message of "Fri, 28
	Mar 2014 18:46:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D821298A-B6A7-11E3-BC6B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245410>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 28.03.2014 18:06, schrieb Junio C Hamano:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> Am 3/27/2014 19:48, schrieb Junio C Hamano:
>>>>> From: Kirill Smelkov <kirr@mns.spb.ru>
>>>>> Date: Mon, 24 Feb 2014 20:21:46 +0400
>>>>> ...
>>>>
>>>> By the way, in general I do not appreciate people lying on the Date:
>>>> with an in-body header in their patches, either in the original or
>>>> in rerolls.
>>>
>>> format-patch is not very cooperative in this aspect. When I prepare a
>>> patch series with format-patch, I find myself editing out the Date: line
>>> from all patches it produces again and again. :-(
>> 
>> I am not sure what you mean.  If you are pasting the format-patch
>> output into an editor your MUA is using to receive the body of the
>> message from you, you would remove all the non-body lines, not just
>> Date: but Subject: and From:, no?
>
> Correct. So I should add that my gripe is about when I want to send a
> patch series with git-send-email that was prepared with git-format-patch.

Hmph.  Don't you get fresh timestamps for your messages in such a
case, ignoring whatever is at the beginning of the input files?

My reading of git-send-email is:

 * "$time = time - scalar $#files" prepares the initial "timestamp",
   so that running two "git send-email" back to back will give
   timestamps to the series sent out by the first invocation that
   are older than the ones the second series will get;

 * "sub send_message" calls "format_2822_time($time++)" to send the
   first message with that initial "timestamp", incrementing the
   timestamps by 1 second intervals (without having to actually wait
   1 second in between messages) for each patch.
