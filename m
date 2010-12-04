From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/8] vcs-svn: Consume whole preimage when applying deltas
Date: Sat, 4 Dec 2010 11:34:49 -0600
Message-ID: <20101204173449.GB28299@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
 <20101120192928.GI17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 04 18:35:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POw0y-00066e-71
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 18:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab0LDRfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 12:35:09 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33784 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab0LDRfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 12:35:07 -0500
Received: by ywl5 with SMTP id 5so5321547ywl.19
        for <git@vger.kernel.org>; Sat, 04 Dec 2010 09:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=58igg5irdWnONLH+EI2LSWeaAdXpAl5/mSQ27ON7TDE=;
        b=ntQzxkqLir16l9/m6uX0BKUHL5zTnKEZ8xq8YaHX1+B5uovxxjxsPyKOset7qlbsqq
         wPafJ9iyUZbDub6xPBpBUPS8HztipvdOdois8JHQgHKNQMxy1ud79u0Unt3PUx6shqq6
         u0FmmhkwHd9mX9ovvGMgdt7SxK3uJVm7WfC/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SdumoYCgt0zOvvhfgOz5Q90rZezj7rvzaPbRUbf7/KcpmZ0npSeKTX8r5GlFaWhMsT
         DHpO7gnU4fMgIgR2/UmeE41Nmh7OzNN+NjsS2HDmbhtHwbJN/ETtM9AVOgRPEhZC5rmn
         H6Z9tceew1o2Lq7uf2CfDi43ae3K4prmqnIZE=
Received: by 10.151.150.11 with SMTP id c11mr6077749ybo.413.1291484107013;
        Sat, 04 Dec 2010 09:35:07 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id v39sm402004yba.19.2010.12.04.09.35.03
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Dec 2010 09:35:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192928.GI17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162899>

Date: Sun Nov 21 20:24:12 2010 -0600

Some deltas do not consume the entire preimage, so we have to
consume it explicitly.

Noticed during imports from the ASF repo.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> +++ b/vcs-svn/fast_export.c
> @@ -102,33 +115,39 @@ static const char *get_response_line(void)
[...]
> +	if (svndiff0_apply(input, len, &preimage, out))
> +		die("cannot apply delta");
> +	if (old_mark) {
> +		/* Discard trailing newline from cat-blob-fd. */
> +		const char *tail = get_response_line();
> +		if (!tail || *tail)
> +			die("missing newline after cat-blob response");

As mentioned before, this error

	fatal: missing newline after cat-blob response

and

	error: Preimage ends early

were sometimes triggering.  Here's a fix for squashing.  Sorry for
the nonsensical code.

 t/t9010-svn-fe.sh     |  108 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/fast_export.c |   16 ++++---
 2 files changed, 117 insertions(+), 7 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 6c8b803..1776a38 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -678,6 +678,114 @@ test_expect_success 'deltas for typechange' '
 	test_cmp expect actual
 '
 
+test_expect_success PIPE 'deltas need not consume the whole preimage' '
+	reinit_git &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:120000 100644 OBJID OBJID T	postimage
+	OBJID
+	:100644 120000 OBJID OBJID T	postimage
+	OBJID
+	:000000 100644 OBJID OBJID A	postimage
+	EOF
+	echo "first preimage" >expect.1 &&
+	printf target >expect.2 &&
+	printf lnk >expect.3 &&
+	rm -f backflow &&
+	{
+		printf "SVNQ%b%b%b" "QQ\017\001\017" "\0217" "first preimage\n" |
+		q_to_nul
+	} >delta.1 &&
+	{
+		properties svn:special "*" &&
+		echo PROPS-END
+	} >symlink.props &&
+	{
+		printf "SVNQ%b%b%b" "Q\002\013\004\012" "\0201\001\001\0211" "lnk target" |
+		q_to_nul
+	} >delta.2 &&
+	{
+		printf "SVNQ%b%b" "Q\004\003\004Q" "\001Q\002\002" |
+		q_to_nul
+	} >delta.3 &&
+	{
+		cat <<-\EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: postimage
+		Node-kind: file
+		Node-action: add
+		Text-delta: true
+		Prop-content-length: 10
+		EOF
+		echo Text-content-length: $(wc -c <delta.1) &&
+		echo Content-length: $((10 + $(wc -c <delta.1))) &&
+		echo &&
+		echo PROPS-END &&
+		cat delta.1 &&
+		cat <<-\EOF &&
+
+		Revision-number: 2
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: postimage
+		Node-kind: file
+		Node-action: change
+		Text-delta: true
+		EOF
+		echo Prop-content-length: $(wc -c <symlink.props) &&
+		echo Text-content-length: $(wc -c <delta.2) &&
+		echo Content-length: $(($(wc -c <symlink.props) + $(wc -c <delta.2))) &&
+		echo &&
+		cat symlink.props &&
+		cat delta.2 &&
+		cat <<-\EOF &&
+
+		Revision-number: 3
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: postimage
+		Node-kind: file
+		Node-action: change
+		Text-delta: true
+		Prop-content-length: 10
+		EOF
+		echo Text-content-length: $(wc -c <delta.3) &&
+		echo Content-length: $((10 + $(wc -c <delta.3))) &&
+		echo &&
+		echo PROPS-END &&
+		cat delta.3 &&
+		echo
+	} >deltapartial.dump &&
+	mkfifo backflow &&
+	test-svn-fe deltapartial.dump 3<backflow |
+	git fast-import --cat-blob-fd=3 3>backflow &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	test_cmp expect actual &&
+	git show HEAD:postimage >actual.3 &&
+	git show HEAD^:postimage >actual.2 &&
+	git show HEAD^^:postimage >actual.1 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2 &&
+	test_cmp expect.3 actual.3
+'
+
 test_expect_success 't9135/svn.dump' '
 	svnadmin create simple-svn &&
 	svnadmin load simple-svn <"$TEST_DIRECTORY/t9135/svn.dump" &&
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index ceb1fc5..f8a41e7 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -119,6 +119,7 @@ static long apply_delta(uint32_t mark, off_t len, struct line_buffer *input,
 			uint32_t old_mark, uint32_t old_mode)
 {
 	long ret;
+	off_t preimage_len = 0;
 	struct view preimage = {REPORT_FILENO, 0, STRBUF_INIT};
 	FILE *out;
 
@@ -126,22 +127,23 @@ static long apply_delta(uint32_t mark, off_t len, struct line_buffer *input,
 		die("cannot open temporary file for blob retrieval");
 	if (old_mark) {
 		const char *response;
-		off_t dummy;
 		printf("cat-blob :%"PRIu32"\n", old_mark);
 		fflush(stdout);
 		response = get_response_line();
-		/* Not necessary, just for robustness */
-		if (parse_cat_response_line(response, &dummy))
+		if (parse_cat_response_line(response, &preimage_len))
 			die("invalid cat-blob response: %s", response);
 	}
-	if (old_mode == REPO_MODE_LNK)
+	if (old_mode == REPO_MODE_LNK) {
 		strbuf_addstr(&preimage.buf, "link ");
+		preimage_len += strlen("link ");
+	}
 	if (svndiff0_apply(input, len, &preimage, out))
 		die("cannot apply delta");
 	if (old_mark) {
-		/* Discard trailing newline from cat-blob-fd. */
-		const char *tail = get_response_line();
-		if (!tail || *tail)
+		/* Read the remainder of preimage and trailing newline. */
+		if (move_window(&preimage, preimage_len, 1))
+			die("cannot seek to end of input");
+		if (preimage.buf.buf[0] != '\n')
 			die("missing newline after cat-blob response");
 	}
 	ret = buffer_tmpfile_prepare_to_read(&postimage);
-- 
1.7.2.4
