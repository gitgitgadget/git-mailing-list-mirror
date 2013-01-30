From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
Subject: [PATCH 5/7] perl/Git.pm: simplify Git::activestate_pipe
Date: Wed, 30 Jan 2013 15:23:01 -0200
Message-ID: <1359566583-19654-6-git-send-email-gnustavo@cpan.org>
References: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
Cc: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 18:23:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0bNu-0006al-0N
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 18:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab3A3RXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 12:23:19 -0500
Received: from mail-ye0-f174.google.com ([209.85.213.174]:65000 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab3A3RXS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 12:23:18 -0500
Received: by mail-ye0-f174.google.com with SMTP id m3so303555yen.33
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 09:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:x-gm-message-state;
        bh=EYOHaKik1rNFBRo/SWW53+/hLKulpRXowErI+tA1Ejg=;
        b=c6hY2n5JUjViklvFnQoULzxWRHbutczwPid9QmzZGwYuZMrBgvRLsSglCV3sVTa6LR
         sDrlfy65T9vEV2epEayClh39CTRhiBMdTIXtnrdu5Ynw7bJRt9gIshsKcsmTp3cHul+K
         UIqrY0UlY5aFUewAPhiQ41ZtcQG/tbY8hfQy+WYYS7wy7Aj4VmE37pBdV2IsWiQ70Tm2
         CmJ/R3YbsQFHCdsRswtZTiYMhhMfbP5nzrVsoWWWRRbcA3+5eZ1pyHdVUufMGtaDrFVV
         ubeAt5aCtKf05VOHdSrdjRwIkq/jpKcITWo0MXIHsRI8FPWu62vV6VtNSshtIZcpL/3T
         R7Vg==
X-Received: by 10.236.89.49 with SMTP id b37mr6621467yhf.33.1359566597630;
        Wed, 30 Jan 2013 09:23:17 -0800 (PST)
Received: from gnu.cpqd.com.br (fw-cpqd.cpqd.com.br. [189.112.183.66])
        by mx.google.com with ESMTPS id q11sm1689802anp.13.2013.01.30.09.23.15
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 09:23:16 -0800 (PST)
X-Mailer: git-send-email 1.7.12.464.g83379df.dirty
In-Reply-To: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
X-Gm-Message-State: ALoCoQmjpBfBfZIKRIltnnePGLiRP+m4v1zZU5MhC8hDaxpk0gd/febsYIluNnqS1LTXr0UOK5IN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215036>

From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>

Git::activestate_pipe::TIEHANDLE creates an object to keep the
external command's output as an array of lines. The object also kept
an index into the array to know up to which line had already been read
via Git::activestate_pipe::READLINE.

We don't really need that index because lines already read don't need
to be kept. So, we simply unshift lines as they're being read and use
the array's size to know when we have read all lines.

This implementation uses more idiomatic Perl, which makes it more
readable and probably a little bit faster.

Signed-off-by: Gustavo L. de M. Chaves <gnustavo@cpan.org>
---
 perl/Git.pm | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 42c3971..2d88b89 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1402,33 +1402,28 @@ sub TIEHANDLE {
 	# should take care of the most common cases.
 	my @escaped_params = map { "\"$_\"" } map { s/"/""/g; $_ } @params;
 	my @data = qx{git @escaped_params};
-	bless { i => 0, data => \@data, exit => $? }, $class;
+	bless { data => \@data, exit => $? }, $class;
 }
 
 sub READLINE {
 	my $self = shift;
-	if ($self->{i} >= scalar @{$self->{data}}) {
-		return undef;
-	}
-	my $i = $self->{i};
+	return unless @{$self->{data}};
 	if (wantarray) {
-		$self->{i} = $#{$self->{'data'}} + 1;
-		return splice(@{$self->{'data'}}, $i);
+		return splice @{$self->{data}};
+	} else {
+		return shift @{$self->{data}};
 	}
-	$self->{i} = $i + 1;
-	return $self->{'data'}->[ $i ];
 }
 
 sub CLOSE {
 	my $self = shift;
 	delete $self->{data};
-	delete $self->{i};
 	return $self->{exit} == 0;
 }
 
 sub EOF {
 	my $self = shift;
-	return ($self->{i} >= scalar @{$self->{data}});
+	return @{$self->{data}} == 0;
 }
 
 
-- 
1.7.12.464.g83379df.dirty
