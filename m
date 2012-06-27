From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 11:28:21 -0700
Message-ID: <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
 <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: Daniel Lyubomirov <daniel@digitalus.bg>
X-From: git-owner@vger.kernel.org Wed Jun 27 20:28:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjwyc-000828-RX
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 20:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab2F0S2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 14:28:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386Ab2F0S2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 14:28:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A692972CF;
	Wed, 27 Jun 2012 14:28:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5HTzVK7UyFGsFG1SvxN5gplIZEI=; b=Af6ZlM
	35DTM9XttvSligT4Fe0MZ2vSGgseldxJw08vDTYe5wj1aycI+QReREFJ8mh67H2R
	GBVCy/yzlbf3SRd8xf4smq3Xi0CU6K3ic7jgZokulvgYCHHXMvRxR8kZTcPfD6r1
	EAiovdcHUfc4RTv+b0yQaWpw1NaQIh2zrI5Iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OF1cVAdkhrW52wjgbMfXjQUoNzeugjO7
	6k8cL1uDYNKAlp+D6XJG2UpuN6TctpfNcPp2qXBi6jx6Agh02VfS0P+kHRiqYOhn
	Uh0EPeFW3zi9k8LlW7IYi4A8vVsXE0sVPOOMIO410TpH92Y+uaueXtI7ZDs7Kxiq
	G0Kc5nDgvSk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D98C72CE;
	Wed, 27 Jun 2012 14:28:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2247472CD; Wed, 27 Jun 2012
 14:28:23 -0400 (EDT)
In-Reply-To: <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
 (Daniel Lyubomirov's message of "Wed, 27 Jun 2012 09:32:21 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0BD68D4-C085-11E1-BF48-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200734>

Daniel Lyubomirov -|- Digitalus Bulgaria <daniel@digitalus.bg>
writes:

> Аccidentally my colleague created a file in the root dir of the git repo called - (just dash).
> As result for every commit having this file, diff , merge, cherry-pick maybe others just hang.

Thanks for a report.  I think the "diff" callchain should be
refactored so that the caller can mark the special "stdin" token in
a saner way, but until it happens, the following one-liner should
do.


 diff.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/diff.c b/diff.c
index 1a594df..caa2309 100644
--- a/diff.c
+++ b/diff.c
@@ -2589,6 +2589,14 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1))
 		return 0;
 
+	/*
+	 * And asking to read "-" from the working tree triggers stdin
+	 * input (which needs to be fixed separately by refactoring the
+	 * callchain), forbid "reuse" for now.
+	 */
+	if (!strcmp(name, "-"))
+		return 0;
+
 	len = strlen(name);
 	pos = cache_name_pos(name, len);
 	if (pos < 0)
