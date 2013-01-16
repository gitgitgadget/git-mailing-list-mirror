From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [GUILT] [PATCH 1/7] get rid of "cat: write error: Broken pipe" error
 message
Date: Tue, 15 Jan 2013 18:27:01 -0800
Message-ID: <20130116022701.GJ12524@google.com>
References: <20130116022606.GI12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>,
	Theodore Ts'o <tytso@mit.edu>, Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:27:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvIix-0007wf-8q
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757712Ab3APC1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:27:07 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:54052 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757854Ab3APC1F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:27:05 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so488580pad.27
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 18:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/7f3BvjgvYGL67OkYESFV9qpsnnGWwkM7eRu81Cqabk=;
        b=eVoZQddVi2UNgkmJ3+Ho/I+CyC0jpMhnwIiLQJ8xu9j4V81U+pN3arP3EmGpDXjb1F
         H+bAcV9kSHQweiKHs7CRPTeV+gLttI7tCcc1JyglJ2Sx9wsReZ8NZevl8uiWL4p0W5o5
         +dyJqeAYWMo+ZoCfhNFF7VG9eJy64sa9ouFEniPrKkLihyEcN8+n4YUM7RyJ+XuxOIbB
         Yv9JED+Gw+FMWJto/71RGYxUpH5LkwoybyzdR4tJ1JeRzaNFzHeMKKvLEpHNQ+R0wIDo
         g2RATlli1pWOo51hzZ4HWlAYFhpDT0uUb2NuMWKvW8EgMoGFTPfGzrdIE3W6uoDOIBeR
         WcxA==
X-Received: by 10.68.130.170 with SMTP id of10mr270382560pbb.131.1358303225243;
        Tue, 15 Jan 2013 18:27:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id kl3sm11291510pbc.15.2013.01.15.18.27.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 18:27:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130116022606.GI12524@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213709>

From: Per Cederqvist <cederp@opera.com>
Date: Tue, 13 Mar 2012 14:39:44 +0100

In some circumstances (like running guilt in a M-x shell buffer in
Emacs) cat may give the above error message when the reader of the
output from cat exits without reading all input from cat.  (In other
circumstances cat is just silently terminated with SIGPIPE.)

Get rid of the error by removing the useless use of cat in
do_get_header and do_get_full_header.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Acked-by: Jeff Sipek <jeffpc@josefsipek.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 guilt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
 /^Subject:/ && (body == 0 && subj == 0){subj=1; print substr($0, 10) "\n"; next}
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
1.8.1
