From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] index-pack: support multithreaded delta resolving
Date: Thu, 03 May 2012 23:21:54 -0700
Message-ID: <7vipgccvp9.fsf@alter.siamese.dyndns.org>
References: <1334123388-6083-1-git-send-email-pclouds@gmail.com>
 <1334123388-6083-4-git-send-email-pclouds@gmail.com>
 <7v62ccex0x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 08:22:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQBu1-00060M-0O
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 08:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab2EDGV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 02:21:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40289 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab2EDGV6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 02:21:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F398E3D03;
	Fri,  4 May 2012 02:21:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PAUr4NUzVaYO
	udVCBeltvtaSQ5g=; b=tofuCa0NOid4iJSQkzdbbZWqHDdeQTA1MVaGJ75TKX2P
	Q2lP210QL/Tpw3B1NrBdbknm5QUnHnGxC/1+FaGC/MPfWoaXyM2W13DuqRaseXq2
	MQxT4JVIRNt310OL/hc/nO5nhDZl23ph7XpH73pnToKiqDuUhtjavrSVYEFut1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xLaeLS
	cPaj6iI31JGZHfYprnrfvFuz+Q6U9RZqm9J/S5+6LHh4Xb6S1hlD0G/sHwmluMlN
	wVXYuLNpQF3YfspxYMMo3J62JnzU47IDM2q4nyY76EjNIkdntfKKMFe3Jme55vGa
	43hyZprIzNPHX0UXnI8aAJMOTJYEtmjRsoZi0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E81823D02;
	Fri,  4 May 2012 02:21:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63EB73D01; Fri,  4 May 2012
 02:21:57 -0400 (EDT)
In-Reply-To: <7v62ccex0x.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 03 May 2012 15:10:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 735003E6-95B1-11E1-9954-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196993>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> @@ -696,7 +796,31 @@ static void second_pass(struct object_entry *ob=
j)
>>  	base_obj->obj =3D obj;
>>  	base_obj->data =3D NULL;
>>  	find_unresolved_deltas(base_obj);
>> -	display_progress(progress, nr_resolved_deltas);
>> +}
>> +
>> +static void *threaded_second_pass(void *arg)
>> +{
>> +#ifndef NO_PTHREADS
>> +	if (threads_active)
>> +		pthread_setspecific(key, arg);
>> +#endif
>> +	for (;;) {
>> +		int i;
>> +		work_lock();
>> +		display_progress(progress, nr_resolved_deltas);
>> +		while (nr_processed < nr_objects &&
>> +		       is_delta_type(objects[nr_processed].type))
>> +			nr_processed++;
>> +		if (nr_processed >=3D nr_objects) {
>> +			work_unlock();
>> +			break;
>> +		}
>> +		i =3D nr_processed++;
>> +		work_unlock();
>> +
>> +		second_pass(&objects[i]);
>> +	}
>> +	return NULL;
>>  }
>
> It may be just the matter of naming, but the above is taking the
> abstraction backwards, I think.  Shouldn't it be structured in such a=
 way
> that the caller may call second_pass() and its implementation may tur=
n out
> to be threaded (or not)?
>
> The naming of "arg" made things worse.  I wasted 5 minutes scratching=
 my
> head thinking "arg" was a single specific object that was to be given=
 to
> second_pass(), and wondered why it is made into thread-local data.  N=
ame
> it "thread_data" or something.
>
> And I think the root cause of this confusion is the way "second_pass"=
 was
> split out in the earlier patch.  It is not the entire second-pass, bu=
t is
> merely a single step of it (the whole "for (i =3D 0; i < nr_objects; =
i++)"
> is the second-pass, in other words), and its implementation detail mi=
ght
> change to either thread (i.e. instead of a single line of control
> iterating from 0 to nr_objects, each thread grab the next available t=
ask
> and work on it until everything is exhausted) or not.
>
> By the way, if one object is very heavy and takes a lot of time until
> completion, could it be possible that objects[0] is still being proce=
ssed
> for its base data but objects[1] has already completed and an availab=
le
> thread could work on objects[2]?  How does it learn to process object=
s[2]
> in such a case, or does it wait until the thread working on objects[0=
] is
> done?

Please disregard the "By the way" part, except that my confusion that l=
ed
to the "By the way" comment was caused by another misnaming, namely,
"nr_processed".  It is not counting "How many of them have we already
processed?"---it merely counts "How many of them have we dispatched?" a=
nd
completion of the task does not matter in this critical section, which =
I
missed.  If it were named "nr_dispatched", I wouldn't have wasted my ti=
me
wondering about the loop and writing the "By the way" review comment.
