From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git does not handle changing inode numbers well
Date: Wed, 08 Aug 2012 10:53:52 -0700
Message-ID: <7vboiltglr.fsf@alter.siamese.dyndns.org>
References: <20120808152230.GQ21274@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Wed Aug 08 19:54:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzASH-000795-VW
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 19:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486Ab2HHRx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 13:53:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53648 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030483Ab2HHRxz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 13:53:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 748EA98DC;
	Wed,  8 Aug 2012 13:53:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8+ebj/GnltSHRcHstUsYJHwKS1Q=; b=Uw0/ri
	RH+fBj/blODURxRlBBPHBb/chhSoaQA6gulaMvKbW85FihTdNT46hTBGAVl/mOO0
	hCZ+foVvEusN8jc7fjAnJj1jkURFfOKNfrb2SBilYjtLgS537tRIvVje3NK663Ds
	UcpUNQv2bBvCtI+pRUzrt4K4pa9b34OQxpOBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JLwI3AFM2ZJ7VCd1Mxxl3VIFR+CGhuq+
	Dfsg4b1/wvwz9QFChzigXys8SYSBSYlLzBhv+6Qc6dZOdhl8rDwEfC4wqtlJahoW
	54xFOy7CEZsVumui0CiJZSIfaX9I9MS7ZcNmBjaO72ZmO12JXL24LSAaoDXfbDtH
	qHp3gEZUpyM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6207598DB;
	Wed,  8 Aug 2012 13:53:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEB6598DA; Wed,  8 Aug 2012
 13:53:53 -0400 (EDT)
In-Reply-To: <20120808152230.GQ21274@login.drsnuggles.stderr.nl> (Matthijs
 Kooijman's message of "Wed, 8 Aug 2012 17:22:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04A71F2A-E182-11E1-B6B2-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203104>

Matthijs Kooijman <matthijs@stdin.nl> writes:

> So, it seems that git just doesn't cope well with changing inode numbers
> because it checks the content in a first pass in refresh_index, but only
> checks the stat info in the second pass in run_diff_files. The reason it
> does work for regular files is EC_UPTODATE optimization introduced in
> eadb5831: Avoid running lstat(2) on the same cache entry.
>
> So, let's see if I can fix my filesystem now ;-)

True.  We have knobs to cope with filesystems whose st_dev or
st_ctime are not stable, but there is no such knob to tweak for
st_ino.  Shouldn't be too hard to add such, though.  One approach is
to do something like the attached patch, and declare, define,
initialize, and set trust_inum in a way similar to how we handle
trust_ctime in the existing code.

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 2f8159f..6da99af 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -210,7 +210,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	if (ce->ce_uid != (unsigned int) st->st_uid ||
 	    ce->ce_gid != (unsigned int) st->st_gid)
 		changed |= OWNER_CHANGED;
-	if (ce->ce_ino != (unsigned int) st->st_ino)
+	if (trust_inum && ce->ce_ino != (unsigned int) st->st_ino)
 		changed |= INODE_CHANGED;
 
 #ifdef USE_STDEV
