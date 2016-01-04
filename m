From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/17] update-index: read --index-info with strbuf_getline_crlf()
Date: Mon, 04 Jan 2016 11:50:33 -0800
Message-ID: <xmqqio39nmye.fsf@gitster.mtv.corp.google.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
	<1450303398-25900-1-git-send-email-gitster@pobox.com>
	<1450303398-25900-4-git-send-email-gitster@pobox.com>
	<alpine.DEB.2.20.1601041308310.14434@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 20:50:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGB9Z-0006qR-1h
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 20:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbcADTuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 14:50:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752646AbcADTug (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 14:50:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FC07372C3;
	Mon,  4 Jan 2016 14:50:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kpg7nt/jbbkV5RfgIMbfK34dVYk=; b=vGkSZd
	fL9fBTfs4SCOES3EkArk1aTcraitaJHpdvUDrp12c3ReWYhzZJStD8Of0g204+Mp
	U43LTEHNd1dLC5JJb08ePbCp1jFZ77I06ZoBtcdmDQm7MmPQbxEtFC9hA105a3ls
	dhuhJMNSUUQ13tASIxJuzEdM/sAuS+RvTYm6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nyxnlpxABL6AIlWpdqbk0MOg639CfW6q
	oJS7WIybJ78azxRNjbAMyqttMFkbKS7GoreUNp7SPd02iuDC/72+bJiIqhGFHJzk
	+6B8FfTLlw2KXk2CuB//df1YU5pycyqaxs4Ds9z/cDmEsIc3SQYylnBAiwdJW1+R
	hmO6/d8gNds=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 56E5D372BF;
	Mon,  4 Jan 2016 14:50:35 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C9B73372BE;
	Mon,  4 Jan 2016 14:50:34 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601041308310.14434@virtualbox> (Johannes
	Schindelin's message of "Mon, 4 Jan 2016 13:27:31 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B7B78D0-B31C-11E5-8B1D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283320>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index 7431938..a7a9a7e 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -473,7 +473,9 @@ static void read_index_info(int line_termination)
>>  	struct strbuf buf = STRBUF_INIT;
>>  	struct strbuf uq = STRBUF_INIT;
>>  
>> -	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
>> +	while ((line_termination
>> +		? strbuf_getline_crlf(&buf, stdin)
>> +		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
>>  		char *ptr, *tab;
>
> This is a problematic change because it does not safeguard for future
> introduction of a line_termination value other than LF or NUL. I believe
> the safest would be to change read_index_info() to take a `nul_delimited`
> parameter instead of the `line_termination` parameter first, and then
> introduce that change to use strbuf_getline_crlf if !nul_delimited.

When I introduced line_termination long time ago, I wrote these
codepaths anticipating that there might be a value other than NUL
and LF that could be useful, but no useful caller that uses other
useful value has emerged, so I agree that the interface was too
broad and general for its own good.

I agree with your comments for all the changes in this series that
switch between getline and getline_delim('\0') based on the value of
line_termination; its generality is useless and we should declare
"the line termination is either NUL or LF, no other choices"; using
nul_delimited = 0/1 is a very good way to express it clearly.

Thanks.
