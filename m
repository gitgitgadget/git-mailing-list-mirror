From: Kyle McKay <mackyle@gmail.com>
Subject: [PATCH 2/2] git-svn: allow git-svn fetching to work using serf
Date: Fri, 5 Jul 2013 20:44:07 -0700
Message-ID: <ABDE5FFA-C19F-44BF-A360-3FD5D74F2B28@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Rothenberger <daveroth@acm.org>, Petr Baudis <pasky@ucw.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Shahaf <danielsh@apache.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 06 05:44:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvJPz-0006Aa-Dz
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 05:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab3GFDoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 23:44:11 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:51487 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab3GFDoL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 23:44:11 -0400
Received: by mail-oa0-f50.google.com with SMTP id k7so4199164oag.23
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 20:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:content-type:content-transfer-encoding:subject
         :mime-version:date:cc:x-mailer;
        bh=8ma6wb3Rpi9cOXf9n89Px4wwNJUydj10JE9T79OMmeE=;
        b=dI2tivvW4lRZst8Go5fg+Q+croe8jX3Vj7I8Y8qpCQI6D0agKU7/bcPiwvmb1UN4MF
         M62RBzfM8F9S7j1iRrotRK6sx67hgDNimrnz3P5rBE8KQb3HNXMuKGKO0Tv4qUFyP4Fr
         JZ6Y5OOAFdCARUdFdZKlSYfkgBEhx5L+70tT+6tQ2ZSRXF5ROxfrvYB68U7ptNhPCTOl
         rIOtE0wkPMRkT94m+SbalYHjxmr8WmH6cuU4IpC6Y1uSutJ4Ekgqzrz4A6QKSCh72gvC
         r0A+P2OPCO9DAZq1MhOO8lwMLeTey+Z2MsbKHj5VFVkgJnj5fLi/+jeSUEPz3vNI9spN
         i8oQ==
X-Received: by 10.60.115.199 with SMTP id jq7mr13790576oeb.19.1373082250322;
        Fri, 05 Jul 2013 20:44:10 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id h3sm19994907obx.11.2013.07.05.20.44.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 20:44:09 -0700 (PDT)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229693>

When attempting to git-svn fetch files from an svn https?: url using
the serf library (the only choice starting with svn 1.8) the following
errors can occur:

Temp file with moniker 'svn_delta' already in use at Git.pm line 1250
Temp file with moniker 'git_blob' already in use at Git.pm line 1250

David Rothenberger <daveroth@acm.org> has determined the cause to
be that ra_serf does not drive the delta editor in a depth-first
manner [...]. Instead, the calls come in this order:

1. open_root
2. open_directory
3. add_file
4. apply_textdelta
5. add_file
6. apply_textdelta

This change causes a new temp file moniker to be generated if the
one that would otherwise have been used is currently locked.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
perl/Git/SVN/Fetcher.pm | 6 ++++--
1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index bd17418..10edb27 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -315,11 +315,13 @@ sub change_file_prop {
sub apply_textdelta {
	my ($self, $fb, $exp) = @_;
	return undef if $self->is_path_ignored($fb->{path});
-	my $fh = $::_repository->temp_acquire('svn_delta');
+	my $suffix = 0;
+	++$suffix while $::_repository->temp_is_locked("svn_delta_${$}_ 
$suffix");
+	my $fh = $::_repository->temp_acquire("svn_delta_${$}_$suffix");
	# $fh gets auto-closed() by SVN::TxDelta::apply(),
	# (but $base does not,) so dup() it for reading in close_file
	open my $dup, '<&', $fh or croak $!;
-	my $base = $::_repository->temp_acquire('git_blob');
+	my $base = $::_repository->temp_acquire("git_blob_${$}_$suffix");

	if ($fb->{blob}) {
		my ($base_is_link, $size);
-- 
1.8.3
