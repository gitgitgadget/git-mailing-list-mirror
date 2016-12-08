Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C1C1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 17:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbcLHR1w (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 12:27:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61012 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752443AbcLHR1w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 12:27:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F22D54EFA;
        Thu,  8 Dec 2016 12:27:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=usTZZxSeVoj061zmj+xpJBxl2Ig=; b=uMoQ2W
        BMC184t3d5pMJSmfeAayG4+2gMSUEkNdAa91Viqs6fV/IDEnHYTC0nTMePLu+N4z
        XhC301KVwyIjRVgAVC5+MkQs8dnkuqSt3O0/M4pgycK+md/KMG56SurA9AYtln/M
        pMQ5ieZ7B84Bo2s1S7nYzzdu6IJxBi71diTEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HeyLaCTDl0k9nzlMP6p+M1mf0moxIYn0
        iTuYK6hTuOuLGF2J2UHGl5fwRDVanQ/d6abWZbFcUscoAlW62BhHsyDwG491pYKw
        eSzYmFMs/0eIuL7z+fUkIczWdNUknWEILuZ69Gfukk9yGfbzdBmtm+kX1Ea5LEvo
        oncCaqpBYhE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8792054EF9;
        Thu,  8 Dec 2016 12:27:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B82C254EF5;
        Thu,  8 Dec 2016 12:27:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 4/5] Make sequencer abort safer
References: <20161207215133.13433-1-s-beyer@gmx.net>
        <20161207215133.13433-4-s-beyer@gmx.net>
        <alpine.DEB.2.20.1612081627290.23160@virtualbox>
Date:   Thu, 08 Dec 2016 09:27:48 -0800
In-Reply-To: <alpine.DEB.2.20.1612081627290.23160@virtualbox> (Johannes
        Schindelin's message of "Thu, 8 Dec 2016 16:28:06 +0100 (CET)")
Message-ID: <xmqqr35itjor.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A456CCC2-BD6B-11E6-8DFB-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 7 Dec 2016, Stephan Beyer wrote:
>
>> diff --git a/sequencer.c b/sequencer.c
>> index 30b10ba14..c9b560ac1 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -27,6 +27,7 @@ GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
>>  static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
>>  static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
>>  static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
>> +static GIT_PATH_FUNC(git_path_curr_file, "sequencer/current")
>
> Is it required by law to have a four-letter infix, or can we have a nicer
> variable name (e.g. git_path_current_file)?

I agree with you that, as other git_path_*_file variables match the
actual name on the filesystem, this one should too, together with
the update_curr_file() function.

By the way, this step seems to be a fix to an existing problem, and
the new test added in 3/5 seems to be a demonstration of the issue.
If that is the case, shouldn't the new test initially expect failure
and updated by this step to expect success?

I'll queue this on top of step 4/5 as "SQUASH???" as usual.  The
other SQUASH??? that must come after 3/5 for t3510 should be trivial
(the reverse of what appears here).

Thanks.


 sequencer.c                     | 22 +++++++++++-----------
 t/t3510-cherry-pick-sequence.sh |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c9b560ac15..ce04377f8e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -27,7 +27,7 @@ GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
 static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
 static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
-static GIT_PATH_FUNC(git_path_curr_file, "sequencer/current")
+static GIT_PATH_FUNC(git_path_current_file, "sequencer/current")
 
 /*
  * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
@@ -311,7 +311,7 @@ static int error_dirty_index(struct replay_opts *opts)
 	return -1;
 }
 
-static void update_curr_file()
+static void update_current_file(void)
 {
 	struct object_id head;
 
@@ -320,9 +320,9 @@ static void update_curr_file()
 		return;
 
 	if (!get_oid("HEAD", &head))
-		write_file(git_path_curr_file(), "%s", oid_to_hex(&head));
+		write_file(git_path_current_file(), "%s", oid_to_hex(&head));
 	else
-		write_file(git_path_curr_file(), "%s", "");
+		write_file(git_path_current_file(), "%s", "");
 }
 
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
@@ -354,7 +354,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	strbuf_release(&sb);
 	strbuf_release(&err);
 	ref_transaction_free(transaction);
-	update_curr_file();
+	update_current_file();
 	return 0;
 }
 
@@ -829,7 +829,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 
 leave:
 	free_message(commit, &msg);
-	update_curr_file();
+	update_current_file();
 
 	return res;
 }
@@ -1149,23 +1149,23 @@ static int save_head(const char *head)
 	return 0;
 }
 
-static int rollback_is_safe()
+static int rollback_is_safe(void)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id expected_head, actual_head;
 
-	if (strbuf_read_file(&sb, git_path_curr_file(), 0) >= 0) {
+	if (strbuf_read_file(&sb, git_path_current_file(), 0) >= 0) {
 		strbuf_trim(&sb);
 		if (get_oid_hex(sb.buf, &expected_head)) {
 			strbuf_release(&sb);
-			die(_("could not parse %s"), git_path_curr_file());
+			die(_("could not parse %s"), git_path_current_file());
 		}
 		strbuf_release(&sb);
 	}
 	else if (errno == ENOENT)
 		oidclr(&expected_head);
 	else
-		die_errno(_("could not read '%s'"), git_path_curr_file());
+		die_errno(_("could not read '%s'"), git_path_current_file());
 
 	if (get_oid("HEAD", &actual_head))
 		oidclr(&actual_head);
@@ -1441,7 +1441,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return -1;
 	if (save_opts(opts))
 		return -1;
-	update_curr_file();
+	update_current_file();
 	res = pick_commits(&todo_list, opts);
 	todo_list_release(&todo_list);
 	return res;
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index efcd4fc485..372307c21b 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -147,7 +147,7 @@ test_expect_success '--abort to cancel single cherry-pick' '
 	git diff-index --exit-code HEAD
 '
 
-test_expect_failure '--abort does not unsafely change HEAD' '
+test_expect_success '--abort does not unsafely change HEAD' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick picked anotherpick &&
 	git reset --hard base &&
