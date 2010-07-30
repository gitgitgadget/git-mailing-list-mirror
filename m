From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: t4111 fails under valgrind
Date: Fri, 30 Jul 2010 13:31:22 -0500
Message-ID: <20100730183122.GA7578@dert.cs.uchicago.edu>
References: <201007301218.52437.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 30 20:32:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeuNM-0003VD-Ev
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 20:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281Ab0G3Sbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 14:31:35 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:60462 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933269Ab0G3SbX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 14:31:23 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id BA7BEA21F;
	Fri, 30 Jul 2010 13:31:22 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 64B3D882; Fri, 30 Jul 2010 13:31:22 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <201007301218.52437.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152256>

Thomas Rast wrote:

>   error: sub/dir/file: does not match index
>   error: sub/dir/file: does not match index
>   error: sub/dir/file: does not match index
>   not ok - 5 apply --index from subdir of toplevel

Thanks for reporting.  Does this patch work for you?

-- 8< --
Subject: t4111 (apply): refresh index before applying patches to it

"git apply", like most plumbing, does not automatically refresh the
index file even if it is only stat-dirty.  So unless the two "cp"
commands in reset_preimage() for a given file happen to have the same
time stamp, there will be a spurious

	error: sub/dir/file: does not match index

Refresh the index to eliminate this timing dependency.  Noticed by
running the test with --valgrind (which slows things down a lot).

Reported-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/t/t4111-apply-subdir.sh b/t/t4111-apply-subdir.sh
index 57cae50..a52d94a 100755
--- a/t/t4111-apply-subdir.sh
+++ b/t/t4111-apply-subdir.sh
@@ -36,7 +36,8 @@ test_expect_success 'setup: subdir' '
 		cp "$2" file &&
 		cp "$2" sub/dir/file &&
 		cp "$2" sub/dir/b/file &&
-		cp "$2" objects/file
+		cp "$2" objects/file &&
+		test_might_fail git update-index --refresh -q
 	}
 '
 
-- 
