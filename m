From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] completion: match ctags symbol names in grep
 patterns
Date: Tue, 18 Oct 2011 00:15:23 -0700
Message-ID: <7vd3duixdg.fsf@alter.siamese.dyndns.org>
References: <20111018044955.GA8976@sigill.intra.peff.net>
 <20111018050105.GC9008@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 18 09:15:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG3tb-0002Kg-Ne
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 09:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757102Ab1JRHP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 03:15:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756774Ab1JRHP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 03:15:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45ADB36E9;
	Tue, 18 Oct 2011 03:15:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X/Fi19WemlbDfyEjcqeNL1eJCuk=; b=vJmG4M
	z3QJx+F1V6Xb4qfkiQdiA1SEOwNZxIcxm0gveu0agQCj5bS8pAN+vjxUHIofPqM/
	TBHxGJS4B043+ChU4Vbv8Nduu0Lz72wtk5wrabJVLeDQoT7wgDuwoqpuQS1MP1jV
	2pFnRjNzAM2wgKXuCRJnJvFl9LA0AWlmRKJus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LgHfKvDabC0XBnBKPvenr6VbmwzEZpk9
	2WOwOgTwIBIFAqWAYFW8MqDYQ3F4uDHTh15r4p9BMaZxEvrIcaJwYImuZRyfoaH8
	/F5823OZTgSR1hN+X9Kxwi5O8kRjVsJOPLxf315DJg3yBXhy/PAsKdDfrw8GQY5h
	RHpfJi4xAec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CF4B36E8;
	Tue, 18 Oct 2011 03:15:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A56EB36E7; Tue, 18 Oct 2011
 03:15:24 -0400 (EDT)
In-Reply-To: <20111018050105.GC9008@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 18 Oct 2011 01:01:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2CA0838-F958-11E0-870F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183866>

Jeff King <peff@peff.net> writes:

> A common thing to grep for is the name of a symbol. This
> patch teaches the completion for "git grep" to look in
> a 'tags' file, if present, to complete a pattern. For
> example, in git.git:
>
>   $ make tags
>   $ git grep get_sha1<Tab><Tab>
>   get_sha1                 get_sha1_oneline
>   get_sha1_1               get_sha1_with_context
>   get_sha1_basic           get_sha1_with_context_1
>   get_sha1_hex             get_sha1_with_mode
>   get_sha1_hex_segment     get_sha1_with_mode_1
>   get_sha1_mb
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It's debatable whether this belongs in the generic completion code, as
> it really only works if your project uses ctags. But I find it to be a
> huge timesaver for finding callsites of functions, especially when
> coupled with "git jump grep" from the previous patch.

Could you elaborate a bit more on how this would help for finding
callsites? You are looking at a function and do not want to break its
callers, so at that point presumably you already know the name of the
function, no?

Ahh, Ok, you do not necessarily want to type the long function name.

By the way, I notice that "make tags" runs "find ." looking for any files
and directories that match "*.[hcS]" (so do $(ETAGS_TARGET) and cscope),
without even excluding .git metadirectory.

Perhaps something like this is in order?

 Makefile |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 17404c4..b38f55b 100644
--- a/Makefile
+++ b/Makefile
@@ -2127,17 +2127,25 @@ po/git.pot: $(LOCALIZED_C)
 
 pot: po/git.pot
 
+git_check = $(shell git ls-files >/dev/null 2>&1; echo $$?)
+ifeq ($(git_check),0)
+FIND_SOURCE_FILES = git ls-files '*.[hcS]'
+else
+FIND_SOURCE_FILES = $(FIND) . \( -name .git -type d -prune \) \
+		-o \( -name '*.[hcS]' -type f -print \)
+endif
+
 $(ETAGS_TARGET): FORCE
 	$(RM) $(ETAGS_TARGET)
-	$(FIND) . -name '*.[hcS]' -print | xargs etags -a -o $(ETAGS_TARGET)
+	$(FIND_SOURCE_FILES) | xargs etags -a -o $(ETAGS_TARGET)
 
 tags: FORCE
 	$(RM) tags
-	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
+	$(FIND_SOURCE_FILES) | xargs ctags -a
 
 cscope:
 	$(RM) cscope*
-	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
+	$(FIND_SOURCE_FILES) | xargs cscope -b
 
 ### Detect prefix changes
 TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):\
