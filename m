From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge <tag>: Spawning an editor can't be disabled
Date: Thu, 09 Feb 2012 13:20:56 -0800
Message-ID: <7vpqdnvh3b.fsf@alter.siamese.dyndns.org>
References: <20120209153431.GA24033@godiug.sigxcpu.org>
 <20120209160803.GA5742@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 22:21:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvbQP-0004Ev-6Y
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 22:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174Ab2BIVVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 16:21:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40820 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754346Ab2BIVU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 16:20:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D3077C45;
	Thu,  9 Feb 2012 16:20:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DmzJ/j/jHCFUJHTscRFfUl/vCug=; b=m2Ix/+
	zWGw+aT+mQS0gErZcoxwESXD/L3TUxTxBnRZaibzsyokrt+dKRZfEyi+pRBlAjr1
	gguQUYtorZjood2BsC/qwGkRnuymo7OrgV2OdcPYOP2Pb69oGn9R0Ks+67NYLpcL
	2E8FQxdZhPNIrENBYXOhua+of6I+xS6P0XJzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HhlfYT6c89gfr1PQe9Pd8b7yEVp1PhhZ
	Fk8XC3EXJnW0mnP8JRunN8njQqYruQMaHYMKKcRHADm+krJ713J6WoqFFCdfy122
	R0BO/Hnrlg97FsSBmxJUTyg/J8cwCn35OzdiE1mfqIYi3O1xni3wcLbg116JNjf9
	dVWYhkrGy9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1502B7C43;
	Thu,  9 Feb 2012 16:20:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D8667C42; Thu,  9 Feb 2012
 16:20:57 -0500 (EST)
In-Reply-To: <20120209160803.GA5742@burratino> (Jonathan Nieder's message of
 "Thu, 9 Feb 2012 10:08:18 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5022EEA-5363-11E1-A69F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190325>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Patch relies on "merge: use editor by default in interactive sessions"
> from master.  If this looks like a sane approach, I can resend with a
> proposed log message and a test for t/t7600-merge.sh.  (Or if someone
> else wants to do it first, even better.)

Please do not depend on that one that will never be merged to 1.7.9.x
maintenance track.

Your approach is the right one, though.  A patch for 1.7.9.1, on top of
b5c9f1c (merge: do not create a signed tag merge under --ff-only option,
2012-02-05), would look like this, I think.

I think various "0 < option_edit" we can find in f824628 (merge: use
editor by default in interactive sessions, 2012-01-10) and f26af3f (merge:
add instructions to the commit message when editing, 2012-01-30) can and
should be reverted back to just "option_edit", as nobody should be looking
at option_edit before the "if edit is negative, set it to the default" we
can see in the last hunk of this patch (except for the "merging tag? turn
editing on by default unless --no-edit is given" that is the topic of this
thread).

Thanks.

-- >8 --
Subject: merge: do not launch an editor on "--no-edit $tag"

When the user explicitly asked us not to, don't launch an editor.

But do everything else the same way as the "edit" case, i.e. leave the
comment with verification result in the log template and record the
mergesig in the resulting merge commit for later inspection.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b4fbc60..f385b8a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -48,7 +48,7 @@ static const char * const builtin_merge_usage[] = {
 
 static int show_diffstat = 1, shortlog_len = -1, squash;
 static int option_commit = 1, allow_fast_forward = 1;
-static int fast_forward_only, option_edit;
+static int fast_forward_only, option_edit = -1;
 static int allow_trivial = 1, have_message;
 static int overwrite_ignore = 1;
 static struct strbuf merge_msg = STRBUF_INIT;
@@ -193,7 +193,7 @@ static struct option builtin_merge_options[] = {
 		"create a single commit instead of doing a merge"),
 	OPT_BOOLEAN(0, "commit", &option_commit,
 		"perform a commit if the merge succeeds (default)"),
-	OPT_BOOLEAN('e', "edit", &option_edit,
+	OPT_BOOL('e', "edit", &option_edit,
 		"edit message before committing"),
 	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
 		"allow fast-forward (default)"),
@@ -1287,11 +1287,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		    merge_remote_util(commit) &&
 		    merge_remote_util(commit)->obj &&
 		    merge_remote_util(commit)->obj->type == OBJ_TAG) {
-			option_edit = 1;
+			if (option_edit < 0)
+				option_edit = 1;
 			allow_fast_forward = 0;
 		}
 	}
 
+	if (option_edit < 0)
+		option_edit = 0;
+
 	if (!use_strategies) {
 		if (!remoteheads->next)
 			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
