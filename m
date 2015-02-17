From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/push.c: make push_default a static variable
Date: Tue, 17 Feb 2015 14:16:30 -0800
Message-ID: <xmqqzj8cyyip.fsf@gitster.dls.corp.google.com>
References: <20150216054550.GA24611@peff.net>
	<20150216054754.GB25088@peff.net> <20150217104628.GA25978@peff.net>
	<xmqqsie4300s.fsf@gitster.dls.corp.google.com>
	<20150217182324.GA12816@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 23:16:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNqRb-00024a-37
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 23:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbbBQWQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 17:16:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752044AbbBQWQd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 17:16:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F25123861A;
	Tue, 17 Feb 2015 17:16:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ByFa9Krb1nk5jVjY+qWU9CaVe7U=; b=DzN2zcBiPpZyDYgl4v9G
	HrA8IDkleTpH5KgVQICxIyyBYvuYKwWkdZt1mnpCQPOTFfCUrUtOX6QliHrdRmiO
	/JrLOOG0JUpy5SwhqC4s5q19dDVVKAZ/juIS6wSkNTNsnHOzTwunm5Il+7Vrj13b
	EeZsanVIn3yQAc9HhmsB1Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=yMbu2vT4gjT3DVtXErSlBvxJUxL32P8TlcWnehfMPGvHHB
	qMtg79PsdZ57xklDd8DswbkBTuEmTluskjwch94UWhhpEsiOCS1+9AXfw76OG/1l
	39c+VSuHHIhD/i/Uf1ChLScIbs9XTnfuiDXmP5B8vP+6wL6bki8yRLaQ1VND8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E93C238619;
	Tue, 17 Feb 2015 17:16:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BC2038618;
	Tue, 17 Feb 2015 17:16:32 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0B5CD10-B6F2-11E4-BC14-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263991>

Jeff King <peff@peff.net> writes:

>> So we probably would do something similar to @{push} side, which
>> would mean that push_default variable and the logic needs to be
>> visible to remote.c if we want to have the helper that is similar to
>> set_merge() that is used from branch_get() to support @{upstream}.
>
> Sure, we could go that way. But I don't think it changes the issue for
> _this_ patch series, which is that the variable needs visibility outside
> of builtin/push.c (and we need to load the config for programs besides
> git-push).

I do not disagree.  push_default and other things that affect the
computation needs to be visible to the code that implements the
logic.

Do you want to resurrect that @{publish} stuff?  I think it had
sensible semantics, and I do not think we mind keeping the
push_default configuration to be read from the default_config
codepath.

If we decide to go that route, then the series would become
something like this:

$gmane/263871 [1/4] git_push_config: drop cargo-culted wt_status pointer
$gmane/263878 [2/4] cmd_push: set "atomic" bit directly
$gmane/263879 [3/4] cmd_push: pass "flags" pointer to config callback
$gmane/263880 [4/4] push: allow --follow-tags to be set by config push.followTags

omitting the original 2/2 patch we are discussing.  I am inclined to
replace what I queued with the above four.

The last one needs a bit of tweaking and should look like the
attached.  Again, as you wrote in $gmane/263880, this is just a
preview. Dave should send the final when he thinks it is good,
possibly with some tests.

-- >8 --
From: Dave Olszewski <cxreg@pobox.com>
Date: Mon, 16 Feb 2015 01:16:19 -0500
Subject: [PATCH] [NEEDSACK] push: allow --follow-tags to be set by config push.followTags

Signed-off-by: Dave Olszewski <cxreg@pobox.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt               |  6 ++++++
 Documentation/git-push.txt             |  5 ++++-
 builtin/push.c                         | 10 ++++++++++
 contrib/completion/git-completion.bash |  1 +
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ae6791d..e01d21c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2079,6 +2079,12 @@ new default).
 
 --
 
+push.followTags::
+	If set to true enable '--follow-tags' option by default.  You
+	may override this configuration at time of push by specifying
+	'--no-follow-tags'.
+
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index ea97576..caa187b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -128,7 +128,10 @@ already exists on the remote side.
 	Push all the refs that would be pushed without this option,
 	and also push annotated tags in `refs/tags` that are missing
 	from the remote but are pointing at commit-ish that are
-	reachable from the refs being pushed.
+	reachable from the refs being pushed.  This can also be specified
+	with configuration variable 'push.followTags'.  For more
+	information, see 'push.followTags' in linkgit:git-config[1].
+
 
 --signed::
 	GPG-sign the push request to update refs on the receiving
diff --git a/builtin/push.c b/builtin/push.c
index bba22b8..57c138b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -473,11 +473,21 @@ static int option_parse_recurse_submodules(const struct option *opt,
 
 static int git_push_config(const char *k, const char *v, void *cb)
 {
+	int *flags = cb;
 	int status;
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
 		return status;
+
+	if (!strcmp(k, "push.followtags")) {
+		if (git_config_bool(k, v))
+			*flags |= TRANSPORT_PUSH_FOLLOW_TAGS;
+		else
+			*flags &= ~TRANSPORT_PUSH_FOLLOW_TAGS;
+		return 0;
+	}
+
 	return git_default_config(k, v, NULL);
 }
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21190d..cffb2b8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2188,6 +2188,7 @@ _git_config ()
 		pull.octopus
 		pull.twohead
 		push.default
+		push.followTags
 		rebase.autosquash
 		rebase.stat
 		receive.autogc
-- 
2.3.0-283-g21bf3f5
