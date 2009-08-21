From: Mark A Rada <marada@uwaterloo.ca>
Subject: Re: What's cooking in git.git (Aug 2009, #03; Thu, 20)
Date: Fri, 21 Aug 2009 08:40:34 -0400
Message-ID: <F4C7A2F3-B030-449A-87AC-B54CA2B647B4@mailservices.uwaterloo.ca>
References: <7veir5naq3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 14:40:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeTQL-0001cG-5E
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 14:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbZHUMkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 08:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755521AbZHUMkm
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 08:40:42 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:40669 "EHLO
	minos.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754898AbZHUMkm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 08:40:42 -0400
Received: from [192.168.1.105] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by minos.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7LCeYWZ005314
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 21 Aug 2009 08:40:37 -0400
In-Reply-To: <7veir5naq3.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.936)
X-UUID: 45c2da3a-982f-4f69-97da-828ebe61c99b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126706>


On 20-Aug-09, at 10:48 PM, Junio C Hamano wrote:

> Should graduate to 'master' soon.
>
> * mr/gitweb-xz (2009-08-06) 3 commits
>  (merged to 'next' on 2009-08-14 at b63b8e6)
> + gitweb: add support for XZ compressed snapshots
> + gitweb: update INSTALL regarding specific snapshot settings
> + gitweb: support to globally disable a snapshot format
>


I never submitted any tests for the patch that adds global snapshot  
disabling
functionality to gitweb.

Jakub, I changed the gitweb_run routine to capture STDOUT as well, is  
that ok?

Unless I missed a case, the tests show that the extra condition check  
that was
added in the &git_snapshot routine is never actually executed, because a
disabled snapshot format is not added to @snapshot_fmts, which is  
checked
first.

snippet:
5178     } elsif (!grep($_ eq $format, @snapshot_fmts)) {
5179         die_error(403, "Unsupported snapshot format");
5180     } elsif ($known_snapshot_formats{$format}{'disabled'}) {
5181         die_error(403, "Snapshot format not allowed");
5182     }
5183


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


---
  t/t9500-gitweb-standalone-no-errors.sh |   67 +++++++++++++++++++++++ 
++++++++-
  1 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb- 
standalone-no-errors.sh
index 6275181..9ce9667 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -57,10 +57,11 @@ gitweb_run () {
  	# we are interested only in properly formatted errors/warnings
  	rm -f gitweb.log &&
  	perl -- "$SCRIPT_NAME" \
-		>/dev/null 2>gitweb.log &&
+		>gitweb.output 2>gitweb.log &&
  	if grep "^[[]" gitweb.log >/dev/null 2>&1; then false; else true; fi

  	# gitweb.log is left for debugging
+	# gitweb.output is used to parse output
  }

  . ./test-lib.sh
@@ -704,4 +705,68 @@ test_expect_success \
  	 gitweb_run "p=.git;a=summary"'
  test_debug 'cat gitweb.log'

+
+#  
----------------------------------------------------------------------
+# snapshot settings
+
+cat >>gitweb_config.perl <<EOF
+
+\$feature{'snapshot'}{'override'} = 0;
+EOF
+
+test_expect_success \
+	'snapshots: tgz only default format enabled' \
+	'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tbz2" &&
+	grep "403 - Unsupported snapshot format" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=txz" &&
+	grep "403 - Unsupported snapshot format" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
+	grep "403 - Unsupported snapshot format" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+cat >>gitweb_config.perl <<EOF
+
+\$feature{'snapshot'}{'default'} = ['tgz','tbz2','txz','zip'];
+EOF
+
+test_expect_success \
+	'snapshots: all enabled in default, use default disabled value' \
+	'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tbz2" &&
+	grep "Status: 200 OK" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=txz" &&
+	grep "403 - Unsupported snapshot format" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
+	grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+cat >>gitweb_config.perl <<EOF
+
+\$known_snapshot_formats{'zip'}{'disabled'} = 1;
+EOF
+
+test_expect_success \
+	'snapshots: zip explicitly disabled' \
+	'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
+	grep "403 - Unsupported snapshot format" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+cat >>gitweb_config.perl <<EOF
+
+\$known_snapshot_formats{'tgz'}{'disabled'} = 0;
+EOF
+
+test_expect_success \
+	'snapshots: tgz explicitly enabled' \
+	'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
  test_done
-- 
1.6.4
