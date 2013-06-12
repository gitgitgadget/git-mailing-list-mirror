From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Refactor useful notes functions into notes-utils.[ch]
Date: Wed, 12 Jun 2013 13:02:36 -0700
Message-ID: <7vzjuv14ir.fsf@alter.siamese.dyndns.org>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	artagnon@gmail.com, john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	felipe.contreras@gmail.com, torvalds@linux-foundation.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 12 22:02:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmrFk-0006NH-Um
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 22:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab3FLUCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 16:02:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab3FLUCj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 16:02:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED88927958;
	Wed, 12 Jun 2013 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=D/DDJkDwnBf6qeRbn9cVVus0k44=; b=eLNpGG+wCPqIqWzyNzZE
	LagWM1VDuLM85WuxYaqW60umhVU26tqVsGd+5cL/menG/UGp2Maw5OVI4S9EpqyR
	5uAm22s29YQFl++WomGcx9R5HEQvrzAoRAdrnYLCkPunxNQksKeQGh1BAc6eL8BZ
	M04Cc+qUP76x0R1ILy1WT08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MTol50/FqtIydGwapOPHsb2YiSlqfoqs2p4TH5VIi++1jW
	wHTs6AFyXvz6laNO7FwRL5z5kBTsNZ1z1e7aIOg7KEMKk5vH7sdvDqHsox/Ih1k4
	WiudN268ihZ6FGtJjAbzjsLdXd76myqSvxoQDfawEUjX4kg0toQpoDNzbuHLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E19BF27957;
	Wed, 12 Jun 2013 20:02:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3263727956;
	Wed, 12 Jun 2013 20:02:38 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 080CB722-D39B-11E2-B3CD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227672>

Johan Herland <johan@herland.net> writes:

>> There is only one right solution.  If a useful function is buried in
>> builtin/*.o as a historical accident (i.e. it started its life as a
>> helper for that particular command, and nobody else used it from
>> outside so far) and that makes it impossible to use the function
>> from outside builtin/*.o, refactor the function and its callers and
>> move it to libgit.a.
>
> Here goes...
>
> ...Johan

With these three patches, if you apply the following skeleton patch
(lifted from $gmane/226851 and adjusted minimally to the change
these patches introduce), we can see that the link breakage Felipe
observed in the message:

    Felipe Contreras <felipe.contreras@gmail.com> writes in $gmane/226851:
    > What happens?
    > 
    > libgit.a(sequencer.o): In function `copy_notes':
    > /home/felipec/dev/git/sequencer.c:110: undefined reference to
    > `init_copy_notes_for_rewrite'
    > /home/felipec/dev/git/sequencer.c:114: undefined reference to
    > `finish_copy_notes_for_rewrite'

is gone.

    > It is not the first time, nor the last that top-level code needs
    > builtin code, and the solution is easy; organize the code.

And as I already said, the above is correct.  The problem and the
general approach to solve it correctly were identified in the
message.

But what followed was a nonsense, which ended up wastign everybody's
time:

> ... Alas, this
> simple solution reject on the basis that we shouldn't organize the
> code, because the code is not meant to be organized.

The proposed patch was rejected on the basis that it was organized
the code in a wrong way.  And your patch shows how it should be
done.

Thanks for doing it right.

-- skeleton patch --

 sequencer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index ab6f8a7..4281466 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -14,6 +14,7 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "notes-utils.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -979,6 +980,17 @@ static void save_opts(struct replay_opts *opts)
 	}
 }
 
+static void copy_notes(const char *name, const char *msg)
+{
+       struct notes_rewrite_cfg *cfg;
+
+       cfg = init_copy_notes_for_rewrite(name);
+       if (!cfg)
+               return;
+
+       finish_copy_notes_for_rewrite(cfg, msg);
+}
+
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 {
 	struct commit_list *cur;
@@ -997,6 +1009,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 			return res;
 	}
 
+	copy_notes("cherry-pick", "notes copied by cherry-pick");
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
