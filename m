From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] revlist.c: introduce --left/right-only for
 unsymmetric picking
Date: Mon, 21 Feb 2011 16:48:43 -0800
Message-ID: <7vvd0cgahg.fsf@alter.siamese.dyndns.org>
References: <4D625972.4090500@drmicha.warpmail.net>
 <a3224c4269b26c366bb5b5df691f22f17b767f83.1298304396.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 01:49:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrgRA-00061D-4F
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 01:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab1BVAsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 19:48:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab1BVAsw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 19:48:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 514E047B6;
	Mon, 21 Feb 2011 19:50:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hj+smWbf6iSDovGwCFdwqSkihgo=; b=TDBzfV
	4DOQFCEW01zKGPL62F0ijgA97BVWM7868Dc78sWzcX0ayWDbtNQ/0+PghCq3NeVm
	MrfFJg9DFR6lZ/VK15DklE4Upx5oqQ+QCF0tOyyYd3Ya6Ol8PzqH1vb0NJaZRrnS
	P33N8VsgMKmITnQCjkThmZeaAMC38pQAoIlXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eb2gjS1qCkwIHUvcSzkz5KbPOlY5LMXN
	V1Fr4rO+tGiD8+xsysnx9iMGj2Dye+b6EgaWEEu4D6frsq1QVfgMkRs1w4ibMBo7
	YdofsGHQ2FsDJrZy2HOsB0k3bk67ANDwoEeJ6rFEKGviUXwDmqW+mkjhZ/DnwtRX
	FNntweZ31ME=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16C1F47B3;
	Mon, 21 Feb 2011 19:49:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1B82B47B2; Mon, 21 Feb 2011
 19:49:55 -0500 (EST)
In-Reply-To: <a3224c4269b26c366bb5b5df691f22f17b767f83.1298304396.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 21 Feb 2011 17\:09\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC8462F2-3E1D-11E0-AC89-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167519>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The existing "--cherry-pick" does not work with unsymmetric ranges
> (A..B) for obvious reasons.

The implementation of this round looks a lot simpler and cleaner.  We
might want to make sure that l/r only are mutually exclusive at the
command parser, though.

diff --git a/revision.c b/revision.c
index 0681c7c..02aa788 100644
--- a/revision.c
+++ b/revision.c
@@ -1906,6 +1906,9 @@ int prepare_revision_walk(struct rev_info *revs)
 	int nr = revs->pending.nr;
 	struct object_array_entry *e, *list;
 
+	if (revs->left_only && revs->right_only)
+		die("left-only and right-only are mutually exclusive");
+
 	e = list = revs->pending.objects;
 	revs->pending.nr = 0;
 	revs->pending.alloc = 0;


Also, I wonder if we want to enhance cherry_pick_list() a bit to give it
an option to show only the commits that have equivalent commits on the
other side (i.e. "the ones that I can now discard"); it obviously is a
separate topic.

>     It could be followed up by introducing --cherry as equivalent to
>     --cherry-pick --right-only --no-merges.

Yeah, I think that is a good idea.

Thanks.
