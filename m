From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git segfaults on older Solaris releases
Date: Thu, 07 Apr 2016 11:50:46 -0700
Message-ID: <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
References: <5706A489.7070101@jupiterrise.com>
	<xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: "Tom G. Christensen" <tgc@jupiterrise.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:51:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoF1H-0007QS-5D
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 20:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbcDGSuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 14:50:50 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751950AbcDGSut (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 14:50:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3221552393;
	Thu,  7 Apr 2016 14:50:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rvI8ZIxn5wF5nzdWHcrbmgZrIgI=; b=kFHawj
	DryZpVe7taFnuY5TAvJdk9EPnklGOAqeBeLsRkKvnMRiCX2R2KMIZ8wXcBiySYly
	gwXVtfLiHNGK/mUL2NNfG6gCuxRZuMTLHnwtOZ2HtKmn2wI977zR5Y/W6unl/gFK
	qGQOXWEzkwLP7oY4EXVPZFJU15ympmzSbqSK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pEig3a4O1ExWKoe+DQhEoQhc1M/hpSMn
	/sSIleERh90fZ5bsDqC+GppqlqPVHyid2ELxek15hOW1tdwCUX0DW4uuXDGASIMs
	2f6yjVYqKyzoB6jSp7Lc+Bbod+AGhZ35oRQzSxBhncqIQlVtsxyTHWCWNHgtT5aw
	gymjWi6l1Z0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29A1652392;
	Thu,  7 Apr 2016 14:50:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9BE1052391;
	Thu,  7 Apr 2016 14:50:47 -0400 (EDT)
In-Reply-To: <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Apr 2016 11:32:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A42EA64C-FCF1-11E5-8167-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290946>

Junio C Hamano <gitster@pobox.com> writes:

> "Tom G. Christensen" <tgc@jupiterrise.com> writes:
>
>> The reason for the crash is simple, a null value was passed to the 's'
>> format for the *printf family of functions.
>> ...
>> Passing a null value to the 's' format is explicitly documented as
>> giving undefined results on Solaris, even on Solaris 11(2).
>
> Do you mean
>
> 	*printf("...%.*s...", ..., 0, NULL, ...)
>
> i.e. you saw a NULL passed only when we use %.*s with width=0?

So, I've looked at places where we use "%.*s" with "prefix" nearby,
and it seems that this is the only place.

The "prefix" being a NULL is a perfectly valid state throughout the
system and means a different thing than it being an empty string, so
it is valid for callers of prefix_path() and prefix_path_gently() to
pass prefix=NULL as long as they pass len=0.

So perhaps this is all we need to fix your box.

 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 3439ec6..b6c8aab 100644
--- a/setup.c
+++ b/setup.c
@@ -103,7 +103,7 @@ char *prefix_path_gently(const char *prefix, int len,
 			return NULL;
 		}
 	} else {
-		sanitized = xstrfmt("%.*s%s", len, prefix, path);
+		sanitized = xstrfmt("%.*s%s", len, prefix ? prefix : "", path);
 		if (remaining_prefix)
 			*remaining_prefix = len;
 		if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {
