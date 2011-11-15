From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] refresh_index: notice typechanges in output
Date: Mon, 14 Nov 2011 16:08:32 -0800
Message-ID: <7vaa7yi6wv.fsf@alter.siamese.dyndns.org>
References: <20111114225056.GA27370@sigill.intra.peff.net>
 <20111114225651.GD3993@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 01:08:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ6Zt-0002UN-3W
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 01:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768Ab1KOAIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 19:08:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698Ab1KOAIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 19:08:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EBE952A0;
	Mon, 14 Nov 2011 19:08:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nCOA3RD/p2M28t+enNq+aXibsU8=; b=E+lHLj
	tREXyvz599ki2UQ54GRuV940jqXsHGAGFdKhD0ukthGTvg7FTl9lPmwCXqRC2FZ9
	htlzLR2wDh31XG0lbqAlolHm9wETBr32Q/bOVVkrsA2WYpyJUphVapFvFDzrcIsg
	fmhdsVIhmJqShQEPuZ0O0pyd7qt+ZKR5bdNa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Um29GG9rbP3Ed/stZSf0NcFTDBiosRq5
	PcN3sDL3AbpLC9cBEKwQewqb3z31m4m46GmjMT5io6orJdLOB8qxzbrviHNEZFkr
	pggRjPUwkS3wz1dwZoOujVQOHJ7+EGKLXztZinaHIcmp2Pm0MGLR9vsZzjlNmBo0
	vNjE+b28WwI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4616C529F;
	Mon, 14 Nov 2011 19:08:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4D1E529D; Mon, 14 Nov 2011
 19:08:33 -0500 (EST)
In-Reply-To: <20111114225651.GD3993@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 14 Nov 2011 17:56:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F50C3EB0-0F1D-11E1-812B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185418>

Jeff King <peff@peff.net> writes:

> If a file changes type and a porcelain updates the index, we
> will print "M file". Instead, let's be more specific and
> print "T file", which matches actual diff and status output.
>
> The plumbing version remains "needs update" for historical
> compatibility.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The "changed" flag comes from refresh_cache_ent, which in turn gets it
> from ie_modified_stat. The one hesitation I have is that intent-to-add
> entries get the TYPE_CHANGED flag set, which means they will get a "T"
> output. Whereas I actually think "M" is a little more sensible.

I agree that we should not say that an intent-to-add entry has changed
type relative to whatever, as by definition there is nothing to compare
against. "A" that stands for "A"dd is a lot more sensible here, I would
think.

 read-cache.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 0e17add..27e9fc6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1108,11 +1108,13 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	const char *modified_fmt;
 	const char *deleted_fmt;
 	const char *typechange_fmt;
+	const char *added_fmt;
 	const char *unmerged_fmt;
 
 	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
 	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
+	added_fmt = (in_porcelain ? "A\t%s\n" : "%s needs update\n");
 	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
@@ -1142,6 +1144,8 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 		if (new == ce)
 			continue;
 		if (!new) {
+			const char *fmt;
+
 			if (not_new && cache_errno == ENOENT)
 				continue;
 			if (really && cache_errno == EINVAL) {
@@ -1153,9 +1157,16 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			show_file((cache_errno == ENOENT ? deleted_fmt :
-				   changed & TYPE_CHANGED ? typechange_fmt :
-				   modified_fmt),
+
+			if (cache_errno == ENOENT)
+				fmt = deleted_fmt;
+			else if (ce->ce_flags & CE_INTENT_TO_ADD)
+				fmt = added_fmt; /* must be before other checks */
+			else if (changed & TYPE_CHANGED)
+				fmt = typechange_fmt;
+			else
+				fmt = modified_fmt;
+			show_file(fmt,
 				  ce->name, in_porcelain, &first, header_msg);
 			has_errors = 1;
 			continue;
