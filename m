From: Junio C Hamano <gitster@pobox.com>
Subject: log --pretty/--oneline: ignore log.decorate
Date: Tue, 06 Apr 2010 14:48:55 -0700
Message-ID: <7vmxxggsl4.fsf@alter.siamese.dyndns.org>
References: <7vtyrr6nes.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Drake <sdrake@xnet.co.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 23:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzGe0-0003hH-HT
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 23:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889Ab0DFVtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 17:49:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab0DFVtE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 17:49:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CF61A8444;
	Tue,  6 Apr 2010 17:49:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f/a/BLBTvTql1WY/l4zBbOUMKWE=; b=TIDghe
	FkjEhuZnQ0ZGUAqMSu2UQD0jHJJ51a7reMN+j9oun6cblxLRmjOiNkr491exTGjs
	K+jG5/v4dodX2U8M/xrfW2IktCslYW8VtxFmal0PJ3tymGXwhsVNmubJkkZ/n5ht
	6cJuXQsE/OiMCXntbjHuMwwwBZ+opS+Ga8MIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TmfkKwZ4a6ogYUMmn6JXbLF0zCNv4kIm
	RPrXg73REcQMAzXXwPukIPW0lqdVP/ft1lS39KIHcyGCCNe1ZTsI7CB5oh5C+2rz
	vcCYN3P+j7Hs84EfH/XT/TqoE8/pkRkrY/QT+bUwzYaww1H3+PqQIhVJUM1cgoNm
	eVJnw2C7v+o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDC74A843D;
	Tue,  6 Apr 2010 17:49:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEFA4A843A; Tue,  6 Apr
 2010 17:48:57 -0400 (EDT)
In-Reply-To: <7vtyrr6nes.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 04 Apr 2010 12\:14\:03 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35F48E4A-41C6-11DF-A11E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144175>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * sd/log-decorate (2010-02-17) 3 commits
>   (merged to 'next' on 2010-03-08 at 58a6fba)
>  + log.decorate: usability fixes
>  + Add `log.decorate' configuration variable.
>  + git_config_maybe_bool()
>
> Needs squelching the configuration setting when "--pretty=raw" is given,
> at least, or possibly when any "--pretty" is explicitly given.

This is necessary if we want to let users specify log.decorate and still
use gitk.  A patch should look like this (of course untested).

-- >8 --

Many scripts, most notably gitk, rely on output from the log family of
command not to be molested by random user configuration.  This is
especially true when --pretty=raw is given.

Just like we disable notes output unless the command line explicitly
asks for --show-notes, disable the decoration code unless --decorate is
given explicitly from the command line and --pretty or --oneline is
given.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---
 builtin-log.c  |   11 +++++++++++
 t/t4202-log.sh |   44 ++++++++++++++++++++++++++++----------------
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 0afba31..7f4186f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -53,6 +53,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
 	int i;
+	int decoration_given = 0;
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -89,11 +90,13 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--decorate")) {
 			decoration_style = DECORATE_SHORT_REFS;
+			decoration_given = 1;
 		} else if (!prefixcmp(arg, "--decorate=")) {
 			const char *v = skip_prefix(arg, "--decorate=");
 			decoration_style = parse_decoration_style(arg, v);
 			if (decoration_style < 0)
 				die("invalid --decorate option: %s", arg);
+			decoration_given = 1;
 		} else if (!strcmp(arg, "--no-decorate")) {
 			decoration_style = 0;
 		} else if (!strcmp(arg, "--source")) {
@@ -103,6 +106,14 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		} else
 			die("unrecognized argument: %s", arg);
 	}
+
+	/*
+	 * defeat log.decorate configuration interacting with --pretty
+	 * from the command line.
+	 */
+	if (!decoration_given && rev->pretty_given)
+		decoration_style = 0;
+
 	if (decoration_style) {
 		rev->show_decorations = 1;
 		load_ref_decorations(decoration_style);
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2230e60..166de44 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -390,50 +390,62 @@ test_expect_success 'log --graph with merge' '
 test_expect_success 'log.decorate configuration' '
 	git config --unset-all log.decorate || :
 
-	git log --oneline >expect.none &&
-	git log --oneline --decorate >expect.short &&
-	git log --oneline --decorate=full >expect.full &&
+	git log >expect.none &&
+	git log --decorate >expect.short &&
+	git log --decorate=full >expect.full &&
+	git log --oneline >expect.oneline &&
 
 	echo "[log] decorate" >>.git/config &&
-	git log --oneline >actual &&
+	git log >actual &&
 	test_cmp expect.short actual &&
+	git log --oneline >actual &&
+	test_cmp expect.oneline actual &&
 
 	git config --unset-all log.decorate &&
 	git config log.decorate true &&
-	git log --oneline >actual &&
+	git log >actual &&
 	test_cmp expect.short actual &&
-	git log --oneline --decorate=full >actual &&
+	git log --decorate=full >actual &&
 	test_cmp expect.full actual &&
-	git log --oneline --decorate=no >actual &&
+	git log --decorate=no >actual &&
 	test_cmp expect.none actual &&
+	git log --oneline >actual &&
+	test_cmp expect.oneline actual &&
 
 	git config --unset-all log.decorate &&
 	git config log.decorate no &&
-	git log --oneline >actual &&
+	git log >actual &&
 	test_cmp expect.none actual &&
-	git log --oneline --decorate >actual &&
+	git log --decorate >actual &&
 	test_cmp expect.short actual &&
-	git log --oneline --decorate=full >actual &&
+	git log --decorate=full >actual &&
 	test_cmp expect.full actual &&
+	git log --oneline >actual &&
+	test_cmp expect.oneline actual &&
 
 	git config --unset-all log.decorate &&
 	git config log.decorate short &&
-	git log --oneline >actual &&
+	git log >actual &&
 	test_cmp expect.short actual &&
-	git log --oneline --no-decorate >actual &&
+	git log --no-decorate >actual &&
 	test_cmp expect.none actual &&
-	git log --oneline --decorate=full >actual &&
+	git log --decorate=full >actual &&
 	test_cmp expect.full actual &&
+	git log --oneline >actual &&
+	test_cmp expect.oneline actual &&
 
 	git config --unset-all log.decorate &&
 	git config log.decorate full &&
-	git log --oneline >actual &&
+	git log >actual &&
 	test_cmp expect.full actual &&
-	git log --oneline --no-decorate >actual &&
+	git log --no-decorate >actual &&
 	test_cmp expect.none actual &&
-	git log --oneline --decorate >actual &&
+	git log --decorate >actual &&
 	test_cmp expect.short actual
+	git log --oneline >actual &&
+	test_cmp expect.oneline actual &&
 
+	:
 '
 
 test_done
