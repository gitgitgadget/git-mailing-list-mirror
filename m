From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v4 2/2] git-svn: allow git-svn fetching to work using serf
Date: Thu, 18 Jul 2013 12:15:29 -0700
Message-ID: <ac83ba2812aee248275a0760bb39a00@f74d39fa044aa309eaea14b9f57fe79>
References: <8a6adfae744011599e410da7a46808b@f74d39fa044aa309eaea14b9f57fe79>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Rothenberger <daveroth@acm.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 21:15:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uztg7-00023g-8j
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 21:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933728Ab3GRTPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 15:15:44 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:59315 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933574Ab3GRTPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 15:15:42 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so3545403pad.2
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jQytlaUHotKP5CG7/BggVGq/5ANqFrK043NqDvl9O24=;
        b=aBL3E96kIefhRZenj4HpgT4zgtIIGyD7eTf1CJINSIScHrnPZNBOy9OUsXxg+itQ1O
         qxWFY0VM6dvU8Yhxk0xcu7cfZYlycJdJYx0gIWGSgOfKDPPg0CL224+hUY2Z0jYAs4GS
         s2fyH9PB4DqRtfxYvlv8z3w0ZAChOAFaxj8WaaR2Rzdz97EwwTJI2VVEqB+kaVG6hFks
         47zEfFn2kYerOm51z23jTlZqiNE3AvUb+oBTZNQnRotJKqAfSeqelnq9u2l8W07ZV6Gk
         B1CRTucIUOES1RYpQ3yjtXCdHtGll4IzA8w3M1pfqw8cpdNccEUIMApCCRB5c+3as9D4
         C5yw==
X-Received: by 10.68.212.106 with SMTP id nj10mr13571309pbc.74.1374174941947;
        Thu, 18 Jul 2013 12:15:41 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id sq5sm18223018pab.11.2013.07.18.12.15.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 12:15:41 -0700 (PDT)
In-Reply-To: <8a6adfae744011599e410da7a46808b@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230727>

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
