From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] index-pack: support multithreaded delta resolving
Date: Thu, 03 May 2012 15:10:22 -0700
Message-ID: <7v62ccex0x.fsf@alter.siamese.dyndns.org>
References: <1334123388-6083-1-git-send-email-pclouds@gmail.com>
 <1334123388-6083-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 00:10:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ4EI-00023w-JG
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 00:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab2ECWK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 18:10:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755522Ab2ECWKZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 18:10:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CDF4679C;
	Thu,  3 May 2012 18:10:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LGLcomZvAydC
	GmAgDbqFMY1giY4=; b=gopknEQ5oEn8dYI+OKYZNFw0JDJpx/njYJo39Jyo2971
	ofqCWfNJ8CEivpUQ9aNBus1iHK03s5Q6b/QXv72dMz4g5B3ip2yHxvhCA6B2xDM1
	Nv5sQnth5/jdGj7FvE1UCexwaBMr6sauu7TiaSmrqLEOWskr+CrQE578jaF3inQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DafSte
	fs0zRuuo6QZFrEX+mHJmzl0cjCCnbxmOUQQfLr+315+0j0L4xugYPXJE9jwmnoL3
	VEfJBqBG6qV85beG42Esj3wpYRR4+x5UCQzOKCs+HZHNUlPG3VVJPBibkYUL4lhp
	HrEVQgdgDI5o/K5z7L+2QodWlGbcgmH6fzaEw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54EE96792;
	Thu,  3 May 2012 18:10:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE5DA6791; Thu,  3 May 2012
 18:10:23 -0400 (EDT)
In-Reply-To: <1334123388-6083-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 11 Apr
 2012 12:49:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7D14E2E-956C-11E1-9495-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196965>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -696,7 +796,31 @@ static void second_pass(struct object_entry *obj=
)
>  	base_obj->obj =3D obj;
>  	base_obj->data =3D NULL;
>  	find_unresolved_deltas(base_obj);
> -	display_progress(progress, nr_resolved_deltas);
> +}
> +
> +static void *threaded_second_pass(void *arg)
> +{
> +#ifndef NO_PTHREADS
> +	if (threads_active)
> +		pthread_setspecific(key, arg);
> +#endif
> +	for (;;) {
> +		int i;
> +		work_lock();
> +		display_progress(progress, nr_resolved_deltas);
> +		while (nr_processed < nr_objects &&
> +		       is_delta_type(objects[nr_processed].type))
> +			nr_processed++;
> +		if (nr_processed >=3D nr_objects) {
> +			work_unlock();
> +			break;
> +		}
> +		i =3D nr_processed++;
> +		work_unlock();
> +
> +		second_pass(&objects[i]);
> +	}
> +	return NULL;
>  }

It may be just the matter of naming, but the above is taking the
abstraction backwards, I think.  Shouldn't it be structured in such a w=
ay
that the caller may call second_pass() and its implementation may turn =
out
to be threaded (or not)?

The naming of "arg" made things worse.  I wasted 5 minutes scratching m=
y
head thinking "arg" was a single specific object that was to be given t=
o
second_pass(), and wondered why it is made into thread-local data.  Nam=
e
it "thread_data" or something.

And I think the root cause of this confusion is the way "second_pass" w=
as
split out in the earlier patch.  It is not the entire second-pass, but =
is
merely a single step of it (the whole "for (i =3D 0; i < nr_objects; i+=
+)"
is the second-pass, in other words), and its implementation detail migh=
t
change to either thread (i.e. instead of a single line of control
iterating from 0 to nr_objects, each thread grab the next available tas=
k
and work on it until everything is exhausted) or not.

By the way, if one object is very heavy and takes a lot of time until
completion, could it be possible that objects[0] is still being process=
ed
for its base data but objects[1] has already completed and an available
thread could work on objects[2]?  How does it learn to process objects[=
2]
in such a case, or does it wait until the thread working on objects[0] =
is
done?
