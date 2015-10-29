From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: avoid symlinks when reusing worktree files
Date: Thu, 29 Oct 2015 11:19:01 -0700
Message-ID: <xmqq4mh9sfl6.fsf@gitster.mtv.corp.google.com>
References: <1445981088-6285-1-git-send-email-davvid@gmail.com>
	<xmqq1tcgne4u.fsf@gitster.mtv.corp.google.com>
	<20151029015539.GA12513@gmail.com>
	<xmqq8u6lsggx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ismail Badawi <ismail@badawi.io>,
	John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:19:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zrrn5-0008Sj-Rr
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 19:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbbJ2STG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 14:19:06 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751536AbbJ2STF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 14:19:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6A98827743;
	Thu, 29 Oct 2015 14:19:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9GECTGeA1bkjkUS5UH6+xdW57rk=; b=VMz00K
	wUd3oYCam0LC8mjKe7JZbo2sv9Yby2nN2vZteIgs71hYDO8ZEbZ2Fh19sWki0x9O
	DBu/F9PKZTg9npzCYXYppnFhgf4nsrPCVDfecl/iOqTa2lNPYxH3prmYGBL1/BJn
	C3YM85n+TrgT+OrFtxLXw8ryEyffeMMJ6NdrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bLlqVTPdA6BHcjLIX+ZS5e5urxsvMEf2
	SccUq8C52ZkNqgrt3yEuI15YYng/IjjfYWBoFtTx6xwR3s4s86x9vAkR9EvnlCTD
	wjZyRjTxMRZPFRwrOn1Gbxq/Cn2e0pBXlbNc+CwpzEp1F2wkvT8jYG0hmfTzTQSo
	siFJzf/hdn0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 600A627742;
	Thu, 29 Oct 2015 14:19:03 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CDAA92773C;
	Thu, 29 Oct 2015 14:19:02 -0400 (EDT)
In-Reply-To: <xmqq8u6lsggx.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 29 Oct 2015 10:59:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 885402D4-7E69-11E5-A967-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280454>

Junio C Hamano <gitster@pobox.com> writes:

> So I think it is fine to return $use=0 for any symbolic link from
> use_wt_file.  Anything you do there will be replaced by the loop
> over %symlink that appears later in the caller.  The caller discards
> $wt_sha1 when $use=0 is returned, so the second return value does
> not matter.

So let me try to update your patch with the result of the study of
the codeflow.

-- >8 --
From: David Aguilar <davvid@gmail.com>
Subject: difftool: ignore symbolic links in use_wt_file

The caller is preparing a narrowed-down copy of the working tree and
this function is asked if the path should be included in that copy.
If we say yes, the path from the working tree will be either symlinked
or copied into the narrowed-down copy.

For any path that is a symbolic link, the caller later fixes up the
narrowed-down copy by unlinking the path and replacing it with a
regular file it writes out that mimics the way how "git diff"
compares symbolic links.

Let's answer "no, you do not want to copy/symlink the working tree
file" for all symbolic links from this function, as we know the
result will not be used because it will be overwritten anyway.

Incidentally, this also stops the function from feeding a symbolic
link in the working tree to hash-object, which is a wrong thing to
do to begin with. The link may be pointing at a directory, or worse
may be dangling (both would be noticed as an error).  Even if the
link points at a regular file, hashing the contents of a file that
is pointed at by the link is not correct (Git hashes the contents of
the link itself, not the pointee).

Signed-off-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-difftool.perl   |  4 +---
 t/t7800-difftool.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 7df7c8a..488d14b 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -70,9 +70,7 @@ sub use_wt_file
 	my ($repo, $workdir, $file, $sha1) = @_;
 	my $null_sha1 = '0' x 40;
 
-	if (! -e "$workdir/$file") {
-		# If the file doesn't exist in the working tree, we cannot
-		# use it.
+	if (-l "$workdir/$file" || ! -e _) {
 		return (0, $null_sha1);
 	}
 
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index ea35a02..a771cf7 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -504,4 +504,23 @@ test_expect_success PERL 'difftool properly honors gitlink and core.worktree' '
 	)
 '
 
+test_expect_success PERL,SYMLINKS 'difftool --dir-diff symlinked directories' '
+	git init dirlinks &&
+	(
+		cd dirlinks &&
+		git config diff.tool checktrees &&
+		git config difftool.checktrees.cmd "echo good" &&
+		mkdir foo &&
+		: >foo/bar &&
+		git add foo/bar &&
+		test_commit symlink-one &&
+		ln -s foo link &&
+		git add link &&
+		test_commit symlink-two &&
+		echo good >expect &&
+		git difftool --tool=checktrees --dir-diff HEAD~ >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
