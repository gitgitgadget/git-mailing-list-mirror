From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Tue, 28 May 2013 10:04:21 -0700
Message-ID: <7vobbv2fze.fsf@alter.siamese.dyndns.org>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
	<1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
	<20130528110014.GA1264@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue May 28 19:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNK2-0006cb-0K
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934866Ab3E1REZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:04:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934848Ab3E1REY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:04:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E15923D3F;
	Tue, 28 May 2013 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Uri7PcGVcnQoLEw1u9WFY55sCBA=; b=heMCMFR+EWJ2uSSWQbo8
	pWOOYQsld1ymwfVM1+sttxoxeGxuKsWoi0hdoaHa6F73b+z/yKP+QwHH4VmrHBju
	NlATDSp38lilGShojB2YuHcGutF2743LJGNWwgGNTrsnlNj5vSt2E23wjLGhOR5y
	lZiLBhgMb431hYl9ddChm28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=GENdu7j4bnVSdG38S6tH1BNxGISiONdxytSXm1E/z3XTX5
	5+wIcqGauc+Ce5gvkeas9gSzvawwGWQHb/nASxD+xtNS+Z9vwoPbX1YgG57R0QdL
	CTnyBR1+R288DERyhK1+nF0c+YJnycZI2rloqVL/TCCNhHX5f6rXts7GSPoxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 205CA23D3E;
	Tue, 28 May 2013 17:04:24 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36B6E23D3C;
	Tue, 28 May 2013 17:04:23 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A524F5CC-C7B8-11E2-92EA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225663>

Neil Horman <nhorman@tuxdriver.com> writes:

> On Mon, May 27, 2013 at 11:52:18AM -0500, Felipe Contreras wrote:
>> We should free objects before leaving.
>> 
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  sequencer.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/sequencer.c b/sequencer.c
>> index ab6f8a7..7eeae2f 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -626,12 +626,15 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>>  		rerere(opts->allow_rerere_auto);
>>  	} else {
>>  		int allow = allow_empty(opts, commit);
>> -		if (allow < 0)
>> -			return allow;
>> +		if (allow < 0) {
>> +			res = allow;
>> +			goto leave;
>> +		}
>>  		if (!opts->no_commit)
>>  			res = run_git_commit(defmsg, opts, allow);
>>  	}
>>  
>> +leave:
>>  	free_message(&msg);
>>  	free(defmsg);
>>  
>> -- 
>> 1.8.3.rc3.312.g47657de
>> 
>> 
> Acked-by: Neil Horman <nhorman@tuxdriver.com>

This is better done without "goto" in general.

The other patch 2/2/ adds one more "we need to exit from the middle
of the flow" and makes it look handier to add an exit label here,
but it would be even better to express the logic of that patch as a
normal cascade of if/else if/..., which is small enough and we do
not need the "leave:" label.

It probably is better to fold this patch into the other one when it
is rerolled to correct the option name gotcha "on the tin".

Thanks.
