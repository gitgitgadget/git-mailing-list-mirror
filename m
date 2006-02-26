From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] annotate: Use qx{} for pipes on activestate.
Date: Sun, 26 Feb 2006 16:09:12 -0500
Message-ID: <11409881522219-git-send-email-ryan@michonline.com>
References: <1140922925166-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: merlyn@stonehenge.com, git@vger.kernel.org,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 22:10:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDT9b-000612-RY
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 22:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWBZVJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 16:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWBZVJU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 16:09:20 -0500
Received: from mail.autoweb.net ([198.172.237.26]:676 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751209AbWBZVJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 16:09:20 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FDT8m-0005NO-2Z; Sun, 26 Feb 2006 16:09:18 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FDT8i-0006NL-JW; Sun, 26 Feb 2006 16:09:12 -0500
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan.michonline.com with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FDT8i-0007br-Ci; Sun, 26 Feb 2006 16:09:12 -0500
In-Reply-To: <1140922925166-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email
To: junkio@cox.net
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16800>

Note: This needs someone to tell me what the value of $^O is on ActiveState.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

As always, available in
	http://h4x0r5.com/~ryan/git/ryan.git/ annotate-upstream

Randal, does this look basically the right approach here?
(I would like to make that glob I use not a global, but I can't
seem to figure out how at the moment.)

 git-annotate.perl |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

a927bb08b9b319cc3832fcf354a75e3760af593c
diff --git a/git-annotate.perl b/git-annotate.perl
index ee8ff15..f9c2c6c 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -431,8 +431,20 @@ sub gitvar_name {
     return join(' ', @field[0...(@field-4)]);
 }
 
-
 sub open_pipe {
+	if ($^O eq '##INSERT_ACTIVESTATE_STRING_HERE##') {
+		return open_pipe_activestate(@_);
+	} else {
+		return open_pipe_normal(@_);
+	}
+}
+
+sub open_pipe_activestate {
+	tie *fh, "Git::ActiveStatePipe", @_;
+	return *fh;
+}
+
+sub open_pipe_normal {
 	my (@execlist) = @_;
 
 	my $pid = open my $kid, "-|";
@@ -445,3 +457,32 @@ sub open_pipe {
 
 	return $kid;
 }
+
+package Git::ActiveStatePipe;
+use strict;
+
+sub TIEHANDLE {
+	my ($class, @params) = @_;
+	my $cmdline = join " ", @params;
+	my  @data = qx{$cmdline};
+	bless { i => 0, data => \@data }, $class;
+}
+
+sub READLINE {
+	my $self = shift;
+	if ($self->{i} >= scalar @{$self->{data}}) {
+		return undef;
+	}
+	return $self->{'data'}->[ $self->{i}++ ];
+}
+
+sub CLOSE {
+	my $self = shift;
+	delete $self->{data};
+	delete $self->{i};
+}
+
+sub EOF {
+	my $self = shift;
+	return ($self->{i} >= scalar @{$self->{data}});
+}
-- 
1.2.3.g9ca3
