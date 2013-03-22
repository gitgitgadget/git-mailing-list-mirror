From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/4] match-trees: drop "x = x" initializations
Date: Fri, 22 Mar 2013 14:26:43 -0700
Message-ID: <7v1ub76s8c.fsf@alter.siamese.dyndns.org>
References: <20130322161837.GG3083@sigill.intra.peff.net>
 <20130322162155.GB25857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 22 22:27:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ9UY-0006VU-RN
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 22:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423308Ab3CVV0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 17:26:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423295Ab3CVV0q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 17:26:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8569AA309;
	Fri, 22 Mar 2013 17:26:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/523Ch7GjC6kckPWNZhu4X8HgjU=; b=S156ZQ
	tiFXCEjh2WrzzrPx9yIa9zNk0FlMGKma7lxKSgXLkzzVD4HBJjInP+8jEOoWB8+I
	KGT1He7hDbg21IaZwgp68mVSfq90G250/vPXFuRQjwVXMTL5y1ln5ut/LqYkTddu
	fkX8K9S9MAf1Yc+nEcESdluafKjZM7nF4xjhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YWHzapmLjNs72fn7I92bCZZh4I2lcDJP
	u8LbiASnBdF1lTOQSfIeK7ixzzIiMiwlycWl6qqXQZ1lAtH29jEiF/VXtg2Ii+mT
	kcx8qAGZtsLxmMOS4JoqazMfUvof+tmNIHhct7233fFzWJl5gmVr8LLdf0J6kLZ7
	K7iyFr/wamE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79F99A308;
	Fri, 22 Mar 2013 17:26:45 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D139CA307; Fri, 22 Mar 2013
 17:26:44 -0400 (EDT)
In-Reply-To: <20130322162155.GB25857@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Mar 2013 12:21:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 322A4C3A-9337-11E2-9F9A-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218850>

Jeff King <peff@peff.net> writes:

> Of the 8 patches, this is the one I find the least satisfying, if only
> because I do not think gcc's failure is because of complicated control
> flow, and rearranging the code would only hurt readability. And I'm
> quite curious why it complains about "mode", but not about the other
> variables, which are set in the exact same place (and why it would not
> be able to handle such a simple control flow at all).
>
> It makes me wonder if I am missing something, or there is some subtle
> bug. But I can't see it. Other eyes appreciated.

I obviously am not qualified as "other eyes" to catch bugs in this
code as this is entirely mine, but I do not see any obvious reason
that would make the compiler to think mode[12] less initialized than
elem[12] or path[12] either.

These three are all updated by the same tree_entry_extract() call,
and whenever we use mode[12] we use path[12], so if it decides path1
is used or assigned, it should be able to tell mode1 is, too.

Unsatisfactory, it surely is...

>  match-trees.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/match-trees.c b/match-trees.c
> index 26f7ed1..4360f10 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -71,13 +71,13 @@ static int score_trees(const unsigned char *hash1, const unsigned char *hash2)
>  	if (type != OBJ_TREE)
>  		die("%s is not a tree", sha1_to_hex(hash2));
>  	init_tree_desc(&two, two_buf, size);
> -	while (one.size | two.size) {
> -		const unsigned char *elem1 = elem1;
> -		const unsigned char *elem2 = elem2;
> -		const char *path1 = path1;
> -		const char *path2 = path2;
> -		unsigned mode1 = mode1;
> -		unsigned mode2 = mode2;
> +	while (one.size || two.size) {
> +		const unsigned char *elem1;
> +		const unsigned char *elem2;
> +		const char *path1;
> +		const char *path2;
> +		unsigned mode1 = 0; /* make gcc happy */
> +		unsigned mode2 = 0; /* make gcc happy */
>  		int cmp;
>  
>  		if (one.size)
