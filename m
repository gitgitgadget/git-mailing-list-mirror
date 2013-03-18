From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] push test: rely on &&-chaining instead of 'if bad; then
 echo Oops; fi'
Date: Mon, 18 Mar 2013 16:14:26 -0700
Message-ID: <20130318231426.GG5062@elie.Belkin>
References: <20130318220224.3b23a381@hoelz.ro>
 <20130318231043.GD5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Tue Mar 19 00:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHjGl-0007cf-OU
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 00:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab3CRXOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 19:14:33 -0400
Received: from mail-da0-f47.google.com ([209.85.210.47]:45667 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab3CRXOc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 19:14:32 -0400
Received: by mail-da0-f47.google.com with SMTP id s35so1628996dak.20
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MDPa4jStvrIYugpPZQVAEfb5RyoxUjqGlAC8JbpP3rc=;
        b=1IzaZlKi+bzqlvIo4MTqdAdtF49BQg6uLOtIEYaIqsOY7RQGWEdCujVNjNL/YBxd/l
         G0aIyQ3wmtX2GPE6eOIelpAEBeG4iBMzxVTvDgdnf/n4y51MQM1LK8m167v1ZiOXOEmp
         237190LNH8OcmM9ZE5dWMqpeFd22CQau0ZgngOi+4TmprbiKsKZ/0J9ZxGCAV5HTAe0i
         QAQjW3AzM39cZCtAr+S5NRx4EsTknj1YYykfDb0wl86G2q0eg5i4TeaOua7W873mvnj8
         /Gm+I0zo8tltbW9hTXHfo+UzQEt3LiklHicUBfAyITfxVaZVoIs2mfIfvxpNa1SXab6e
         lMAg==
X-Received: by 10.66.40.206 with SMTP id z14mr13151880pak.216.1363648471621;
        Mon, 18 Mar 2013 16:14:31 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id m18sm9877243pad.17.2013.03.18.16.14.29
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 16:14:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130318231043.GD5062@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218464>

When it is unclear which command from a test has failed, usual
practice these days is to debug by running the test again with "sh -x"
instead of relying on debugging 'echo' statements.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t5516-fetch-push.sh | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2f1255d4..0695d570 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -22,10 +22,8 @@ mk_test () {
 	(
 		for ref in "$@"
 		do
-			git push testrepo $the_first_commit:refs/$ref || {
-				echo "Oops, push refs/$ref failure"
-				exit 1
-			}
+			git push testrepo $the_first_commit:refs/$ref ||
+			exit
 		done &&
 		cd testrepo &&
 		for ref in "$@"
@@ -328,13 +326,8 @@ test_expect_success 'push with weak ambiguity (2)' '
 test_expect_success 'push with ambiguity' '
 
 	mk_test heads/frotz tags/frotz &&
-	if git push testrepo master:frotz
-	then
-		echo "Oops, should have failed"
-		false
-	else
-		check_push_result $the_first_commit heads/frotz tags/frotz
-	fi
+	test_must_fail git push testrepo master:frotz &&
+	check_push_result $the_first_commit heads/frotz tags/frotz
 
 '
 
-- 
1.8.2.rc3
