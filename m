From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: gitweb commitdiff page - binary files with ampersands in filename?
Date: Mon, 15 Apr 2013 23:42:13 +0200
Message-ID: <516C7435.7050203@gmail.com>
References: <CAKzCUUH4m8Hn_zcE_eHB9YBjDQWPAiX17HCOVZ80f+Tx5EVdOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Oj W <ojwlists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 23:42:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URrAL-0006JA-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 23:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305Ab3DOVmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 17:42:17 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:61144 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab3DOVmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 17:42:17 -0400
Received: by mail-ee0-f44.google.com with SMTP id c41so2526992eek.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 14:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=NwE06ba9KCWJzxWOGpGXzynB5eMZ8jc4tlhEv/+WKBg=;
        b=TyKO/rLy0FepJXirERIVgeJsQeVqVL08tTkLmukdg1Vb9qGAGz8ir6rhpZImz4OaoI
         UjhVk1GWpisV0vqR04KYdVboya3VG8L5d2aC8paDiGVOEmRKhnsDq9MnkOCU1lJfZETg
         NsVFyyBy8Ibd2uO3nJg281Y9dqeBTQyfcbMq/ylcghUUUbx3WXQhtHjAkfdlFvG3rj3S
         nKXZEHnuF2bedQyfaARBJM9kXIh64REv0USaenZ2+ZCXOU9G5wC1B/cUWw0+JE1nZfok
         2gJGH9vwIknN1DNGyqBSkfIeZR5jpBFNen5w5XRT5Z3CCtNhqTVmTrm3Js2/Y0cjJs4V
         Hm2Q==
X-Received: by 10.14.177.197 with SMTP id d45mr9780132eem.9.1366062135988;
        Mon, 15 Apr 2013 14:42:15 -0700 (PDT)
Received: from [192.168.1.14] (ept17.neoplus.adsl.tpnet.pl. [83.20.61.17])
        by mx.google.com with ESMTPS id a41sm29052827eei.4.2013.04.15.14.42.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 14:42:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAKzCUUH4m8Hn_zcE_eHB9YBjDQWPAiX17HCOVZ80f+Tx5EVdOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221319>

Oj W wrote:

> Change a binary file whose filename contains an ampersand, then view
> the commitdiff page in gitweb.
> 
> Git outputs a message like "Binary files a/b&w.dll and b/b&w.dll differ"
> 
> Gitweb format_diff_from_to_header() doesn't notice anything in that
> output which needs escaping, and writes it directly to the XHTML 1.0
> Strict output.
> 
> Then gitweb's output is invalid XML, meaning that browsers such as
> Firefox will refuse to display the page.

This was because in case of binary files we don't get usual diff,
just "Binary files a/foo and b/foo differ" just after extended git diff 
headers.

There are two problems with gitweb code.  First is that git_patchset_body()
didn't recognize and handle this situation.  This should be fixed by the
patch below (I have trouble testing it as git-instaweb keeps using old
gitweb version for some reason).

Second is that format_diff_from_to_header() doesn't handle unrecognized
extended git diff headers well - it doesn't HTML escape them.  This is to
be fixed.

-- >8 --
---
 gitweb/gitweb.perl |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1309196..33a0de1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5345,7 +5345,8 @@ sub git_patchset_body {
 		while ($patch_line = <$fd>) {
 			chomp $patch_line;
 
-			last EXTENDED_HEADER if ($patch_line =~ m/^--- |^diff /);
+			last EXTENDED_HEADER
+				if ($patch_line =~ m/^--- |^diff |^Binary files .* differ$/);
 
 			print format_extended_diff_header_line($patch_line, $diffinfo,
 			                                       \%from, \%to);
@@ -5357,7 +5358,12 @@ sub git_patchset_body {
 			print "</div>\n"; # class="patch"
 			last PATCH;
 		}
-		next PATCH if ($patch_line =~ m/^diff /);
+		if ($patch_line =~ m/^Binary files .* differ$/) {
+			print "<div class=\"diff bin\">" .
+			      esc_html($patch_line, -nbsp => 1) .
+			      "</div>\n";
+		}
+		next PATCH if ($patch_line =~ m/^diff |^Binary files .* differ$/);
 		#assert($patch_line =~ m/^---/) if DEBUG;
 
 		my $last_patch_line = $patch_line;
-- 
1.7.10.4
