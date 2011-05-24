From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Allow built-ins to also use -c var=val via alias
Date: Tue, 24 May 2011 14:18:18 -0700
Message-ID: <7vmxib7q79.fsf@alter.siamese.dyndns.org>
References: <7vsjs37qcp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 23:18:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOyzo-0008D6-Lv
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 23:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536Ab1EXVS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 17:18:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251Ab1EXVS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 17:18:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5FD555E4D;
	Tue, 24 May 2011 17:20:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8x2ADpNgPwsFUC9/OqmLH34Nc50=; b=GPItsx
	Y3phYpRDcILSEsU6s0gJr2aMiF1PJrpoytzjY5i9p54PE/NJ4rgQD2PSObdUib1B
	+ZDd4Kc2AvgaNnufiGdOz0QXOoXjbJs3jEvp/v3hAu8kPHFV+FgXldaeB8YgcrDa
	+kSctmz8rF6JaeBhu1dMacIOOCTHksc3RBa50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gNbZXnLVtfHh0o/UTX72iHNNo2OEviBD
	FgExP9FCrpGdiDiDmRamHyHvsb7cMFbt2UnT2e2Q5QozyNN10eBd2WsoQowJvo+e
	4685zleq9UlOhTLrhBIF1AiJ6xm3Vri0hogR1cP4iCcb9YjWjqGn4LFhW7IBE4L1
	As34gsnMEKQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D8DA5E4C;
	Tue, 24 May 2011 17:20:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 314985E4A; Tue, 24 May 2011
 17:20:27 -0400 (EDT)
In-Reply-To: <7vsjs37qcp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 24 May 2011 14:15:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A77C3ED0-864B-11E0-B55A-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174344>

The previous commit 2b64fc8 (pass "git -c foo=bar" params through
environment, 2010-08-23) tried to make all the one-shot configuration
setting made via the "-c" option to the "git" wrapper go through an
environment variable, so that the value can be propagated to external
commands _as well as_ the internal ones, but ended up breaking one of the
codepaths that invokes internal commands, because it incorrectly assumed
that git_config_from_parmeters() can never be called in a single process
after git_config_parse_environment() was called once.

Not so.

When the options came as part of an alias to an internal command, e.g.

  [alias]
    aw = -c apply.whitespace=fix apply

and then run as "git aw P.diff", we have already read the configuration to
find out about the alias definition (setting loaded_environment to true),
then pushed apply.whitespace=fix to the environment, but not to the
in-core list of configuration variables. The implementation of the
internal command, e.g. cmd_apply(), will try to read from git_config() but
the setting is lost, as the environment is never read in this codepath.

Add the in-core queuing of the parameters back to fix this.

Note that the handling of such an alias is still broken for another reason
in this codepath; a separate patch fixes it.

While at it, avoid getting our test confused by GIT_CONFIG_PARAMETERS
exported to the tester's environment.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is the other fix. Applying this on top of 2b64fc8 does not
   make "git aw P.diff" in the test t1300 in the other patch, but this
   is prerequisite for the other fix to work in a more modern codebase.

 config.c      |    1 +
 t/test-lib.sh |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/config.c b/config.c
index c2c995f..c803ae8 100644
--- a/config.c
+++ b/config.c
@@ -43,6 +43,7 @@ void git_config_push_parameter(const char *text)
 		strbuf_addstr(&env, old);
 		strbuf_addch(&env, ' ');
 	}
+	git_config_parse_parameter(text);
 	sq_quote_buf(&env, text);
 	setenv(CONFIG_DATA_ENVIRONMENT, env.buf, 1);
 	strbuf_release(&env);
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e5523dd..0b1358e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -57,6 +57,7 @@ GIT_AUTHOR_NAME='A U Thor'
 unset GIT_COMMITTER_DATE
 GIT_COMMITTER_EMAIL=committer@example.com
 GIT_COMMITTER_NAME='C O Mitter'
+unset GIT_CONFIG_PARAMETERS
 unset GIT_DIFF_OPTS
 unset GIT_DIR
 unset GIT_WORK_TREE
-- 
1.7.5.2.459.g67e41
