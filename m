From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-rev-list.txt: Clarify the use of multiple
 revision arguments
Date: Wed, 05 Aug 2009 09:42:33 -0700
Message-ID: <7vd47adxfq.fsf@alter.siamese.dyndns.org>
References: <1249459117-3853-1-git-send-email-git@drmicha.warpmail.net>
 <1249459117-3853-2-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 18:43:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYjZw-0001QU-Ne
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 18:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934657AbZHEQml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 12:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934654AbZHEQml
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 12:42:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934528AbZHEQmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 12:42:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5987721222;
	Wed,  5 Aug 2009 12:42:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9592F2121F; Wed, 
 5 Aug 2009 12:42:35 -0400 (EDT)
In-Reply-To: <1249459117-3853-2-git-send-email-git@drmicha.warpmail.net>
 (Michael J. Gruber's message of "Wed\,  5 Aug 2009 09\:58\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD819410-81DE-11DE-A8FC-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124920>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index 847cc7d..40ca276 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -66,6 +66,13 @@ command:
>  means "list all the commits which are included in 'foo' or 'bar', but
>  not in 'baz'".
>  
> +So, the resulting set of commits is the union of 'foo' and 'bar',
> +intersected with the complement of baz. The order of arguments is
> +irrelevant: first, the union of all positive refs (those without
> +'{caret}') is taken, then the result is intersected with all negative
> +refs (i.e. with the complement of the union of all refs which appear
> +with a preceding '{caret}').

It seems to me that the first sentence just repeats what the previous
sentence that we can see in the context with different fuzziness.

I am guessing that the reason you are patching this is because you felt
that the existing "list all the commits which are _included in_ 'foo' or
'bar', but not _in_ 'baz'" uses "be included in" without defining what it
really means (i.e. "reachable by following the ancestry").

I however find the "union of 'foo' and 'bar' intersected with the
complement of 'baz'" similarly lacking.  The sentence equates commit X
with the set of commits that are reachable from X, without explaining that
is what it is doing.

To me, this feels much worse than the original.  When you say commit X,
the reader must guess if you are talking about the single commit, or the
set of commits reachable from it by following the ancestry chain.

How about rewriting it a bit more without repeating?

 Documentation/git-rev-list.txt |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index a765cfa..8c1535e 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -51,20 +51,26 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Lists commit objects in reverse chronological order starting at the
-given commit(s), taking ancestry relationship into account.  This is
-useful to produce human-readable log output.
+List commits that are reachable by following the `parent` links from the
+given commit(s), but exclude commits that are reachable from the one(s)
+given with a '{caret}' in front of them.  The output is given in reverse
+chronological order by default.
 
-Commits which are stated with a preceding '{caret}' cause listing to
-stop at that point. Their parents are implied. Thus the following
-command:
+You can think of this as a set operation.  Commits given on the command
+line form a set of commits that are reachable from any of them, and then
+commits reachable from any of the ones given with '{caret}' in front are
+subtracted from that set.  The remaining commits are what comes out in the
+command's output.  Various other options and paths parameters can be used
+to further limit the result.
+
+Thus, the following command:
 
 -----------------------------------------------------------------------
 	$ git rev-list foo bar ^baz
 -----------------------------------------------------------------------
 
-means "list all the commits which are included in 'foo' and 'bar', but
-not in 'baz'".
+means "list all the commits which are reachable from 'foo' or 'bar', but
+not from 'baz'".
 
 A special notation "'<commit1>'..'<commit2>'" can be used as a
 short-hand for "{caret}'<commit1>' '<commit2>'". For example, either of
