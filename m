From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix git_patchset_body not closing <div class="patch">
Date: Wed, 10 Jan 2007 00:07:43 +0100
Message-ID: <11683840631010-git-send-email-jnareb@gmail.com>
References: <734286.71437.qm@web31814.mail.mud.yahoo.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 10 00:07:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Q4D-0004tw-Gk
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbXAIXHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbXAIXHi
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:07:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:5321 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932498AbXAIXHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:07:37 -0500
Received: by nf-out-0910.google.com with SMTP id o25so291310nfa
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 15:07:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NW8GHA5QUANmBrWl7IGv4tSYSDChrwkWGeoctbJ4PT7fDkpCZngtYCnqSMSNTrjFhQlIDDgXBRFAVthJhAbjl0s3fX/vlLRpkAXxklzCT2ZR0En24F5a5tA+xx9YMfwDi8kiL2pVY90PnikeTw/hVpkPGG+3n5X3whX6eAV4lGo=
Received: by 10.49.10.3 with SMTP id n3mr701164nfi.1168384056486;
        Tue, 09 Jan 2007 15:07:36 -0800 (PST)
Received: from roke.D-201 ( [81.190.20.31])
        by mx.google.com with ESMTP id d2sm2137743nfe.2007.01.09.15.07.35;
        Tue, 09 Jan 2007 15:07:36 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l09N7iPs020881;
	Wed, 10 Jan 2007 00:07:45 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l09N7hQj020880;
	Wed, 10 Jan 2007 00:07:43 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <734286.71437.qm@web31814.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36419>

Fix case when git_patchset_body didn't close <div class="patch">,
for patchsets with last patch empty.

perlsyn(1):
  The "last" command immediately exits the loop in question.
  The "continue" block, if any, is not executed.

Remove some commented out code in git_patchset_body.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
>> Jakub Narebski wrote:
>>> Luben Tuikov wrote:
>>> 
>>>> Ok, I see that Junio has committed the fixes to "next" -- thanks!
>>>> That saved me time having to manually apply them.
>>>> 
>>>> Now, the results are that I see the same bug.
>>>  
>>> (The same bug = no closing div).
>>> 
>>> I'll try to reproduce this.
>> 
>> I failed to reproduce this error.
>> 
>> Could you apply the following patch, and report the result of
>>   grep "</div>\|<div" | grep -v "<div.*</div>
>> (find all opening and closing <div> elements, but omitting
>> those which are opened and closed in the same line)?

[...] 
> <div class="patchset">
> <div class="patch" id="patch1">
> <div class="diff extended_header">
> </div><!-- diff extended_header -->
> </div><!-- patch 0 -->
> <div class="patch" id="patch2">
> <div class="diff extended_header">
> </div><!-- diff extended_header -->
> </div><!-- patchset -->
[...] 
> The bug is clear.

Oops. I'm bit new to Perl.

This should fix it.

 gitweb/gitweb.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 25e5079..88af2e6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2412,7 +2412,6 @@ sub git_patchset_body {
 
 			push @diff_header, $patch_line;
 		}
-		#last PATCH unless $patch_line;
 		my $last_patch_line = $patch_line;
 
 		# check if current patch belong to current raw line
@@ -2522,7 +2521,10 @@ sub git_patchset_body {
 
 		# from-file/to-file diff header
 		$patch_line = $last_patch_line;
-		last PATCH unless $patch_line;
+		if (! $patch_line) {
+			print "</div>\n"; # class="patch"
+			last PATCH;
+		}
 		next PATCH if ($patch_line =~ m/^diff /);
 		#assert($patch_line =~ m/^---/) if DEBUG;
 		if ($from{'href'} && $patch_line =~ m!^--- "?a/!) {
@@ -2533,7 +2535,6 @@ sub git_patchset_body {
 		print "<div class=\"diff from_file\">$patch_line</div>\n";
 
 		$patch_line = <$fd>;
-		#last PATCH unless $patch_line;
 		chomp $patch_line;
 
 		#assert($patch_line =~ m/^+++/) if DEBUG;
-- 
1.4.4.3
