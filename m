From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2] test-lib: limit the output of the yes utility
Date: Tue, 2 Feb 2016 19:15:53 +0100
Message-ID: <56B0F259.1060100@kdbg.org>
References: <56B05A95.3000808@kdbg.org>
 <alpine.DEB.2.20.1602020907290.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 02 19:16:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQfUg-0004fz-0D
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 19:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932994AbcBBSP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 13:15:58 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:22635 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755778AbcBBSP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 13:15:56 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pvvTQ31Nxz5tlW;
	Tue,  2 Feb 2016 19:15:54 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 97BD25208;
	Tue,  2 Feb 2016 19:15:53 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <alpine.DEB.2.20.1602020907290.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285294>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, there is no SIGPIPE. A consequence of this is that the
upstream process of a pipe does not notice the death of the downstream
process until the pipe buffer is full and writing more data returns an
error. This behavior is the reason for an annoying delay during the
execution of t7610-mergetool.sh: There are a number of test cases where
'yes' is invoked upstream. Since the utility is basically an endless
loop it runs, on Windows, until the pipe buffer is full. This does take
a few seconds.

The test suite has its own implementation of 'yes'. Modify it to produce
only a limited amount of output that is sufficient for the test suite.
The amount chosen should be sufficiently high for any test case, assuming
that future test cases will not exaggerate their demands of input from
an upstream 'yes' invocation.

[j6t: commit message]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 02.02.2016 um 09:21 schrieb Johannes Schindelin:
> On Tue, 2 Feb 2016, Johannes Sixt wrote:
>> On Windows, there is no SIGPIPE.
> 
> True. But we do get some sort of write failure, no? Otherwise
> https://github.com/git/git/commit/2b86292ed would not work...

Of course. See the second sentence of the commit message.

> I agree with the idea, but I would like to have a less intrusive patch.
> Something like this should do the job as well, and is a little easier on
> the eyes IMHO:

I'm not 100% satisfied with your version because it stomps on
short-and-sweet shell variables $i and $y. But then the utility
only occurs upstream of a pipeline in a separate process, so that
does not matter.

Please allow me to pass authorship to you, since the patch text is
now all yours, and to forge your sign-off.

-- Hannes

 t/test-lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bd4b02e..51e4a88 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -907,9 +907,11 @@ yes () {
 		y="$*"
 	fi
 
-	while echo "$y"
+	i=0
+	while test $i -lt 99
 	do
-		:
+		echo "$y"
+		i=$(($i+1))
 	done
 }
 
-- 
2.7.0.118.g90056ae
