From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] restore_env(): free the saved environment variable once we are done
Date: Tue, 02 Feb 2016 18:19:32 -0800
Message-ID: <xmqqy4b2o7rf.fsf@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DzHYpw3TT3i17W-8eiR9J9DOQUO6mkxffUEnGqT1u96Q@mail.gmail.com>
	<xmqqtwlz8c4w.fsf@gitster.mtv.corp.google.com>
	<xmqqy4ba627n.fsf_-_@gitster.mtv.corp.google.com>
	<xmqqio26pt91.fsf_-_@gitster.mtv.corp.google.com>
	<CAPig+cT8PhJU=9aS8NvkN9wx6imtACOS9rkgDJeJpN=CGikd7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 03:19:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQn2h-00016e-O0
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 03:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbcBCCTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 21:19:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64277 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755157AbcBCCTf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 21:19:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 716C441EB4;
	Tue,  2 Feb 2016 21:19:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Aou/J4eubyghpsOu2U1EKX837tc=; b=M4LXB2
	CgzKhBsmRHLrykAySFrO7mdQEV7Z2rFvUyOwKY0BNYXBVQ1wiwAgz8CG8zKm2+G3
	O+JqdXc2J7Ppv8ll0EfJP/vtWk3s3QBgci78mjto7bhKWKH8trTE+7/eyf0gAQNz
	meUWTWIdBu1Ekjq1VCDJRfofZKdpjPRqKI+4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u2k9kixaPcoa0lDoLdM3RHkGKKDW8gtV
	TmBAXcX1eAVQsK9br0bDGaCl+Xl2MeDuI7nkvHJn5UBx5rOPlb4wB74CaVrokSTV
	e5u9v0i1UIM1G4OclwhnrIkTRFfNU9ZcwxTkkuk/EAKomLUodtOHNgXsmGTVRw1U
	amu7SPN1BsM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E36941EB2;
	Tue,  2 Feb 2016 21:19:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA2E141EB1;
	Tue,  2 Feb 2016 21:19:33 -0500 (EST)
In-Reply-To: <CAPig+cT8PhJU=9aS8NvkN9wx6imtACOS9rkgDJeJpN=CGikd7Q@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 2 Feb 2016 20:47:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 90A266CA-CA1C-11E5-A22E-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285324>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/git.c b/git.c
>> @@ -54,10 +54,12 @@ static void restore_env(int external_alias)
>>                 if (external_alias &&
>>                     !strcmp(env_names[i], GIT_PREFIX_ENVIRONMENT))
>>                         continue;
>> -               if (orig_env[i])
>> +               if (orig_env[i]) {
>>                         setenv(env_names[i], orig_env[i], 1);
>> -               else
>> +                       free(orig_env[i]);
>
> Now that this is "well-protected"[1] against incorrect nesting, you
> don't worry about the dangling pointers in static orig_env[], right?
> (The same for the dangling pointer in static 'orig_cwd' after being
> freed a bit earlier in this function, correct?)

Correct.

I do not think we follow a style that requires "after freeing memory
pointed at by a variable, the variable must be assigned NULL".
Would it be a good idea?  I do not see a point in it.

Thanks.
