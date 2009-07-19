From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Sat, 18 Jul 2009 17:19:34 -0700
Message-ID: <7vskgt1q3t.fsf@alter.siamese.dyndns.org>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
 <20090719080558.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Finn Arne Gangstad <finnag@pvv.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 02:19:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSK88-0001lt-27
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 02:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbZGSATp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 20:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbZGSATo
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 20:19:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbZGSATn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 20:19:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 56CDD32BF;
	Sat, 18 Jul 2009 20:19:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6A31332BD; Sat, 18 Jul 2009
 20:19:36 -0400 (EDT)
In-Reply-To: <20090719080558.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sun\, 19 Jul 2009 08\:05\:58 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DB6F21B4-73F9-11DE-BE9D-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123543>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com> writes:
>
>> When the user does not tell "git push" what to push, it has always
>> pushed matching refs.  For some people it is unexpected, and a new
>> configuration variable push.default has been introduced to allow
>> changing a different default behaviour.  To advertise the new feature,
>> a big warning is issued if this is not configured and a git push without
>> arguments is attempted.
>>
>> 	Side note: we might want to tone this down, as it does not seem
>> 	likely for us to change the default behaviour when this option is
>> 	not set.
>
> I thought you applied this patch from Finn Arne:
>
>     http://article.gmane.org/gmane.comp.version-control.git/119173
>
> but apparently you didn't.

I wrote that side note after googling around and found that many users
outside git community wondering what a strange way to announce a new
feature it was, and I think they are right.  I stupidly said that we
should tone the message neutral, because we might want to change the
default in the future but we are still not committed.  But the end result
is just a confusing advertisement of an optional feature.

I actually think that the right course of action at this point is this
patch instead.  We keep the default, we do not annoy the users, and people
who want to use a non-default configuration can use the feature.

-- >8 --
Subject: do not give big warning when push preference is unconfigured

If the message said "we will be changing the default in the future, so
this is to warn people who want to keep the current default what to do",
it would have made some sense, but as it stands, the message is merely an
unsolicited advertisement for a new feature which it is not helpful at
all.  Squelch it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-push.c |   27 +--------------------------
 cache.h        |    1 -
 environment.c  |    2 +-
 3 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 0a0297f..1d92e22 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -64,36 +64,11 @@ static void setup_push_tracking(void)
 	add_refspec(refspec.buf);
 }
 
-static const char *warn_unconfigured_push_msg[] = {
-	"You did not specify any refspecs to push, and the current remote",
-	"has not configured any push refspecs. The default action in this",
-	"case is to push all matching refspecs, that is, all branches",
-	"that exist both locally and remotely will be updated.  This may",
-	"not necessarily be what you want to happen.",
-	"",
-	"You can specify what action you want to take in this case, and",
-	"avoid seeing this message again, by configuring 'push.default' to:",
-	"  'nothing'  : Do not push anything",
-	"  'matching' : Push all matching branches (default)",
-	"  'tracking' : Push the current branch to whatever it is tracking",
-	"  'current'  : Push the current branch"
-};
-
-static void warn_unconfigured_push(void)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(warn_unconfigured_push_msg); i++)
-		warning("%s", warn_unconfigured_push_msg[i]);
-}
-
 static void setup_default_push_refspecs(void)
 {
 	git_config(git_default_config, NULL);
 	switch (push_default) {
-	case PUSH_DEFAULT_UNSPECIFIED:
-		warn_unconfigured_push();
-		/* fallthrough */
-
+	default:
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
 		break;
diff --git a/cache.h b/cache.h
index f1e5ede..c72f125 100644
--- a/cache.h
+++ b/cache.h
@@ -543,7 +543,6 @@ enum rebase_setup_type {
 };
 
 enum push_default_type {
-	PUSH_DEFAULT_UNSPECIFIED = -1,
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
 	PUSH_DEFAULT_TRACKING,
diff --git a/environment.c b/environment.c
index 801a005..720f26b 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
-enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
+enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
