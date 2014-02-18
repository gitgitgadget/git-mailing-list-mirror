From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: teach "git config --file -" to read from the standard input
Date: Tue, 18 Feb 2014 15:02:46 -0800
Message-ID: <xmqqy518ausp.fsf@gitster.dls.corp.google.com>
References: <CAPig+cSRgpABwzC36FoBst52hCOPieMBTvsTx9CPFoHifHG9yg@mail.gmail.com>
	<1392552781-23275-1-git-send-email-kirill@shutemov.name>
	<20140218084144.GA2692@sigill.intra.peff.net>
	<xmqq7g8sfd19.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 19 00:03:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFtgv-0005A6-Hm
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 00:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbaBRXCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 18:02:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327AbaBRXCv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 18:02:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C1956ED05;
	Tue, 18 Feb 2014 18:02:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=03MmQ3UbxDrlGfGspZt4z7Z1oeY=; b=vyD2uxcU9PEQBhC65Des
	oAGMFGfH4AMlX9eUVQB8LOJ4FnWOnDWZ0LCPCra6XB9ZIk6fvuxOQd66geACgamf
	+IpmBI41k2KTT4ai7mBQwdeOVjgFTiYfsmISxfH2G5uiH7jRnm6iaWFJKT3YDDD/
	kA0HG5pNVNyWIIrormIF3dA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=N18VQ/p7xgN5/R+GyEsI0IiK3l86WN5qYwnEnGZADF09bd
	d8Jr/p/6Jaiqk0ZCaEU7khSNyi+KVqIkJzx46P9hxooSFqxg8n2WzvzfOwU2FEz7
	eRN8cFo5jX9mf6Jb0/E2+65fiy4DSplFuCv77KTWQCCRyNin7/LGusj5suVO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A80D66ED02;
	Tue, 18 Feb 2014 18:02:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C2CB6ED01;
	Tue, 18 Feb 2014 18:02:48 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C916DA54-98F0-11E3-ABF2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242371>

Junio C Hamano <gitster@pobox.com> writes:

>> I think I preferred the earlier version where you had "<stdin>" in the
>> name field, and this hunk could just go away. I know you switched it to
>> NULL here to avoid making bogus relative filenames in includes.
>
> Exactly the same comment here.  I really like the way how this
> series becomes more polished every time we see it.
>
>> But that would be pretty straightforward to fix by splitting the "name"
>> field into an additional "path" field. It looks like "git config --blob"
>> has the same problem (it will try relative lookups in the filesystem,
>> even though that is nonsensical from the blob). So we could fix the
>> existing bug at the same time. :)
>>
>> Perhaps this could go at the start of your series?
>
> Sounds like the right thing to do.
>
> Thanks.

And [PATCH 3/3] rebased on the others may look like this.

 builtin/config.c          | 11 +++++++++++
 cache.h                   |  1 +
 config.c                  | 42 ++++++++++++++++++++++++++++--------------
 t/t1300-repo-config.sh    | 17 +++++++++++++++--
 t/t1305-config-include.sh | 16 +++++++++++++++-
 5 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index de41ba5..5677c94 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -360,6 +360,9 @@ static int get_colorbool(int print)
 
 static void check_write(void)
 {
+	if (given_config_source.use_stdin)
+		die("writing to stdin is not supported");
+
 	if (given_config_source.blob)
 		die("writing config blobs is not supported");
 }
@@ -472,6 +475,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (given_config_source.file &&
+			!strcmp(given_config_source.file, "-")) {
+		given_config_source.file = NULL;
+		given_config_source.use_stdin = 1;
+	}
+
 	if (use_global_config) {
 		char *user_config = NULL;
 		char *xdg_config = NULL;
@@ -558,6 +567,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 0, 0);
 		if (!given_config_source.file && nongit)
 			die("not in a git directory");
+		if (given_config_source.use_stdin)
+			die("editing stdin is not supported");
 		if (given_config_source.blob)
 			die("editing blobs is not supported");
 		git_config(git_default_config, NULL);
diff --git a/cache.h b/cache.h
index 9d94bd6..4db19b5 100644
--- a/cache.h
+++ b/cache.h
@@ -1147,6 +1147,7 @@ extern int update_server_info(int);
 #define CONFIG_GENERIC_ERROR 7
 
 struct git_config_source {
+	unsigned int use_stdin:1;
 	const char *file;
 	const char *blob;
 };
diff --git a/config.c b/config.c
index a21b0dd..9dd0bdb 100644
--- a/config.c
+++ b/config.c
@@ -1031,24 +1031,36 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 	return ret;
 }
 
-int git_config_from_file(config_fn_t fn, const char *filename, void *data)
+static int do_config_from_file(config_fn_t fn,
+			       const char *filename, FILE *f,
+			       const char *label, void *data)
 {
-	int ret;
-	FILE *f = fopen(filename, "r");
+	struct config_source top;
 
-	ret = -1;
-	if (f) {
-		struct config_source top;
+	top.u.file = f;
+	top.name = label;
+	top.path = filename;
+	top.die_on_error = 1;
+	top.do_fgetc = config_file_fgetc;
+	top.do_ungetc = config_file_ungetc;
+	top.do_ftell = config_file_ftell;
+
+	return do_config_from(&top, fn, data);
+}
 
-		top.u.file = f;
-		top.name = top.path = filename;
-		top.die_on_error = 1;
-		top.do_fgetc = config_file_fgetc;
-		top.do_ungetc = config_file_ungetc;
-		top.do_ftell = config_file_ftell;
+static int git_config_from_stdin(config_fn_t fn, void *data)
+{
+	return do_config_from_file(fn, NULL, stdin, "<stdin>", data);
+}
 
-		ret = do_config_from(&top, fn, data);
+int git_config_from_file(config_fn_t fn, const char *filename, void *data)
+{
+	int ret = -1;
+	FILE *f;
 
+	f = fopen(filename, "r");
+	if (f) {
+		ret = do_config_from_file(fn, filename, f, filename, data);
 		fclose(f);
 	}
 	return ret;
@@ -1190,7 +1202,9 @@ int git_config_with_options(config_fn_t fn, void *data,
 	 * If we have a specific filename, use it. Otherwise, follow the
 	 * regular lookup sequence.
 	 */
-	if (config_source && config_source->file)
+	if (config_source && config_source->use_stdin)
+		return git_config_from_stdin(fn, data);
+	else if (config_source && config_source->file)
 		return git_config_from_file(fn, config_source->file, data);
 	else if (config_source && config_source->blob)
 		return git_config_from_blob_ref(fn, config_source->blob, data);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 9673593..c9c426c 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -475,15 +475,28 @@ ein.bahn=strasse
 EOF
 
 test_expect_success 'alternative GIT_CONFIG' '
-	GIT_CONFIG=other-config git config -l >output &&
+	GIT_CONFIG=other-config git config --list >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'alternative GIT_CONFIG (--file)' '
-	git config --file other-config -l > output &&
+	git config --file other-config --list >output &&
 	test_cmp expect output
 '
 
+test_expect_success 'alternative GIT_CONFIG (--file=-)' '
+	git config --file - --list <other-config >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'setting a value in stdin is an error' '
+	test_must_fail git config --file - some.value foo
+'
+
+test_expect_success 'editing stdin is an error' '
+	test_must_fail git config --file - --edit
+'
+
 test_expect_success 'refer config from subdirectory' '
 	mkdir x &&
 	(
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 6edd38b..9ba2ba1 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -113,7 +113,7 @@ test_expect_success 'missing include files are ignored' '
 test_expect_success 'absolute includes from command line work' '
 	echo "[test]one = 1" >one &&
 	echo 1 >expect &&
-	git -c include.path="$PWD/one" config test.one >actual &&
+	git -c include.path="$(pwd)/one" config test.one >actual &&
 	test_cmp expect actual
 '
 
@@ -138,6 +138,20 @@ test_expect_success 'relative includes from blobs fail' '
 	test_must_fail git config --blob=$blob test.one
 '
 
+test_expect_success 'absolute includes from stdin work' '
+	echo "[test]one = 1" >one &&
+	echo 1 >expect &&
+	echo "[include]path=\"$(pwd)/one\"" |
+	git config --file - test.one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'relative includes from stdin line fail' '
+	echo "[test]one = 1" >one &&
+	echo "[include]path=one" |
+	test_must_fail git config --file - test.one
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
