From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch refspec foo/* matches foo*
Date: Sat, 26 Jul 2008 17:18:33 -0700
Message-ID: <7vvdysb2na.fsf@gitster.siamese.dyndns.org>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com>
 <1216858043-53646-1-git-send-email-lee.marlow@gmail.com>
 <20080725204051.GB23202@spearce.org>
 <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org>
 <20080726082405.GA10104@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 27 02:26:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMu5K-0003dU-P7
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 02:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbYG0ASp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 20:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbYG0ASp
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 20:18:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbYG0ASo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 20:18:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B5AC044788;
	Sat, 26 Jul 2008 20:18:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B01E944786; Sat, 26 Jul 2008 20:18:35 -0400 (EDT)
In-Reply-To: <20080726082405.GA10104@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 26 Jul 2008 04:24:05 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 900ED3DC-5B71-11DD-B121-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90295>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 25, 2008 at 02:02:15PM -0700, Junio C Hamano wrote:
>
>> BTW, has anybody taken a look at this one?
>> 
>>   Subject: BUG: fetch incorrect interpretation of globing patterns in refspecs
>>   Date: Thu, 24 Jul 2008 09:07:21 +0200
>>   Message-ID: <71295b5a0807240007k246973abj1897895d0d67bb6c@mail.gmail.com>
>> 
>> If not, I think I probably need to take a look at this, reproducing and
>> possibly fixing, before applying non-fix patches.
>
> I have been meaning to look at it for days, so I finally took a peek.  I
> was able to reproduce the problem easily. I think it is (almost) as
> simple as the patch below. In the refspec parsing, we already require
> globs to come after '/', so this is the analagous check during match.
>
> Unfortunately, this breaks t1020 (something about failing to clone HEAD

Your patch expects that the parsed refspec->{src,dst} omit the terminating
slash, which is in line with what parse_refspec_internal() in remote.c
does.  The problem is that builtin-clone.c uses a refspec that is
incompatible from that assumption.  The static "tag_refspec" variable
defined in remote.c has the same problem.  These two have trailing slash
e.g. "refs/heads/", "refs/tags/", that should be dropped for your updated
check to work.

The attached patch, that includes your one-liner change, makes all tests
pass.

I have a nagging suspicion that it might be a simpler and cleaner change
to change parse_refspec_internal() to keep the trailing slash, instead of
dropping it.  Then the check you added is not needed (the trailing slash
guarantees that the pattern matches at the hierarchy boundary), neither
any of the change in this patch.

---
 builtin-clone.c        |    9 +++++----
 remote.c               |    7 ++++---
 t/t5513-fetch-track.sh |   30 ++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index e086a40..022ffb9 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -440,12 +440,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	if (option_bare) {
-		strcpy(branch_top, "refs/heads/");
+		strcpy(branch_top, "refs/heads");
 
 		git_config_set("core.bare", "true");
 	} else {
 		snprintf(branch_top, sizeof(branch_top),
-			 "refs/remotes/%s/", option_origin);
+			 "refs/remotes/%s", option_origin);
 
 		/* Configure the remote */
 		snprintf(key, sizeof(key), "remote.%s.url", option_origin);
@@ -453,13 +453,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		snprintf(key, sizeof(key), "remote.%s.fetch", option_origin);
 		snprintf(value, sizeof(value),
-				"+refs/heads/*:%s*", branch_top);
+				"+refs/heads/*:%s/*", branch_top);
 		git_config_set_multivar(key, value, "^$", 0);
 	}
 
 	refspec.force = 0;
 	refspec.pattern = 1;
-	refspec.src = "refs/heads/";
+	refspec.src = "refs/heads";
 	refspec.dst = branch_top;
 
 	if (path && !is_bundle)
@@ -514,6 +514,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 			strbuf_init(&head_ref, 0);
 			strbuf_addstr(&head_ref, branch_top);
+			strbuf_addch(&head_ref, '/');
 			strbuf_addstr(&head_ref, "HEAD");
 
 			/* Remote branch link */
diff --git a/remote.c b/remote.c
index 0d6020b..6b313fb 100644
--- a/remote.c
+++ b/remote.c
@@ -9,8 +9,8 @@ static struct refspec s_tag_refspec = {
 	0,
 	1,
 	0,
-	"refs/tags/",
-	"refs/tags/"
+	"refs/tags",
+	"refs/tags"
 };
 
 const struct refspec *tag_refspec = &s_tag_refspec;
@@ -1108,7 +1108,8 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
-		if (!prefixcmp(ref->name, refspec->src)) {
+		if (!prefixcmp(ref->name, refspec->src) &&
+		    ref->name[remote_prefix_len] == '/') {
 			const char *match;
 			struct ref *cpy = copy_ref(ref);
 			match = ref->name + remote_prefix_len;
diff --git a/t/t5513-fetch-track.sh b/t/t5513-fetch-track.sh
new file mode 100755
index 0000000..9e74862
--- /dev/null
+++ b/t/t5513-fetch-track.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='fetch follows remote tracking branches correctly'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	>file &&
+	git add . &&
+	test_tick &&
+	git commit -m Initial &&
+	git branch b-0 &&
+	git branch b1 &&
+	git branch b/one &&
+	test_create_repo other &&
+	(
+		cd other &&
+		git config remote.origin.url .. &&
+		git config remote.origin.fetch "+refs/heads/b/*:refs/remotes/b/*"
+	)
+'
+
+test_expect_success fetch '
+	(
+		cd other && git fetch origin &&
+		test "$(git for-each-ref --format="%(refname)")" = refs/remotes/b/one
+	)
+'
+
+test_done
