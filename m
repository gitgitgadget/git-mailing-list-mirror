From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] skip_prefix: rewrite so that prefix is scanned once
Date: Mon, 03 Mar 2014 14:43:18 -0800
Message-ID: <xmqq61nuoqd5.fsf@gitster.dls.corp.google.com>
References: <1393816384-3300-1-git-send-email-siddharth98391@gmail.com>
	<xmqqvbvvp0gj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Siddharth Goel <siddharth98391@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:43:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbaJ-0001HQ-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbaCCWnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:43:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbaCCWnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:43:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9181771E83;
	Mon,  3 Mar 2014 17:43:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fH5Hl7EkgQMD52aAKA0aLtgypuU=; b=JIuWNX
	dMR2c658n7rkkGkN91fFVxJaZyU4R/FbcqtDds0eX1rogdGoBrhqof9mXclWXwVY
	9R0XxnwnL8KmYi6xj4AH/uN5G23tSwjj4lgz3USbtmE+eUdea/vfY/eRgI1GMcJj
	vc65luv23Xfx4F/EaUK8TlNK6S8eID3olDDcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h6bSOjd1Y18onNSlLzN/RR2fj6bU+DiA
	0RnXxCr4CxlJ3dR1ptzyViz3MUNUEEKTRGiXuyEbduhfAVbX43Se5qpMe87ogcb8
	hBUBqemxgmMerqPbRsSqw2kS4CZguhcCUh/DfRvyfRzedEipf/0zP1mFRhZnZt0F
	0dT8bWpUP9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7888A71E82;
	Mon,  3 Mar 2014 17:43:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF9C171E81;
	Mon,  3 Mar 2014 17:43:20 -0500 (EST)
In-Reply-To: <xmqqvbvvp0gj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 03 Mar 2014 11:05:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 387ADDC6-A325-11E3-A60C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243295>

Junio C Hamano <gitster@pobox.com> writes:

> Siddharth Goel <siddharth98391@gmail.com> writes:
>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Siddharth Goel <siddharth98391@gmail.com>
>> ---
>> Added a space after colon in the subject as compared to previous 
>> patch [PATCH v2].
>>
>> [PATCH v2]: http://thread.gmane.org/gmane.comp.version-control.git/243150
>
> Whenever you see "Change", "Rewrite", etc. in the subject of a patch
> that touches existing code, think twice.  The subject line is a
> scarce real estate to be wasted on a noiseword that carries no real
> information, and we already know a patch that touches existing code
> changes or rewrites things.
>
>     Subject: [PATCH v3] skip_prefix: scan prefix only once
>
> perhaps?
>
>>  git-compat-util.h | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 614a5e9..550dce3 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char *suffix);
>>  
>>  static inline const char *skip_prefix(const char *str, const char *prefix)
>>  {
>> -	size_t len = strlen(prefix);
>> -	return strncmp(str, prefix, len) ? NULL : str + len;
>> +	while (*prefix != '\0' && *str == *prefix) {
>> +		str++;
>> +		prefix++;
>> +	}
>> +	return (*prefix == '\0' ? str : NULL);
>
> Unlike another patch I saw the other day on the same topic, this
> checks *prefix twice for the last round, even though I think this
> one is probably slightly easier to read.  I dunno.

That is, something like this instead.  After looking at it again, I
do not think it is less readable than the above.

 git-compat-util.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..68ffaef 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -357,8 +357,14 @@ extern int suffixcmp(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
-	size_t len = strlen(prefix);
-	return strncmp(str, prefix, len) ? NULL : str + len;
+	while (1) {
+		if (!*prefix)
+			return str;
+		if (*str != *prefix)
+			return NULL;
+		prefix++;
+		str++;
+	}
 }
 
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
