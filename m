From: Orivej Desh <orivej@gmx.fr>
Subject: SVN.pm produces "Wide character in setenv" warnings
Date: Thu, 19 Feb 2015 06:49:45 +0000
Message-ID: <m3h9ui4cqe.fsf@gmx.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 07:55:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOL10-0005ix-RU
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 07:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbbBSGzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 01:55:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:57984 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbbBSGzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 01:55:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YOL0q-0005eZ-5i
	for git@vger.kernel.org; Thu, 19 Feb 2015 07:55:04 +0100
Received: from 81.4.107.250 ([81.4.107.250])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 07:55:04 +0100
Received: from orivej by 81.4.107.250 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 07:55:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.4.107.250
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Cancel-Lock: sha1:HRK7ZU/OOEF7z3pZzurvFkhRmHw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264085>

--=-=-=
Content-Type: text/plain

"git svn fetch" causes Perl 5.18 or newer to emit "Wide character in
setenv" warnings when used in combination with svn.authorsfile with
non-ASCII names:

     Wide character in setenv at /usr/lib64/perl5/vendor_perl/5.20.1/Git/SVN.pm line 969.
     Wide character in setenv at /usr/lib64/perl5/vendor_perl/5.20.1/Git/SVN.pm line 973.

I have no taste of Perl so I do not propose this patch for inclusion,
but it fixes this for me.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=git-svn-env.patch

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index d9a52a5..2ffebfe 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -957,6 +957,17 @@ sub full_pushurl {
 	}
 }
 
+sub utf8_encode {
+	my ($s) = @_;
+	utf8::encode($s);
+	return $s;
+}
+
+sub UENV {
+	my ($var, $val) = @_;
+	$ENV{$var} = utf8_encode($val);
+}
+
 sub set_commit_header_env {
 	my ($log_entry) = @_;
 	my %env;
@@ -966,13 +977,13 @@ sub set_commit_header_env {
 		}
 	}
 
-	$ENV{GIT_AUTHOR_NAME} = $log_entry->{name};
+	UENV("GIT_AUTHOR_NAME", $log_entry->{name});
 	$ENV{GIT_AUTHOR_EMAIL} = $log_entry->{email};
 	$ENV{GIT_AUTHOR_DATE} = $ENV{GIT_COMMITTER_DATE} = $log_entry->{date};
 
-	$ENV{GIT_COMMITTER_NAME} = (defined $log_entry->{commit_name})
+	UENV("GIT_COMMITTER_NAME", (defined $log_entry->{commit_name})
 						? $log_entry->{commit_name}
-						: $log_entry->{name};
+						: $log_entry->{name});
 	$ENV{GIT_COMMITTER_EMAIL} = (defined $log_entry->{commit_email})
 						? $log_entry->{commit_email}
 						: $log_entry->{email};

--=-=-=--
