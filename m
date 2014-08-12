From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v2 23/23] rebase -i: enable options --signoff, --reset-author
 for pick, reword
Date: Tue, 12 Aug 2014 23:04:12 +0200
Message-ID: <53EA814C.2050802@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1407368621.git.bafain@gmail.com>	<ed19a079924e11edac0163837500c2e8caa2a555.1407368621.git.bafain@gmail.com> <87sil6ajbx.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Aug 12 23:04:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHJF0-0003y3-55
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 23:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbaHLVES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 17:04:18 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:56440 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaHLVER (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 17:04:17 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so10454380wes.14
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=g/BnG5G2GBOb+LkUw4SLAp+GOGLgY6XkCkwf5VPCsMg=;
        b=GaKqr57LZxD7Wb5KstCCn1UVEQgr3JBbh099XnwNgFg/1FhHY3WbXZiOpCT6yTJaSc
         UC0RYQaqVxLmF7X/59+noMHvZP+Jrl3BszH2fvr2RmiXNPzmTmYoJJk3RPosrEPK25d4
         CgLe+dEcIHDVAJOaVttzGshC1PeTs4QHpjSOSydGA9zHzAND5LaZPWGXTLkNO9is5zGh
         ssWIosmvZs+Pr0SvDR9RTWTyNQAUBlwX3sr7U9tSmiPonyOm8muzyKvsebEHn9MfQKxc
         Vaf13HNmV71jtFXmoHODmstVgQ70spitGIGjUmZwRdf10HHmPoS84/JGQGtgDFGBXfdG
         qh1Q==
X-Received: by 10.194.2.132 with SMTP id 4mr154783wju.49.1407877454635;
        Tue, 12 Aug 2014 14:04:14 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id ga2sm11713180wjb.44.2014.08.12.14.04.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 14:04:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <87sil6ajbx.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255164>

Hi Thomas,

Thomas Rast writes:
> Fabian Ruch <bafain@gmail.com> writes:
>> @@ -634,21 +644,24 @@ do_replay () {
>>  		comment_for_reflog pick
>>  
>>  		mark_action_done
>> -		do_pick $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
>> +		eval do_pick $opts $sha1 \
>> +			|| die_with_patch $sha1 "Could not apply $sha1... $rest"
> 
> You had me a little puzzled at the switch to 'eval' here.  That is
> necessary to match the quoting added in 20/23, not for any change in
> this commit.  This commit is simply the first one to trigger this.

This patch switches to 'eval' here because it is the first time
'opts' occurs. However, I agree that it might be confusing that
'opts' wasn't already added to the 'do_pick' lines by 20/23. By
"trigger" you mean that this commit is the first to actually fill
'opts' with contents? I will move these changes to 20/23 then.

> Also, are you sure $sha1 does not require quoting through an eval?

At least if we can assume that it is really a SHA-1 object name. As
such it does not contain characters interpreted by the shell, like
backslashes, quotes or whitespace.

> Please add tests to this patch.

The ones I had in mind are attached below the scissors line. The
current reroll fails the authorship checks and the 'git rebase
--continue' test cases. As the necessary changes would obfuscate this
sub-thread, they will be included in the next reroll.

   Fabian

-- >8 --
diff --git a/t/t3427-rebase-line-options.sh b/t/t3427-rebase-line-options.sh
index 5881162..a5a9e66 100755
--- a/t/t3427-rebase-line-options.sh
+++ b/t/t3427-rebase-line-options.sh
@@ -6,10 +6,32 @@ test_description='git rebase -i with line options'
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
+commit_message () {
+	git cat-file commit "$1" | sed '1,/^$/d'
+}
+
+commit_authorship () {
+	git cat-file commit "$1" | sed -n '/^$/q;/^author /p'
+}
+
+authorship () {
+	echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE"
+}
+
+test_diff_file () {
+	if cmp "$1" "$2" >/dev/null
+	then
+		echo "'$1' and '$2' are the same"
+		return 1
+	fi
+}
+
 test_expect_success 'Set up repository' '
 	test_commit Initial &&
 	test_commit Commit1 &&
-	test_commit Commit2
+	test_commit Commit2 &&
+	git checkout -b branch Commit1 &&
+	test_commit Commit2_ Commit2.t
 '
 
 test_expect_success 'Unknown option' '
@@ -23,4 +45,137 @@ test_expect_success 'Unknown option' '
 	git rebase --continue
 '
 
+test_msg_author () {
+	set_fake_editor &&
+	FAKE_LINES="1 $1 2" git rebase -i HEAD~2 &&
+	commit_message HEAD >actual.msg &&
+	commit_authorship HEAD >actual.author &&
+	test_cmp expected.msg actual.msg &&
+	test_cmp expected.author actual.author
+}
+
+test_msg_author_misspelled () {
+	set_cat_todo_editor &&
+	test_must_fail git rebase -i HEAD^ >todo &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 $1-misspelled 2" git rebase -i HEAD~2 &&
+	set_fixed_todo_editor "$(pwd)"/todo &&
+	FAKE_LINES="$1 1" git rebase --edit-todo &&
+	git rebase --continue &&
+	commit_message HEAD >actual.msg &&
+	commit_authorship HEAD >actual.author &&
+	test_cmp expected.msg actual.msg &&
+	test_cmp expected.author actual.author
+}
+
+test_msg_author_conflicted () {
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="$1 1" git rebase -i master &&
+	git checkout --theirs Commit2.t &&
+	git add Commit2.t &&
+	git rebase --continue &&
+	commit_message HEAD >actual.msg &&
+	commit_authorship HEAD >actual.author &&
+	test_cmp expected.msg actual.msg &&
+	test_cmp expected.author actual.author
+}
+
+test_expect_success 'Misspelled pick --signoff' '
+	git checkout -b misspelled-pick--signoff master &&
+	cat >expected.msg <<-EOF &&
+	$(commit_message HEAD)
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	commit_authorship HEAD >expected.author &&
+	test_msg_author_misspelled pick_--signoff
+'
+
+test_expect_success 'Conflicted pick --signoff' '
+	git checkout -b conflicted-pick--signoff branch &&
+	cat >expected.msg <<-EOF &&
+	$(commit_message HEAD)
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	commit_authorship HEAD >expected.author &&
+	test_msg_author_conflicted pick_--signoff
+'
+
+test_expect_success 'pick --signoff' '
+	git checkout -b pick--signoff master &&
+	cat >expected.msg <<-EOF &&
+	$(commit_message HEAD)
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	commit_authorship HEAD >expected.author &&
+	test_msg_author pick_--signoff
+'
+
+test_expect_success 'reword --signoff' '
+	git checkout -b reword--signoff master &&
+	cat >expected.msg <<-EOF &&
+	$(commit_message HEAD)
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	commit_authorship HEAD >expected.author &&
+	test_msg_author reword_--signoff
+'
+
+test_expect_success 'Misspelled pick --reset-author' '
+	git checkout -b misspelled-pick--reset-author master &&
+	commit_message HEAD >expected.msg &&
+	test_tick &&
+	authorship >expected.author &&
+	commit_authorship HEAD >original.author &&
+	test_diff_file expected.author original.author &&
+	test_msg_author_misspelled pick_--reset-author
+'
+
+test_expect_success 'Conflicted pick --reset-author' '
+	git checkout -b conflicted-pick--reset-author branch &&
+	commit_message HEAD >expected.msg &&
+	test_tick &&
+	authorship >expected.author &&
+	commit_authorship HEAD >original.author &&
+	test_diff_file expected.author original.author &&
+	test_msg_author_conflicted pick_--reset-author
+'
+
+test_expect_success 'pick --reset-author' '
+	git checkout -b pick--reset-author master &&
+	commit_message HEAD >expected.msg &&
+	test_tick &&
+	authorship >expected.author &&
+	commit_authorship HEAD >original.author &&
+	test_diff_file expected.author original.author &&
+	test_msg_author pick_--reset-author
+'
+
+test_expect_success 'pick --reset-author --signoff' '
+	git checkout -b pick--reset-author--signoff master &&
+	cat >expected.msg <<-EOF &&
+	$(commit_message HEAD)
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	test_tick &&
+	authorship >expected.author &&
+	commit_authorship HEAD >original.author &&
+	test_diff_file expected.author original.author &&
+	test_msg_author pick_--reset-author_--signoff
+'
+
+test_expect_success 'reword --reset-author' '
+	git checkout -b reword--reset-author master &&
+	commit_message HEAD >expected.msg &&
+	test_tick &&
+	authorship >expected.author &&
+	commit_authorship HEAD >original.author &&
+	test_diff_file expected.author original.author &&
+	test_msg_author reword_--reset-author
+'
+
 test_done
