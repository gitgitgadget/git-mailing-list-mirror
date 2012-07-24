From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/3] fast-import: do not write null_sha1 as a merge
 parent
Date: Tue, 24 Jul 2012 14:30:40 -0500
Message-ID: <20120724193040.GC5210@burratino>
References: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
 <1340818825-13754-2-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:30:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stkol-0002Xw-Mt
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 21:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953Ab2GXTaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 15:30:46 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:43515 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab2GXTap (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 15:30:45 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so7077594ggl.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gmD1FGZNgGr7TS1qPAsG8LWonc4re5jGP16gP32+MoM=;
        b=kelbifNXJFlja50MYUHg+mApUWdEZaZGe81jjuDlWsE+0FeyVz6m882QHReVjUknkq
         sHTHhyarK45VHin7WGmOQbfaCNHob/j2KVhdEVGe6LM1fGkqAkofvhTB5uSKSj+xcqwE
         6wWLYZHb2qjADcjpXxoDPipeuO5cm2CmUdRvRQv0OE6Gg8LWS369q8GAg/2x8qRs7aPF
         mrf5Cd1nBe0iPe/qjj8WRAtHSokAh+mLF6wNbZw8cnE9CTQpBceYG/S9A3eh/Kr4HAHP
         2Yn+RKSI5UwS9Si32w2MUuLoZtWtF494E1qc7tdrsQnlaUDtXaTRmsBb0JhUldPhMBMx
         0qNg==
Received: by 10.42.154.199 with SMTP id r7mr17671927icw.55.1343158244482;
        Tue, 24 Jul 2012 12:30:44 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id qo3sm5510598igc.8.2012.07.24.12.30.43
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 12:30:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340818825-13754-2-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202060>

Hi,

In June, Dmitry Ivankov wrote:

> null_sha1 is used in fast-import to indicate "empty" branches and
> should never be actually written out as a commit parent. 'merge'
> command lacks is_null_sha1 checks and must be fixed.
>
> It looks like using null_sha1 or empty branches in 'from' command
> is legal and/or an intended option (it has been here from the very
> beginning and survived). So leave it allowed for 'merge' command too,
> and just like with 'from' command silently skip null_sha1 parents.

As Junio mentioned, this might have just been an implementation
accident --- without a use case in mind, it is hard to say that
support for the 'from 0{40}' was really intended to be part of the
supported fast-import syntax.

On the other hand it seems possible and even likely that some frontend
has taken advantage of the feature to avoid having to use conditional
logic to decide whether to emit a "from" command, since it has been
around so long.  So you are right that it's safest not to remove it.

That means that adding the same support for the "merge" command could
be a pretty bad thing, since it would be making a new promise of
continued support and would place a new burden on other implementers
of backends.

[...]
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2734,7 +2734,8 @@ static void parse_new_commit(void)
>  		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(b->sha1));
>  	while (merge_list) {
>  		struct hash_list *next = merge_list->next;
> -		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(merge_list->sha1));
> +		if (!is_null_sha1(merge_list->sha1))
> +			strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(merge_list->sha1));

Since these "merge" commands produced invalid results in the past,
would it be safe to do

		if (is_null_sha1(merge_list->sha1))
			die("cannot use unborn branch or all-zeroes hash as merge parent";

instead?

> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -850,6 +850,27 @@ INPUT_END
>  test_expect_success \
>  	'J: tag must fail on empty branch' \
>  	'test_must_fail git fast-import <input'
> +
> +cat >input <<INPUT_END
> +reset refs/heads/J3
> +
> +reset refs/heads/J4
> +from 0000000000000000000000000000000000000000
> +
> +commit refs/heads/J5
> +committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +data <<COMMIT
> +Merge J3, J4 into fresh J5.
> +COMMIT
> +merge refs/heads/J3
> +merge refs/heads/J4
> +
> +INPUT_END
> +test_expect_success \
> +	'J: allow merge with empty branch' \
> +	'git fast-import <input &&
> +	git rev-parse --verify J5 &&
> +	test_must_fail git rev-parse --verify J5^'

Thanks for the test --- in any case, we should test the behavior.  How
about this, for now?

-- >8 --
From: Dmitry Ivankov <divanorama@gmail.com>
Subject: test: demonstrate fast-import bug that produces invalid commits with null parent

null_sha1 is used in fast-import to indicate "empty" branches and
should never be actually written out as a commit parent. 'merge'
command lacks is_null_sha1 checks and must be fixed.

[jn: extracted from a patch with a proposed fix; split into two tests]

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2fcf2694..f13b85b8 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -850,6 +850,42 @@ INPUT_END
 test_expect_success \
 	'J: tag must fail on empty branch' \
 	'test_must_fail git fast-import <input'
+
+cat >input <<INPUT_END
+reset refs/heads/J-unborn
+
+commit refs/heads/J-merge-unborn
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+Merge J-unborn into fresh J-merge-unborn.
+COMMIT
+merge refs/heads/J-unborn
+
+INPUT_END
+test_expect_failure \
+	'J: reject or ignore merge with unborn branch' \
+	'test_when_finished "git update-ref -d refs/heads/J-merge-unborn" &&
+	 test_might_fail git fast-import <input &&
+	 git fsck'
+
+cat >input <<INPUT_END
+reset refs/heads/J-null-sha1
+from 0000000000000000000000000000000000000000
+
+commit refs/heads/J-merge-null
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+Merge J-null-sha1 into fresh J-merge-null.
+COMMIT
+merge refs/heads/J-null-sha1
+
+INPUT_END
+test_expect_failure \
+	'J: reject or ignore merge with unborn branch' \
+	'test_when_finished "git update-ref -d refs/heads/J-merge-null" &&
+	 test_might_fail git fast-import <input &&
+	 git fsck'
+
 ###
 ### series K
 ###
-- 
1.7.10.4
