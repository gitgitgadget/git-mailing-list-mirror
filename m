From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Git does not convert CRLF=>LF on files with \r not before \n
Date: Tue, 21 Apr 2015 10:41:01 -0700
Message-ID: <xmqq1tjdidle.fsf@gitster.dls.corp.google.com>
References: <CAFFOgCUTxnbL7vJpf1Hw39CJL_p2raDZ2a3DehhYhdbkVyi2fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
To: Alexandre Garnier <zigarn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:41:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkcAZ-0002Uh-T8
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 19:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbbDURlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 13:41:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932426AbbDURlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 13:41:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8247C4ABD8;
	Tue, 21 Apr 2015 13:41:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZQGHvGgiHddpfa6hYHByNr6rBLQ=; b=vI6K1q
	eoSGeoWVT57i6nQh62QTKkcHdu9sn7HPiFVZn7VPx0EAOx49koV893c0Vb79eyUv
	zsfHE6ujwSDtvSbf4FF/H3xEP1+XtrvY3cJGqrj05W05buy0E1AshvVzzhH7nCwm
	GoQtr6BZAOqaw8Lmf0pueOPSUQsKscPwVX3UY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bdm7ff4NKxbOP3gUNweCExdUbRBgo//F
	z14gESEUxYPXQ93Z5REgeNqtDmkNvfHZGY13OCmwiHH3TZPw4MsBMDE9b0u+12lD
	G/1faiFAI0eOjhEETcxSKk5wioD73G8vXeh5v9tJdsjWpNnqWHY6aaozkOed0hNs
	4L7YUYOTFUU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 797C54ABD7;
	Tue, 21 Apr 2015 13:41:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DECF54ABD5;
	Tue, 21 Apr 2015 13:41:02 -0400 (EDT)
In-Reply-To: <CAFFOgCUTxnbL7vJpf1Hw39CJL_p2raDZ2a3DehhYhdbkVyi2fw@mail.gmail.com>
	(Alexandre Garnier's message of "Tue, 21 Apr 2015 15:51:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 94871C9C-E84D-11E4-B3F2-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267540>

Alexandre Garnier <zigarn@gmail.com> writes:

> echo '*       text=auto' > .gitattributes
> git add .gitattributes
> git commit -q -m "Normalize EOL"
> echo -ne 'some content\r\nother \rcontent with CR\r\ncontent\r\nagain

With text=auto, the user instructs us to guess, and we expect either
LF or CRLF line-terminated files that is *TEXT*.  A lone CR in the
middle of the line would mean we cannot reliably guess---it may be
LF terminated file with CRs sprinkled inside text, some of which
happen to be at the end of the line, or it may be CRLF terminated
file with CRs sprinkled in.  We try to preserve the user input by
not munging when we are not sure.

You are seeing the designed and intended behaviour.

But it would be a bug if the same thing happens when the user
explicitly tells us that the file has CRLF line endings, and I
suspect we have that bug, which may want to be corrected.

I've Cc'ed various people who worked on convert.c around line
endings.  I recall we saw a few other discussion threads on
text=auto and eol settings.  Stakeholders may want to have a unified
discussion to first list the issues in the current implementation
and come up with fixes for them.

Thanks.
