From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [RFC] git-am: handling unborn branches
Date: Sat, 6 Jun 2015 00:26:43 +0800
Message-ID: <CACRoPnTjqWrhS0UArSevjp6kUbQL8YYEvvobmykssoo05wjbow@mail.gmail.com>
References: <CACRoPnSmF0ym7ONnLAfL=o5ouSrP2Ucxdh40k6Ps-hnTsSUx4w@mail.gmail.com>
	<xmqqpp5bv0z9.fsf@gitster.dls.corp.google.com>
	<CACRoPnS9UK0ebD2JdSfun8+F0MXj6Loza4Y07whqbO6tV4_APQ@mail.gmail.com>
	<xmqqfv66tbei.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:27:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0uSS-00054I-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbbFEQ0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:26:46 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:34745 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbbFEQ0p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 12:26:45 -0400
Received: by laew7 with SMTP id w7so57957782lae.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=subsi4Z9KiKih+bNKHSor2VIBBDQx+UIAa2PuvATmwM=;
        b=XiPBu4E8OX9KXhTJCUWY7C0Zqq5KmNHGE9poc/H07Hdkhp6khChxtOpdt5C3YbqXlF
         I7a8f/wOTiSX3PAka9T1pONYn2hUDk2Yk5bH6aA/abb04d03wBi0j08Kd6UhX4iXU5hE
         D/h6sJ9UMpbzmAvu3wBdURisYyNOoi2DFWCvuiGaw7AVlM4nNVh6QTkbpySWE20beY0w
         /lr36YCHPHarl+l/9ke9s8/ZYIbi5GqumatBOCy7YEhL4jMpESo68VTW5amFlXRjloYT
         FyD4g5jhxpHiZ1bdo68X1RpYd3mGB2+uFn8yGn5PiA4Y07FOYm1VDDVT7600q8KZaIVw
         b5jQ==
X-Received: by 10.152.87.13 with SMTP id t13mr4254046laz.66.1433521603520;
 Fri, 05 Jun 2015 09:26:43 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 5 Jun 2015 09:26:43 -0700 (PDT)
In-Reply-To: <xmqqfv66tbei.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270849>

On Fri, Jun 5, 2015 at 11:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> Hmm, actually git-am.sh doesn't seem to do that even when we have a
>> history to apply patches to. This is okay in the non-3way case, as
>> git-apply will check to see if the patch applies before it modifies
>> the index, but if we fall back on 3-way merge, any new files the
>> failed merge added will not be deleted in the "git read-tree --reset
>> -u HEAD HEAD".
>>
>> Should we do that?
>
> That sounds like the right thing to do; I agree that fixing it may
> or may not be outside the scope of the immediate series.

Hmm, thinking about it, the equivalent C code would be greatly
affected by whatever behavior we go with, so I think we should try
fixing the behavior first.

This was done really quickly, but I think this may fix it:

diff --git a/git-am.sh b/git-am.sh
index 761befb..f7d54bf 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -502,7 +502,9 @@ then
         ;;
     t,)
         git rerere clear
-        git read-tree --reset -u HEAD HEAD
+        git read-tree --reset HEAD HEAD &&
+        our_tree=$(git write-tree) &&
+        git read-tree -m -u $our_tree HEAD
         orig_head=$(cat "$GIT_DIR/ORIG_HEAD")
         git reset HEAD
         git update-ref ORIG_HEAD $orig_head
diff --git a/t/t4153-am-clean-index.sh b/t/t4153-am-clean-index.sh
new file mode 100755
index 0000000..6d696db
--- /dev/null
+++ b/t/t4153-am-clean-index.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='test clean index with am'
+. ./test-lib.sh
+
+test_expect_success setup '
+    test_commit initial file &&
+    test_commit master-commit file &&
+    git checkout -b conflict master^ &&
+    echo conflict-commit >file &&
+    echo newfile >newfile &&
+    git add newfile &&
+    test_tick &&
+    git commit -a -m conflict-commit &&
+    git format-patch --stdout initial >conflict.patch &&
+    git checkout master
+'
+
+test_expect_success 'am -3 pauses on conflict' '
+    test_must_fail git am -3 conflict.patch &&
+    echo newfile >expected &&
+    test_cmp newfile expected
+'
+
+test_expect_success 'am --skip removes newfile' '
+    git am --skip &&
+    test_path_is_missing newfile
+'
+
+test_done

However, it assumes that the contents of the index are from the failed
merge. If the user modified the index before running git-am --skip,
e.g. the user added a file, then that file would be deleted, which may
not be desired...

Thanks,
Paul
