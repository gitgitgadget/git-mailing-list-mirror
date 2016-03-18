From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Thu, 17 Mar 2016 22:40:05 -0700
Message-ID: <xmqqbn6cs5sa.fsf@gitster.mtv.corp.google.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
	<1458219254-16343-1-git-send-email-pclouds@gmail.com>
	<xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com>
	<CACsJy8Dm3_w6TT6FP-my9fsRJ8F+StK8dBPid9zxQv4OzoZfcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Durham Goode <durham@fb.com>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:40:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agn9Q-0007bu-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbcCRFkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 01:40:35 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753259AbcCRFkI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:40:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5067243C73;
	Fri, 18 Mar 2016 01:40:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZDk8xJtSM13HItB9cEV/nO9cTE4=; b=ucr+8A
	Awfuhx2p47nF9/++f454HdBBtXrZNScUu94nffWm723gEwdi4DfSoU3iZiDTkN7W
	jgdmLGKdgA0fCwtSvQcFvu/cQShFPzVp1PXoKsRBweXbjhCxRV1eUKbHV9i5lIBM
	fXzcdldkM31Q6VK1ryo+5MwKew/dmJSB43r0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k5BLNEHAjQ3PWjCITX/94/9tg4CCMbKR
	tz4MH+9rFfoxbLCaZGlQ09eLORGytxQUH3ZnjCWlGej9lJoXfYkqTwEUwPnkyzHW
	XWaZS1LFZJBpwA5C/nHN72/Zu2E+9HqkEfnGk5GJQjEdYTiYaDEqKevV4Gh3+Dv9
	cKPIgO+/U+c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 48F3F43C72;
	Fri, 18 Mar 2016 01:40:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C0AE643C71;
	Fri, 18 Mar 2016 01:40:06 -0400 (EDT)
In-Reply-To: <CACsJy8Dm3_w6TT6FP-my9fsRJ8F+StK8dBPid9zxQv4OzoZfcw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 18 Mar 2016 07:15:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DEF88986-ECCB-11E5-BA13-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289193>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Mar 18, 2016 at 6:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thanks for these 5 patches, two of which need to be discarded ;-).
>> I think you can pick either one of 1/2, pick the one that says
>> "non-NULL" (as opposed to "something") in the log message for 2/2.
>
> Sorry, I did "git send-email ... 00*" and it picked up *.patch~ as
> well. non-NULL is the non-backup version.

Off-topic.  I wonder what people think about doing something like
this patch.

-- >8 --
send-email: detect and offer to skip backup files

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
