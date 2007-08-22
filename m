From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix git-remote for ActiveState Perl
Date: Wed, 22 Aug 2007 18:13:07 +0200
Message-ID: <20070822161307.GA3528@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 18:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INspY-00052j-NY
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 18:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759859AbXHVQNN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 12:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758224AbXHVQNM
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 12:13:12 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:45964 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758578AbXHVQNL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 12:13:11 -0400
Received: from tigra.home (Fad89.f.strato-dslnet.de [195.4.173.137])
	by post.webmailer.de (klopstock mo44) (RZmta 10.3)
	with ESMTP id j06315j7MDaYLY ; Wed, 22 Aug 2007 18:13:08 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 42CD2277BD;
	Wed, 22 Aug 2007 18:13:08 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CFE86BE01; Wed, 22 Aug 2007 18:13:07 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFiUp4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56395>

For reason unknown a package in ActiveState Perl 5.8.7 must implement
READLINE method differently for scalar and array context. The code
tested to work for more sane and recent version of perl (5.8.8 shipped
with Ubuntu), so maybe it was always a requirement.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Without this only the first remote can be used if you are unlucky
enough to use that perl. There are probably more breakages, as only
first line of a file/stream can be read. Not many use Git.pm on
Windows and ActiveState Perl, so it went unnoticed for long time.

 perl/Git.pm |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 8fd3611..3f4080c 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -860,7 +860,13 @@ sub READLINE {
 	if ($self->{i} >= scalar @{$self->{data}}) {
 		return undef;
 	}
-	return $self->{'data'}->[ $self->{i}++ ];
+	my $i = $self->{i};
+	if (wantarray) {
+		$self->{i} = $#{$self->{'data'}} + 1;
+		return splice(@{$self->{'data'}}, $i);
+	}
+	$self->{i} = $i + 1;
+	return $self->{'data'}->[ $i ];
 }
 
 sub CLOSE {
-- 
1.5.3.rc6.19.g4d600f
