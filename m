From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Wed, 03 Dec 2014 09:23:11 -0800
Message-ID: <xmqq388wk5q8.fsf@gitster.dls.corp.google.com>
References: <20140324213814.GA1267@achilles.my.domain>
	<xmqqfvcwk6en.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Luis Henriques <henrix@camandro.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 18:23:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwDe9-0001Rk-VE
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 18:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbaLCRXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 12:23:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751148AbaLCRXV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 12:23:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADD3321BC3;
	Wed,  3 Dec 2014 12:23:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1IlcKXECEhppbPTy/kryqn5GEe4=; b=wfA4c6
	oEMwa1YQO6XIEPwckMArAmsAXWKeNSYehuISDz2m+mmEanc+00+TW3zTpC3U2Mbe
	XlAF2iLBdNtyueA6vXoEUDhhuMmEFnkpcheEizlFW/WwzwbMldZICJ7PBgkatQYJ
	0o7rNN+x9jY7iBC4pLdijgG1xyi8I9M4gQe6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F3CdflmznwLwwBlLUdPVkH1dh25VL83v
	Xm49ldAAsdtEQ5SUIbuZMDygO2ibYsoKqTp/9QWfomUDO3Z5zOl4MZ+GWQ1Hs/Yu
	HwKnJRXUQHQEnHi4SAQmrGXdnIGG95OWxsquOoUVOmkSAR6fIanzu6WPNA1jGzf8
	B/r6zWIuuwA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A575D21BC1;
	Wed,  3 Dec 2014 12:23:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD1C021BBC;
	Wed,  3 Dec 2014 12:23:12 -0500 (EST)
In-Reply-To: <xmqqfvcwk6en.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 03 Dec 2014 09:08:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0F4A67C2-7B11-11E4-9B2A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260666>

Junio C Hamano <gitster@pobox.com> writes:

> Two problems here.
> ...
> tests?

Something like this squashed into the patch you posted earlier,
perhaps, would be a good place to start.

 Documentation/git-send-email.txt |  6 ++++--
 git-send-email.perl              | 11 +++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f2425ef..a0bd806 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -132,8 +132,10 @@ Note that no attempts whatsoever are made to validate the encoding.
 	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assumed.
 
 --xmailer::
-	Prevent adding the "X-Mailer:" header.  Default value is
-	'sendemail.xmailer'.
+--no-xmailer::
+	Add (or prevent adding) the "X-Mailer:" header.  By default,
+	the header is added, but it can be turned off by setting the
+	`sendemail.xmailer` configuration variable to `false`.
 
 Sending
 ~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index 9ca7c5b..a6e66b9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -54,7 +54,7 @@ sub usage {
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
-    --[no-]xmailer                 * Don't add "X-Mailer:" header.  Default on.
+    --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
     --compose-encoding      <str>  * Encoding to assume for introduction.
@@ -177,8 +177,7 @@ sub format_2822_time {
 my $multiedit;
 my $editor;
 
-# Usage of X-Mailer email header
-my $xmailer;
+my $use_xmailer;
 
 sub do_edit {
 	if (!defined($editor)) {
@@ -224,7 +223,7 @@ sub do_edit {
     "validate" => [\$validate, 1],
     "multiedit" => [\$multiedit, undef],
     "annotate" => [\$annotate, undef],
-    "xmailer" => [\$xmailer, 1]
+    "xmailer" => [\$use_xmailer, 1]
 );
 
 my %config_settings = (
@@ -323,7 +322,7 @@ sub signal_handler {
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "compose-encoding=s" => \$compose_encoding,
 		    "force" => \$force,
-		    "xmailer!" => \$xmailer,
+		    "xmailer!" => \$use_xmailer,
 	 );
 
 usage() if $help;
@@ -1170,7 +1169,7 @@ sub send_message {
 Date: $date
 Message-Id: $message_id
 ";
-	if ($xmailer) {
+	if ($use_xmailer) {
 		$header .= "X-Mailer: git-send-email $gitversion\n";
 	}
 	if ($reply_to) {
-- 
2.2.0-141-gd3f4719
