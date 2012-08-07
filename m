From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] prune.c: only print informational message in
 show_only or verbose mode
Date: Mon, 06 Aug 2012 22:34:23 -0700
Message-ID: <7vpq73w9i8.fsf@alter.siamese.dyndns.org>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
 <1344315709-15897-1-git-send-email-drafnel@gmail.com>
 <1344315709-15897-2-git-send-email-drafnel@gmail.com>
 <7vtxwfw9rp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 07:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SycR6-0004nj-4c
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 07:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785Ab2HGFe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 01:34:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718Ab2HGFe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 01:34:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 178189888;
	Tue,  7 Aug 2012 01:34:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RZwcc5ah/dO27TWCpEdXWmske1I=; b=qTJMoN
	SmiiLjNzMAkl5/yc7XIvz5rZUuFKZoEPBkbEX6nmWBaQwXlr5q8Ozx6AMP1eHkOz
	xo8kf2JxWKbBAkQbb5xf+yd2qcKEqylxFEN7b7IKIfLmqyzgP4XgeCD4+4mZhZxx
	0EU9tNCQncFO7JdD4hU/nGqAJOjYpCoWv1lyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=my9IgIs3ADAmI+M+9e18dFDXt5o+kYCa
	2K0d6dNQxsdPLYBzMI6s1fk/CKdiKgbcOJLidbw8OMPqJb/7OTx9Si9jVjqZ9oxq
	eiuLW4mBeE4tRxCQjE6H0tOvj1qy1H540pROGieYdQM4g3y9HcKPDvzAdVasUOx9
	zdXcPt/GTtY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 052949887;
	Tue,  7 Aug 2012 01:34:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58C129886; Tue,  7 Aug 2012
 01:34:25 -0400 (EDT)
In-Reply-To: <7vtxwfw9rp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 06 Aug 2012 22:28:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C9A3462-E051-11E1-9BBC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203016>

Junio C Hamano <gitster@pobox.com> writes:

> Note that this chooses to expose what comes out of the standard
> output of the subprocess to the standard error to be shown to the
> user sitting on the other end.  This is in line with what we do to
> all of our hooks (Cf. cd83c74 (Redirect update hook stdout to
> stderr., 2006-12-30)).

Ok, now a tested patch, on top of your 1/2

-- >8 --
Subject: [PATCH] receive-pack: do not leak output from auto-gc to standard output

The standard output channel of receive-pack is a structured protocol
channel, and subprocesses must never be allowed to leak anything
into it by writing to their standard output.

Use RUN_COMMAND_STDOUT_TO_STDERR option to run_command_v_opt() just
like we do when running hooks to prevent output from "gc" leaking to
the standard output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 3 ++-
 t/t5400-send-pack.sh   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0afb8b2..3f05d97 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -977,7 +977,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			const char *argv_gc_auto[] = {
 				"gc", "--auto", "--quiet", NULL,
 			};
-			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+			int opt = RUN_GIT_CMD | RUN_COMMAND_STDOUT_TO_STDERR;
+			run_command_v_opt(argv_gc_auto, opt);
 		}
 		if (auto_update_server_info)
 			update_server_info(0);
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 04a8791..250c720 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -145,7 +145,7 @@ test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	)
 '
 
-test_expect_failure 'receive-pack runs auto-gc in remote repo' '
+test_expect_success 'receive-pack runs auto-gc in remote repo' '
 	rm -rf parent child &&
 	git init parent &&
 	(
-- 
1.7.12.rc1.93.g8914ab8
