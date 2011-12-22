From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Thu, 22 Dec 2011 10:08:23 -0800
Message-ID: <7v39cceay0.fsf@alter.siamese.dyndns.org>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
 <4EF2D436.3080303@viscovery.net> <7vaa6ldpk6.fsf@alter.siamese.dyndns.org>
 <4EF2E824.7020509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 22 19:08:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rdn4G-0004OS-W2
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 19:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab1LVSI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 13:08:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575Ab1LVSI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 13:08:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0E6A6267;
	Thu, 22 Dec 2011 13:08:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RVHrkA3k3rtZKO0fdH2nfkR9taY=; b=wF1SNI
	7qFpIr4WEOEzGSWwbz79DHSQ2NfVBct13UIPgd1CHYnQ0zU3RFZVJpbhrTIHpPw8
	qedGGFRRLrrrAF0XIGpz2kF8w6RJ9yBgx3AQD16/OF8LM14H54K8bSmF8JoHyMrk
	wIl1HBDlSjJabHJGTXvaWUPNkJ/WilswskNB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j6v+szXIiqkcUtZLeW43p4/J+hHFYewJ
	OBGOKMozYB2t8gFdVoQEH74k65vb4Vgi3wD0fM2jTxnYmWHYFZte3KI1iiQVIfUo
	wuLqMFs3YEtecaeCQyVo56nJ4Yg5V13t9ni8Cts4Y+3llc5wPD0PNEkaKUQdswTb
	dcrxcEE357s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7BFE6266;
	Thu, 22 Dec 2011 13:08:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29B7C6263; Thu, 22 Dec 2011
 13:08:25 -0500 (EST)
In-Reply-To: <4EF2E824.7020509@viscovery.net> (Johannes Sixt's message of
 "Thu, 22 Dec 2011 09:19:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F108C942-2CC7-11E1-94CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187612>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 12/22/2011 8:38, schrieb Junio C Hamano:
>> +static void v_format(const char *prefix, const char *fmt, va_list params,
>> +		     emit_fn emit, void *cb_data)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +	struct strbuf line = STRBUF_INIT;
>> +	const char *cp, *np;
>> +
>> +	strbuf_vaddf(&buf, fmt, params);
> ...
>>  void vreportf(const char *prefix, const char *err, va_list params)
>>  {
>> -	char msg[4096];
>> -	vsnprintf(msg, sizeof(msg), err, params);
>> -	fprintf(stderr, "%s%s\n", prefix, msg);
>> +	v_format(prefix, err, params, emit_report, NULL);
>>  }
>
> Using strbuf (or xmalloc for that matter) from a function that can be
> called from die() is a big no-no. You should keep the fixed-sized buffer.

I _think_ I liked the simplicity of having the logic to

 - format localized message to a multi-line buffer; and
 - split the contents of that buffer into lines and add prefix in an
   i18n friendly way

in vreportf(), but there are many problems in this approach, it seems.  We
may need to limit the message length for error()/die() codepath, but we do
not want to be limited in others, definitely not from advise().

Also some calls to error() are meant to produce plumbing error message and
should never be localized. The approach to localize the prefix in vreportf()
will not work for this reason.

I think we should start from the original "advise-only" way. In the longer
term (if somebody cares about it deeply), things can be fixed up and the
mechanism can then be unified in the following order:

 (1) figure out a way to allow error() and die() tell if they are called
     to produce a plumbing message that should not be translated (multiple
     approaches are possible, ranging from adding error_plumb() function
     to marking the message format string specially);

 (2) update the existing error()/die() calls that are used to produce
     plumbing message and mark them as such, using the mechanism decided
     in (1);

 (3) Take the v_format/vreport code from my patch I am discarding with
     this message, enhance them to turn the "prefix" i18n part
     consitional, and use that to reimplement the mechanism (1).

But that is not for this year.
