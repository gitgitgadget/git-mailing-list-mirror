From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] replace: forbid replacing an object with one of a different type
Date: Thu, 08 Aug 2013 14:38:31 -0700
Message-ID: <7vsiyj982w.fsf@alter.siamese.dyndns.org>
References: <20130807044248.17464.35806.chriscool@tuxfamily.org>
	<A88E12BCC58A401DBDD2EB300C1AAA2D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Christian Couder" <chriscool@tuxfamily.org>,
	"Git List" <git@vger.kernel.org>, "Thomas Rast" <trast@inf.ethz.ch>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:38:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Xuq-0003lD-67
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966775Ab3HHVig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:38:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966756Ab3HHVif (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 17:38:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4668A3737C;
	Thu,  8 Aug 2013 21:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LIQke1ZGXnQcrwFZdFhMKn3ppCc=; b=MfvzPP
	QFiVibZbxlbGNF1Y/s4QimZcYGV/SJbtXV1uaLYOVB90XoPOVHVsQti+ihGlHITP
	566tOdj2OXXqoMdnq4TVrEAjHzOG6itDKb7JmnHWKQt4LAJUTdaSDtaBNeyQ/k9l
	aADLd6U+8i4jZF3skfm5ZE6ckaXI8HJBAUP74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JEy3bhnVUkP+XaQ2AOniiKORY7SzISiO
	XkCog4VGyHtsk1iAGiPLJwh5dSwQ+ZkyrrowogxaHiEHpSqOS5lpKJlAKsaNC3Oj
	3GHyPuxhablMbh03YvrjVl2y1m+x3OU7J15CNPJEkmjS/J+jVwxZ9p251ENxPB+i
	UmBFIvppnXI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 397793737B;
	Thu,  8 Aug 2013 21:38:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDB5737379;
	Thu,  8 Aug 2013 21:38:32 +0000 (UTC)
In-Reply-To: <A88E12BCC58A401DBDD2EB300C1AAA2D@PhilipOakley> (Philip Oakley's
	message of "Thu, 8 Aug 2013 22:09:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF9C5F04-0072-11E3-A42C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231940>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Christian Couder" <chriscool@tuxfamily.org>
> Sent: Wednesday, August 07, 2013 5:42 AM
>> Users replacing an object with one of a different type were not
>> prevented to do so, even if it was obvious, and stated in the doc,
>> that bad things would result from doing that.
>>
>> To avoid mistakes, it is better to just forbid that though.
>>
>> The doc will be updated in a later patch.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> If this patch is considered useful, I will update the doc and
>> maybe add tests.
>
> Acked-by: Philip Oakley <philipoakley@iee.org>
> Improved documentation would always be useful.

Will wait for a reroll with tests and doc updates, then.

>> @@ -100,6 +101,14 @@ static int replace_object(const char *object_ref,
>> const char *replace_ref,
>>  if (check_refname_format(ref, 0))
>>  die("'%s' is not a valid ref name.", ref);
>>
>> + obj_type = sha1_object_info(object, NULL);
>> + repl_type = sha1_object_info(repl, NULL);
>
> Do (very) large blobs have any issues here?  As I understand it, such
> blobs, as with other smaller objects, need to be expanded to determine
> the type.

sha1_object_info() is coded to peek into only the early part of a
loose object or the object header part of a packed object.  Loose
ones we do mmap(), but we only inflate a tiny bit (the first 32
bytes).

>> + if (obj_type != repl_type)
>> + die("Object ref '%s' is of type '%s'\n"
>> +     "while replace ref '%s' is of type '%s'.",
>> +     object_ref, typename(obj_type),
>> +     replace_ref, typename(repl_type));
>
> Perhaps start with "Objects must be of the same type.\n"

Yes.
