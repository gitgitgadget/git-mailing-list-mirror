From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] allowing hooks to ignore input?
Date: Tue, 16 Sep 2014 15:27:12 -0700
Message-ID: <xmqq7g1319rz.fsf@gitster.dls.corp.google.com>
References: <xmqqzje48nh4.fsf@gitster.dls.corp.google.com>
	<5413FE06.1020901@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 00:27:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU1DV-00024U-Kd
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 00:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbaIPW1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 18:27:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61621 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367AbaIPW1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 18:27:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 86FAA3A5BF;
	Tue, 16 Sep 2014 18:27:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=47d/pF8DOCP6BtpgBLFeuBq8iUI=; b=sF7BKp
	3JSnPVo2WfvlAKEPxKaezYygRHoRWRnTvf7cNMlir3w0WeqOkOa94LcXTbQv7xM7
	7NDlnwR8fvTdwKqaRu+XKN27hL43XuqoT0gBmIQuE4cCJF6UwWU31mpaFTWDObh6
	q1WNrE1nqS8p3CtBsDWv5U2x6i/SnnVACr8aA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mHp7PP8u21qXUZbkJ7IYDfDlHjJ+mqWZ
	GI6lt3vjb4Xp/KQkVuffSZOBDVqGSQJQZfm3K8mt1i5lHb93fMv1YIn6FNWVMth8
	s4aB3zo2mmdyL4Li3clMlgPnctZ08MxqySfjnplEIIK+tDB/ls//G/3s8Dvutwf8
	xXt3pa8hrJU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 75F593A5BE;
	Tue, 16 Sep 2014 18:27:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C47203A5BD;
	Tue, 16 Sep 2014 18:27:14 -0400 (EDT)
In-Reply-To: <5413FE06.1020901@kdbg.org> (Johannes Sixt's message of "Sat, 13
	Sep 2014 10:19:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9C16EE22-3DF0-11E4-8C07-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257206>

Johannes Sixt <j6t@kdbg.org> writes:

> I think this is a good move. Hooks are written by users, who sometimes
> are not clueful enough.

Thanks for a sanity check.  I do not think it is about cluefulness
in this particular case.  A rule that is not meaningfully enforced
by reliably failing offenders is a rule that is hard to follow if a
clueful user wanted to.

This round comes with a test, but depending on the size of your pipe
buffer and context switching race, an unpatched Git may pass it
(reducing the test_seq number down to say 199 would certainly make
it pass without the fix most of the time).

-- >8 --
Subject: [PATCH] receive-pack: allow hooks to ignore its standard input stream

The pre-receive and post-receive hooks were designed to be an
improvement over old style update and post-update hooks, which take
the update information on their command line and are limited by the
command line length limit.  The same information is fed from the
standard input to pre/post-receive hooks instead to lift this
limitation.  It has been mandatory for these new style hooks to
consume the update information fully from the standard input stream.
Otherwise, they would risk killing the receive-pack process via
SIGPIPE.

If a hook does not want to look at all the information, it is easy
to send its standard input to /dev/null (perhaps a niche use of hook
might need to know only the fact that a push was made, without
having to know what objects have been pushed to update which refs),
and this has already been done by existing hooks that are written
carefully.

However, because there is no good way to consistently fail hooks
that do not consume the input fully (a small push may result in a
short update record that may fit within the pipe buffer, to which
the receive-pack process may manage to write before the hook has a
chance to exit without reading anything, which will not result in a
death-by-SIGPIPE of receive-pack), it can lead to a hard to diagnose
"once in a blue moon" phantom failure.

Lift this "hooks must consume their input fully" mandate.  A mandate
that is not enforced strictly is not helping us to catch mistakes in
hooks.  If a hook has a good reason to decide the outcome of its
operation without reading the information we feed it, let it do so
as it pleases.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c  |  6 ++++++
 t/t5401-update-hooks.sh | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f93ac45..516386f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -15,6 +15,7 @@
 #include "connected.h"
 #include "argv-array.h"
 #include "version.h"
+#include "sigchain.h"
 
 static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
@@ -288,6 +289,8 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 		return code;
 	}
 
+	sigchain_push(SIGPIPE, SIG_IGN);
+
 	while (1) {
 		const char *buf;
 		size_t n;
@@ -299,6 +302,9 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 	close(proc.in);
 	if (use_sideband)
 		finish_async(&muxer);
+
+	sigchain_pop(SIGPIPE);
+
 	return finish_command(&proc);
 }
 
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 17bcb0b..7f278d8 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -135,4 +135,17 @@ test_expect_success 'send-pack stderr contains hook messages' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pre-receive hook that forgets to read its input' '
+	write_script victim.git/hooks/pre-receive <<-\EOF &&
+	exit 0
+	EOF
+	rm -f victim.git/hooks/update victim.git/hooks/post-update &&
+
+	for v in $(test_seq 100 999)
+	do
+		git branch branch_$v master || return
+	done &&
+	git push ./victim.git "+refs/heads/*:refs/heads/*"
+'
+
 test_done
-- 
2.1.0-403-g099cf47
