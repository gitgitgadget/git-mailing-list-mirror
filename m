From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: [PATCH] git-svn now work with crlf convertion enabled.
Date: Thu, 31 Jul 2008 12:43:34 +0700
Organization: AcademSoft Ltd.
Message-ID: <200807311243.35219.litvinov2004@gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 07:44:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOQxz-0008NN-52
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 07:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbYGaFnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 01:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbYGaFnq
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 01:43:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:47209 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbYGaFnp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 01:43:45 -0400
Received: by ug-out-1314.google.com with SMTP id h2so334112ugf.16
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 22:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ePUs9ihvd1s/mWL0ZCzD/TTk9tH9DXlqLRr7SVJMwm8=;
        b=ZPMjPKeoYXI3GreY1Ch/2DsVcOnZcdQ/YRbBRWVIMSqvzwG6vFPAR4qCrSUEOxpyt/
         nUN3ibEDddUiNk0BEW0TFc2G/PlcwlDXouaed3vX51yo/QnLD4+OgXY/C5r7n+ah+TTI
         ovJEmBj+2TP8vTR3W+Co1Vcw73bhZPMbQcsnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=f1gTCNRETCTfuuUfdZFSSUmqfYhUh+Y6k6sIrbme7AVdXRyoHouiYpFXt5FxOweMXi
         ChKigJ+Y/4CuaXKcLbtqP1SeHSt1ndQPJoGzQMnPtky//w4dHoOmPbzrF8a7QLQUIrJW
         1Zd/b2zEwEc6HgfTsfJx+Cddi40mXvSUjwsqY=
Received: by 10.66.236.16 with SMTP id j16mr2105558ugh.31.1217483023661;
        Wed, 30 Jul 2008 22:43:43 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [91.201.74.194])
        by mx.google.com with ESMTPS id a1sm9979198ugf.29.2008.07.30.22.43.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jul 2008 22:43:42 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90891>

Make git-svn works with crlf (or any other) file content convertion enabled.

When we modify file content SVN cant apply its delta to it. To fix this
situation I take full file content from SVN as next revision. This is
dump and slow but it works.
---
 git-svn.perl |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index cf6dbbc..606a177 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -28,6 +28,7 @@ sub fatal (@) { print STDERR "@_\n"; exit 1 }
 require SVN::Core; # use()-ing this causes segfaults for me... *shrug*
 require SVN::Ra;
 require SVN::Delta;
+require SVN::Client;
 if ($SVN::Core::VERSION lt '1.1.0') {
 	fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)";
 }
@@ -3075,6 +3076,7 @@ sub new {
 	my $self = SVN::Delta::Editor->new;
 	bless $self, $class;
 	$self->{c} = $git_svn->{last_commit} if exists $git_svn->{last_commit};
+	$self->{url} = $git_svn->{url};
 	$self->{empty} = {};
 	$self->{dir_prop} = {};
 	$self->{file_prop} = {};
@@ -3214,30 +3216,32 @@ sub change_file_prop {
 
 sub apply_textdelta {
 	my ($self, $fb, $exp) = @_;
-	my $fh = IO::File->new_tmpfile;
-	$fh->autoflush(1);
-	# $fh gets auto-closed() by SVN::TxDelta::apply(),
-	# (but $base does not,) so dup() it for reading in close_file
-	open my $dup, '<&', $fh or croak $!;
+
 	my $base = IO::File->new_tmpfile;
 	$base->autoflush(1);
 	if ($fb->{blob}) {
 		print $base 'link ' if ($fb->{mode_a} == 120000);
 		my $size = $::_repository->cat_blob($fb->{blob}, $base);
 		die "Failed to read object $fb->{blob}" if ($size < 0);
-
-		if (defined $exp) {
-			seek $base, 0, 0 or croak $!;
-			my $got = ::md5sum($base);
-			die "Checksum mismatch: $fb->{path} $fb->{blob}\n",
-			    "expected: $exp\n",
-			    "     got: $got\n" if ($got ne $exp);
-		}
 	}
 	seek $base, 0, 0 or croak $!;
-	$fb->{fh} = $dup;
+
+	my $fh = IO::File->new_tmpfile;
+	$fh->autoflush(1);
+
+	$fb->{fh} = $fh;
 	$fb->{base} = $base;
-	[ SVN::TxDelta::apply($base, $fh, undef, $fb->{path}, $fb->{pool}) ];
+
+	my $url = $self->{url};
+	$url =~ s/\/$//;
+	$url .= '/';
+	$url .= $fb->{path};
+
+	my $rev = $self->{file_prop}->{$fb->{path}}->{'svn:entry:committed-rev'};
+	die ("Can't find $fb->{path} revision") unless defined $rev;
+
+	my $ctx = SVN::Client->new();
+	$ctx->cat($fh, $url, $rev);
 }
 
 sub close_file {
-- 
1.5.6.2
