From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be sha1 based
Date: Fri, 28 Mar 2014 12:27:22 -0700
Message-ID: <xmqqd2h69l9h.fsf@gitster.dls.corp.google.com>
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
	<xmqqtxai9nmq.fsf@gitster.dls.corp.google.com>
	<5335C89A.7040802@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@navytux.spb.ru>, kirr@mns.spb.ru,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 20:27:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTcR9-00035L-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 20:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbaC1T10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 15:27:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbaC1T1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 15:27:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AE3F77399;
	Fri, 28 Mar 2014 15:27:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bWuCvFOj1lLzvuXTUj9xcZQokPc=; b=Y3HGOY
	aBMCre49zipw4SVC/fBQ/cYI35a5SySMp2z7XjKgEkYsc3O87OvmQj+1jaWYl29U
	9ManMv7WKO3TJKj3BokrrjCF9eDO9bV7I7cl2GkIHHuDO46x6E9mxp0Yxg7RAhYi
	UZD2PXUNN+XsQzIcZcfzm59cNLC6sxuobpfig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DpJvTQQ6sbV1dULntOd25UNfdHRjGdlq
	hM4tV6TQSyB+qPek+Bf1FWIzTvKCCbMRB/L/NMaYxecpv2riPjaWVOqmPC0z1+QM
	xFrfikqa3rB1aSzsqz93T/4ra+H/9Sx63ntJHN4UiO1cxoQ7EihD2h/DeZzlaalE
	Yte0QUuZmrk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7470877396;
	Fri, 28 Mar 2014 15:27:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD54877394;
	Fri, 28 Mar 2014 15:27:23 -0400 (EDT)
In-Reply-To: <5335C89A.7040802@kdbg.org> (Johannes Sixt's message of "Fri, 28
	Mar 2014 20:08:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FD15BD12-B6AE-11E3-B9B6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245421>

Johannes Sixt <j6t@kdbg.org> writes:

>> My reading of git-send-email is:
>> 
>>  * "$time = time - scalar $#files" prepares the initial "timestamp",
>>    so that running two "git send-email" back to back will give
>>    timestamps to the series sent out by the first invocation that
>>    are older than the ones the second series will get;

A completely irrelevant tangent, but I was being an idiot here.  The
"-scaler #$files" is not about two send-email running back to back.
A second invocation that sends out a long series will start its
timestamp #$files in the past, that will overlap with the timestamp
of the last one in the first invocation.  And that is not what the
code attempts to address.  It wants to merely avoid timestamps from
the future.
