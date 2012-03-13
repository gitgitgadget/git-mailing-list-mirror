From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT] [PATCH]  get rid of "cat: write error: Broken pipe" error
 message
Date: Tue, 13 Mar 2012 14:39:44 +0100
Message-ID: <4F5F4E20.6000706@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 14:40:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7RxG-0002Lu-Px
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 14:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab2CMNjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 09:39:55 -0400
Received: from smtp.opera.com ([213.236.208.81]:59776 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931Ab2CMNjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 09:39:53 -0400
Received: from [10.30.1.61] (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q2DDdjWX000883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Mar 2012 13:39:48 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193025>

In some circumstances (like running guilt in a M-x shell buffer in
Emacs) cat may give the above error message when the reader of the
output from cat exits without reading all input from cat.  (In other
circumstances cat is just silently terminated with SIGPIPE.)

Get rid of the error by removing the useless use of cat in
do_get_header and do_get_full_header.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
  guilt |    8 ++++----
  1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/guilt b/guilt
index d1e17d4..7f6806e 100755
--- a/guilt
+++ b/guilt
@@ -359,7 +359,7 @@ do_get_header()
  	# 4th line skips any empty lines thereafter.
  	# 5th line turns off empty line skip upon seeing a non-empty line.
  	# 6th line terminates execution when we encounter the diff
-	cat "$1" | awk '
+	awk '
  BEGIN{body=0; subj=0}
  /^Subject:/ && (body == 0 && subj == 0){subj=1; print substr($0, 10) 
"\n"; next}
  /^(Subject:|From:|Author:|Date:|commit)/ && (body == 0){next}
@@ -369,7 +369,7 @@ BEGIN{body=0; subj=0}
  /^(diff |---$|--- )/{exit}
  {print $0}
  END{}
-'
+' < "$1"
  }

  # usage: do_get_full_header patchfile
@@ -377,12 +377,12 @@ do_get_full_header()
  {
  	# 2nd line checks for the begining of a patch
  	# 3rd line outputs the line if it didn't get pruned by the above rules
-	cat "$1" | awk '
+	awk '
  BEGIN{}
  /^(diff |---$|--- )/{exit}
  {print $0}
  END{}
-'
+' < "$1"
  }

  # usage: assert_head_check
-- 
1.7.9
