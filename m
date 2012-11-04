From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] git p4: RCS expansion should not span newlines
Date: Sun, 4 Nov 2012 17:04:02 -0500
Message-ID: <20121104220402.GA9160@padd.com>
References: <CACtYWOYOSxmogJHy70McsRVf0m2PVuu=q+pDZ2-gAza7vpeEiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Goard <cgoard@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 23:08:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV8Mh-0001ed-OB
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 23:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860Ab2KDWEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 17:04:09 -0500
Received: from honk.padd.com ([74.3.171.149]:54458 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242Ab2KDWEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 17:04:07 -0500
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 6EAE8D27;
	Sun,  4 Nov 2012 14:04:06 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id F087222AF9; Sun,  4 Nov 2012 17:04:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACtYWOYOSxmogJHy70McsRVf0m2PVuu=q+pDZ2-gAza7vpeEiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209042>

This bug was introduced in cb585a9 (git-p4: keyword
flattening fixes, 2011-10-16).  The newline character
is indeed special, and $File$ expansions should not try
to match across multiple lines.

Based-on-patch-by: Chris Goard <cgoard@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---

cgoard@gmail.com wrote on Mon, 16 Jul 2012 12:49 -0700:
> Hi. Noticed an apparent bug in git-p4 related to RCS keyword
> expansion. Some files in our Perforce repository have malformed RCS
> keywords, e.g. "$Revision:" without a closing $. Perforce doesn't
> expand these, obviously, but when a change to this file is imported
> into git, everything up to the next $, on another line much later in
> the file, is deleted. Seems to be due to multi-line matching of RCS
> keywords. One fix is:
> 
> diff --git a/git-p4.py b/git-p4.py
> index f895a24..ae7b431 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -215,7 +215,7 @@ def p4_keywords_regexp_for_type(base, type_mods):
>          pattern = r"""
>              \$              # Starts with a dollar, followed by...
>              (%s)            # one of the keywords, followed by...
> -            (:[^$]+)?       # possibly an old expansion, followed by...
> +            (:[^\n$]+)?     # possibly an old expansion, followed by...
>              \$              # another dollar
>              """ % kwords
>          return pattern

Chris,

I finally got around to building a test-case for this.  The bug
has been in since around 1.7.7, so I won't call this exactly
urgent, even though it is blatantly buggy as is.

Will try to get it into the next release.

Thanks,

		-- Pete

 git-p4.py             |  2 +-
 t/t9810-git-p4-rcs.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 882b1bb..7d6c928 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -227,7 +227,7 @@ def p4_keywords_regexp_for_type(base, type_mods):
         pattern = r"""
             \$              # Starts with a dollar, followed by...
             (%s)            # one of the keywords, followed by...
-            (:[^$]+)?       # possibly an old expansion, followed by...
+            (:[^$\n]+)?     # possibly an old expansion, followed by...
             \$              # another dollar
             """ % kwords
         return pattern
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index fe30ad8..0c2fc3e 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -155,6 +155,25 @@ test_expect_success 'cleanup after failure' '
 	)
 '
 
+# perl $File:: bug check
+test_expect_success 'ktext expansion should not expand multi-line $File::' '
+	(
+		cd "$cli" &&
+		cat >lv.pm <<-\EOF
+		my $wanted = sub { my $f = $File::Find::name;
+				    if ( -f && $f =~ /foo/ ) {
+		EOF
+		p4 add -t ktext lv.pm &&
+		p4 submit -d "lv.pm"
+	) &&
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		test_cmp "$cli/lv.pm" lv.pm
+	)
+'
+
 #
 # Do not scrub anything but +k or +ko files.  Sneak a change into
 # the cli file so that submit will get a conflict.  Make sure that
-- 
1.7.12.1.457.g468b3ef
