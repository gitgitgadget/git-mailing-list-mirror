From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v2 2/2] git-svn: allow git-svn fetching to work using serf
Date: Sat,  6 Jul 2013 20:39:57 -0700
Message-ID: <1373168397-7360-3-git-send-email-mackyle@gmail.com>
References: <1373168397-7360-1-git-send-email-mackyle@gmail.com>
Cc: David Rothenberger <daveroth@acm.org>, Petr Baudis <pasky@ucw.cz>,
	Daniel Shahaf <danielsh@apache.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 05:40:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvfq3-0002xF-Gp
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 05:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab3GGDkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 23:40:36 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:52501 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab3GGDkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 23:40:08 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so3026505pde.4
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 20:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ch1BIYWf6AiKAGh4kZtyTnLx6JfqF22C7iROifDgiIE=;
        b=jDlNEPHlyx3qS9ZZWTPw/ZtHeudKFanr6MhLzeVR4Wf4s7rPa7HN1cmwVebP6b9Z+C
         YJ5sO/VeSp4dEA+8Fp4ZZBH6c0w4J/+ChhPOp0ww5q8RxZI6WXF+DmGzJnc57JhynkRu
         xobnIi7X6LmTQp3pOLi85ahkhMkCP83eJCnOMi01RRUuUXJcE8ajwjg+HjLWNJf7LZeQ
         jAwEi1zsTEGkRczdWz8MZ8HbXFqwvvH/YVD+rQjIJQGPqaaLha20WvH/hdViET0WdZjU
         8qupfRlgullmWbEzb4aflkEgf4b03ZgDU+s4IG9MDjbCsI9LY+iro4rr0xISf858MNeh
         nD9w==
X-Received: by 10.68.213.5 with SMTP id no5mr15719894pbc.185.1373168407280;
        Sat, 06 Jul 2013 20:40:07 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wg6sm15027459pbc.3.2013.07.06.20.40.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 20:40:06 -0700 (PDT)
In-Reply-To: <1373168397-7360-1-git-send-email-mackyle@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229721>

From: "Kyle J. McKay" <mackyle@gmail.com>

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

When using the ra_serf access method, git-svn can end up needing
to create several temp files before the first one is closed.

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
+	++$suffix while $::_repository->temp_is_locked("svn_delta_${$}_$suffix");
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
