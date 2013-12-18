From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] difftool: Change prompt to display the number of files in the diff queue
Date: Tue, 17 Dec 2013 22:06:19 -0800
Message-ID: <xmqqmwjyk810.fsf@gitster.dls.corp.google.com>
References: <1386286726-26653-1-git-send-email-zoltan.klinger@gmail.com>
	<20131218052523.GB90546@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 07:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtAH5-0005St-Bt
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 07:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988Ab3LRGGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 01:06:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59026 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab3LRGGW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 01:06:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C3235166D;
	Wed, 18 Dec 2013 01:06:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zYlb+AKKK467KODsHSeVeObKuB0=; b=I2/IRY
	vIsGK/ePJgv9CmQEID9g1Y2uZAI2WPseJTX88eMrpTXZEEvtGDG0x3EQfV2MMfAR
	U0FMBj0s8G0QUgcp0bz8AyRnAG8Wb2QX0yfJl2TytGPN0HxMyAVDl6lB1QVZuaQu
	XrO9cfZl2bjEj0r4R5GJNC/5JfGGhlMX53Pnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iXeNiBTuQSkNg4bmE6BQ+LJS80qDbt9C
	Ekj0Dd3fC8vPr/3M97R+S5oYTVmK9A5fImd7lPV1GQk1SJ2QTQIqOv5vEXRFs96c
	KR7qemixMArGkTmtq3EvBMFyxHdbqqb2uCyOel9RrYSheBmMvs8KkBIKwpxD5zfZ
	4Wo5k/xzo/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 894E65166A;
	Wed, 18 Dec 2013 01:06:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D51E551668;
	Wed, 18 Dec 2013 01:06:20 -0500 (EST)
In-Reply-To: <20131218052523.GB90546@gmail.com> (David Aguilar's message of
	"Tue, 17 Dec 2013 21:25:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 840D6C88-67AA-11E3-A2EF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239425>

David Aguilar <davvid@gmail.com> writes:

> Thanks for the patch, and sorry for the late response.
> I have just a couple of notes below...
>
> On Fri, Dec 06, 2013 at 10:38:46AM +1100, Zoltan Klinger wrote:
>> diff --git a/diff.c b/diff.c
>> index e34bf97..a7d5a47 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2899,11 +2899,16 @@ static void run_external_diff(const char *pgm,
>>  			      struct diff_filespec *one,
>>  			      struct diff_filespec *two,
>>  			      const char *xfrm_msg,
>> -			      int complete_rewrite)
>> +			      int complete_rewrite,
>> +			      struct diff_options *o)
>
> Very minor nit -- "o" is a very terse variable name.
> Maybe "opts"?

The diff-options parameter passed around in the callchain has always
been "o" throughout this file from the beginning of time, though ;-).

>
>>  {
>>  	const char *spawn_arg[10];
>>  	int retval;
>>  	const char **arg = &spawn_arg[0];
>> +	struct diff_queue_struct *q = &diff_queued_diff;
>> +	const char *env[3] = { NULL };
>> +	char env_counter[50];
>> +	char env_total[50];
>
> Hard-coded 50; what's the length of the maximum signed int?

;-) A bit of slack is fine, but 50 might be excessive (more than
twice as big as necessary).

>> diff --git a/diff.h b/diff.h
>> index e342325..42bd34c 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -164,6 +164,8 @@ struct diff_options {
>>  	diff_prefix_fn_t output_prefix;
>>  	int output_prefix_length;
>>  	void *output_prefix_data;
>> +
>> +	int diff_path_counter;
>>  };
>
> Since these are already "diff_options" it seems redundant to call
> the struct entry the "diff_path_counter" when "path_count"
> should be specific enough.  Would it make sense to rename it?

Yeah, makes sense.  diff_options->diff_path_counter++ sounds awful,
while options->path_count++ looks quite tame and reasonable.

> These are tiny nitpicky style notes; it looks good otherwise.

Thanks.
