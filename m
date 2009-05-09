From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] format-patch let -k override a config-specified format.numbered
Date: Sat, 09 May 2009 10:12:01 +0200
Message-ID: <878wl6ofu6.fsf@meyering.net>
References: <8763gcri2c.fsf@meyering.net>
	<7vbpq2da8v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	"Stephen C. Tweedie" <sct@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 10:12:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2hfQ-0001XL-VS
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 10:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbZEIIML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 04:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbZEIIML
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 04:12:11 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:56613 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbZEIIMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 04:12:09 -0400
X-Greylist: delayed 142854 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 May 2009 04:12:08 EDT
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 21C43D48161
	for <git@vger.kernel.org>; Sat,  9 May 2009 10:12:03 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 43CADD48152
	for <git@vger.kernel.org>; Sat,  9 May 2009 10:12:01 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 24F1538150; Sat,  9 May 2009 10:12:01 +0200 (CEST)
In-Reply-To: <7vbpq2da8v.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 09 May 2009 00:08:16 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118653>


Let a command-line --keep-subject (-k) override a config-specified
format.numbered (--numbered (-n)), rather than provoking the
"-n and -k are mutually exclusive" failure.
* t4021-format-patch-numbered.sh: Test for the above

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
Junio C Hamano wrote:
> Jim Meyering <meyering@redhat.com> writes:
>> Let a command-line --keep-subject (-k) override a config-specified
>> format.numbered (--numbered (-n)), rather than provoking the
>> "-n and -k are mutually exclusive" failure.
>> * t4021-format-patch-numbered.sh: Test for the above
>> ---
>
> Sign-off?

Whoops. Here you go.

 builtin-log.c                    |   14 +++++++++++++-
 t/t4021-format-patch-numbered.sh |    7 +++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5eaec5d..f10cfeb 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -755,6 +755,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int cover_letter = 0;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
+	int numbered_cmdline_opt = 0;
 	struct commit *origin = NULL, *head = NULL;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
@@ -786,8 +787,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[i], "--stdout"))
 			use_stdout = 1;
 		else if (!strcmp(argv[i], "-n") ||
-				!strcmp(argv[i], "--numbered"))
+				!strcmp(argv[i], "--numbered")) {
 			numbered = 1;
+			numbered_cmdline_opt = 1;
+		}
 		else if (!strcmp(argv[i], "-N") ||
 				!strcmp(argv[i], "--no-numbered")) {
 			numbered = 0;
@@ -918,6 +921,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)

 	if (start_number < 0)
 		start_number = 1;
+
+	/*
+	 * If numbered is set solely due to format.numbered in config,
+	 * and it would conflict with --keep-subject (-k) from the
+	 * command line, reset "numbered".
+	 */
+	if (numbered && keep_subject && !numbered_cmdline_opt)
+		numbered = 0;
+
 	if (numbered && keep_subject)
 		die ("-n and -k are mutually exclusive.");
 	if (keep_subject && subject_prefix)
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 390af23..9b6e1be 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -86,6 +86,13 @@ test_expect_success 'format.numbered && --no-numbered' '

 '

+test_expect_success 'format.numbered && --keep-subject' '
+
+	git format-patch --keep-subject --stdout HEAD^ >patch4a &&
+	grep "^Subject: Third" patch4a
+
+'
+
 test_expect_success 'format.numbered = auto' '

 	git config format.numbered auto
--
1.6.3.195.gad81
