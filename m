From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Thu, 21 Jan 2010 19:05:19 -0800
Message-ID: <7vmy06et5c.fsf@alter.siamese.dyndns.org>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <7vpr52gbmu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 22 04:05:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY9qE-0004iW-Qy
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 04:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab0AVDFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 22:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868Ab0AVDFa
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 22:05:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896Ab0AVDF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 22:05:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 37E7E9269D;
	Thu, 21 Jan 2010 22:05:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tNtuG14WIMyR4oWDKJtnTviOyiI=; b=TM9W2K
	UlKnjfwsMlg/KpgKUqsux0VCA4JnLZnN851PoY+GJzs2/oedN8OQjHWpR9g5GCuv
	xWX49UDWINHpVqYoLaiW+8+ioNH/ptOh5FQ4E07dHk4fACdja/nSHNCZ+r+2nt7L
	WnZjRIyOIbVAqYUYbcfwkvU62JPLwdauySPa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZXbXXyHhbbzpgMEVqZ4rE3OtoWJip4tt
	MeZTd1x9N2LaggLZFWA1HUIlWDB/ibNuPCn+1x5VvjUFRYnfXR2fdy2DHxIpxjCa
	dNPOfW48XAvD2sQOCsYM6GWncv9RAVlKaLvzlKRoN0n4bFKEZl3eatMYUboGuReg
	2GTPZB1aXxA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 000819269C;
	Thu, 21 Jan 2010 22:05:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10ED892696; Thu, 21 Jan
 2010 22:05:20 -0500 (EST)
In-Reply-To: <7vpr52gbmu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 21 Jan 2010 17\:40\:41 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC5CF206-0702-11DF-85F7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137730>

Junio C Hamano <gitster@pobox.com> writes:

> I would actually have expected to see something like this, but I haven't
> even compile tested it, so... 

Ok, here is a compile and "make test" tested one, together with your
addition to the test script.

I am still curious how you managed to end up with a wrong function name in
the context header, though.  The patch below has "set_shared_perm" because
that is the header we find before the context of the hunk, so it is sort
of understandable; we might want to squelch the hunk header string when
the first context line of the hunk already matches the funcname pattern,
though.

-- >8 --
Subject: ignore duplicated slashes in make_relative_path()

The function takes two paths, an early part of abs is supposed to match
base; otherwise abs is not a path under base and the function returns the
full path of abs.  The caller can easily confuse the implementation by
giving duplicated and needless slashes in these path arguments.

Credit for test script, motivation and initial patch goes to Thomas Rast,
but the bugs in the implementation of this patch are mine..

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.c              |   32 +++++++++++++++++++++++---------
 t/t1501-worktree.sh |    6 ++++++
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/path.c b/path.c
index 2ec950b..5906fa3 100644
--- a/path.c
+++ b/path.c
@@ -394,17 +394,31 @@ int set_shared_perm(const char *path, int mode)
 const char *make_relative_path(const char *abs, const char *base)
 {
 	static char buf[PATH_MAX + 1];
-	int baselen;
+	int i = 0, j = 0;
+
 	if (!base)
 		return abs;
-	baselen = strlen(base);
-	if (prefixcmp(abs, base))
-		return abs;
-	if (abs[baselen] == '/')
-		baselen++;
-	else if (base[baselen - 1] != '/')
-		return abs;
-	strcpy(buf, abs + baselen);
+	while (base[i]) {
+		if (base[i] == '/') {
+			if (abs[j] != '/')
+				return abs;
+			while (base[i] == '/')
+				i++;
+			while (abs[j] == '/')
+				j++;
+			continue;
+		} else if (abs[j] != base[i]) {
+			return abs;
+		}
+		i++;
+		j++;
+	}
+	while (abs[j] == '/')
+		j++;
+	if (!abs[j])
+		strcpy(buf, ".");
+	else
+		strcpy(buf, abs + j);
 	return buf;
 }
 
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 74e6443..9df3012 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -189,4 +189,10 @@ test_expect_success 'absolute pathspec should fail gracefully' '
 	)
 '
 
+test_expect_success 'make_relative_path handles double slashes in GIT_DIR' '
+	: > dummy_file
+	echo git --git-dir="$(pwd)//repo.git" --work-tree="$(pwd)" add dummy_file &&
+	git --git-dir="$(pwd)//repo.git" --work-tree="$(pwd)" add dummy_file
+'
+
 test_done
