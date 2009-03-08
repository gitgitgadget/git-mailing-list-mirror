From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Extend pattern refspecs
Date: Sun, 08 Mar 2009 00:31:13 -0800
Message-ID: <7vocwcl8ku.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903052346270.19665@iabervon.org>
 <76718490903052119y4d6a7e0ck24bfeb1c0964e413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 09:32:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgERH-0000tk-Ff
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 09:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbZCHIbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 04:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbZCHIbX
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 04:31:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZCHIbV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 04:31:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C4ECE9F3B9;
	Sun,  8 Mar 2009 04:31:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6BD459F3B8; Sun,
  8 Mar 2009 04:31:15 -0400 (EDT)
In-Reply-To: <76718490903052119y4d6a7e0ck24bfeb1c0964e413@mail.gmail.com>
 (Jay Soffian's message of "Fri, 6 Mar 2009 00:19:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7FC06798-0BBB-11DE-B50C-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112613>

Jay Soffian <jaysoffian@gmail.com> writes:

> This series and js/remote-improvements (e5dcbfd) in pu may not get
> along completely. "git remote show" tries to show how the refspecs
> expand out.

I've created an "early semantic conflict resolution" topic branch that is
a cross between this series and js/remote-improvements, like so:

    $ git checkout -b xx/db-refspec-vs-js-remote db/refspec-wildcard-in-the-middle
    $ git merge js/remote-improvements
    $ git apply evil-fixup.diff
    $ git commit --amend -a -m "Evil merge."

with the following "fixup-as-an-evil-merge patch", which I'd appreciate if
you two can sanity check.

The result will be queued at the tip of 'pu', and hopefully I can merge it
to 'next' when this series goes to 'next'.  Similarly, whichever one goes
first to 'master' can be merged straight, but the merge of the other one
needs to merge this branch as well.

diff --git a/builtin-remote.c b/builtin-remote.c
index 7e82a52..3e4a41b 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -359,14 +358,9 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 	}
 	for (i = 0; i < remote->push_refspec_nr; i++) {
 		struct refspec *spec = remote->push + i;
-		char buf[PATH_MAX];
 		if (spec->matching)
 			item = string_list_append("(matching)", &states->push);
-		else if (spec->pattern) {
-			snprintf(buf, (sizeof(buf)), "%s*", spec->src);
-			item = string_list_append(buf, &states->push);
-			snprintf(buf, (sizeof(buf)), "%s*", spec->dst);
-		} else if (strlen(spec->src))
+		else if (strlen(spec->src))
 			item = string_list_append(spec->src, &states->push);
 		else
 			item = string_list_append("(delete)", &states->push);
@@ -374,10 +368,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 		info = item->util = xcalloc(sizeof(struct push_info), 1);
 		info->forced = spec->force;
 		info->status = PUSH_STATUS_NOTQUERIED;
-		if (spec->pattern)
-			info->dest = xstrdup(buf);
-		else
-			info->dest = xstrdup(spec->dst ? spec->dst : item->string);
+		info->dest = xstrdup(spec->dst ? spec->dst : item->string);
 	}
 	return 0;
 }
@@ -390,7 +381,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 
 	refspec.force = 0;
 	refspec.pattern = 1;
-	refspec.src = refspec.dst = "refs/heads/";
+	refspec.src = refspec.dst = "refs/heads/*";
 	states->heads.strdup_strings = 1;
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
