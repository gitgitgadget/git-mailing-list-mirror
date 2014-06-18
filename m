From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH v3 04/14] refs.c: add a new update_type field to ref_update
Date: Wed, 18 Jun 2014 14:10:26 -0700
Message-ID: <xmqqbntpj54t.fsf_-_@gitster.dls.corp.google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
	<1403111346-18466-5-git-send-email-sahlberg@google.com>
	<xmqqfvj2hs5g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 23:10:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxN7u-0002nW-ME
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 23:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508AbaFRVKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 17:10:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59154 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268AbaFRVKe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 17:10:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F00E82026E;
	Wed, 18 Jun 2014 17:10:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bAyp3XzRFw/mwNhsGLfyQL3w3Lc=; b=OoHjqh
	RJc91LRDupZ955lbumaKl+YZ8IFx4kSdzYcTsi6zIfAhwqhBprq+4PfWaC5rOq6C
	K4e7FVhrp7nTL9nv04Oop5idmJiJaNj0NOV0n+EGUsima2Ln7bdktQ9sUbq3DEQz
	upK8jEsLZROzX9j7Qy+uYMs1iPQj2dPy2VUMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wsEQVv5EwNquIE/TUJRqFop6f7bT2kwP
	lsBgIkzSVLT6x5ejrKReNEpRwo+wog1duyK4UUYQ+2yw9v11RS+ixm87HYzteuo/
	zxWzXotoTIjSNbMqmmetVSplxFnQvK1RuSx5yCLzO/IE1aAy290zI4+FA8VeVYCe
	bnz0dOw2MRc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A54622026B;
	Wed, 18 Jun 2014 17:10:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EF7C320268;
	Wed, 18 Jun 2014 17:10:25 -0400 (EDT)
In-Reply-To: <xmqqfvj2hs5g.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 Jun 2014 13:36:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F7D6CC92-F72C-11E3-A297-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252071>

Junio C Hamano <gitster@pobox.com> writes:

> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> Add a field that describes what type of update this refers to. For now
>> the only type is UPDATE_SHA1 but we will soon add more types.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 25 +++++++++++++++++++++----
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 4e3d4c3..4129de6 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3374,6 +3374,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
>>  	return retval;
>>  }
>>  
>> +enum transaction_update_type {
>> +       UPDATE_SHA1 = 0,
>
> indent with SP?
>
> Unlike an array initialisation, e.g.
>
> 	int foo[] = { 1,2,3,4,5, };
>
> some compilers we support complain if enum definition ends with a
> trailing comma.

I do recall we had fixes to drop the comma after the last element in
enum definition in the past, in response real compilation breakages
on some platforms.  But there is a curious thing:

    git grep -A<somenumber> 'enum ' master -- \*.c

tells me that builtin/clean.c would fail to compile for those folks.

Here is an off-topic "fix" that may no longer be needed.

 builtin/clean.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 9a91515..27701d2 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -48,7 +48,7 @@ enum color_clean {
 	CLEAN_COLOR_PROMPT = 2,
 	CLEAN_COLOR_HEADER = 3,
 	CLEAN_COLOR_HELP = 4,
-	CLEAN_COLOR_ERROR = 5,
+	CLEAN_COLOR_ERROR = 5
 };
 
 #define MENU_OPTS_SINGLETON		01
