From: Matteo Bertini <naufraghi@develer.com>
Subject: [PATCH 2/4] Git.pm: Add $path and $enable_filters arguments to hash_and_insert_object.
Date: Tue, 31 May 2016 17:07:47 +0200
Message-ID: <20160531150749.24840-3-naufraghi@develer.com>
References: <20160531150749.24840-1-naufraghi@develer.com>
Cc: Matteo Bertini <matteo@naufraghi.net>, normalperson@yhbt.net,
	gitster@pobox.com, Matteo Bertini <naufraghi@develer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 17:14:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7lNa-00028N-8S
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbcEaPOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 11:14:45 -0400
Received: from neo.develer.net ([2.228.72.10]:39511 "EHLO neo.develer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436AbcEaPOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 11:14:44 -0400
Received: from odello.trilan (odello.trilan [10.3.15.118])
	(Authenticated sender: naufraghi)
	by neo.develer.net (Postfix) with ESMTPSA id C97EE5E3120;
	Tue, 31 May 2016 17:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=develer.com;
	s=gongolo; t=1464707277;
	bh=zB+JG8OBMvxnFZ5I9zYZvCO4YjX3jE2aadRQJNzGmws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y2a3awlFnTl33oXK6CIev/jHLLTUuybzBLgImKWyGJAdnQ5vTsJuOhMl27+i2KDeS
	 VYzA95Lbr5deWwSYuGjbT47cKlFmOcH+xzLCGtirrDoBZEtFkRo+BpXLXzCHheja2F
	 C4R2i7FNw9uUdrLrQYSk3euDk2YAc56SqEaWUnuk=
X-Mailer: git-send-email 2.9.0.rc0.39.gb9f310b.dirty
In-Reply-To: <20160531150749.24840-1-naufraghi@develer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295979>

From: Matteo Bertini <matteo@naufraghi.net>

The option $enable_filters skips the --no-filters option,
the $path argument provide a path to be used alike the --path argument
to hash-object in the non streaming invocation.

Signed-off-by: Matteo Bertini <naufraghi@develer.com>
---
 perl/Git.pm | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index ce7e4e8..6c2e3fc 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -963,11 +963,13 @@ The function returns the SHA1 hash.
 
 # TODO: Support for passing FILEHANDLE instead of FILENAME
 sub hash_and_insert_object {
-	my ($self, $filename) = @_;
-
-	carp "Bad filename \"$filename\"" if $filename =~ /[\r\n]/;
+	my ($self, $filename, $path, $enable_filters) = @_;
+	carp "Bad filename \"$filename\"" if $filename =~ /[\r\n\t]/;
+	if (defined($path)) {
+		$filename = join("\t", $filename, $path);
+	}
 
-	$self->_open_hash_and_insert_object_if_needed();
+	$self->_open_hash_and_insert_object_if_needed($enable_filters);
 	my ($in, $out) = ($self->{hash_object_in}, $self->{hash_object_out});
 
 	unless (print $out $filename, "\n") {
@@ -985,13 +987,18 @@ sub hash_and_insert_object {
 }
 
 sub _open_hash_and_insert_object_if_needed {
-	my ($self) = @_;
+	my ($self, $enable_filters) = @_;
 
 	return if defined($self->{hash_object_pid});
 
+	my @command = qw(hash-object -w --stdin-paths);
+	if (!$enable_filters) {
+		push(@command, "--no-filters");
+	}
+
 	($self->{hash_object_pid}, $self->{hash_object_in},
 	 $self->{hash_object_out}, $self->{hash_object_ctx}) =
-		$self->command_bidi_pipe(qw(hash-object -w --stdin-paths --no-filters));
+		$self->command_bidi_pipe(@command);
 }
 
 sub _close_hash_and_insert_object {
-- 
2.9.0.rc0.39.gb9f310b.dirty
