From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Query on git commit amend
Date: Tue, 06 Dec 2011 13:00:56 -0800
Message-ID: <7vk469fm9j.fsf@alter.siamese.dyndns.org>
References: <4EDDD0E4.6040003@st.com> <87fwgxwvn9.fsf@gmail.com>
 <7vobvlfowk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vijay Lakshminarayanan <laksvij@gmail.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 22:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY28Q-0003T8-QD
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385Ab1LFVBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:01:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028Ab1LFVBB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:01:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3845A596C;
	Tue,  6 Dec 2011 16:00:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tvTDRKn2q7/DhuAcDZjPN4KT8b0=; b=lPeduE
	Pzra2X5thnvGp2PsLeDdTemBwjpwSEy1YvaXleIuRzwSsUO7Jj9XHcnP08azWBTO
	6rniixAVEkWXdx9boIoTL69k/XgyCkpRlFqqDVf+xfoQg023pTIjMKjWp7rRu2cm
	+2u/7qqsddEScIxKGJBsgoAkdiKdSRXokPgy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ecLFghkBwQZO7adjtEgz+LGELbECZf1R
	EAQJU0wopZWODalD+NAyyfp0QTWER5tKFL0GRjqbS5YM+4fZN1ls7awXJyTin21B
	5fxuQe1VHfNrSFL7o6s994eP/OyMpgQoSowTZdZ5vDG6zU5uRZvmsWTgkvGuIILQ
	G8vb7gjE1rE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FE185967;
	Tue,  6 Dec 2011 16:00:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C7395965; Tue,  6 Dec 2011
 16:00:58 -0500 (EST)
In-Reply-To: <7vobvlfowk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 06 Dec 2011 12:03:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6592DFFA-204D-11E1-B562-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186382>

Junio C Hamano <gitster@pobox.com> writes:

> I almost always use
>
>     $ EDITOR=: git commit --amend
>
> when rewriting the contents without updating the message, but I think
> we should allow people to say:
>
>     $ git commit --amend --no-edit
>
> which is accepted from the command line but is not honoured.

And this should fix it (only lightly tested).

-- >8 --
Subject: [PATCH] commit: honor --no-edit

After making fixes to the contents to be committed, it is not unusual to
update the current commit without rewording the message. Idioms to do
tell "commit --amend" that we do not need an editor have been:

    $ EDITOR=: git commit --amend
    $ git commit --amend -C HEAD

but that was only because a more natural

    $ git commit --amend --no-edit

did not honour "--no-edit" option.    

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8f2bebe..48bea8f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -81,7 +81,8 @@ static const char *template_file;
 static const char *author_message, *author_message_buffer;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
-static int all, edit_flag, also, interactive, patch_interactive, only, amend, signoff;
+static int all, also, interactive, patch_interactive, only, amend, signoff;
+static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
@@ -141,7 +142,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the commit is authored by me now (used with -C-c/--amend)"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
-	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
+	OPT_BOOL('e', "edit", &edit_flag, "force edit of commit"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 	OPT_BOOLEAN(0, "status", &include_status, "include status in commit message template"),
 	/* end commit message options */
@@ -1020,8 +1021,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (logfile || message.len || use_message || fixup_message)
 		use_editor = 0;
-	if (edit_flag)
-		use_editor = 1;
+	if (0 <= edit_flag)
+		use_editor = edit_flag;
 	if (!use_editor)
 		setenv("GIT_EDITOR", ":", 1);
 
-- 
1.7.8.157.g03e55
