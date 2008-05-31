From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Add charset info to "raw" blob output
Date: Sat, 31 May 2008 11:22:00 -0700
Message-ID: <7vprr2fi5z.fsf@gitster.siamese.dyndns.org>
References: <m3tzgg1a06.fsf@localhost.localdomain>
 <20080531112513.30913.44393.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jan Engelhardt <jengelh@medozas.de>,
	Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 20:23:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2VjS-0006Ep-3O
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 20:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbYEaSWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 14:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYEaSWR
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 14:22:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbYEaSWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 14:22:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E6A5394A;
	Sat, 31 May 2008 14:22:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1F5C83947; Sat, 31 May 2008 14:22:07 -0400 (EDT)
In-Reply-To: <20080531112513.30913.44393.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Sat, 31 May 2008 13:27:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7EBCE77C-2F3E-11DD-9E6A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83398>

Jakub Narebski <jnareb@gmail.com> writes:

> Always add charset info from $default_text_plain_charset (if it is
> defined) to "raw" (a=blob_plain) output for 'text/plain' blobs.
> Adding charset info in a special case was removed from blob_mimetype().
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---

Looks Ok but it took a bit of digging on the list for me to figure out
that something like this was missing from the beginning of your commit log
message:

	Earlier "blob_plain" view sent "charset=utf-8" only when gitweb
	guessed the content type to be text by reading from it, and not
	when the MIME type was obtained from /etc/mime.types.

	This fixes the bug by always adding....

But I wonder if moving of this to the calling site is the right thing to
do.  Wouldn't it become much more contained and robust if you did it this
way?

 gitweb/gitweb.perl |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 57a1905..f5338e1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2471,29 +2471,33 @@ sub mimetype_guess {
 sub blob_mimetype {
 	my $fd = shift;
 	my $filename = shift;
+	my $mime;
 
 	if ($filename) {
-		my $mime = mimetype_guess($filename);
-		$mime and return $mime;
-	}
-
-	# just in case
-	return $default_blob_plain_mimetype unless $fd;
-
-	if (-T $fd) {
-		return 'text/plain' .
-		       ($default_text_plain_charset ? '; charset='.$default_text_plain_charset : '');
+		$mime = mimetype_guess($filename);
+	} else if (!defined $fd) {
+		$mime = $default_blob_plain_mimetype;
+	} else if (-T $fd) {
+		$mime = 'text/plain';
 	} elsif (! $filename) {
-		return 'application/octet-stream';
+		$mime = 'application/octet-stream';
 	} elsif ($filename =~ m/\.png$/i) {
-		return 'image/png';
+		$mime = 'image/png';
 	} elsif ($filename =~ m/\.gif$/i) {
-		return 'image/gif';
+		$mime = 'image/gif';
 	} elsif ($filename =~ m/\.jpe?g$/i) {
-		return 'image/jpeg';
+		$mime = 'image/jpeg';
 	} else {
-		return 'application/octet-stream';
+		$mime = 'application/octet-stream';
 	}
+
+	# Type specific postprocessing can be added as needed...
+	if ($mime =~ /^text\//i &&
+	    $mime !~ /charset=/i && $default_text_plain_charset) {
+		$mime .=  '; charset='.$default_text_plain_charset;
+	}
+
+	return $mime;
 }
 
 ## ======================================================================
