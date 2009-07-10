From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: gitweb: buggy 'commitdiff_plain' output
Date: Fri, 10 Jul 2009 10:04:52 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907100941060.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 19:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPJXy-0002I8-VG
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 19:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbZGJRGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 13:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594AbZGJRF7
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 13:05:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38285 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754348AbZGJRF6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 13:05:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6AH4qJE016046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Jul 2009 10:04:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6AH4q4L006058;
	Fri, 10 Jul 2009 10:04:52 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.465 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123064>


I complained to the CIFS people about their crazy duplicated commit 
message headers: see for example

    [torvalds@nehalem linux]$ git show --stat aeaaf253c4dee7ff9af2f3f0595f3bb66964e944
    commit aeaaf253c4dee7ff9af2f3f0595f3bb66964e944
    Author: Jeff Layton <jlayton@redhat.com>
    Date:   Thu Jul 9 01:46:39 2009 -0400
    
        cifs: remove cifsInodeInfo->inUse counter
        
        cifs: remove cifsInodeInfo->inUse counter
        
        It was purported to be a refcounter of some sort, but was never
        used that way. It never served any purpose that wasn't served equally well
        by the I_NEW flag.
        
        Signed-off-by: Jeff Layton <jlayton@redhat.com>
        Reviewed-by: Christoph Hellwig <hch@lst.de>
        Signed-off-by: Steve French <sfrench@us.ibm.com>
    
     fs/cifs/cifsfs.c   |    1 -
     fs/cifs/cifsglob.h |    1 -
     2 files changed, 0 insertions(+), 2 deletions(-)

and note the duplicated "cifs: remove cifsInodeInfo->inUse counter" line.

It turns out that that duplication is because they use gitweb as a strange 
patch distribution system (rather than emailing each other patches), and 
download the 'commitdiff_plain' version of the diff and then apply it with 
'git am -s'.

Ok, so it's a really odd way of doing things, but hey, that gitweb feature 
clearly does try to support that exact workflow, or why would that 
commitdiff_plain output try to look like an email?

But gitweb is a totally buggy piece of trash when it comes to exporting 
commits that way.

Why? Because it first has a 'Subject:' line, and then the "body" of the 
email repeats the raw commit message output. So _of_course_ you get the 
header duplicated.

Now, I asked Steve to not use gitweb (or edit the result some way), but 
this really is a gitweb bug. And since I don't do perl, I can't fix it, 
even though I can pinpoint exactly where the bug is (lines 5732 - 5752 in 
gitweb/gitweb.perl).

I totally untested patch written by a monkey who doesn't actually do perl 
is appended as a purely theoretical pointer in the right direction. But I 
really have no clue about perl, so what the heck do I know? This is like 
my tcl programming - pattern matching rather than any real understanding.

I'm sure there are smarter ways to do this with some simple mapping 
function or whatever.

		Linus

---
 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6a1b5b5..a809768 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5729,6 +5729,7 @@ sub git_commitdiff {
 		}
 
 	} elsif ($format eq 'plain') {
+		my $show = false;
 		my $refs = git_get_references("tags");
 		my $tagname = git_get_rev_name_tags($hash);
 		my $filename = basename($project) . "-$hash.patch";
@@ -5747,7 +5748,11 @@ sub git_commitdiff {
 		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
 
 		foreach my $line (@{$co{'comment'}}) {
-			print to_utf8($line) . "\n";
+			if ($show) {
+				print to_utf8($line) . "\n";
+			} else if ($line ne "") {
+				$show = true;
+			}
 		}
 		print "---\n\n";
 	} elsif ($format eq 'patch') {
