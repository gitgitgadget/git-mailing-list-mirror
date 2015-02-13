From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] git-send-email.perl: support no- prefix with older GetOptions
Date: Fri, 13 Feb 2015 12:19:28 -0800
Message-ID: <1423858769-1565-2-git-send-email-gitster@pobox.com>
References: <xmqq8ug2pvw7.fsf@gitster.dls.corp.google.com>
 <1423858769-1565-1-git-send-email-gitster@pobox.com>
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 21:19:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMMiC-00033M-Dm
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 21:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbbBMUTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 15:19:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753215AbbBMUTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 15:19:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3FAE248BE;
	Fri, 13 Feb 2015 15:19:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Iuvc
	vXb2VX9eDPGVeOONyqVEBQ4=; b=dO/sVJNDQgRYSJleAJ01sBhCNlZ7nhqRIdB0
	ODuO4N9gG8UAeQOijCpOoqgakRt9ec/zMEpb/2ccysSrbXQSY67ndzI/5i/N4Wzm
	3eRgf1PPEbjtFvddJFWBq2Mkd59x9Y1wc7L+6wuqe61svUDFPQNij66ueoKl69Gu
	ewFWepM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	iBXQazuiw6VBen6o5H/HGw5YR+hoUDHpspuH4yAoerFyYL6zJ5QCdbbetF69TCxS
	JcUj9afSfnt/BeOu2aDiMXkcg7MkFRj7Gg6vJy/VTd8Nud/d9hHOnyNJQ+pHSKjx
	Ht5eS2WM+fXmijICNjASPapxJL/3xcfv9Fzw+9XbYrU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA626248BD;
	Fri, 13 Feb 2015 15:19:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 404CC248BC;
	Fri, 13 Feb 2015 15:19:33 -0500 (EST)
X-Mailer: git-send-email 2.3.0-191-geb1a277
In-Reply-To: <1423858769-1565-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9F6B0F52-B3BD-11E4-BCED-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263828>

From: "Kyle J. McKay" <mackyle@gmail.com>

Only Perl version 5.8.0 or later is required, but that comes with
an older Getopt::Long (2.32) that does not support the 'no-'
prefix.  Support for that was added in Getopt::Long version 2.33.

Since the help only mentions the 'no-' prefix and not the 'no'
prefix, add explicit support for the 'no-' prefix when running
with older GetOptions versions.

Reported-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3092ab3..a18a795 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -299,6 +299,7 @@ sub signal_handler {
 		    "bcc=s" => \@bcclist,
 		    "no-bcc" => \$no_bcc,
 		    "chain-reply-to!" => \$chain_reply_to,
+		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
 		    "smtp-server=s" => \$smtp_server,
 		    "smtp-server-option=s" => \@smtp_server_options,
 		    "smtp-server-port=s" => \$smtp_server_port,
@@ -311,25 +312,34 @@ sub signal_handler {
 		    "smtp-domain:s" => \$smtp_domain,
 		    "identity=s" => \$identity,
 		    "annotate!" => \$annotate,
+		    "no-annotate" => sub {$annotate = 0},
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
+		    "no-suppress-from" => sub {$suppress_from = 0},
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
+		    "no-signed-off-cc|no-signed-off-by-cc" => sub {$signed_off_by_cc = 0},
 		    "cc-cover|cc-cover!" => \$cover_cc,
+		    "no-cc-cover" => sub {$cover_cc = 0},
 		    "to-cover|to-cover!" => \$cover_to,
+		    "no-to-cover" => sub {$cover_to = 0},
 		    "confirm=s" => \$confirm,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
+		    "no-thread" => sub {$thread = 0},
 		    "validate!" => \$validate,
+		    "no-validate" => sub {$validate = 0},
 		    "transfer-encoding=s" => \$target_xfer_encoding,
 		    "format-patch!" => \$format_patch,
+		    "no-format-patch" => sub {$format_patch = 0},
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "compose-encoding=s" => \$compose_encoding,
 		    "force" => \$force,
 		    "xmailer!" => \$use_xmailer,
+		    "no-xmailer" => sub {$use_xmailer = 0},
 	 );
 
 usage() if $help;
-- 
2.3.0-191-geb1a277
