From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH and RFC] gitweb: Remove --full-history from git_history
Date: Wed, 9 Aug 2006 12:57:19 +0200
Message-ID: <200608091257.19461.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 09 12:57:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAlkZ-0005PH-2p
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 12:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030677AbWHIK5U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 06:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030678AbWHIK5U
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 06:57:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:17588 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030677AbWHIK5T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 06:57:19 -0400
Received: by nf-out-0910.google.com with SMTP id a4so113205nfc
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 03:57:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eigStk812FjqhMP6E7j/S7tEH7RCIb/5b7OP05Mj7wkV78glw1SirRtcZ711UVvyhvo6W3fEx6VTyG6c1Z9taaomThSIbjk/Nr+qgbthrCdyO03qR0kDsnHOUayzWeF9I+cbIzjKqNj8pUMucEoDX2FezE7J+/lIedaUZNVldMk=
Received: by 10.49.43.2 with SMTP id v2mr1117397nfj;
        Wed, 09 Aug 2006 03:57:05 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id p45sm949255nfa.2006.08.09.03.57.04;
        Wed, 09 Aug 2006 03:57:05 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25111>

Stop pretending that gitweb is rename-aware, and remove --full-history
option to git-rev-list in git_history (for "history" action):

 * gitweb cannot handle renames as of yet; it uses constant original
   $file_name as 'f' argument in links
 * at least for git 1.4.1.1 --full-history option doesn't follow
   renames (check 'git rev-list next -- gitweb/test/file+plus+sign'
   with and without --full-history option and compare to
   'git rev-list next -- gitweb/test/file+plus+sign test/file+plus+sign')
   and is three times slower than git-rev-list without --full-history

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is call for better rename support in git (better than --full-history).
There was such an attempt in "[RFC, PATCH] Teach revision.c about renames"
by Fredrik Kuivinen
  http://marc.theaimsgroup.com/?l=git&m=114772921317920
but IIRC patch was dropped in the favor of --full-history option.

What is needed by gitweb is for git-rev-list to not only follow revisions
of file contents across renames, and return more revisions, but also
return _how_ filename changes, without need to call git-diff-tree on each
returned revision.

PROPOSAL:
---------

Implement --follow/--follow-path/--follow-contents option to git-rev-list,
which would output besides revision ids also current path limit; the format
could be for example:

  <commit> [ -- <paths>...]

for example:
$ git rev-list --follow db58b69ba -- gitweb/test/file+plus+sign
0a8f4f0020cb35095005852c0797f0b90e9ebb74 -- gitweb/test/file+plus+sign
85852d44e48c1d1c6d815cc5fccf1b580f2f2cad -- test/file+plus+sign
cc3245b6512a01d74c0fd460d762ba8a1e8b968a -- test/file+plus+sign

There might be better format, as the proposed isn't best for copying
detections support, as path limit gets larger and one cannot immediately
get which element of new <paths>... correspond to which original <paths>...
element. Same with splitting file vs. simply creating file.

It should be not that hard to implement, just detecting copying, renaming
and filename vanishing, and updating current path limit; or putting
modified path limit and revision to start modified path-limit from to
the queue...


 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ae13e3e..59222c2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2284,7 +2284,7 @@ sub git_history {
 	git_print_page_path($file_name, $ftype);
 
 	open my $fd, "-|",
-		$GIT, "rev-list", "--full-history", $hash_base, "--", $file_name;
+		$GIT, "rev-list", $hash_base, "--", $file_name;
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	while (my $line = <$fd>) {
-- 
1.4.1.1
