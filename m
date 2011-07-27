From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/18] revert: Simplify and inline add_message_to_msg
Date: Wed, 27 Jul 2011 06:18:09 +0200
Message-ID: <20110727041809.GB18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 06:18:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlvZk-0002E4-LJ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 06:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497Ab1G0ESX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 00:18:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54716 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321Ab1G0ESV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 00:18:21 -0400
Received: by ewy4 with SMTP id 4so1017302ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 21:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=N7HpgLMUaPR0Q8QXwYnImpHBWyxUZb3iYn8WYZ6EsaE=;
        b=rpDfo69TMUXzR2gSXx58FcH6pJF52N8/NykOKuUlnARbNI9EpEY7/EAm8R+LXu9AXZ
         2KAH0FJ67MoqQ1KrAIf4KUKo/1/13vd/iR65T1tH8yWTUvv0zMtQwpUN78JylK9O7x0E
         mD4eCbitiV2epJXvOVQzLuREG5cb6JaquR0/U=
Received: by 10.213.33.145 with SMTP id h17mr2729863ebd.39.1311740300468;
        Tue, 26 Jul 2011 21:18:20 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id t1sm809595eeb.6.2011.07.26.21.18.16
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 21:18:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177924>

Ramkumar Ramachandra wrote:

> [Subject: [PATCH 03/18] revert: Simplify and inline add_message_to_msg]

Before, I wrote that it would be better to present this as a bugfix
than as a code reorganization, since the former is more likely to
affect people upgrading or to be relevant if this later turns out to
have a regression and someone wonders why not to just revert it.  Was
I wrong?

Testcase below.  It makes a commit like this:

	tree f0db5ba931b3f121d2050e23ac3cd47ac2233306
	parent 43991719f0536a734e91e94f40361114477b3b5e
	author A U Thor <author@example.com> 1112912113 -0700
	committer C O Mitter <committer@example.com> 1112912113 -0700

with no blank line afterwards.  I think this is relevant and not a
"what if cosmic rays corrupt that pointer" kind of thing because
people use non-git programs or libraries to write to git object stores
pretty often.  If this object were invalid, it would still not be a
good behavior to segfault (better to die() or give some
arbitrary-but-sane result).  Not sure whether the object should be
considered invalid (e.g., "git fsck" accepts it).

Unfortunately it fails for me even after the patch.  If the test looks
reasonable to you, it could be worth adding marked with
"test_expect_failure".

 t/t3501-revert-cherry-pick.sh |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 595d2ff9..e46e7131 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -12,6 +12,12 @@ test_description='test cherry-pick and revert with renames
 
 . ./test-lib.sh
 
+remove_object() {
+	file=$(echo "$*" | sed 's#..#.git/objects/&#') &&
+	test -e "$file" &&
+	rm -f "$file"
+}
+
 test_expect_success setup '
 
 	for l in a b c d e f g h i j k l m n o
@@ -70,6 +76,25 @@ test_expect_success 'cherry-pick after renaming branch' '
 
 '
 
+test_expect_success 'cherry-pick commit with no delimiter after header' '
+
+	printf "%s\n" rename1 initial >expect &&
+
+	git cat-file commit rename1 >cmit &&
+	sed -e "/^\$/ Q" <cmit >newcmit &&
+	objname=$(git hash-object -t commit -w newcmit) &&
+	test_when_finished "remove_object $objname" &&
+
+	git checkout initial &&
+	git cherry-pick "$objname" &&
+
+	test_path_is_missing oops &&
+	test_path_is_file spoo &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+
+'
+
 test_expect_success 'revert after renaming branch' '
 
 	git checkout rename1 &&
-- 
1.7.6
