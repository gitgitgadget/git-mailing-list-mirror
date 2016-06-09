From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule--helper: initial clone learns retry logic
Date: Thu, 09 Jun 2016 13:40:59 -0700
Message-ID: <xmqqlh2egko4.fsf@gitster.mtv.corp.google.com>
References: <20160609190637.21177-1-sbeller@google.com>
	<20160609190637.21177-2-sbeller@google.com>
	<xmqqy46egofw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbpurbwAB4H5_JPMsaGHmbeZA=EWjMOfQGB6apLhEXVeA@mail.gmail.com>
	<xmqqtwh2gmlv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 22:41:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB6lK-0002Du-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 22:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbcFIUlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 16:41:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750752AbcFIUlE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 16:41:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8851023523;
	Thu,  9 Jun 2016 16:41:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y0RRaPWjoe4Zk6jH+NCraqhS3Ds=; b=L880B9
	NAd6k0VSIsANQV69Ukzqii572QBXaS4qhsTCqEUS50xWB2vN78QkgGuahtfM4ImJ
	Hrt8vOeuLbo9kvujug7gUAWgWcOhvYXZXZRBDx1w9UJqKsnoRw9xmOU3w0VXTwxR
	aXqu4VU25nQA5t2CYxuotNjFmQO/bphalgHT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w0Vzd3TJSlabPkY6XjquhxCoh4Ct9mOR
	kx6FB8HDJQT/J+Ud+eU3U62Ye4JC57vkEL3n7uUi4lEJI1FZxXvb2k8HiayuqB7l
	uwLQiYgXGDzDCyKqEEaRhmnNm7e4acBsaJ4Yd3G620DPZaZiPxzl0aRAEg5btM2D
	9eyxWdrVf5M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8050023522;
	Thu,  9 Jun 2016 16:41:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB09823521;
	Thu,  9 Jun 2016 16:41:01 -0400 (EDT)
In-Reply-To: <xmqqtwh2gmlv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 09 Jun 2016 12:59:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7AA68A52-2E82-11E6-AFC1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296924>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> instead. But that is still unspecified, so we rather go with
>>
>> static int compare_ce(const void *one, const void *two, void *cb_data)
>> {
>>     const struct cache_entry *ce_one = one, *ce_two = two;
>>     return strcmp(ce_one->name, ce_two->name);
>> }
>
> As I said below, I do not think it is worth addressing by making the
> code's behaviour on real systems worse.  As long as what you have as
> the key into priority queue is a pointer to cache_entry, you cannot
> make it better from that point of view.

... because having to strcmp() their names would be much more
expensive than the pointer comparison.

However, I think you could use a pointer into a single array as
an element of prio_queue.  I notice here:

 	for (; suc->current < suc->list.nr; suc->current++) {
-		const struct cache_entry *ce = suc->list.entries[suc->current];
+		ce = suc->list.entries[suc->current];
 		if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
+			*ce_task_cb = (struct cache_entry *) ce;
 			suc->current++;
 			return 1;
 		}
 	}
 
that list.entries[] can serve as such an array.  If you pass around
the pointer to its element instead, i.e.

-		ce = suc->list.entries[suc->current];
+		ceP = &suc->list.entries[suc->current];
- 		if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
+ 		if (prepare_to_clone_next_submodule(*ceP, child, suc, err)) {
+			*ce_task_cb = (struct cache_entry *) ce;
-			*ce_task_cb = ceP;
		...
	}
	/*
	 * The loop above tried cloning each submodule once,
	 * now try the stragglers again.
	 */
-	ce = (struct cache_entry *) prio_queue_get(&suc->failed_queue);
+	ceP = (struct cache_entry **) prio_queue_get(&suc->failed_queue);

then the elements you are pushing into prio-queue would not be ce
(pointer to a cache entry), but would be a pointer of an array that
holds many pointers to cache entries, so it becomes kosher to
compare them for ordering.

That would probably not add too much overhead at runtime; it may
have to involve a bit of code restructuring, so I do not know if it
is worth it, though.
