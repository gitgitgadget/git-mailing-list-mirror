From: Avishay Lavie <avishay.lavie@gmail.com>
Subject: [PATCH] git svn: Only follow first parents when populating
 svn:mergeinfo properties
Date: Thu, 23 Aug 2012 19:07:15 +0300
Message-ID: <CAHkK2bpCjmxTKmBj6Wqgmky2YjRk8_MQF6th8xxc6XoStdVOeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bryan Jacobs <bjacobs@woti.com>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 18:07:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Zwp-0004fw-JH
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 18:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758848Ab2HWQHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 12:07:42 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62722 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459Ab2HWQHg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 12:07:36 -0400
Received: by vcbfk26 with SMTP id fk26so987088vcb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=GjHFzIII5Uc233GXIcdoE7aGidO8gkQJ9AVRM5izQS0=;
        b=M7Mtrw/mBv9lYQrS0FDoIGOoY49mo+UqSu/MzhdnN6XAacf5GPUYesQ/dDreVEcAdO
         VsujxJKiXrFbk4XxS2us5OFHX1snyfAe3NbZsZvhuXNONM3oYk4omRnXOVw0kO1d6bB5
         z0Gksfj8RPvFe1hpLbxyC7bg9RhBeQDXtAKoRm9+mrAYAEEXb7WvN5K51pcqyAXFIPjh
         2rzKvz0FTY9W25RyB8gppGi4E2/p6zUeqDYuw9JP7Vv0PGovxWpORmktFeDas3INp9d+
         evgrYGADeMmmwsb3rvLS6L75C3fLlAXEL5Jk2QU0+zHNElTc/kl+daVANDICaw3GHupT
         0Psg==
Received: by 10.58.151.197 with SMTP id us5mr1933030veb.14.1345738055719; Thu,
 23 Aug 2012 09:07:35 -0700 (PDT)
Received: by 10.58.66.226 with HTTP; Thu, 23 Aug 2012 09:07:15 -0700 (PDT)
X-Google-Sender-Auth: wvsBckciy9CNd_bpjWrT6qs7-JU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204152>

Subject: [PATCH] git svn: Only follow first parents when populating
svn:mergeinfo
 properties.

When svn.pushmergeinfo is set, git-svn tries to correctly populate mergeinfo
properties when encountering a merge commit. It does so by first aggregating
the mergeinfo property of the merged parent into the target, and then
adding to it the SVN revision number of any commit reachable from the
merged parent but not from the first (target) parent.

If a third branch was merged into the merged parent (e.g. X was merged into Y
and Y was then merged into Z), its revisions will be listed twice --
once as part
of aggregating Y's mergeinfo property into Z's, and once more when walking
the tree and finding X's commits reachable from Y's tip. While the first listing
correctly lists those revisions as merged from X, the second listing
will list them
as merged from Y, creating incorrect mergeinfo properties that later cause
unnecessary lookups and warnings when git-svn-fetching.

Adding '--first-parent' to the rev-list command fixes this by only walking the
part of the tree that's directly included in the merged branch (Y) and not any
branches merged into it (X).

Signed-off-by: Avishay Lavie <avishay.lavie@gmail.com>
---
 git-svn.perl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 828b8f0..f69a4d6 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -728,7 +728,7 @@ sub populate_merge_info {

  next if $parent eq $parents[0]; # Skip first parent
  # Add new changes being placed in tree by merge
- my @cmd = (qw/rev-list --reverse/,
+ my @cmd = (qw/rev-list --first-parent --reverse/,
    $parent, qw/--not/);
  foreach my $par (@parents) {
  unless ($par eq $parent) {
-- 
1.7.10.msysgit.1
