From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-cache.c: fix a memleak in add_to_index
Date: Mon, 23 Mar 2015 11:07:16 -0700
Message-ID: <xmqqpp7za8q3.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY=b3=ppmB+eJOAgcUec7hq+ycJiCvBzkTc7U78Mgog_g@mail.gmail.com>
	<1427133432-26703-1-git-send-email-sbeller@google.com>
	<1427133432-26703-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 19:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya6l3-0004pd-At
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 19:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbbCWSHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 14:07:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752214AbbCWSHT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 14:07:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D56CC429AA;
	Mon, 23 Mar 2015 14:07:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+YsXozrmx+1t9+/llc3dkvdy3Wk=; b=CwNmjN
	JXUHniEzPvptxF7LnoTInb9mkoy9Py3eOaO2rNruCK40qZzAcos29z3T/5640IE0
	ml/MZMcLI6ygZFEOk2IseDJxL9HcBgQvR6Z9wWPxqCpQ3mRD/OHjSmyXgqMccxPx
	mMT+9vMr7HuIwRu/U2kle7K/HYZyiAGVXpbm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FT5mZTSYQ4LuDTw1ZxyYIK8jlZPYY9OL
	38VBnQDO16R0ax6pcprxJ7IgmXkN5ZH7FpABsCOm+dZzX+wU1HFoVDmDgRymnlaf
	DMEdmmV544n5GbswHLBZK0nKf9kY8RBRDAlj5apQVsmArTiQ5NCmkChHeudWCdq/
	nDOXxKgltVk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE710429A9;
	Mon, 23 Mar 2015 14:07:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 537E8429A8;
	Mon, 23 Mar 2015 14:07:18 -0400 (EDT)
In-Reply-To: <1427133432-26703-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 23 Mar 2015 10:57:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7188F2C4-D187-11E4-AB24-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266154>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  I have reread your remarks from the weekend, and I agree
>  this looks more intuitive. Thanks for pointing out the subtle details
>  to make programming an art!

Heh, Our mails crossed, I guess.  I've done this myself like this

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 23 Mar 2015 10:58:00 -0700
Subject: [PATCH] add_to_index(): free unused cache-entry

We allocate a cache-entry pretty early in the function and then
decide either not to do anything when we are pretending to add, or
add it and then get an error (another possibility is obviously to
succeed).

When pretending or failing to add, we forgot to free the
cache-entry.

Noticed during a discussion on Stefan's patch to change the coding
style without fixing the issue ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 60abec6..5b922fd5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -707,9 +707,11 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		    ce->ce_mode == alias->ce_mode);
 
 	if (pretend)
-		;
-	else if (add_index_entry(istate, ce, add_option))
-		return error("unable to add %s to index",path);
+		free(ce);
+	else if (add_index_entry(istate, ce, add_option)) {
+		free(ce);
+		return error("unable to add %s to index", path);
+	}
 	if (verbose && !was_same)
 		printf("add '%s'\n", path);
 	return 0;
-- 
2.3.3-454-g85aa98f
