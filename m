From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #01; Mon, 05)
Date: Fri, 09 Jan 2009 22:15:59 -0800
Message-ID: <7vr63by9cw.fsf@gitster.siamese.dyndns.org>
References: <7vbpulnduj.fsf@gitster.siamese.dyndns.org>
 <2c6b72b30901092015l2405627aqf928e43c12eabc3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Jonas Fonseca" <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 07:17:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLXA6-000504-OQ
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 07:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbZAJGQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jan 2009 01:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZAJGQJ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 01:16:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbZAJGQI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jan 2009 01:16:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AB22A1C2A9;
	Sat, 10 Jan 2009 01:16:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 058D11BC58; Sat,
 10 Jan 2009 01:16:01 -0500 (EST)
In-Reply-To: <2c6b72b30901092015l2405627aqf928e43c12eabc3c@mail.gmail.com>
 (Jonas Fonseca's message of "Fri, 9 Jan 2009 23:15:37 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A6D1C28-DEDE-11DD-8EFF-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105079>

"Jonas Fonseca" <jonas.fonseca@gmail.com> writes:

> On Tue, Jan 6, 2009 at 01:33, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> ----------------------------------------------------------------
>> * mv/apply-parse-opt (Sun Dec 28 00:03:57 2008 +0100) 1 commit
>>  + parse-opt: migrate builtin-apply.
>
> This broke apply for me after updating to the current "next" earlier
> today. When requesting that the patch be read from stdin I get the
> following error message:
>
>   > git diff | git apply -R -
>   fatal: can't open patch '-': No such file or directory

Thanks.  I think this patch would fix it.

Because the original option parser was incremental and immediate with
respect to "-", we used to be able to say:

	$ git apply -p - --stat patch2.txt <patch1.txt

and the use of parseopt breaks such usage, even after this fix.

But I think it is a bit too crazy to support such backward compatibilit=
y.

 builtin-apply.c        |   19 +++++--------------
 t/t4106-apply-stdin.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git c/builtin-apply.c w/builtin-apply.c
index cb988a3..2811c0f 100644
--- c/builtin-apply.c
+++ w/builtin-apply.c
@@ -3140,16 +3140,6 @@ static int git_apply_config(const char *var, con=
st char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
=20
-static int option_parse_stdin(const struct option *opt,
-			      const char *arg, int unset)
-{
-	int *errs =3D opt->value;
-
-	*errs |=3D apply_patch(0, "<stdin>", options);
-	read_stdin =3D 0;
-	return 0;
-}
-
 static int option_parse_exclude(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -3218,9 +3208,6 @@ int cmd_apply(int argc, const char **argv, const =
char *unused_prefix)
 	const char *whitespace_option =3D NULL;
=20
 	struct option builtin_apply_options[] =3D {
-		{ OPTION_CALLBACK, '-', NULL, &errs, NULL,
-			"read the patch from the standard input",
-			PARSE_OPT_NOARG, option_parse_stdin },
 		{ OPTION_CALLBACK, 0, "exclude", NULL, "path",
 			"don=C2=B4t apply changes matching the given path",
 			0, option_parse_exclude },
@@ -3302,7 +3289,11 @@ int cmd_apply(int argc, const char **argv, const=
 char *unused_prefix)
 		const char *arg =3D argv[i];
 		int fd;
=20
-		if (0 < prefix_length)
+		if (!strcmp(arg, "-")) {
+			errs |=3D apply_patch(0, "<stdin>", options);
+			read_stdin =3D 0;
+			continue;
+		} else if (0 < prefix_length)
 			arg =3D prefix_filename(prefix, prefix_length, arg);
=20
 		fd =3D open(arg, O_RDONLY);
diff --git c/t/t4106-apply-stdin.sh w/t/t4106-apply-stdin.sh
new file mode 100755
index 0000000..72467a1
--- /dev/null
+++ w/t/t4106-apply-stdin.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description=3D'git apply --numstat - <patch'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo hello >text &&
+	git add text &&
+	echo goodbye >text &&
+	git diff >patch
+'
+
+test_expect_success 'git apply --numstat - < patch' '
+	echo "1	1	text" >expect &&
+	git apply --numstat - <patch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git apply --numstat - < patch patch' '
+	for i in 1 2; do echo "1	1	text"; done >expect &&
+	git apply --numstat - < patch patch >actual &&
+	test_cmp expect actual
+'
+
+test_done
