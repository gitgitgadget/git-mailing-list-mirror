From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/4] sha1_file.c: support reading from a loose object of unknown type
Date: Sun, 05 Apr 2015 12:57:58 -0700
Message-ID: <xmqqbnj2e4ah.fsf@gitster.dls.corp.google.com>
References: <551F7984.5070902@gmail.com>
	<1428126162-18987-1-git-send-email-karthik.188@gmail.com>
	<xmqq7ftrg02b.fsf@gitster.dls.corp.google.com>
	<55204141.9070100@gmail.com>
	<xmqqiodbdnkn.fsf@gitster.dls.corp.google.com>
	<5520E9D2.4010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:58:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeqgO-0000yY-KQ
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 21:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbbDET6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 15:58:03 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752010AbbDET6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 15:58:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D984C453B4;
	Sun,  5 Apr 2015 15:57:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ib6EQYk8qHOMae6HjV/5iIBlYsw=; b=eIPJvg
	B+6sHBAxFKQEVqNDAnRxqdOxBvrk/TcZv0ODGj9n2byQpz5st15gSftt4DXHOb+L
	ODV1tTdrW12BtMu6wHj32Je01GmPkdZvlIWtJNICQtrMb4WZQXjGUzroTatWsI5Q
	RbQ6AYaPq0GBEQ2LuuHlW2gpBW4Od2kOnpMiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=peQSG5p1cBzP7xFlww0eebqiPan8Xcng
	KphCt1P3u9tTg6dxxq7s8dWr6OLJMBUI79bhjpNmZ/+00un/Bp+0Enue/SQfwMTC
	W19TKvckPOkwuM9/tXaIftcVRh8Bl70gEhRSwkxvLYA+SLxtyO3H9xzGgwOusvjc
	esRyPMCsWsc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1A69453B3;
	Sun,  5 Apr 2015 15:57:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47F4E453B2;
	Sun,  5 Apr 2015 15:57:59 -0400 (EDT)
In-Reply-To: <5520E9D2.4010603@gmail.com> (karthik nayak's message of "Sun, 05
	Apr 2015 13:22:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0F394438-DBCE-11E4-91A0-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266816>

karthik nayak <karthik.188@gmail.com> writes:

> On 04/05/2015 01:16 PM, Junio C Hamano wrote:
>
>> If it semantically does not make sense to ask for the typename
>> without asking for the type code, then we can and should make that
>> as a new calling convention _all_ callers must follow.
>>
>> In other words, I think it is better to have
>>
>> 	if (oi->typename && !oi->typep)
>> 		die("BUG");
>>
>> somewhere near the beginning of the callchain that takes oi; that
>> will ensure all callers understand the rule.
>
> Yes! this is a better approach as it will enforce that typep must be
> set when typename is set.

Not so fast ;-)

The key phrase in what I wrote above is "If it does not make sense",
and I am not yet convinced if that is the case or not.  If we are to
change the calling convention for the callers, the reason why it
does not make sense to ask only for typename but not typep must be
explained in the log message.

And if it turns out that the answer to that question is "it is valid
to ask only for typename", then it would be wrong to force everybody
who wants to learn the stringified typename to supply typep.  And in
such a case it might be better to do something like this instead (on
top of your patch I am responding to):

 sha1_file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index f4055dd..26fbb7c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2639,6 +2639,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
+	enum object_type real_type;
 	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
 
 	co = find_cached_object(real);
@@ -2670,9 +2671,18 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			return -1;
 	}
 
+	/*
+	 * packed_object_info() does not follow the delta chain to
+	 * find out the real type, unless it is given oi->typep.
+	 */
+	if (oi->typename && !oi->typep)
+		oi->typep = &real_type;
+
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
+		if (oi->typep == &real_type)
+			oi->typep = NULL;
 		return sha1_object_info_extended(real, oi, 0);
 	} else if (in_delta_base_cache(e.p, e.offset)) {
 		oi->whence = OI_DBCACHED;
@@ -2686,6 +2696,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	if (oi->typename)
 		strbuf_addstr(oi->typename, typename(*oi->typep));
 
+	if (oi->typep == &real_type)
+		oi->typep = NULL;
 	return 0;
 }
 
