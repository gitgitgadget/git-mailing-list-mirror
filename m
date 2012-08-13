From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Re: cherry-pick and 'log --no-walk' and ordering
Date: Mon, 13 Aug 2012 00:17:59 -0700
Message-ID: <7vhas7fefs.fsf@alter.siamese.dyndns.org>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 09:18:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0ouh-0006vz-Al
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 09:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab2HMHSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 03:18:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344Ab2HMHSC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 03:18:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B28F77AEA;
	Mon, 13 Aug 2012 03:18:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wTJjZ/SbHFyi2Bq+nDuaPCrQqio=; b=O5HTBu
	29QZJYRYcIfe5Mwm0Ll8Cj4rJ/uaU4K6MdgdzQxTcAalLDzUMJiZA4jOO49I7MLJ
	FmtNNcujshiNGO78LRFvngmp2mp/aQpXDSeT47/OVHIa5N2QJdAIgRXXzGOAbKMk
	O2J6zcBom3zfNHOaOH7sLIxTzEUVvmsxV5370=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xekVdeosUtM4e4cyEZxcBtN/vuIYxPVh
	7GhWDRt3nFDkvd+z1JvfplAz8W7nZvjpILgVAgl6HehG2fT/p5ufaML/zW26atxi
	fLKjxMNE2u5vMFAT3EpixJTlxJyyioDtr3FXeYsvh2gkIPquzu1meriCJkJLCJfH
	M66F5Iqt7AE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FC6A7AE9;
	Mon, 13 Aug 2012 03:18:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9A827AE8; Mon, 13 Aug 2012
 03:18:00 -0400 (EDT)
In-Reply-To: <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
 (y.'s message of "Sun, 12 Aug 2012 23:27:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03C902A6-E517-11E1-BE2E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203329>

y@google.com writes:

[Administrivia: I somehow doubt y@google.com would reach you, and
futzed with the To: line above]

> From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
>
> This series adds supports for 'git log --no-walk=unsorted', which
> should be useful for the re-roll of my mz/rebase-range series. It also
> addresses the bug in cherry-pick/revert, which makes it sort revisions
> by date.
>
> On Fri, Aug 10, 2012 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Range limited revision walking, e.g. "git cherry-pick A..B D~4..D",
>> fundamentally implies sorting and you cannot assume B would appear
>> before D only because B comes before D on the command line (B may
>> even be inside D~4..D range in which case it would not even appear
>> in the final output).
>
> Sorry, I probably wasn't clear; I mentioned "revision walking", but I
> only meant the no-walk case. I hope the patches make sense.

I actually think --no-walk, especially when given any negative
revision, that sorts is fundamentally a flawed concept (it led to
the inconsistency that made "git show A..B C" vs "git show C A..B"
behave differently, which we had to fix recently).

Would anything break if we take your patch, but without two
possibilities to revs->no_walk option (i.e. we never sort under
no_walk)?  That is, the core of your change would become something
like this:

 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 9e8f47a..589d17f 100644
--- a/revision.c
+++ b/revision.c
@@ -2116,12 +2116,12 @@ int prepare_revision_walk(struct rev_info *revs)
 		}
 		e++;
 	}
-	commit_list_sort_by_date(&revs->commits);
 	if (!revs->leak_pending)
 		free(list);
 
 	if (revs->no_walk)
 		return 0;
+	commit_list_sort_by_date(&revs->commits);
 	if (revs->limited)
 		if (limit_list(revs) < 0)
 			return -1;
