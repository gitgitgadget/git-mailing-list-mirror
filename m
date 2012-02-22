From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bundle: use a strbuf to scan the log for boundary
 commits
Date: Wed, 22 Feb 2012 12:22:04 -0800
Message-ID: <7vlinuaaab.fsf@alter.siamese.dyndns.org>
References: <a795f6dca5e7c3fc5f9212becda4a46116c502b7.1329939233.git.trast@student.ethz.ch> <fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:22:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Iha-0002Hf-CJ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab2BVUWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 15:22:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871Ab2BVUWH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 15:22:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 804256466;
	Wed, 22 Feb 2012 15:22:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4qk3Hrbquq/UVBdL//cBSjWEexA=; b=wtWiz3
	Ik04zVaR4bQIFNNoRoR4VtzgUnEGKikgep2KZBjZDWupbR4XZCWDlZ+GDLMPcTLK
	b7c5ClQ6QX8tm0Bi0s25zcPvFP+qjA0jUmx2jPo9YMCo8dpW9SfoR5ehPmnTatct
	hiccJo2J5FV/Yae/Bn9Ea/vS1pDNT8lZ9bFjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o1pJkI8bGqdbf+STxVsf2BvX7uf+MAmV
	J2bl9Bsp6wRajqa+Nzda/penmM916P2xErmisSVSN7ujY5LbB954VnW1Jf6H/od8
	eo0GsyhASMznXjXG/5Vx9PZu16qEtogV1sdZpjXOIQm+eiCDhEPvlxs4Jb5nsBp6
	SDqijRIt2mY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7803C6465;
	Wed, 22 Feb 2012 15:22:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8FCA6461; Wed, 22 Feb 2012
 15:22:05 -0500 (EST)
In-Reply-To: <fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed, 22 Feb 2012 20:34:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E353AD66-5D92-11E1-BCAB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191278>

Thomas Rast <trast@student.ethz.ch> writes:

> The first part of the bundle header contains the boundary commits, and
> could be approximated by
>
>   # v2 git bundle
>   $(git rev-list --pretty=oneline --boundary <ARGS> | grep ^-)
>
> git-bundle actually spawns exactly this rev-list invocation, and does
> the grepping internally.
>
> There was a subtle bug in the latter step: it used fgets() with a
> 1024-byte buffer.  If the user has sufficiently long subjects (e.g.,
> by not adhering to the git oneline-subject convention in the first
> place), the 'oneline' format can easily overflow the buffer.  fgets()
> then returns the rest of the line in the next call(s).  If one of
> these remaining parts started with '-', git-bundle would mistakenly
> insert it into the bundle thinking it was a boundary commit.
>
> Fix it by using strbuf_getwholeline() instead, which handles arbitrary
> line lengths correctly.
>
> Note that on the receiving side in parse_bundle_header() we were
> already using strbuf_getwholeline_fd(), so that part is safe.

Thanks for diagnosing this, but I wonder if it even needs --pretty=oneline
to begin with, except for debugging purposes.

Do we ever use the subject string read from the rev-list output in any
way?

In other words, I am wondering if the right patch to minimally fix the
issue starting from older releases is something along this line instead:

diff --git a/bundle.c b/bundle.c
index b8acf3c..339dbb0 100644
--- a/bundle.c
+++ b/bundle.c
@@ -248,7 +248,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	static struct lock_file lock;
 	int bundle_fd = -1;
 	int bundle_to_stdout;
-	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
+	const char **argv_boundary = xmalloc((argc + 3) * sizeof(const char *));
 	const char **argv_pack = xmalloc(6 * sizeof(const char *));
 	int i, ref_count = 0;
 	char buffer[1024];
@@ -271,11 +271,10 @@ int create_bundle(struct bundle_header *header, const char *path,
 	init_revisions(&revs, NULL);
 
 	/* write prerequisites */
-	memcpy(argv_boundary + 3, argv + 1, argc * sizeof(const char *));
+	memcpy(argv_boundary + 2, argv + 1, argc * sizeof(const char *));
 	argv_boundary[0] = "rev-list";
 	argv_boundary[1] = "--boundary";
-	argv_boundary[2] = "--pretty=oneline";
-	argv_boundary[argc + 2] = NULL;
+	argv_boundary[argc + 1] = NULL;
 	memset(&rls, 0, sizeof(rls));
 	rls.argv = argv_boundary;
 	rls.out = -1;
