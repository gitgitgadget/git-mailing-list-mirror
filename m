From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "mailinfo: Remove only one set of square brackets" considered
 harmful
Date: Wed, 15 Jul 2009 15:31:12 -0700
Message-ID: <7vfxcxefyn.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0907150821280.13838@localhost.localdomain>
 <7vljmpegy4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 00:31:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRD0d-00030i-E1
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 00:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428AbZGOWbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 18:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753477AbZGOWbU
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 18:31:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbZGOWbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 18:31:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4841B71E2;
	Wed, 15 Jul 2009 18:31:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7ED5771E0; Wed, 15 Jul 2009
 18:31:14 -0400 (EDT)
In-Reply-To: <7vljmpegy4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 15 Jul 2009 15\:09\:55 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37791392-718F-11DE-8167-9AE02FB70C38-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123340>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> So I see why Andreas did it, and I don't disagree violently, BUT...
>>
>> The fact is, we have mailing lists etc that add their own headers to the 
>> subject, and they know they can add things in brackets. The most obvious 
>> example is the Linux kernel security list, which adds a prefix of
>>
>> 	"[Security] "
>>
>> to the subject line in order to stand out (I'm on other lists that do 
>> this too, but those generally don'thave patches).
>>>
>> So I have emails witgh subjects like
>>
>> 	Subject: [Security] [patch] random: make get_random_int() more random
>>
>> but I also have people who do the same thing themselves, eg:
>>
>> 	Subject: [PATCH -rc] [BUGFIX] x86: fix kernel_trap_sp()
>> 	Subject: [BUGFIX][PATCH] fix bad page removal from LRU (Was Re: [RFC][PATCH] ..
>>
>> so people did kind of depend on the "remove square brackets" behavior.
>
> Thanks.  The reason why I have merged some questionable stuff (including
> this one) early in this cycle was exactly because we would want to catch
> real world breakages caused by such changes.
>
> Even though it is silly not to rely on already well established
> conventions such as X-Mailing-List and List-ID but instead to waste
> precious real estate at the initial part of the Subject in this century
> merely for list identification purposes, this change regresses the end
> result.

I've reverted Andreas's patch for now, but it may not be a bad idea to
resurrect it like this with an option.

 Documentation/git-mailinfo.txt |    7 +++++-
 builtin-mailinfo.c             |   49 +++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 8d95aaa..d800aea 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -8,7 +8,7 @@ git-mailinfo - Extracts patch and authorship from a single e-mail message
 
 SYNOPSIS
 --------
-'git mailinfo' [-k] [-u | --encoding=<encoding> | -n] <msg> <patch>
+'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] <msg> <patch>
 
 
 DESCRIPTION
@@ -32,6 +32,11 @@ OPTIONS
 	munging, and is most useful when used to read back
 	'git-format-patch -k' output.
 
+-b::
+	When -k is not in effect, all leading strings bracketed with '['
+	and ']' pairs are stripped.  This option limits the stripping to
+	only the pairs whose bracketed string contains the word "PATCH".
+
 -u::
 	The commit log message, author name and author email are
 	taken from the e-mail, and after minimally decoding MIME
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 92637ac..a5949e2 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -10,6 +10,7 @@
 static FILE *cmitmsg, *patchfile, *fin, *fout;
 
 static int keep_subject;
+static int keep_non_patch_brackets_in_subject;
 static const char *metainfo_charset;
 static struct strbuf line = STRBUF_INIT;
 static struct strbuf name = STRBUF_INIT;
@@ -219,35 +220,41 @@ static int is_multipart_boundary(const struct strbuf *line)
 
 static void cleanup_subject(struct strbuf *subject)
 {
-	char *pos;
-	size_t remove;
-	while (subject->len) {
-		switch (*subject->buf) {
+	size_t at = 0;
+
+	while (at < subject->len) {
+		char *pos;
+		size_t remove;
+
+		switch (subject->buf[at]) {
 		case 'r': case 'R':
-			if (subject->len <= 3)
+			if (subject->len <= at + 3)
 				break;
-			if (!memcmp(subject->buf + 1, "e:", 2)) {
-				strbuf_remove(subject, 0, 3);
+			if (!memcmp(subject->buf + at + 1, "e:", 2)) {
+				strbuf_remove(subject, at, 3);
 				continue;
 			}
+			at++;
 			break;
 		case ' ': case '\t': case ':':
-			strbuf_remove(subject, 0, 1);
+			strbuf_remove(subject, at, 1);
 			continue;
 		case '[':
-			if ((pos = strchr(subject->buf, ']'))) {
-				remove = pos - subject->buf;
-				if (remove <= (subject->len - remove) * 2) {
-					strbuf_remove(subject, 0, remove + 1);
-					continue;
-				}
-			} else
-				strbuf_remove(subject, 0, 1);
-			break;
+			pos = strchr(subject->buf + at, ']');
+			if (!pos)
+				break;
+			remove = pos - subject->buf + at + 1;
+			if (!keep_non_patch_brackets_in_subject ||
+			    (7 <= remove &&
+			     memmem(subject->buf + at, remove, "PATCH", 5)))
+				strbuf_remove(subject, at, remove);
+			else
+				at += remove;
+			continue;
 		}
-		strbuf_trim(subject);
-		return;
+		break;
 	}
+	strbuf_trim(subject);
 }
 
 static void cleanup_space(struct strbuf *sb)
@@ -931,7 +938,7 @@ static int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 }
 
 static const char mailinfo_usage[] =
-	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] msg patch <mail >info";
+	"git mailinfo [-k|-b] [-u | --encoding=<encoding> | -n] msg patch <mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
@@ -948,6 +955,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
 			keep_subject = 1;
+		else if (!strcmp(argv[1], "-b"))
+			keep_non_patch_brackets_in_subject = 1;
 		else if (!strcmp(argv[1], "-u"))
 			metainfo_charset = def_charset;
 		else if (!strcmp(argv[1], "-n"))
