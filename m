From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external
 file>' finds changes
Date: Fri, 15 Jun 2012 11:45:47 -0700
Message-ID: <7vzk849zxg.fsf@alter.siamese.dyndns.org>
References: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 20:45:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfbWs-0006wy-US
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 20:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267Ab2FOSpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 14:45:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757187Ab2FOSpu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 14:45:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0A94934F;
	Fri, 15 Jun 2012 14:45:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h77BAF9RCsFrIQA75fMu83Jtq0E=; b=uJfvzS
	nF/guQYX/jv1kaXcDoLkKDUuGZseJ4I4teg8PRVKf38ObYltnKp7iDmJpU/V8BfK
	nEnACdrx92FQQpPJrk08/82UJwPyH0dtFuu/aCQ51lDv1BNwDCcjlZ6hHfrhTKV2
	9q0FH/RGTXXwucJ3PKs3XG+VA5U8TbcbXBIRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CsYSnWuX54Y+hEPlz+rTltCK9AYACcmF
	oqueGbHBU7TxsiTdGkauFH6vMSizPlzaG2jgWAKGR2SGmAxVfp0I5WtRo95Q8xVa
	bMgoDEAuT7RRlHSyWbLFClUgZFccWXoxdxkouAM/oo0fZgmDNnoONx8XM/6IpuA/
	TxOixpFsVxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6174934E;
	Fri, 15 Jun 2012 14:45:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A27A934D; Fri, 15 Jun 2012
 14:45:49 -0400 (EDT)
In-Reply-To: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Fri, 15 Jun 2012 13:31:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 536C345C-B71A-11E1-9351-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200080>

Tim Henigan <tim.henigan@gmail.com> writes:

> This was the least invasive fix that I found.

I think this breaks a normal case of comparing revisions and tracked
contents in a big way.

The "quick" thing is meant to notice any difference in the paths
involved (e.g. "git diff maint master -- t/") at the blob object
name level without having to look at the contents when there is no
DIFF_FROM_CONTENTS processing is needed.  We call into the more
expensive diff_flush_patch() codepath only when things like "ignore
whitespace change" is given, in which case we would need to compare
the contents.

Your patch seems to be making us go through diff_flush_patch()
codepath unconditionally, and it looks like it is only to sweep some
other breakage in diff-no-index codepath under the rug.

Have you looked at how "git diff --quiet HEAD^" (without any other
option) for tracked files notices that there is a difference and
exit with non-zero status?  Is it doing something wrong?  Otherwise
why can't the no-index codepath do the same thing?

I think the following may be a lot closer to the correct fix; I
didn't test many combinations of options with it, though.

 diff-no-index.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index f0b0010..ed74e27 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -172,7 +172,7 @@ void diff_no_index(struct rev_info *revs,
 		   int argc, const char **argv,
 		   int nongit, const char *prefix)
 {
-	int i;
+	int i, result;
 	int no_index = 0;
 	unsigned options = 0;
 
@@ -273,5 +273,6 @@ void diff_no_index(struct rev_info *revs,
 	 * The return code for --no-index imitates diff(1):
 	 * 0 = no changes, 1 = changes, else error
 	 */
-	exit(revs->diffopt.found_changes);
+	result = !!diff_result_code(&revs->diffopt, 0);
+	exit(result);
 }
