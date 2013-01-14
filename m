From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diff: Introduce --diff-algorithm command line option
Date: Mon, 14 Jan 2013 11:12:18 -0800
Message-ID: <7vtxqja8a5.fsf@alter.siamese.dyndns.org>
References: <cover.1358006339.git.mprivozn@redhat.com>
 <6c058f13c6bb83985e8651a8dde99e7b17879d4e.1358006339.git.mprivozn@redhat.com>
 <7vsj63bo4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, trast@student.ethz.ch
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 20:12:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TupSr-00056w-6j
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 20:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405Ab3ANTM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 14:12:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43723 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757425Ab3ANTM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 14:12:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7EA2AA83;
	Mon, 14 Jan 2013 14:12:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QPxESQ+2U6/hFy2CiOLVenarW68=; b=W1Tf4L
	f8kx1KVa7z8QaLIVzKdeGVty+T8waRFbv+f5LaXjZe1Yb8NZSR2QdNW8OKqATeHK
	Ev9XRcWmW2e/QcXc5FVIsg39RPQXqyiYhW9lEmDg3NOXS9xYLWezL/qUToDhZr1L
	gNyr/Erjcgb7pImQAOjdKf4oyJHvHL0OLeR3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eO/+roKxasnE29SFLxUxkiYZrI5HIOMW
	dcNZ3GRhIXvWpnf/pegUStIwxSOUF5ZaN8yUlLfnWrh+CHp55tax/rRHJN1wW7vn
	kuo36P0O0+QuLuPjT0nfNgVmrNOOANFvJOL+gaLVK9qU4K3ktzXyMDRqhjaD37bH
	PtbkRJYegT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70719AA80;
	Mon, 14 Jan 2013 14:12:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62273AA75; Mon, 14 Jan 2013
 14:12:20 -0500 (EST)
In-Reply-To: <7vsj63bo4n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 14 Jan 2013 10:44:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51FA01D8-5E7E-11E2-98AB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213518>

Junio C Hamano <gitster@pobox.com> writes:

> Michal Privoznik <mprivozn@redhat.com> writes:
> ...
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index d882060..53d8feb 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -2068,6 +2068,12 @@ int parse_merge_opt(struct merge_options *o, const char *s)
>>  		o->xdl_opts = DIFF_WITH_ALG(o, PATIENCE_DIFF);
>>  	else if (!strcmp(s, "histogram"))
>>  		o->xdl_opts = DIFF_WITH_ALG(o, HISTOGRAM_DIFF);
>> +	else if (!strcmp(s, "diff-algorithm=")) {
>> +		long value = parse_algorithm_value(s+15);
>> +		if (value < 0)
>> +			return -1;
>> +		o->xdl_opts |= value;
>
> Isn't this new hunk wrong?  DIFF_WITH_ALG() removes the previously
> chosen algorithm choice before OR'ing the new one in, so that
>
> 	diff --histogram --patience
>
> would not end up with a value PATIENCE|HISTOGRAM OR'ed together in
> the algo field.

I misspoke; this is not "diff", but "merge-recursive".  The issue
may be the same here, though.
