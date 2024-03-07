Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E1135A7C
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839216; cv=none; b=G5jPaGAMcYpd/36DTBSRAd+trvPfaeTZdmgpXAM9tXg1jghGc7stRYDiv+bej32/E9DU4wdcjSgGitw0MHeNfz5RuwbJg2rdIu2/cd/T+GLSu0qSSHDL+Ze8IqH/mcp80u2s+KhLFmnnvYYEP1as2vYn8sfD6rcO40kOKjRTWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839216; c=relaxed/simple;
	bh=y4b+iVebSI7IX0kT65Ooyn6p3mL415hOf0cdFmubxHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipzHpelbkiZgXLMBDgHw6DKNK984tyJd+v8MlCOKFv2cnXmVMkEQGQB0hwL7orXl6ZbW+t/wKbtfB+LjzmRt8pQtrW+KJ+sdctn1euoVhc+WMeDnOd6bvtHLJpBFYCYLlDfVtrEzMbF67+KIEAg1EFt6r/+K6itPUpKDg9D/npU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bs7v/xHb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bs7v/xHb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1576F1EECCD;
	Thu,  7 Mar 2024 14:20:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=y4b+iVebSI7IX0kT65Ooyn6p3mL415hOf0cdFm
	ubxHQ=; b=Bs7v/xHbyAvESnn8KYwAhB6ORKogbgsPt4GivgIhdXPRpv9kn8Wyh8
	hfmu+Eov1S7VdJxKqoLh43mZYLpUtf8huMMIrtyyDdM5uFkoANStM7m9BnzJ6frj
	c2Z4abPbJzi8GvWQvr6j45+zy8aRnG2oMCt30QlLNrV+TK3SpH4BQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A6BB1EECCC;
	Thu,  7 Mar 2024 14:20:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D7E61EECCA;
	Thu,  7 Mar 2024 14:20:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Florian Schmidt <flosch@nutanix.com>
Cc: git@vger.kernel.org,  Jonathan Davies <jonathan.davies@nutanix.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Denton Liu
 <liu.denton@gmail.com>,
    Linus Arver <linusa@google.com>
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
In-Reply-To: <20240307183743.219951-1-flosch@nutanix.com> (Florian Schmidt's
	message of "Thu, 7 Mar 2024 18:37:38 +0000")
References: <20240307183743.219951-1-flosch@nutanix.com>
Date: Thu, 07 Mar 2024 11:20:11 -0800
Message-ID: <xmqq34t1n91w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B853D1A2-DCB7-11EE-853D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Florian Schmidt <flosch@nutanix.com> writes:

> Currently, if
> (a) There is a "---" divider in a commit message,
> (b) At some point beyond that divider, there is a cut-line (that is,
>     "# ------------------------ >8 ------------------------") in the
>     commit message,
> (c) the user does not explicitly set the "no-divider" option,
> then "git interpret-trailers" will hang indefinitively.

You do not have to say "Currently, if"; just "If" is sufficient.
Cf. Documentation/SubmittingPatches[[present-tense]]

> This is because when (a) is true, find_end_of_log_message() will invoke
> ignored_log_message_bytes() with a len that is intended to make it
> ignore the part of the commit message beyond the divider. However,
> ignored_log_message_bytes() calls wt_status_locate_end(), and that
> function ignores the length restriction when it tries to locate the cut
> line. If it manages to find one, the returned cutoff value is greater
> than len. At this point, ignored_log_message_bytes() goes into an
> infinite loop, because it won't advance the string parsing beyond len,
> but the exit condition expects to reach cutoff.

Good finding.  

> It seems sensible to expect that wt_status_locate_end() should honour
> the length parameter passed in, and doing so fixes this issue.

Thanks.  This is an ancient bug, not a retression from recent
changes to the trailer library [linusa CC'ed to save him from
wasting his time wondering if he broke anything].

> diff --git a/wt-status.c b/wt-status.c
> index b5a29083df..51a84575ed 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1089,14 +1089,19 @@ size_t wt_status_locate_end(const char *s, size_t len)
>  {
>  	const char *p;
>  	struct strbuf pattern = STRBUF_INIT;
> +	size_t result = len;
>  
>  	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
>  	if (starts_with(s, pattern.buf + 1))
> -		len = 0;
> -	else if ((p = strstr(s, pattern.buf)))
> -		len = p - s + 1;
> +		result = 0;
> +	else if ((p = strstr(s, pattern.buf))) {
> +		result = p - s + 1;
> +		if (result > len) {
> +			result = len;
> +		}
> +	}
>  	strbuf_release(&pattern);
> -	return len;
> +	return result;
>  }

Looks correct, but we probably can make the fix a lot more isolated
into a single block, like the attached patch.  How does this look?

 wt-status.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git c/wt-status.c w/wt-status.c
index b5a29083df..511f37cfe0 100644
--- c/wt-status.c
+++ w/wt-status.c
@@ -1093,8 +1093,11 @@ size_t wt_status_locate_end(const char *s, size_t len)
 	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
 	if (starts_with(s, pattern.buf + 1))
 		len = 0;
-	else if ((p = strstr(s, pattern.buf)))
-		len = p - s + 1;
+	else if ((p = strstr(s, pattern.buf))) {
+		int newlen = p - s + 1;
+		if (newlen < len)
+			len = newlen;
+	}
 	strbuf_release(&pattern);
 	return len;
 }
