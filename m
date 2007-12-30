From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Speedup prefixcmp() common case
Date: Sat, 29 Dec 2007 16:05:57 -0800
Message-ID: <7v1w95avx6.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
	<7v63yhb8kf.fsf@gitster.siamese.dyndns.org>
	<e5bfff550712291214p7554ea52o875667906ce1a22d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 01:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8lhS-0007GL-6d
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 01:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbXL3AGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 19:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbXL3AGJ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 19:06:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbXL3AGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 19:06:08 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2949C5127;
	Sat, 29 Dec 2007 19:06:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 95C8B5125;
	Sat, 29 Dec 2007 19:05:59 -0500 (EST)
In-Reply-To: <e5bfff550712291214p7554ea52o875667906ce1a22d@mail.gmail.com>
	(Marco Costalba's message of "Sat, 29 Dec 2007 21:14:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69337>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On Dec 29, 2007 8:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Why isn't it like this?
>>
>>         if (!prefix[1])
>>
>
> well, what about if prefix == NULL ?

What about it?  Do not trim what's relevant when your quote,
please.

Your slow path does this:

>  	return strncmp(str, prefix, strlen(prefix));
>  }

So it will barf when prefix == NULL anyway due to strlen().  I
think passing NULL as prefix to prefixcmp() is a caller-error.

I think my version is also buggy.  Passing "" as prefix to
prefixcmp() is nonsense but is supported, and checking prefix[1]
without looking at prefix[0] reads past the end of the string.

So, in summary, I think the following is what we would want.

 static inline int prefixcmp(const char *str, const char *prefix)
 {
+	// shortcut common case of a single char prefix
+	if (prefix[0] && !prefix[1])
+		return *str - *prefix;
+
 	return strncmp(str, prefix, strlen(prefix));
 }
