From: Adam Williamson <awilliam@redhat.com>
Subject: Re: 'simple' push check that branch name matches does not work if push.default is unset (and hence implicitly simple)
Date: Wed, 26 Nov 2014 20:24:04 -0800
Message-ID: <A90836FF-3EF7-48CC-83C0-4DD09D0F022D@redhat.com>
References: <1417040968.12457.78.camel@redhat.com> <20141127034306.GA5341@peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 27 05:25:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtqde-0005JD-Om
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 05:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbaK0EYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 23:24:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41993 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222AbaK0EYR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 23:24:17 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAR4OCqK028951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Nov 2014 23:24:12 -0500
Received: from mail.happyassassin.net (ovpn-113-42.phx2.redhat.com [10.3.113.42])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sAR4OBCP029342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Nov 2014 23:24:12 -0500
User-Agent: K-9 Mail for Android
Authentication-Results: mail.happyassassin.net; dmarc=none header.from=redhat.com
In-Reply-To: <20141127034306.GA5341@peff.net>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260333>

On November 26, 2014 7:43:06 PM PST, Jeff King <peff@peff.net> wrote:
>On Wed, Nov 26, 2014 at 02:29:28PM -0800, Adam Williamson wrote:
>
>> Hi, folks. Ran into an unfortunate issue with git which helped me
>mess
>> up a Fedora package repo today :/
>> 
>> The problem can be reproduced thus:
>> 
>> 1. Create an empty repo, clone it
>> 2. Push its master branch with something in it (just to get started)
>> 3. git branch --track moo origin/master
>> 4. git checkout moo
>> 5. echo moo >> moo && git commit -a -m "create moo"
>> 6. git push
>> ** BUG HAPPENS - CHANGES ARE PUSHED TO origin/master **
>> 7. git config --local push.default simple
>> 8. echo moo2 >> moo && git commit -a -m "update moo"
>> 9. git push
>> ** PUSH IS CORRECTLY REJECTED **
>> 
>> In both those cases, the push behaviour is supposed to be 'simple' -
>at
>> step 6 it's *implicitly* set to 'simple' (according to the
>> documentation), while at step 9 it's *explicitly* set to 'simple'. At
>> step 6, a warning is printed to the console:
>
>Ugh. Yeah, this never worked properly, even in the original v2.0.0
>release. Worse, our tests did not notice it at all.  Patch is below.
>
>
>-- >8 --
>Subject: push: truly use "simple" as default, not "upstream"
>
>The plan for the push.default transition had all along been
>to use the "simple" method rather than "upstream" as a
>default if the user did not specify their own push.default
>value. Commit 11037ee (push: switch default from "matching"
>to "simple", 2013-01-04) tried to implement that by moving
>PUSH_DEFAULT_UNSPECIFIED in our switch statement to
>fall-through to the PUSH_DEFAULT_SIMPLE case.
>
>When the commit that became 11037ee was originally written,
>that would have been enough. We would fall through to
>calling setup_push_upstream() with the "simple" parameter
>set to 1. However, it was delayed for a while until we were
>ready to make the transition in Git 2.0.
>
>And in the meantime, commit ed2b182 (push: change `simple`
>to accommodate triangular workflows, 2013-06-19) threw a
>monkey wrench into the works. That commit drops the "simple"
>parameter to setup_push_upstream, and instead checks whether
>the global "push_default" is PUSH_DEFAULT_SIMPLE. This is
>right when the user has explicitly configured push.default
>to simple, but wrong when we are a fall-through for the
>"unspecified" case.
>
>We never noticed because our push.default tests do not cover
>the case of the variable being totally unset; they only
>check the "simple" behavior itself.
>
>Signed-off-by: Jeff King <peff@peff.net>
>---
>ed2b182 comes from Ram, but the suggestion for this bit of code
>actually
>comes from Junio in:
>
>http://thread.gmane.org/gmane.comp.version-control.git/228383/focus=228436
>
>I am not sure I understand the reason for dropping the "simple"
>parameter in that commit in the first place. If we are in triangular
>mode, then we would not get to setup_push_upstream from "simple" (or
>the
>default) in the first place (we would use "current" instead). The only
>time "triangular" matters to setup_push_upstream is when push.default
>really has been set to "upstream", but in that case, "simple" would
>always be 0 (and likewise, the equality check that replaces it would
>also be false).
>
>So I have a vague concern that I'm missing something. Maybe one of you
>who worked on it can recall more.
>
> builtin/push.c          |  8 ++++----
> t/t5528-push-default.sh | 32 ++++++++++++++++++++++++++++++--
> 2 files changed, 34 insertions(+), 6 deletions(-)
>
>diff --git a/builtin/push.c b/builtin/push.c
>index a076b19..7aedf6f 100644
>--- a/builtin/push.c
>+++ b/builtin/push.c
>@@ -161,7 +161,7 @@ static const char message_detached_head_die[] =
> 	   "    git push %s HEAD:<name-of-remote-branch>\n");
> 
>static void setup_push_upstream(struct remote *remote, struct branch
>*branch,
>-				int triangular)
>+				int triangular, int simple)
> {
> 	struct strbuf refspec = STRBUF_INIT;
> 
>@@ -184,7 +184,7 @@ static void setup_push_upstream(struct remote
>*remote, struct branch *branch,
> 		      "to update which remote branch."),
> 		    remote->name, branch->name);
> 
>-	if (push_default == PUSH_DEFAULT_SIMPLE) {
>+	if (simple) {
> 		/* Additional safety */
> 		if (strcmp(branch->refname, branch->merge[0]->src))
> 			die_push_simple(branch, remote);
>@@ -257,11 +257,11 @@ static void setup_default_push_refspecs(struct
>remote *remote)
> 		if (triangular)
> 			setup_push_current(remote, branch);
> 		else
>-			setup_push_upstream(remote, branch, triangular);
>+			setup_push_upstream(remote, branch, triangular, 1);
> 		break;
> 
> 	case PUSH_DEFAULT_UPSTREAM:
>-		setup_push_upstream(remote, branch, triangular);
>+		setup_push_upstream(remote, branch, triangular, 0);
> 		break;
> 
> 	case PUSH_DEFAULT_CURRENT:
>diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
>index 6a5ac3a..cc74519 100755
>--- a/t/t5528-push-default.sh
>+++ b/t/t5528-push-default.sh
>@@ -26,7 +26,7 @@ check_pushed_commit () {
> # $2 = expected target branch for the push
> # $3 = [optional] repo to check for actual output (repo1 by default)
> test_push_success () {
>-	git -c push.default="$1" push &&
>+	git ${1:+-c push.default="$1"} push &&
> 	check_pushed_commit HEAD "$2" "$3"
> }
> 
>@@ -34,7 +34,7 @@ test_push_success () {
> # check that push fails and does not modify any remote branch
> test_push_failure () {
> 	git --git-dir=repo1 log --no-walk --format='%h %s' --all >expect &&
>-	test_must_fail git -c push.default="$1" push &&
>+	test_must_fail git ${1:+-c push.default="$1"} push &&
> 	git --git-dir=repo1 log --no-walk --format='%h %s' --all >actual &&
> 	test_cmp expect actual
> }
>@@ -172,4 +172,32 @@ test_pushdefault_workflow success simple master
>triangular
> # master is updated (parent2 does not have foo)
> test_pushdefault_workflow success matching master triangular
> 
>+# default tests, when no push-default is specified. This
>+# should behave the same as "simple" in non-triangular
>+# settings, and as "current" otherwise.
>+
>+test_expect_success 'default behavior allows "simple" push' '
>+	test_config branch.master.remote parent1 &&
>+	test_config branch.master.merge refs/heads/master &&
>+	test_config remote.pushdefault parent1 &&
>+	test_commit default-master-master &&
>+	test_push_success "" master
>+'
>+
>+test_expect_success 'default behavior rejects non-simple push' '
>+	test_config branch.master.remote parent1 &&
>+	test_config branch.master.merge refs/heads/foo &&
>+	test_config remote.pushdefault parent1 &&
>+	test_commit default-master-foo &&
>+	test_push_failure ""
>+'
>+
>+test_expect_success 'default triangular behavior acts like "current"'
>'
>+	test_config branch.master.remote parent1 &&
>+	test_config branch.master.merge refs/heads/foo &&
>+	test_config remote.pushdefault parent2 &&
>+	test_commit default-triangular &&
>+	test_push_success "" master repo2
>+'
>+
> test_done

Yeah, I've gone down pretty much exactly the same avenues of investigation, but had to suspend it to go out to dinner. I wanted to try and completely grok the whole history of this particular bit of behavior before suggesting a patch. So far my guess is that junio just got a bit mixed up with working on top of ram's changes and didn't catch that the check wouldn't work in the implicit case, but I wanted to look into it a bit more.
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin DOT net
http://www.happyassassin.net
