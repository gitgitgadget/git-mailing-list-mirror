From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Teach commit about CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 13:07:00 -0800
Message-ID: <7vpqqrit8r.fsf@alter.siamese.dyndns.org>
References: <1297850903-65038-1-git-send-email-jaysoffian@gmail.com>
 <1297850903-65038-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 22:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppoan-0002dt-OU
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 22:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709Ab1BPVHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 16:07:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab1BPVHP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 16:07:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5584D4144;
	Wed, 16 Feb 2011 16:08:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ga9eYHxTqkG+6UDtp9trrQ/vCLA=; b=HexTyY
	g5s1Fnkc49dQ7pX7LWv36he9W6pML6Qol4lutZYGx4KY713Y2q742gqYSUDkdecy
	K+j1C8a48Xxy4s1TKuGtMm9WiNL01pOYSvZDJKQmhO6Xt7aC+BbCJVYnL0z2FNmo
	d2uislq/oX9E+Bb3utFZ9+Db2Cu2iSr8D9yxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MjxGJoM9u/bkvSw1NIYAsbXTG+pG3vk4
	x8CvJe2qqq1Uz/zjBrgSLe1OdPIOTYLo+85kdRVqhsrtFNDgBVlZrNtLniM2NoGM
	ziTsocMotDsp4ZsUEK1gY8gzrLjhiduuYmLxe5MCyQhFrJQJOD8JCDHGELKZkfjy
	I8v9ScnRYrg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 148274142;
	Wed, 16 Feb 2011 16:08:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1BE08413E; Wed, 16 Feb 2011
 16:08:07 -0500 (EST)
In-Reply-To: <1297850903-65038-3-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Wed\, 16 Feb 2011 05\:08\:23 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE0C41F2-3A10-11E0-83E3-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167000>

Jay Soffian <jaysoffian@gmail.com> writes:

> If the user wishes to reset authorship, that must now be done explicitly
> via --reset-author.

This is not a new requirement, is it?  Even "commit -c $that_commit"
before the previous "commit -c CHERRY_PICK_HEAD" does use the original,
no?


I think the changed code is _MUCH_ easier to follow compared to the
previous round; the only thing the reader needs to keep in mind is that
the most of the change essentially is "s/in_merge/whence != FROM_COMMIT/"
and making that work.

> * We remove a unused import from revert.c

Micronit: s/import/include/.


> @@ -766,7 +802,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  
>  	fclose(fp);
>  
> -	if (!commitable && !in_merge && !allow_empty &&
> +	if (!commitable && whence != FROM_MERGE && !allow_empty &&
>  	    !(amend && is_a_merge(head_sha1))) {
>  		run_status(stdout, index_file, prefix, 0, s);
>  		if (amend)

The original says that we reject an attempt to record a no-change commit
when the user is making his own commit without an explicit --allow-empty
request.  Should cherry-pick change this?

"git cherry-pick $a_no_change_commit" does not cause conflicts but it does
fail with "nothing added to commit".  If you said "whence == FROM_COMMIT"
here, you would end up allowing "git commit" following such a failure to
commit without --allow-empty, and that inconsistency is to be avoided
(note that I didn't check if you leave CHERRY_PICK_HEAD behind to trigger
this codepath when this happens).

On the other hand, when the earlier cherry-pick did fail with conflict,
but the resolution ended up to be a no-change commit, you would not
blindly want to record the result as a no-change commit, either.

So I think the above is the right thing to do, but we probably need a bit
of in-code comment to describe why we say "whence != FROM_MERGE" here.

Thanks.
