From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH] git-svn: make batch mode optional for git-cat-file
Date: Mon, 21 Sep 2015 16:51:38 +0300
Message-ID: <1442843498-22908-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.6.0.rc1.dirty"
Cc: Victor Leschuk <vleschuk@accesssoftek.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 15:51:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze1VZ-0003Ms-KL
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 15:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbbIUNvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 09:51:44 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36783 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389AbbIUNvn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 09:51:43 -0400
Received: by lbcao8 with SMTP id ao8so51201254lbc.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type;
        bh=2QMkKGjyzyhI6f2PIIa4MF7U70ssnpAbsKmqLVafU5w=;
        b=YcHH07go3iLZxogTpOhM399+xNis0GcsOQS9tErJ8LMr3TZ8zvUkJtqvjuEv4kZQVB
         h6zebimSKfX4Pd7yGWMpydxPDBx4FrP+2wkB8LOeWmCcirk5AvcJzQNUNsLLOLMYOoTQ
         WYpP3LD0yhAce9BRPitPXzIWcQID6b8uAw2p9Z220QDLym970dBjg5umYLVp/UOE83pz
         eQaAt0K2uUrRhOFIAplzH2vyZGzsf7GPYZmDioJTACdlxlrlF+EH05aHSKZ7GYBoeKxw
         IfKYzetChhkC2lECarJNbbvFQ4CFzG7xf2GTzEn/nk9UITjUulkWgdDcYW77ZTbs0Xmb
         JEoA==
X-Received: by 10.152.178.194 with SMTP id da2mr7710594lac.77.1442843501894;
        Mon, 21 Sep 2015 06:51:41 -0700 (PDT)
Received: from del-lmde (93-80-35-11.broadband.corbina.ru. [93.80.35.11])
        by smtp.gmail.com with ESMTPSA id vz2sm3593280lbb.35.2015.09.21.06.51.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2015 06:51:41 -0700 (PDT)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-lmde with local (Exim 4.86)
	(envelope-from <del@vleschuk-debian>)
	id 1Ze1VL-0005yA-00; Mon, 21 Sep 2015 16:51:39 +0300
X-Mailer: git-send-email 2.6.0.rc1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278302>

This is a multi-part message in MIME format.
--------------2.6.0.rc1.dirty
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
---
 git-svn.perl |  1 +
 perl/Git.pm  | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)


--------------2.6.0.rc1.dirty
Content-Type: text/x-patch; name="0001-git-svn-make-batch-mode-optional-for-git-cat-file.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0001-git-svn-make-batch-mode-optional-for-git-cat-file.patch"

diff --git a/git-svn.perl b/git-svn.perl
index 36f7240..b793c26 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -139,6 +139,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'use-log-author' => \$Git::SVN::_use_log_author,
 		'add-author-from' => \$Git::SVN::_add_author_from,
 		'localtime' => \$Git::SVN::_localtime,
+		'no-cat-file-batch' => sub { $Git::no_cat_file_batch = 1; },
 		%remote_opts );
 
 my ($_trunk, @_tags, @_branches, $_stdlayout);
diff --git a/perl/Git.pm b/perl/Git.pm
index 19ef081..69e5293 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -107,6 +107,7 @@ use Fcntl qw(SEEK_SET SEEK_CUR);
 use Time::Local qw(timegm);
 }
 
+our $no_cat_file_batch = 0;
 
 =head1 CONSTRUCTORS
 
@@ -1012,6 +1013,10 @@ returns the number of bytes printed.
 =cut
 
 sub cat_blob {
+	(1 == $no_cat_file_batch) ? _cat_blob_cmd(@_) : _cat_blob_batch(@_);
+}
+
+sub _cat_blob_batch {
 	my ($self, $sha1, $fh) = @_;
 
 	$self->_open_cat_blob_if_needed();
@@ -1072,7 +1077,7 @@ sub cat_blob {
 sub _open_cat_blob_if_needed {
 	my ($self) = @_;
 
-	return if defined($self->{cat_blob_pid});
+	return if ( defined($self->{cat_blob_pid}) || 1 == $no_cat_file_batch );
 
 	($self->{cat_blob_pid}, $self->{cat_blob_in},
 	 $self->{cat_blob_out}, $self->{cat_blob_ctx}) =
@@ -1090,6 +1095,40 @@ sub _close_cat_blob {
 	delete @$self{@vars};
 }
 
+sub _cat_blob_cmd {
+	my ($self, $sha1, $fh) = @_;
+
+	my $size = $self->command_oneline('cat-file', '-s', $sha1);
+
+	if (!defined $size) {
+		carp "cat-file couldn't detect object size";
+		return -1;
+	}
+
+	my ($in, $c) = $self->command_output_pipe('cat-file', 'blob', $sha1);
+
+	my $blob;
+	my $bytesLeft = $size;
+
+	while (1) {
+		last unless $bytesLeft;
+
+		my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
+		my $read = read($in, $blob, $bytesToRead);
+		unless (defined($read)) {
+			$self->command_close_pipe($in, $c);
+			throw Error::Simple("in pipe went bad");
+		}
+		unless (print $fh $blob) {
+			$self->command_close_pipe($in, $c);
+			throw Error::Simple("couldn't write to passed in filehandle");
+		}
+		$bytesLeft -= $read;
+	}
+
+	$self->command_close_pipe($in, $c);
+	return $size;
+}
 
 =item credential_read( FILEHANDLE )
 

--------------2.6.0.rc1.dirty--
