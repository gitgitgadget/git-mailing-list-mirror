From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar to disable display of #
Date: Wed, 28 Aug 2013 22:59:59 +0200
Message-ID: <vpq61up5y5s.fsf@anie.imag.fr>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
	<1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq1u5da8dp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 23:00:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEmqm-0006C5-7L
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 23:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275Ab3H1VAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 17:00:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40032 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235Ab3H1VAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 17:00:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7SKxule017720
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Aug 2013 22:59:56 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VEmqN-0001VE-LF; Wed, 28 Aug 2013 22:59:59 +0200
In-Reply-To: <xmqq1u5da8dp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 28 Aug 2013 13:05:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Aug 2013 22:59:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7SKxule017720
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378328399.32491@z+p6JAYdmX6nnU+Lk2cdHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233213>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index ec57a15..dacf4b9 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2118,6 +2118,11 @@ status.branch::
>>  	Set to true to enable --branch by default in linkgit:git-status[1].
>>  	The option --no-branch takes precedence over this variable.
>>  
>> +status.displayCommentChar::
>> +	If set to false, linkgit:git-status[1] will not prefix each
>> +	line with the comment char (`core.commentchar`, i.e. `#` by
>> +	default). Defaults to true.
>
> We prefix core.commentchar followed by a single space for non-empty
> lines; is that worth mentioning, I wonder?

(and sometimes # is followed by a tab)

I don't think it's worth the trouble. The goal is not to document the
format precisely, but to explain the user how to use the variable.

> Also I envision that we would extend core.commentchar to be more
> than a single character.  Is "displayCommentChar" still a good name
> for this setting?

It is as good as core.commentChar ;-).

I chose the variable name to remind commentChar (after finding
commentChar, one can grep it and find status.displayCommentChar). I tend
to think that it's better than omitCommentPrefix, but I can change is
people think it's better.

> What are our plans to help existing scripts people have written over
> time, especially before "status -s" was invented, that will be
> broken by use of this?

I don't know what's the best plan, but I think any sensible plan starts
by waiting for a few releases, so that Git version not implementing
status.displayCommentChar become rare enough. So we can delay the actual
plan until next year I guess.

That said, I had an idea that may help the transition: allow "auto" as a
value, just like we did for colors. A patch implementing this (on top of
the previous series) is below. Good point: "auto" is a safe value, as it
won't break scripts. There is one drawback, though: "auto" is not a
really good default value in the long run, since newcommers may wonder
why there are differences between "git status" and "git status | cat".

I still find this tempting, and it would make the transition so much
easier. I would even argue to flip the default to "auto" for Git 2.0
then (after all, we didn't even wait for this to change color.ui).

Maybe, later, a transition from "auto" to "never" could be done. Or
perhaps it's not so terrible to keep auto (my "ls" and "ls | cat"
produce very different outputs, and it never bugged me).

diff --git a/builtin/commit.c b/builtin/commit.c
index d4cfced..00e9487 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -163,6 +163,21 @@ static void determine_whence(struct wt_status *s)
 		s->whence = whence;
 }
 
+static void determine_comment_mode(struct wt_status *s)
+{
+	if (s->display_comment_char == COMMENT_AUTO) {
+		/*
+		 * determine_comment_mode is used only for cmd_status,
+		 * which always prints to stdout.
+		 */
+		if (isatty(1) || pager_in_use()) {
+			s->display_comment_char = COMMENT_NEVER;
+		} else {
+			s->display_comment_char = COMMENT_ALWAYS;
+		}
+	}
+}
+
 static void rollback_index_files(void)
 {
 	switch (commit_style) {
@@ -1183,6 +1198,20 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "status.displaycommentchar")) {
+		if (v) {
+			if (!strcasecmp(v, "never")) {
+				s->display_comment_char = COMMENT_NEVER;
+				return 0;
+			}
+			if (!strcasecmp(v, "always")) {
+				s->display_comment_char = COMMENT_ALWAYS;
+				return 0;
+			}
+			if (!strcasecmp(v, "auto")) {
+				s->display_comment_char = COMMENT_AUTO;
+				return 0;
+			}
+		}
 		s->display_comment_char = git_config_bool(k, v);
 		return 0;
 	}
@@ -1254,6 +1283,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(git_status_config, &s);
 	determine_whence(&s);
+	determine_comment_mode(&s);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
@@ -1504,7 +1534,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	 * Ignore status.displayCommentChar: we do need comments in
 	 * COMMIT_EDITMSG.
 	 */
-	s.display_comment_char = 1;
+	s.display_comment_char = COMMENT_ALWAYS;
 	determine_whence(&s);
 	s.colopts = 0;
 
diff --git a/wt-status.h b/wt-status.h
index ac02c64..dbc706e 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -40,6 +40,12 @@ struct wt_status_change_data {
 	unsigned new_submodule_commits : 1;
 };
 
+enum comment_mode {
+	COMMENT_NEVER = 0,
+	COMMENT_ALWAYS = 1,
+	COMMENT_AUTO
+};
+
 struct wt_status {
 	int is_initial;
 	char *branch;
@@ -50,7 +56,7 @@ struct wt_status {
 	enum commit_whence whence;
 	int nowarn;
 	int use_color;
-	int display_comment_char;
+	enum comment_mode display_comment_char;
 	int relative_paths;
 	int submodule_summary;
 	int show_ignored_files;

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
