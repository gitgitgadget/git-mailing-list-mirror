From: Michael G Schwern <schwern@pobox.com>
Subject: Extract Git classes from git-svn (7/10) (was Re: Fix git-svn tests
 for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 16:16:38 -0700
Message-ID: <5005F256.5080403@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:16:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrH0X-0007RP-RH
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 01:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab2GQXQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 19:16:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999Ab2GQXQk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 19:16:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF44885BE;
	Tue, 17 Jul 2012 19:16:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=rSvHu/QNRcn0
	gc7i9LuTl3XBd70=; b=kSLo5gy/oWD2dSQtxSiwRf04Atg38jLzR1s/+v1+UxPn
	PzYPcnLJUYMWTdakgW0FDTJ2qS1yz+qJuNMcb+JLk1ycQHygqWLsLr21+MxoUDua
	JazmrJFL8JEJ6OBOKJ+HzF0p4MmNlm7LLJpxMcASrQqBPF+2U++7KZ+mSlHrNaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LyV7Nv
	43rtCtCCNjfRF4+YsH1VPkP24OLLlIQH2WdVJ6KYokq4cQMK8cOJJIemkSc9xCQ5
	POPdUTV3iM/ZBnrMRcdGbdp0ZN8Top+WYcnZ97XL2uu2s2zbbobglZGjVre/GxM1
	6PmkqjLU1oL9C6UfzWqdLJ7wrQNzHx3euPK24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD06A85BD;
	Tue, 17 Jul 2012 19:16:39 -0400 (EDT)
Received: from windhund.local (unknown [67.23.204.5]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8CF285B6; Tue, 17 Jul
 2012 19:16:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120717174446.GA14244@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 766B1E5A-D065-11E1-B17E-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201632>

>From 9ff49d9e91c9741d501620ac47f78d8ff8ef9983 Mon Sep 17 00:00:00 2001
From: "Michael G. Schwern" <schwern@pobox.com>
Date: Tue, 17 Jul 2012 15:51:53 -0700
Subject: [PATCH 08/11] Cut & paste Git::IndexInfo into its own file.

No other changes, those are next commit so they can be seen in the diff.
---
 git-svn.perl          | 32 --------------------------------
 perl/Git/IndexInfo.pm | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 32 deletions(-)
 create mode 100644 perl/Git/IndexInfo.pm

diff --git a/git-svn.perl b/git-svn.perl
index 8b8607d..6632cfb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2045,38 +2045,6 @@ sub gc_directory {
 }


-package Git::IndexInfo;
-use strict;
-use warnings;
-use Git qw/command_input_pipe command_close_pipe/;
-
-sub new {
-	my ($class) = @_;
-	my ($gui, $ctx) = command_input_pipe(qw/update-index -z --index-info/);
-	bless { gui => $gui, ctx => $ctx, nr => 0}, $class;
-}
-
-sub remove {
-	my ($self, $path) = @_;
-	if (print { $self->{gui} } '0 ', 0 x 40, "\t", $path, "\0") {
-		return ++$self->{nr};
-	}
-	undef;
-}
-
-sub update {
-	my ($self, $mode, $hash, $path) = @_;
-	if (print { $self->{gui} } $mode, ' ', $hash, "\t", $path, "\0") {
-		return ++$self->{nr};
-	}
-	undef;
-}
-
-sub DESTROY {
-	my ($self) = @_;
-	command_close_pipe($self->{gui}, $self->{ctx});
-}
-
 package Git::SVN::GlobSpec;
 use strict;
 use warnings;
diff --git a/perl/Git/IndexInfo.pm b/perl/Git/IndexInfo.pm
new file mode 100644
index 0000000..a43108c
--- /dev/null
+++ b/perl/Git/IndexInfo.pm
@@ -0,0 +1,33 @@
+package Git::IndexInfo;
+use strict;
+use warnings;
+use Git qw/command_input_pipe command_close_pipe/;
+
+sub new {
+	my ($class) = @_;
+	my ($gui, $ctx) = command_input_pipe(qw/update-index -z --index-info/);
+	bless { gui => $gui, ctx => $ctx, nr => 0}, $class;
+}
+
+sub remove {
+	my ($self, $path) = @_;
+	if (print { $self->{gui} } '0 ', 0 x 40, "\t", $path, "\0") {
+		return ++$self->{nr};
+	}
+	undef;
+}
+
+sub update {
+	my ($self, $mode, $hash, $path) = @_;
+	if (print { $self->{gui} } $mode, ' ', $hash, "\t", $path, "\0") {
+		return ++$self->{nr};
+	}
+	undef;
+}
+
+sub DESTROY {
+	my ($self) = @_;
+	command_close_pipe($self->{gui}, $self->{ctx});
+}
+
+1;
-- 
1.7.11.1
