From: Jay Soffian <jaysoffian@gmail.com>
Subject: Okay to invoke merge-recursive with an empty workdir?
Date: Mon, 12 Sep 2011 23:13:37 -0400
Message-ID: <CAG+J_Dyz-aeLYn43ARTG4GJz0+zRw_RyDr80bmPCayd9BjzCwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 05:13:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3JRQ-000659-Ii
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 05:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab1IMDNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 23:13:38 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:51712 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab1IMDNh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 23:13:37 -0400
Received: by yie30 with SMTP id 30so92032yie.19
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=yvPyEHaBSEfgz3Ja17PEpBI0HiELzQOSarLn8U1of/E=;
        b=gxua90qJyfWNyrTDc838Z8DwyWReSKyCG++KEGJ9mymhdOPrANDYJmC3471HSf3IAd
         VfhLQ3qslwhFoZrLf8i/uZtv36RAL50S+sf6r9ebz8vuGNqTCZ7E2qX+U/YSuOwmBdy7
         zeJFzh4oJMJru+W7uGNpVnt1YdhKqlVhqYQpk=
Received: by 10.147.154.12 with SMTP id g12mr883515yao.36.1315883617300; Mon,
 12 Sep 2011 20:13:37 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Mon, 12 Sep 2011 20:13:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181263>

I have an unattended script which performs automated merges into
several destination branches.

As the repo is fairly large, I'd like not to have to checkout each
destination branch, nor have multiple workdirs.

So my approach is to create a temporary, empty, workdir, using
symlinks to point to the parent repo per git new-workdir.

I then invoke merge-recursive directly inside the temporary workdir.

The question is whether this is safe to do, or whether merge-recursive
expects a fully populated working tree that matches the index. My easy
test cases seem to work correctly, but I'm concerned that I sometimes
get:

Skipped /some/file (merged same as existing)
error: addinfo_cache failed for path '/some/file'
Skipped some/other_file (merged same as existing)
error: addinfo_cache failed for path 'some/other_file'

Which seems to be from this code in merge-recursive.cc:

	if (mfi.clean && !df_conflict_remains &&
	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode) {
		int path_renamed_outside_HEAD;
		output(o, 3, "Skipped %s (merged same as existing)", path);
		/*
		 * The content merge resulted in the same file contents we
		 * already had.  We can return early if those file contents
		 * are recorded at the correct path (which may not be true
		 * if the merge involves a rename).
		 */
		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
		if (!path_renamed_outside_HEAD) {
			add_cacheinfo(mfi.mode, mfi.sha, path,
				      0 /*stage*/, 1 /*refresh*/, 0 /*options*/);
			return mfi.clean;
		}

(Peff, hope you don't mind me cc'ing you directly. I seem to recall
you're saying github is doing something like this but I couldn't find
that email.)

j.
