From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: add a function to append a reflog entry to a fd
Date: Thu, 20 Nov 2014 08:57:32 -0800
Message-ID: <xmqqmw7l4xoj.fsf@gitster.dls.corp.google.com>
References: <xmqqvbma4pu3.fsf@gitster.dls.corp.google.com>
	<1416449134-12281-1-git-send-email-sbeller@google.com>
	<20141120023655.GG6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	sahlberg@google.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 17:57:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrV35-0002Yv-Pn
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 17:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984AbaKTQ5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 11:57:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756742AbaKTQ5f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 11:57:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DCB31DBB5;
	Thu, 20 Nov 2014 11:57:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ODEcegzq/xiEkovFowVqggUI4I=; b=XeGaxa
	B7Oq6S3Ur8Bw5oGhQH1XpD6p/oqza017APzEFuFuFiMT3lb6RBp3+2j8+O9/oPDl
	qUgGCx62PQmDLNlseprfdByzqEmk1sAh0F9EFD2+xVNyrcX9WS6gfizqLqGRcylF
	9t5E0QLLKFlSzFAxxO/+7JM6xZwRaCOQH88Bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M5U/O64ss+QtUEklqAdtkB3wgE46noTP
	QTvpb43R1bpJ8p7Vgl4j/HwJiv2uddM97BWn5vKmFFktz1nGUXRCO5EvorUxUWHk
	GWdt4Z8UQxsvMhA4cvMGYGQ7PUvE4RixSe3s8SX0NoCRDyj1xC8YnvoOsH88nWff
	sUk8EArSCP8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83A611DBB4;
	Thu, 20 Nov 2014 11:57:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBA1A1DBB3;
	Thu, 20 Nov 2014 11:57:33 -0500 (EST)
In-Reply-To: <20141120023655.GG6527@google.com> (Jonathan Nieder's message of
	"Wed, 19 Nov 2014 18:36:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 52A43B28-70D6-11E4-A7AE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Break out the code to create the string and writing it to the file
>> descriptor from log_ref_write and add it into a dedicated function
>> log_ref_write_fd.
>
> (grammar) I'm having trouble parsing the above.

Yeah, I can see what it wants to say, but still...

>> Let's discuss the change and decide if I shouldsend a follow up patch to change
>> it into snprintf.
>
> Both sprintf and snprintf are error-prone functions.  It would be
> lovely in a followup to use strbuf_addf or xstrfmt in this code path.
> strbufs are how git deals with bookkeeping for string sizes --- they
> are very pleasant.

Yeah, that solves both sides of not stomping on other peoples' data
(which may lead to replaced return address and such) and not giving
broken result (which may cause trouble to the callers) equally well
without raising a stink about "security!!!", which is good ;-).

>> @@ -3010,19 +3032,9 @@ static int log_ref_write(const char *refname,
>> const unsigned char *old_sha1,
> [...]
>> +	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
>> +				  git_committer_info(0), msg);
>> +	if (result) {
>>  		int save_errno = errno;
>>  		close(logfd);
>>  		error("Unable to append to %s", log_file);
>
> Since 'result' isn't used here, this could be simplified to
>
> 	if (log_ref_write_fd(...)) {
> 		...
> 	}

Yeah that is a good simplification.
