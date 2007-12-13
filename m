From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 0/2] [RFT] git-svn: more efficient revision -> commit
 mapping
Date: Thu, 13 Dec 2007 15:42:01 +1300
Message-ID: <47609BF9.4030005@vilain.net>
References: <1197185262-16765-1-git-send-email-normalperson@yhbt.net> <1197233768.7185.6.camel@brick> <1197248646.7185.25.camel@brick> <20071212180510.GB18980@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Harvey Harrison <harvey.harrison@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 03:44:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2e3o-0000Hb-OQ
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 03:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbXLMCoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 21:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbXLMCoB
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 21:44:01 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:35660 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbXLMCoA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 21:44:00 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1J2e35-0002Do-6C; Thu, 13 Dec 2007 15:43:43 +1300
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id F138D200F6; Thu, 13 Dec 2007 15:43:42 +1300 (NZDT)
FCC: imap://sam@localhost/INBOX/Sent
X-Identity-Key: id4
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20071212180510.GB18980@untitled>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68111>

Eric Wong wrote:
> Sam (or anybody else using useSvmProps:
> 
>   Do you have any feedback with svmProps enabled?

3682645  120 -rw-rw-r--   1 samv     samv       121893 Dec 13 14:05
tags/debian_version_1_2_0beta1@2972/.rev_db.d29f7b36-84ff-0310-85ce-ba787dbd31ca

 =>

-3683050    4 -rw-rw-r--   1 samv     samv           48 Dec 13 14:26
./tags/debian_version_1_2_0beta1@2972/.rev_map.d29f7b36-84ff-0310-85ce-ba787dbd31ca

git-log --all | grep git-svn | tail -3

    git-svn-id:
file:///home/samv/.svk/local/mirror/fai/branches/source-dist@2971
d29f7b36-84ff-0310-85ce-ba787dbd31ca
    git-svn-id: svn+ssh://svn.debian.org/svn/fai/trunk@2
ba5ec265-b0fb-0310-8e1a-cf9e4c2b1591
    git-svn-id: svn+ssh://svn.debian.org/svn/fai/trunk@1
ba5ec265-b0fb-0310-8e1a-cf9e4c2b1591

So, the remapping is still working fine.

The one that failed there is not a new bug.  Here's the fix anyway
though :-)

Subject: [PATCH] git-svn: fix --use-svm-props and --follow-parent

If, when using --follow-parent, it finds that the parent is an SVM
path, *and* the SVM path is not at the root of the corresponding SVN
repository (the usual case when using SVK), then the logic in
Git::SVN::ra will not find the correct source repository.  This is
because the freshly created RA object is missing the path.  So, set
this after creation.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 54d7844..3e5fd82 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2189,6 +2189,7 @@ sub find_parent_branch {
 		$ref_id .= '-' while find_ref($ref_id);
 		print STDERR "Initializing parent: $ref_id\n";
 		$gs = Git::SVN->init($new_url, '', $ref_id, $ref_id, 1);
+		$gs->{path} = $branch_from;
 	}
 	my ($r0, $parent) = $gs->find_rev_before($r, 1);
 	if (!defined $r0 || !defined $parent) {
-- 
1.5.3.5
