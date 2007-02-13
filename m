From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] diffstat generation in hooks--update was passing
 "^baserev" to git-diff-tree
Date: Tue, 13 Feb 2007 09:03:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702130856580.8424@woody.linux-foundation.org>
References: <200702131424.21665.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:04:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH14Y-0005DB-Pl
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbXBMRDs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbXBMRDs
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:03:48 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44444 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903AbXBMRDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:03:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1DH3jhB028916
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Feb 2007 09:03:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1DH3iKd003377;
	Tue, 13 Feb 2007 09:03:44 -0800
In-Reply-To: <200702131424.21665.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.923 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39544>



On Tue, 13 Feb 2007, Andy Parkins wrote:
>
> -			echo "Diffstat:"
> -			git-diff-tree --no-color --stat -M -C --find-copies-harder $newrev ^$baserev
> +			echo "Diffstat against $baserev:"
> +			git-diff-tree --no-color --stat -M -C --find-copies-harder $newrev $baserev

This is wrong.

	newrev ^baserev

is right. The "not baserev" tells diff-tree that the baserev is the 
starting point, so newrev is obviously the target, and thus that will 
generate a diff from baserev to newrev.

So will either of

	baserev..newrev
	baserev newrev

which mean _exactly_ the same thing as "newrev ^basrev" to "diff-tree", 
because in all cases it's obviously "baserev" that is the old one to diff 
against.

But

	newrev baserev

means the diff from "new" to "base", which is exactly the wrong way 
around.

Of course, since we did

	baserev=$(git-merge-base $oldrev $newrev)

to generate base-rev, we could actually have done

	$oldrev...$newrev

(note the _three_ dots) which means "diff from merge-base to newrev". But 
since we use "baserev" multiple times, what the update hook does right now 
is actually better - it avoids the cost of re-computing the merge base 
that we needed for other things anyway.

		Linus
