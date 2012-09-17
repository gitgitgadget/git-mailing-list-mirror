From: Junio C Hamano <gitster@pobox.com>
Subject: Re*: Content-Type handling
Date: Mon, 17 Sep 2012 10:18:19 -0700
Message-ID: <7vy5k8va90.fsf@alter.siamese.dyndns.org>
References: <CABZfb=UhKRREMG_XNJHDJHwbwroi5TKWwgQH-Ge1BDJETizG2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tomas Cohen Arazi <tomascohen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:18:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDexs-0008TX-LW
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646Ab2IQRSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:18:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328Ab2IQRSX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:18:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 192D1844B;
	Mon, 17 Sep 2012 13:18:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TkzBWDHIoq0H9T9Yk3Ahz9Uz0XM=; b=A4m8uP
	9raOQgx+XRa0lj3aBaDziHn8LEY0MjRlk9RQnG9N45miU3QhKhefrE3DnohrofWE
	Qr20RGtRLDUKmMXJtG1jxW9axAP721snflAl6arLzsEWTbrtFUqrD7W/fLjKSUIE
	v3n/nRNBRxmg8jMGPONBDvcOD8Q5C/kySGuIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iMc69bSXLj5DifxLq0f+vh7fslMkdy/x
	y9nbXnMmDWaAJhoYSD/5YabGhmXX7rBLmR7ssevxxfUamquOHZB4atgRODqBtGwd
	4tzGg2g0VVIRuHEPo5YDV8rvCQ3WhMcNuewtpwmOUQGRwiiyXdo2sMMiLanD9d64
	RiT8ut2o0Hg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06530844A;
	Mon, 17 Sep 2012 13:18:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F9678449; Mon, 17 Sep 2012
 13:18:21 -0400 (EDT)
In-Reply-To: <CABZfb=UhKRREMG_XNJHDJHwbwroi5TKWwgQH-Ge1BDJETizG2Q@mail.gmail.com> (Tomas
 Cohen Arazi's message of "Mon, 17 Sep 2012 13:34:13 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE184B96-00EB-11E2-B4F8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205714>

Tomas Cohen Arazi <tomascohen@gmail.com> writes:

> Hi, I'm not sure it is a bug, but we used:
>
> git config --global format.headers "Content-Type: text/plain; charset=\"utf-8\""
>
> and recently (perhaps an Ubuntu default setup issue) the content-type
> is being automatically set, the result is that patches contain this:
>
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> Content-Type: text/plain; charset="utf-8"
>
> This might not be the problem, but when I apply the patch I get this:
>
> fatal: cannot convert from UTF-8utf-8 to UTF-8
>
> which looks like a bug. Not sure it hasn't been reported before, but I
> think it should take one of the content-type specifications and not
> append both. I couldn't find a place to looks for previous bug reports
> to check, so forgive me if this is not the right place to report it.

What I think is happening is:

 * ancient "git format-patch" did not add appropriate content-type
   headers, and that bug was fixed in more recent versions.

 * while waiting for the bug to get fixed, the user worked around by
   having her own format.headers to work it around.

 * the user upgraded to a newer version of git without the bug.

 * Git trusts that the user knows better than git itself, and it
   adds format.headers to whatever it needs to have in the message.
   As a message with more than one content-type: is invalid, the
   handcrafted format.headers used to be used as a workaround should
   be removed, but it hasn't been.

 * Then the receiving end (mailinfo) gets confused by the invalid
   input.


At least, a patch line this may alleviate the symptom.  It seems
that we assumed we won't see multiple charset="..." so the parser,
starting from an empty charset, simply appended whatever it found
in the message, instead of overwriting the old value it had.  The
other user of the function this patch touches always makes sure the
"attr" strbuf is empty before calling the function, and wouldn't
have been confused by multiple occurrences of the same header, and
this patch should not affect it, either.

 builtin/mailinfo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git i/builtin/mailinfo.c w/builtin/mailinfo.c
index b691b77..2b3f4d9 100644
--- i/builtin/mailinfo.c
+++ w/builtin/mailinfo.c
@@ -160,10 +160,9 @@ static int slurp_attr(const char *line, const char *name, struct strbuf *attr)
 	const char *ends, *ap = strcasestr(line, name);
 	size_t sz;
 
-	if (!ap) {
-		strbuf_setlen(attr, 0);
+	strbuf_setlen(attr, 0);
+	if (!ap)
 		return 0;
-	}
 	ap += strlen(name);
 	if (*ap == '"') {
 		ap++;
