From: Junio C Hamano <gitster@pobox.com>
Subject: Re: combined diff, but not condensed, howto?
Date: Thu, 18 Sep 2008 00:01:39 -0700
Message-ID: <7vskryym24.fsf@gitster.siamese.dyndns.org>
References: <48D0B907.7040903@viscovery.net>
 <7vwsha6761.fsf@gitster.siamese.dyndns.org> <48D1EDB7.5070107@viscovery.net>
 <7vy71qyo9d.fsf@gitster.siamese.dyndns.org> <48D1F426.4040208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 18 09:03:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDXa-0006M8-6f
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 09:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbYIRHBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 03:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbYIRHBr
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 03:01:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbYIRHBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 03:01:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AA76C62023;
	Thu, 18 Sep 2008 03:01:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E09FC62022; Thu, 18 Sep 2008 03:01:41 -0400 (EDT)
In-Reply-To: <48D1F426.4040208@viscovery.net> (Johannes Sixt's message of
 "Thu, 18 Sep 2008 08:24:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A74DE274-854F-11DD-8C3D-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96173>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
> ...
>> It all happens inside combine-diff.c::make_hunks().  If you pass dense==0,
>> you should be able to get all the uninteresting hunks, I think.
>> 
>> Perhaps
>> 
>> 	$ git diff --base -c
>
> Yes, that does it!

It may do so, but I do not necessarily agree with the logic.

It is very much Ok and useful for "git diff" to default to "--cc -p", and
it may be fine for "git diff-files -p" to default to "--cc".

But I think ideally an explicit "git diff -c" and "git diff-files -c -p"
should not turn the "dense combined" mode on.

The commonality of these two functions is striking and calls for proper
refactoring, but aside from that, I think a patch like this should be
applied.  What do you think?

---

 builtin-diff-files.c |    7 ++++++-
 builtin-diff.c       |    7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git i/builtin-diff-files.c w/builtin-diff-files.c
index 9bf10bb..2b578c7 100644
--- i/builtin-diff-files.c
+++ w/builtin-diff-files.c
@@ -50,7 +50,12 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	    3 < rev.max_count)
 		usage(diff_files_usage);
 
-	if (rev.max_count == -1 &&
+	/*
+	 * "diff-files --base -p" should not combine merges because it
+	 * was not asked to.  "diff-files -c -p" should not densify
+	 * (the user should ask with "diff-files --cc" explicitly).
+	 */
+	if (rev.max_count == -1 && !rev.combine_merges &&
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
 		rev.combine_merges = rev.dense_combined_merges = 1;
 
diff --git i/builtin-diff.c w/builtin-diff.c
index 037c303..9fb30c6 100644
--- i/builtin-diff.c
+++ w/builtin-diff.c
@@ -223,7 +223,12 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 		argv++; argc--;
 	}
 
-	if (revs->max_count == -1 &&
+	/*
+	 * "diff --base" should not combine merges because it was not
+	 * asked to.  "diff -c" should not densify (the user should ask
+	 * with "diff --cc" explicitly.
+	 */
+	if (revs->max_count == -1 && !revs->combine_merges &&
 	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
 		revs->combine_merges = revs->dense_combined_merges = 1;
 
