From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] diff-lib.c: adjust position of i-t-a entries in diff
Date: Tue, 17 Mar 2015 21:07:04 +0700
Message-ID: <20150317140704.GA7248@lanh>
References: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
 <1426514206-30949-1-git-send-email-pclouds@gmail.com>
 <5506F3A9.1020704@drmicha.warpmail.net>
 <xmqqa8zdrkpy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 15:07:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXs9S-0002S2-85
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 15:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbbCQOHM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2015 10:07:12 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36528 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbbCQOHL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 10:07:11 -0400
Received: by padcy3 with SMTP id cy3so10782014pad.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uSNNxmXal6FI/gcmmpI+NOYVH34gU0oY2TWfLFrGnbs=;
        b=Q6ePfrBHmtjarUVnYV9rjaN3jJtl8Qr2U0H0B8B65pd1jqOz2m2jxFP4oOQsKXedzt
         I87PYTH3mEu+ozp2KFrWpQpqelMIsuAharU73oHNj4pgDrgcykz4hc4sgYwopKNBXftL
         6O2K1MWEYF/8VeONBraNApaW6E4UXAMF/RuHfx6n4Lr1ZEgPuqLqwr/ouCxkg8ng637X
         QvRwsbNPD5B1ZjtV0hsfbKbKoBpfKVmAvfijjyB3fW41GzX1DkN9Y2sIMNkLn+zwvrXd
         wrmjl7gbE/AhjwKhKUppKS7xvY3wWGWfDkbM5ByxINQkDLTJm/Hyrl8G4nbQTf0GJFb7
         CVKw==
X-Received: by 10.66.193.226 with SMTP id hr2mr111677122pac.47.1426601230790;
        Tue, 17 Mar 2015 07:07:10 -0700 (PDT)
Received: from lanh ([115.73.218.182])
        by mx.google.com with ESMTPSA id z1sm22667476pdp.52.2015.03.17.07.07.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2015 07:07:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 17 Mar 2015 21:07:04 +0700
Content-Disposition: inline
In-Reply-To: <xmqqa8zdrkpy.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265630>

On Mon, Mar 16, 2015 at 09:05:45AM -0700, Junio C Hamano wrote:
> The offending one came from eec3e7e4 (cache-tree: invalidate i-t-a
> paths after generating trees, 2012-12-16), which was a fix to an
> earlier bug where a cache-tree written out of an index with i-t-a
> entries had incorrect information and still claimed it is fully
> valid after write-tree rebuilt it.  The test probably should add
> another path without i-t-a bit, run the same "diff --cached" with
> updated expectation before write-tre, and run the "diff --cached"
> again to make sure it produces a result that match the updated
> expectation.

Would adding another non-i-t-a entry help? Before this patch
"diff --cached" after write-tree shows the i-t-a entry only when
eec3e7e4 is applied. But with this patch we don't show i-t-a entry any
more, before or after write-tree, eec3e7e4 makes no visible difference.

We could even revert eec3e7e4 and the outcome of "diff --cached" would
be the same because we just sort of move the "invalidation" part from
cache-tree to do_oneway_diff(). Not invalidating would speed up "diff
--cached" when i-t-a entries are present. Still it may be a good idea
to invalidate i-t-a paths to be on the safe side. Perhaps a patch like
this to resurrect the test?

-- 8< --
Subject: t2203: enable 'cache-tree invalidates i-t-a paths' test

This test is disabled in the previous patch because the "diff
--cached" expectation is the same, with or without eec3e7e4 [1] where
this test is added.

But it still is a good idea to invalidate i-t-a paths because the
index does _not_ match the cached-tree exactly.  "diff --cached" may
not care, but other operations might. Update the test to catch this
invalidation instead.

[1] cache-tree: invalidate i-t-a paths after generating trees, 2012-12-=
16

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 42827b8..1a6c814 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -77,7 +77,7 @@ test_expect_success 'can "commit -a" with an i-t-a en=
try' '
 	git commit -a -m all
 '
=20
-test_expect_failure 'cache-tree invalidates i-t-a paths' '
+test_expect_success 'cache-tree invalidates i-t-a paths' '
 	git reset --hard &&
 	mkdir dir &&
 	: >dir/foo &&
@@ -86,14 +86,14 @@ test_expect_failure 'cache-tree invalidates i-t-a p=
aths' '
=20
 	: >dir/bar &&
 	git add -N dir/bar &&
-	git diff --cached --name-only >actual &&
-	echo dir/bar >expect &&
-	test_cmp expect actual &&
-
 	git write-tree >/dev/null &&
-
-	git diff --cached --name-only >actual &&
-	echo dir/bar >expect &&
+	test-dump-cache-tree >actual &&
+	cat >expect <<-\EOF &&
+	invalid                                   (1 subtrees)
+	invalid                                  #(ref)  (1 subtrees)
+	invalid                                  dir/ (0 subtrees)
+	invalid                                  #(ref) dir/ (0 subtrees)
+	EOF
 	test_cmp expect actual
 '=20
-- 8< --
