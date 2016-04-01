From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Fri, 01 Apr 2016 10:03:25 -0700
Message-ID: <xmqq4mbljm76.fsf@gitster.mtv.corp.google.com>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
	<1459470946-16522-2-git-send-email-sbeller@google.com>
	<CAPig+cQ=83k-of=jP1r6bYqsYrUhiDKhR3_Bm-SfYndn+sL=Dg@mail.gmail.com>
	<xmqqh9fljojo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:03:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am2Ts-0001yH-U5
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 19:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbcDARD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 13:03:29 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753074AbcDARD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 13:03:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CFE324F525;
	Fri,  1 Apr 2016 13:03:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EnCPFA6UPXJkyCrAk8BwVYIEpSQ=; b=fyXNDI
	KCyG/YF+TtozYjj0lMD18jZRjQTZSbQBPFXT8RvDUiat2JfpPYLj/zzQZareaJ+W
	D+rScGWXD6+ggZ9Vw6u4WLaEO9LHz9L7KNAHD2clwdV1iIftPd6UoKGpFLQnHMm2
	bOdnwQmHLKyGdO0PULFohiA3oVrhB/0agvmP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xB2kSx69Q59XH/6K8hA2tR/fudtKckQn
	kDFMhF0PZQ0ybtAJ7Q/31cvYLQpJqyOP0q0HUYfy538snP4YeWfxZLSo8vRG0zlb
	PFmB852jW2SdrHrk/bxUfjQ6Ns5HDZMlzx46soSgy7YIgr20FdnNjiSqQK0jQLZc
	dN7Yj/YNdzM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B78B44F524;
	Fri,  1 Apr 2016 13:03:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 052BC4F521;
	Fri,  1 Apr 2016 13:03:26 -0400 (EDT)
In-Reply-To: <xmqqh9fljojo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 01 Apr 2016 09:12:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A6CCB224-F82B-11E5-AE9C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290559>

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Meh. Rather than reverting the git_config_get_value(), it would have
>> been just as easy and safer (less chance of a future change
>> re-introducing a leak) if you had just inserted the necessary check
>> here:
>>
>>     if (!value)
>>         return  config_error_nonbool(key);
>
> Yup, sounds much more sensible fix that is useful in the longer term
> (and avoids one unnecessary strdup()).

Perhaps like this?

-- >8 --
From: Stefan Beller <sbeller@google.com>
Date: Thu, 31 Mar 2016 11:04:03 -0700
Subject: [PATCH] notes: don't leak memory in git_config_get_notes_strategy

This function asks for the value of a configuration and
after using the value does not have to retain ownership
of the value.  git_config_get_string_const() however is
a function to get a copy of the value, but we forget to
free it before we return.

Because we only need to peek the value without retaining
a pointer to it, use git_config_get_value() to peek into
the value cached in the config API layer.

As git_config_get_value() does not insist the value to be
a string, we'd need to do the "nonbool" check ourselves.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 52aa9af..c1265eb 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -743,8 +743,10 @@ static int git_config_get_notes_strategy(const char *key,
 {
 	const char *value;
 
-	if (git_config_get_string_const(key, &value))
+	if (git_config_get_value(key, &value))
 		return 1;
+	if (!value)
+		return config_error_nonbool(key);
 	if (parse_notes_merge_strategy(value, strategy))
 		git_die_config(key, "unknown notes merge strategy %s", value);
 
-- 
2.8.0-225-g297c00e
