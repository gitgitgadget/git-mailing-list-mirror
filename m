From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 05 Dec 2014 13:19:00 -0800
Message-ID: <xmqqbnnhpzgb.fsf@gitster.dls.corp.google.com>
References: <1417732931.20814.16.camel@segulix>
	<1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org>
	<CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
	<1417798622.23238.6.camel@segulix>
	<xmqq1toeq79b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 22:19:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx0Ht-0005uh-Nd
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 22:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbaLEVTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 16:19:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751030AbaLEVTE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 16:19:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 500E123274;
	Fri,  5 Dec 2014 16:19:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SWNtDNCPaBt42Sd3MS9nUNB/pPc=; b=jh4ata
	W4ql16b7hHkN2H2OgGfNi0O5lnTZ5YbeMbvSMad0R95/JYnm9nlzCYExECn/+8AE
	KThB0ZubH2LPuAjDN1GAwmRRv4URfDUOS1SMzpSH/yn4aqGefYf3Ehl+U7LS2sR0
	r8Xh38/kG9lywbDyIV+R00ztjf5K1xSvT1GDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SkV9SA7+cuVue7s7WiBRWHMtF0J8TPEO
	Etr5oAckYL0neqI2HNXQLV+Yk22fNwlotCCRuvspzFdcO7UdVbUCXfJSMoprIIW5
	ZmFqr82Kr3EoUBCWhUXq/kI9DTv3qBpTgo2JRjdnP7vv0qkEZDNNB+6ooR5I+obT
	YvyViyDcxJE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 483AF23273;
	Fri,  5 Dec 2014 16:19:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C94CF23272;
	Fri,  5 Dec 2014 16:19:01 -0500 (EST)
In-Reply-To: <xmqq1toeq79b.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 05 Dec 2014 10:30:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5587671C-7CC4-11E4-82AC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260893>

Junio C Hamano <gitster@pobox.com> writes:

> If however you did something that made Git notice that you changed
> these paths marked with assume-unchanged bit anyway, then Git will,
> well, notice that they are not "unchanged" as you promised.

By the way, this cuts both ways.  I would not bother checking with
the current codebase, but I know it used to be that when we have a
blob object name and need a temporary file that holds the content
for read-only purpose (e.g. passing a pair of files to external diff
driver), we allowed Git to reuse files in the working tree whose
blob object name we knew.  This is of course because it is faster
than inflating the blob contents out of the object store and writing
a new file.

That codepath is allowed to "borrow" the working tree file as such a
temporary file for read-only purpose, when a file is stat-clean
(i.e. its contents is known to match the blob object recorded in the
index).  A file with assume-unchanged bit set is treated exactly the
same way, because the user promised not to modify it.

If the user broke the promise, then an external diff driver would
have been given a file whose contents does not actually match the
wanted blob object, resulting in an incorrect diff output.
