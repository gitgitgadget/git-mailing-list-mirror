From: Junio C Hamano <gitster@pobox.com>
Subject: Re: weird diff output?
Date: Tue, 29 Mar 2016 10:54:34 -0700
Message-ID: <xmqqzithxj8l.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
	<CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 19:54:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akxqk-0004wX-1E
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 19:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757808AbcC2Ryi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 13:54:38 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753578AbcC2Ryh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 13:54:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8498B505B3;
	Tue, 29 Mar 2016 13:54:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=65oTx/Zva9FdW6oeVgrAnxsaqpI=; b=CNA5dx
	tXvUDwnEbhrLU5Wl4X7Cb0YOD9ev78nYg1S3pIZeu7ReAZFlo3E8ayvlC6rPCMp3
	WhgXrPZSpV6M2Zq3MyTpBgDw1ilfADQajVgj6M3ApA277S5sy3Bk1BEJjbI45jeq
	uFMHpj8YjKP9ade0YIqlZlDVpfd3mQZqR8qi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IrH2JGCk09Szz7xp1c/GDorO1u8Wr4it
	Nuzj6tNQXBtULvo1p8r9v5LpSgPrvor3JZr2KHhzSrGC18VH7z6Z/adamiBqiqrj
	/g92MFAFPH3MdYym2Zk7w3SOEXX32hQ81wKyi4xN1hvHKdMBorCcAnGtL4OSr2E7
	7wzAaKQRToc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BB28505B2;
	Tue, 29 Mar 2016 13:54:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E2DE6505B1;
	Tue, 29 Mar 2016 13:54:35 -0400 (EDT)
In-Reply-To: <CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 29 Mar 2016 10:37:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4CC5296A-F5D7-11E5-9C80-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290152>

Stefan Beller <sbeller@google.com> writes:

> I thought this is an optimization for C code where you have a diff like:
>
>     int existingStuff1(..) {
>     ...
>     }
>     +
>     + int foo(..) {
>     +...
>     +}
>
>     int existingStuff2(...) {
>     ...
>
> Note that the closing '}' could be taken from the method existingStuff1 instead
> of correctly closing foo.

That is a less optimal output.  Another possible output would be
like so:

      int existingStuff1(..) {
      ...
      }
     
     + int foo(..) {
     +...
     +}
     +
      int existingStuff2(...) {

All three are valid output, and ...

> So the correct heuristic really depends on what kind of text we
> are diffing.

... this realization is correct.

I have a feeling that any heuristic would be correct half of the
time, including the ehuristic implemented in the current code.  The
readers of patches have inherent bias.  They do not notice when the
hunk is formed to match their expectation, but they will notice and
remember when they see something less optimal.
