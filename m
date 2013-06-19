From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] peel_onion(): add support for <rev>^{tag}
Date: Wed, 19 Jun 2013 11:38:38 -0700
Message-ID: <7vvc5aymhd.fsf@alter.siamese.dyndns.org>
References: <1371605946-32565-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 20:38:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpNHL-0007il-RW
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 20:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364Ab3FSSio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 14:38:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756845Ab3FSSin (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 14:38:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9354A295AC;
	Wed, 19 Jun 2013 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=syEGs49qoQoMif3312TNpoaui5c=; b=qhn22M
	Nimnayn1W3vzWom2xWcqsXMYeMdSiiPCPHkQ+44A2eqBnl7Ouq5/O2EvHMg/KbZa
	p5p5CptmufxvI7wmOIy7NW6UNcXQy+NQu9PZwFRiVwLirTSR+XKRxIeBCQ/BE7x1
	ObuvbjGcvvbexL9fBUH80fm8qDhziTBhb8g2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BWCLJqPLsladR5pCgvBZJF1XXdAkG2sl
	r2oQM2bS0TCUmVQAi2AL0EniHVWC0YhWBIGv0pXIlmVHv5XwbHqaVknslNVTDEDN
	maiKw2buPvLTfZzCNOiUvkGakZNmq/aEukUb2QaFYnbsfzkgGs6+RgmV5eGpeRQn
	3XCfql/6clA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63BD0295AB;
	Wed, 19 Jun 2013 18:38:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4DAC295A6;
	Wed, 19 Jun 2013 18:38:41 +0000 (UTC)
In-Reply-To: <1371605946-32565-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Tue, 18 Jun 2013 21:39:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76F6E242-D90F-11E2-AE4B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228408>

Richard Hansen <rhansen@bbn.com> writes:

> gitrevisions(7) implies that <rev>^{tag} should work,...

Does it?  Is it possible that that should be fixed?

What does it even _mean_ to peel something to a TAG?

A commit, a tree or a blob cannot be peeled to a tag---none of them
can contain a tag.

When you have a tag that points at something else, what you have is
already a tag, so <that-tag>^{tag} would be <that-tag> itself.

Even more confusingly, when you have a tag that points at another
tag, what does <that-outer-tag>^{tag} mean?  The outer tag itself,
or do you need to peel at least once to reveal the inner-tag?  What
if that inner-tag points at yet another tag?

The patch does not touch peel_to_type(), so your answer to the above
question seems to be "if T is already a tag, T^{tag} is T itself",
but then that operation does not look all that useful.

Confused...

> diff --git a/sha1_name.c b/sha1_name.c
> index 90419ef..68fd0e4 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -677,6 +677,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>  	sp++; /* beginning of type name, or closing brace for empty */
>  	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
>  		expected_type = OBJ_COMMIT;
> +	else if (!strncmp(tag_type, sp, 3) && sp[3] == '}')
> +		expected_type = OBJ_TAG;
>  	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
>  		expected_type = OBJ_TREE;
>  	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
