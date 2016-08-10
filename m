Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F145F1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941407AbcHJTVi (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:21:38 -0400
Received: from us-hpswa-esg-01.alcatel-lucent.com ([135.245.18.29]:45082 "EHLO
	smtp-us.alcatel-lucent.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S941404AbcHJTVg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 15:21:36 -0400
Received: from us70uumx3.dmz.alcatel-lucent.com (unknown [135.245.18.15])
	by Websense Email Security Gateway with ESMTPS id 37C9C2A67D642;
	Wed, 10 Aug 2016 19:21:31 +0000 (GMT)
Received: from us70uusmtp3.zam.alcatel-lucent.com (us70uusmtp3.zam.alcatel-lucent.com [135.5.2.65])
	by us70uumx3.dmz.alcatel-lucent.com (GMO) with ESMTP id u7AJLYG8015385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 10 Aug 2016 19:21:34 GMT
Received: from US70TWXCHHUB04.zam.alcatel-lucent.com (us70twxchhub04.zam.alcatel-lucent.com [135.5.2.36])
	by us70uusmtp3.zam.alcatel-lucent.com (GMO) with ESMTP id u7AJJgBH020936
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 10 Aug 2016 19:21:33 GMT
Received: from [135.121.197.20] (135.5.27.16) by
 US70TWXCHHUB04.zam.alcatel-lucent.com (135.5.2.36) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Wed, 10 Aug 2016 15:21:15 -0400
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
From:	Stephen Morton <stephen.morton@nokia.com>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
Organization: Nokia ION
Message-ID: <09d485df-7d14-97f8-9db9-e3db7512bd68@nokia.com>
Date:	Wed, 10 Aug 2016 15:21:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [135.5.27.16]
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 5:12 AM, Johannes Schindelin 
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stephen,
>
> On Wed, 27 Jul  2016, Stephen Morton wrote:
>
>> On Wed, Jul  27, 2016 at 11:03 AM, Johannes Schindelin
>>  <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Wed,  27 Jul 2016, Stephen Morton wrote:
>> >
>> >>  diff --git a/sequencer.c b/sequencer.c
>> >>  index cdfac82..ce06876 100644
>> >> ---  a/sequencer.c
>> >> +++  b/sequencer.c
>> >> @@  -176,7 +176,8 @@ static void print_advice(int show_hint, struct
>> >>  replay_opts *opts)
>> >>             else
>> >>                     advise(_("after resolving the conflicts, mark
>> >> the  corrected paths\n"
>> >>                              "with 'git add <paths>' or 'git rm <paths>'\n"
>> >> -                              "and commit the result with 'git commit'"));
>> >> +                              "then continue the %s with 'git %s
>> >>  --continue'\n"
>> >> +                              "or cancel the %s operation with 'git
>> >> %s  --abort'" ),  action_name(opts), action_name(opts),
>> >>  action_name(opts), action_name(opts));
>> >
>> > That is  an awful lot of repetition right there, with an added
>> >  inconsistency that the action is referred to by its name alone in the
>> >  "--continue" case, but with "operation" added in the "--abort" case.
>> >
>> > And  additionally, in the most common case (one commit to cherry-pick), the
>> > advice  now suggests a more complicated operation than necessary: a simply
>> > `git  commit` would be enough, then.
>> >
>> > Can't  we have a test whether this is the last of the commits to be
>> >  cherry-picked, and if so, have the simpler advice again?
>>
>> Ok, knowing  that I'm not on the last element of the sequencer is
>> beyond my  git code knowledge.
>
> Oh, my mistake:  I meant to say that this information could be easily
> provided by  `pick_commits()` if it passed it to `print_advice()` via
>  `do_pick_commit()`.
>
> Ciao,
> Johannes

Formatting on previous email was terrible, plus the diff wasn't 
performed against origin. Re-sending.

(Finally getting back to this.)

Something like the diff below, then Johannes?

(I intentionally print the '--continue' hint even in the case whereit's 
last of n commits that fails.)


Stephen

~/ws/extern/git (maint *%>) > git diff @{u}
diff --git a/sequencer.c b/sequencer.c
index c6362d6..e0071aa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -154,7 +154,7 @@ static void free_message(struct commit *commit, 
struct commit_message *msg)
         unuse_commit_buffer(commit, msg->message);
  }

-static void print_advice(int show_hint, struct replay_opts *opts)
+static void print_advice(int show_hint, int multiple_commits, struct 
replay_opts *opts)
  {
         char *msg = getenv("GIT_CHERRY_PICK_HELP");

@@ -174,9 +174,14 @@ static void print_advice(int show_hint, struct 
replay_opts *opts)
                         advise(_("after resolving the conflicts, mark 
the corrected paths\n"
                                  "with 'git add <paths>' or 'git rm 
<paths>'"));
                 else
-                       advise(_("after resolving the conflicts, mark 
the corrected paths\n"
-                                "with 'git add <paths>' or 'git rm 
<paths>'\n"
-                                "and commit the result with 'git 
commit'"));
+                        if  (multiple_commits)
+                               advise(_("after resolving the conflicts, 
mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
+                                        "then continue with 'git %s 
--continue'\n"
+                                        "or cancel with 'git %s 
--abort'" ), action_name(opts), action_name(opts));
+                        else
+                                advise(_("after resolving the 
conflicts, mark the corrected paths\n"
+                                        "with 'git add <paths>' or 'git 
rm <paths>'\n"
+                                        "and commit the result with 
'git commit'"));
         }
  }

@@ -440,7 +445,7 @@ static int allow_empty(struct replay_opts *opts, 
struct commit *commit)
                 return 1;
  }

-static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
+static int do_pick_commit(struct commit *commit, struct replay_opts 
*opts, int multiple_commits)
  {
         unsigned char head[20];
         struct commit *base, *next, *parent;
@@ -595,7 +600,7 @@ static int do_pick_commit(struct commit *commit, 
struct replay_opts *opts)
                       : _("could not apply %s... %s"),
                       find_unique_abbrev(commit->object.oid.hash, 
DEFAULT_ABBREV),
                       msg.subject);
-               print_advice(res == 1, opts);
+               print_advice(res == 1, multiple_commits, opts);
                 rerere(opts->allow_rerere_auto);
                 goto leave;
         }
@@ -959,6 +964,7 @@ static int pick_commits(struct commit_list 
*todo_list, struct replay_opts *opts)
  {
         struct commit_list *cur;
         int res;
+    int multiple_commits = (todo_list->next) != NULL;

         setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
         if (opts->allow_ff)
@@ -968,7 +974,7 @@ static int pick_commits(struct commit_list 
*todo_list, struct replay_opts *opts)

         for (cur = todo_list; cur; cur = cur->next) {
                 save_todo(cur, opts);
-               res = do_pick_commit(cur->item, opts);
+               res = do_pick_commit(cur->item, opts, multiple_commits);
                 if (res)
                         return res;
         }
@@ -1016,7 +1022,7 @@ static int sequencer_continue(struct replay_opts 
*opts)
  static int single_pick(struct commit *cmit, struct replay_opts *opts)
  {
         setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-       return do_pick_commit(cmit, opts);
+       return do_pick_commit(cmit, opts, 0);
  }

  int sequencer_pick_revisions(struct replay_opts *opts)



-- 
Stephen Morton, 7750 SR Product Group, SW Development Tools/DevOps
w: +1-613-784-6026 (int: 2-825-6026) m: +1-613-302-2589 | EST Time Zone

