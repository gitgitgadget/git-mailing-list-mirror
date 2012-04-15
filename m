From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from
 remote remote"
Date: Sun, 15 Apr 2012 03:11:20 +0200
Message-ID: <20120415011118.GA4123@ecki>
References: <4F893CD8.5020700@gmail.com>
 <20120414201446.GB29999@ecki>
 <4F8A0F96.5060408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 03:13:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJE1k-0006Ms-6a
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 03:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653Ab2DOBMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 21:12:38 -0400
Received: from smtpout15.highway.telekom.at ([195.3.96.90]:58274 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756558Ab2DOBMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 21:12:37 -0400
Received: (qmail 19536 invoked from network); 15 Apr 2012 01:12:33 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL504.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub76.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <stefano.lattarini@gmail.com>; 15 Apr 2012 01:12:32 -0000
Content-Disposition: inline
In-Reply-To: <4F8A0F96.5060408@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195540>

On Sun, Apr 15, 2012 at 02:00:22AM +0200, Stefano Lattarini wrote:
>
> Debug: Remote helper: -> export
> Got command 'export' with args ''
> Debug: Remote helper: Waiting...

Hmm. Looks like fast-import and fast-export are in a deadlock. It's
probably time to let the experts take over. But if you want to indulge
me further, you could try again with GIT_TRACE=1.  That should give you
the arguments to use for the fast-export and fast-import commands right
before it hangs. Then run ./t5800-remote-helpers.sh -i with the
following change to make it abort right before git push:

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 1c62001..c4855e9 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -68,7 +68,8 @@ test_expect_success 'pushing to local repo' '
        (cd localclone &&
        echo content >>file &&
        git commit -a -m three &&
-       git push) &&
+       false &&
+       GIT_TRACE=1 GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 git push) &&
        compare_refs localclone HEAD server HEAD
 '
 

You can manually now run fast-export using the arguments from the first
run, for example in my case:

 cd trash\ directory.t5800-remote-helpers
 (cd localclone; git 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/testgit.marks' '--import-marks=.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master') |

That should output:

feature done
blob
mark :5
data 24
content
content
content

commit refs/heads/master
mark :6
author A U Thor <author@example.com> 1334451823 +0000
committer C O Mitter <committer@example.com> 1334451823 +0000
data 6
three
from :4
M 100644 :5 file

done


Finally, you can manually pipe fast-export to fast-import, again using
the arguments from the first run:

 cd trash\ directory.t5800-remote-helpers
 (cd localclone; git 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/testgit.marks' '--import-marks=.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master') |
 (cd server; git fast-import '--quiet' '--export-marks=/home/drizzd/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/git.marks' '--import-marks=/home/drizzd/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/cbf054fee258a261ee43ebdc835f0da71b3d1562/git.marks')

If the fast-export output is the same, and if the last command also
hangs for you, then we can start debugging fast-import.

Clemens
