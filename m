From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug in git-completion.sh
Date: Fri, 08 Jan 2010 11:58:11 -0800
Message-ID: <7vvdfcfjxo.fsf@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 20:58:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTKyh-0004Dn-8M
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 20:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab0AHT6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 14:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910Ab0AHT6a
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 14:58:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab0AHT63 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 14:58:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CBC668F245;
	Fri,  8 Jan 2010 14:58:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gk4Nx6ht2l0hwovG/FpwnUvTEHQ=; b=uVd6kv
	X54MUCIg2wvqri2/BLfJiCAA0Qa0TjYPl8VMTWVtkqnyIfdLB/lpagSuBp4tGVR3
	mWjw3GfCYauQW3tZEm1ZPF3DXtrTp2O/Z16FaIuX68Zdio9N3NBX353wGJw4BJX6
	MdE3XOKx69CWQqnIGn0C3fOnumZUG55JB68vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CzMsm8G3hp8mxg+A6LjdUqrExSXr37uv
	dIX+t54i+pltyVYpif/XbbInxfNem0wT/jPiR9BzA9wnoOIE9se9dMT4QkA+bJI3
	GoTGIN51bq8kh8lPIRr7myVis9cWRUjo7ZtsIVhzvLUH00bhoZAKptSoN5KISuso
	nxZtumdKjlw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C8208F244;
	Fri,  8 Jan 2010 14:58:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6C808F234; Fri,  8 Jan
 2010 14:58:12 -0500 (EST)
In-Reply-To: <7v8wc8jw3k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 08 Jan 2010 10\:21\:51 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B73D15E-FC90-11DE-A1E9-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136467>

Junio C Hamano <gitster@pobox.com> writes:

> Nah, I should have checked the code.
>
> The implementation of ls-files does cd up and uses pathspec, so the intent
> is to apply higher level gitignore.
> 
> It however feeds paths from the already ignored directories, which _is_
> the real bug.
> ...
> I think a proper fix should be in dir.c::read_directory() where it calls
> read_directory_recursive() without first checking if the directory itself
> should be ignored.  read_directory_recursive() itself has a logic to see
> if the dirent it found is worth recursing into and a similar logic should
> be in the toplevel caller.

Actually doing less in fill_directory() turned out to be a simpler
solution.

builtin_add() cares about the return value from fill_directory() and
performs prune_directory() optimization magic, and we may want to change
it not to do so as well, but I didn't want to worry about too many things
at once, so this version still runs the "common_prefix()" that forgets to
take .gitignore at higher levels (or a $GIT_DIR/info/exclude entry that
ignores the common prefix directory of given pathspecs) into account.

Another possibility is to fix common_prefix() and make it walk the path it
returns one level at a time from the top, making sure they are not
ignored, and that would probably be a better fix, but at least this patch
will give you a starting point and tests to check the result against.

diff --git a/dir.c b/dir.c
index d0999ba..56d3f60 100644
--- a/dir.c
+++ b/dir.c
@@ -53,7 +53,6 @@ static int common_prefix(const char **pathspec)
 
 int fill_directory(struct dir_struct *dir, const char **pathspec)
 {
-	const char *path;
 	int len;
 
 	/*
@@ -61,13 +60,8 @@ int fill_directory(struct dir_struct *dir, const char **pathspec)
 	 * use that to optimize the directory walk
 	 */
 	len = common_prefix(pathspec);
-	path = "";
-
-	if (len)
-		path = xmemdupz(*pathspec, len);
-
 	/* Read the directory and prune it */
-	read_directory(dir, path, len, pathspec);
+	read_directory(dir, "", 0, pathspec);
 	return len;
 }
 
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index c65bca8..17d1764 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -153,4 +153,42 @@ test_expect_success 'negated exclude matches can override previous ones' '
 	grep "^a.1" output
 '
 
+test_expect_success 'subdirectory ignore (setup)' '
+	mkdir -p top/l1/l2 &&
+	(
+		cd top &&
+		git init &&
+		echo /.gitignore >.gitignore &&
+		echo l1 >>.gitignore &&
+		echo l2 >l1/.gitignore
+	)
+'
+
+test_expect_success 'subdirectory ignore (toplevel)' '
+	(
+		cd top &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'subdirectory ignore (l1/l2)' '
+	(
+		cd top/l1/l2 &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'subdirectory ignore (l1)' '
+	(
+		cd top/l1 &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
 test_done
