From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Giving command line parameter to textconv command?
Date: Mon, 14 Dec 2009 15:31:38 -0800
Message-ID: <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
References: <20091215071735.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:32:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKKOU-0001Xy-MK
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 00:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707AbZLNXbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 18:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbZLNXbx
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 18:31:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbZLNXbw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 18:31:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FB8CA7B30;
	Mon, 14 Dec 2009 18:31:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Gf9vfSGy8GuMzuZL60HKYW+cD5E=; b=frMlMfIKB2Pwd42On+9Zf1u
	KP/3y4gj42aG7jWbMX7AMUvboVxJ+OywOSP726b3VOhyzlbn+koJlzsWd5FpLjcR
	YROk9i6CAxAu5zH1PIX1v3xEsNYQXGm8mb2R98ILbRqdO8sGjDczJkXErlcpafpl
	wICLXyZ20atNzHVB1iro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=h9u7uxgWtq7hpPziyykSQ76mYlqTMokAKT/ILvO6TY1+XwXbw
	sfxd8NflAGSZNaZXvxWBXl9V0bPzVKGcR+MGE8gEoPLajxZEQVbuxWBsKVFa8jV7
	rPBIdY9SgAPGKVF17O6h7hEqddd7jY2vEzBqNG/qX2gq4M4v/a8ar7ZZNA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70201A7B2F;
	Mon, 14 Dec 2009 18:31:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DD0EDA7B2E; Mon, 14 Dec 2009
 18:31:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D705714E-E908-11DE-9D93-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135254>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I need this extra script because setting 'nkf -w' for
> textconv like this
>
> 	[diff "eucjp"]
> 		textconv = nkf -w
>
> gives an error.
>
> 	% diff --git a/hello.txt b/hello.txt
> 	index 696acd7..f07aa1a 100644
> 	error: cannot run nkf -w: No such file or directory
> 	error: error running textconv command 'nkf -w'
> 	fatal: unable to read files to diff
>
> Could you fix textconv so that it can be given parameters?

The change to do so looks like this; it has a few side effects:

 - If somebody else were relying on the fact that 'nkf -w' names the
   entire command, it now will run 'nkf' command with '-w' as an argument,
   and it will break such a set-up.  IOW, command that has an IFS white
   space in its path will now need to be quoted from the shell.

   You can see the fallout from this in the damage made to t/ hierarchy in
   the attached patch.

 - You can now use $HOME and other environment variables your shell
   expands when defining your textconv command.

Overall I think it is a good direction to go, but we need to be careful
about how we transition the existing repositories that use the old
semantics.

We might need to introduce diff.*.xtextconv or something.

 diff.c                         |    9 ++++-----
 t/t4030-diff-textconv.sh       |    2 +-
 t/t4031-diff-rewrite-binary.sh |    2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 08bbd3e..64a1486 100644
--- a/diff.c
+++ b/diff.c
@@ -3760,15 +3760,14 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 		size_t *outsize)
 {
 	struct diff_tempfile *temp;
-	const char *argv[3];
-	const char **arg = argv;
+	const char *argv[4] = { "sh", "-c", NULL, NULL };
 	struct child_process child;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf cmd = STRBUF_INIT;
 
 	temp = prepare_temp_file(spec->path, spec);
-	*arg++ = pgm;
-	*arg++ = temp->name;
-	*arg = NULL;
+	strbuf_addf(&cmd, "%s %s", pgm, temp->name);
+	argv[2] = strbuf_detach(&cmd, NULL);
 
 	memset(&child, 0, sizeof(child));
 	child.argv = argv;
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index a3f0897..3468f77 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -48,7 +48,7 @@ test_expect_success 'file is considered binary by plumbing' '
 
 test_expect_success 'setup textconv filters' '
 	echo file diff=foo >.gitattributes &&
-	git config diff.foo.textconv "$PWD"/hexdump &&
+	git config diff.foo.textconv \""$PWD"/hexdump\" &&
 	git config diff.fail.textconv false
 '
 
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index a894c60..e6cb30e 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -54,7 +54,7 @@ chmod +x dump
 
 test_expect_success 'setup textconv' '
 	echo file diff=foo >.gitattributes &&
-	git config diff.foo.textconv "$PWD"/dump
+	git config diff.foo.textconv \""$PWD"/dump\"
 '
 
 test_expect_success 'rewrite diff respects textconv' '
