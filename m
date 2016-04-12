From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] send-email: detect and offer to skip backup files
Date: Tue, 12 Apr 2016 15:53:54 -0700
Message-ID: <xmqqlh4io2v1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 00:54:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7C6-0007Wy-JM
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 00:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757060AbcDLWx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 18:53:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756208AbcDLWx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 18:53:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9CF5B558B7;
	Tue, 12 Apr 2016 18:53:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	KFw8VzU5t6/xcJqhXBbMUNH3C8=; b=t9TW+/Ed7dUCIJLh+7wIjFTLp4Ko4PKsv
	sq8qQwmqzy+EQGw4fEW0X+w0F/f8Shi/4yWNDIP2fgq09Pgry0jvmek6msJJ/xRz
	zcLOI+u/q9d0ZCqqtg1U6K01mHfDhRH3muiy7LBXmG9KmPhfXFuJxD26Bun+zSQE
	dcU3vDSc/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=kHV
	kkmNveTs/+qUN4D8kD19Zf6xHM3udN4/EbqkbjOrjslDWI5Z6FM31qHvqw0Wt1h0
	YRFOuV4wugA7uLU4sDNG63bYVK3F06j/0u7yJDfq1qghO9tcTFKBJmZb1I1Rte96
	4HelzokGTPNwsM5oBNJ3+l1ivrHfVi/G0BO+mblY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9414E558B6;
	Tue, 12 Apr 2016 18:53:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 13A1B558B3;
	Tue, 12 Apr 2016 18:53:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6FA3C7A4-0101-11E6-BD79-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291306>

Diligent people save output from format-patch to files, proofread
and edit them and then finally send the result out.  If the
resulting files are sent out with "git send-email 0*", this ends up
sending backup files (e.g. 0001-X.patch.backup or 0001-X.patch~)
left by their editors next to the final version.  Sending them with
"git send-email 0*.patch" (if format-patch was run with the standard
suffix) would avoid such an embarrassment, but not everybody is
careful.

After collecting files to be sent (and sorting them if read from a
directory), notice when the file being sent out has the same name as
the previous file, plus some suffix (e.g. 0001-X.patch was sent, and
we are looking at 0001-X.patch.backup or 0001-X.patch~), and the
suffix begins with a non-alnum (e.g. ".backup" or "~") and ask if
the user really wants to send it out.  Once the user skips sending
such a "backup" file, remember the suffix and stop asking the same
question (e.g. after skipping 0001-X.patch~, skip 0002-Y.patch~
without asking).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just something I had lying around in my tree...

 git-send-email.perl | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index d356901..74ed01a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -621,6 +621,8 @@ sub is_format_patch_arg {
 	push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP => 1), @rev_list_opts);
 }
 
+@files = handle_backup_files(@files);
+
 if ($validate) {
 	foreach my $f (@files) {
 		unless (-p $f) {
@@ -1726,6 +1728,44 @@ sub validate_patch {
 	return;
 }
 
+sub handle_backup {
+	my ($last, $lastlen, $file, $known_suffix) = @_;
+	my ($suffix, $skip);
+
+	$skip = 0;
+	if (defined $last &&
+	    ($lastlen < length($file)) &&
+	    (substr($file, 0, $lastlen) eq $last) &&
+	    ($suffix = substr($file, $lastlen)) !~ /^[a-z0-9]/i) {
+		if (defined $known_suffix && $suffix eq $known_suffix) {
+			print "Skipping $file with backup suffix '$known_suffix'.\n";
+			$skip = 1;
+		} else {
+			my $answer = ask("Do you really want to send $file? (y|N): ",
+					 valid_re => qr/^(?:y|n)/i,
+					 default => 'y');
+			$skip = ($answer ne 'y');
+			if ($skip) {
+				$known_suffix = $suffix;
+			}
+		}
+	}
+	return ($skip, $known_suffix);
+}
+
+sub handle_backup_files {
+	my @file = @_;
+	my ($last, $lastlen, $known_suffix, $skip, @result);
+	for my $file (@file) {
+		($skip, $known_suffix) = handle_backup($last, $lastlen,
+						       $file, $known_suffix);
+		push @result, $file unless $skip;
+		$last = $file;
+		$lastlen = length($file);
+	}
+	return @result;
+}
+
 sub file_has_nonascii {
 	my $fn = shift;
 	open(my $fh, '<', $fn)
-- 
2.8.1-347-g322afaf
