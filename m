From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri, 8 Oct 2010 13:45:13 +0530
Message-ID: <20101008081509.GA2845@kytes>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 10:16:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P488G-0007Ub-8M
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 10:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862Ab0JHIQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 04:16:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51400 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766Ab0JHIQe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 04:16:34 -0400
Received: by iwn6 with SMTP id 6so383676iwn.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=w3cTWqAQrBWEgCyPOFRbbfDcQg2B5ZlP3oOZCUic/l8=;
        b=kh0pK8Ip2RmiCvelrG/6DikYfpnrzg4E9WEbazjFj/4vQPy2IGybHqKUTD6FNDt6PH
         6y1Zl6MduBs3eU6UI074jb1DgzS+EC3yGjAWRDH0lrrd+7c5SPURfod5aNAx1qsDpiAW
         QGbmtXYAvFmEOLZ5OOFYgcv7fy9Hh2yEtY6+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Zk8H+pFfZ/q1YPg83OJtaKfdB4Zsf5vvEImqpPwqggtNeEPS9wZK2QMhLi1dBbTkoz
         ImNGftCaLIpzsFdsAnQbt7p2goHDH1sbbNLJMYs8WjkSGXgU1GKA1LM1hNyi6f+lbSUA
         EiwC73wFOhQSueIV9UitSQF1gTJiAK5i8+0uw=
Received: by 10.42.21.2 with SMTP id i2mr235293icb.480.1286525793630;
        Fri, 08 Oct 2010 01:16:33 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id x10sm3249334iba.10.2010.10.08.01.16.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 01:16:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158493>

Hi David,

I'm sorry I didn't get the time to look at this earlier- just looked
at it now.

David Barr writes:
> Most git commands do their writing to the object db via the index and
> loose objects.  When you just have a pile of trees you want to convert
> into commits, this is wasteful; for performance-critical operations
> like filter-branch --subdirectory-filter, one might want a sort of
> hash-object --batch-to-pack to write a pack directly.
> 
> Fortunately we have fast-import (which is one of the only git commands
> that will write to a pack directly) but there is not an advertised way
> to tell fast-import to use a given tree for its commits.  So in
> current git, one has the unpleasant choice of writing loose objects
> without parsing the trees or writing straight to pack but having to
> parse trees to do it.
> 
> This patch changes that, by allowing
> 
> 	M 040000 <tree id> ""

It can be a <dataref> in general: either a SHA1 or a tree mark.

> as a filemodify line in a commit to reset to a particular tree without
> any need to unpack it.  For example,
> 
> 	M 040000 4b825dc642cb6eb9a060e54bf8d69288fbee4904 ""
> 
> is a synonym for the deleteall command.
> 
> Commit-message-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: David Barr <david.barr@cordelta.com>
> ---
>  fast-import.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

I applied and tried it out- it works as expected. Here's a patch for
the documentation and a test. You might want to put the test in a
separate patch (in preparation for Jonathan's t9300 cleanup series).

@Jonathan: What happened to your series cleaning up t9300?

Tested-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

-- 8< --
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 966ba4f..90a4666 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -524,6 +524,9 @@ start with double quote (`"`).
 If an `LF` or double quote must be encoded into `<path>` shell-style
 quoting should be used, e.g. `"path/with\n and \" in it"`.
 
+Additionally, in `040000` mode, `<path>` may also be an empty string
+(`""`) to specify the root of the tree.
+
 The value of `<path>` must be in canonical form. That is it must not:
 
 * contain an empty directory component (e.g. `foo//bar` is invalid),

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 7c05920..3c0cf05 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -875,6 +875,27 @@ test_expect_success \
 	 compare_diff_raw expect actual'
 
 test_expect_success \
+	'N: copy root directory by tree hash' \
+	'cat >expect <<-\EOF &&
+	:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file3/newf
+	:100644 000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 0000000000000000000000000000000000000000 D	file3/oldf
+	EOF
+	 root=$(git rev-parse refs/heads/branch^0^{tree}) &&
+	 cat >input <<-INPUT_END &&
+	commit refs/heads/N6
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	copy root directory by tree hash
+	COMMIT
+
+	from refs/heads/branch^0
+	M 040000 $root ""
+	INPUT_END
+	 git fast-import <input &&
+	 git diff-tree -C --find-copies-harder -r N4 N6 >actual &&
+	 compare_diff_raw expect actual'
+
+test_expect_success \
 	'N: modify copied tree' \
 	'cat >expect <<-\EOF &&
 	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5

> diff --git a/fast-import.c b/fast-import.c
> index 2317b0f..8f68a89 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1454,6 +1454,15 @@ static int tree_content_set(
>  		n = slash1 - p;
>  	else
>  		n = strlen(p);
> +	if (!slash1 && !n) {
> +		if (!S_ISDIR(mode))
> +			die("Root cannot be a non-directory");
> +		hashcpy(root->versions[1].sha1, sha1);
> +		if (root->tree)
> +			release_tree_content_recursive(root->tree);
> +		root->tree = subtree;

Should there be a hashclr(root->versions[1].sha1) here? I saw it in
the other branches.

Looks good otherwise. I'm surprised fast-import didn't already have
this functionality.

-- Ram
