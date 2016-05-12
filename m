From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/7] i18n: unpack-trees: mark strings for translation
Date: Thu, 12 May 2016 15:50:09 -0700
Message-ID: <xmqqy47ec2n2.fsf@gitster.mtv.corp.google.com>
References: <1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt>
	<1463083168-29213-3-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 13 00:50:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0zQy-0007Kq-Cv
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 00:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbcELWuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 18:50:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750929AbcELWuN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 18:50:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CC40F1B61E;
	Thu, 12 May 2016 18:50:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SmknFsQ0YFjUSEd2IxBNEcChYo8=; b=JXzR2w
	4dy9eoWJG+nMU9CxRQd4pzymJ+0dcyaImRlnRKarSta1sWEu8DbwD8oPod2nC2UZ
	3UkXxYtWdR1ancLZB1tegHS8s0mVgUDbhO2xImtBzazwaZD3aYftfFjlnIEh5uZG
	SZ+5KgW07eL+De81dZAs1RAnobz2CVm7I/N7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0OfoLVQ11y075E2bKMYCg1847UYMOqY
	px8xB4NTomdhmabBLylRfJaqtkaO+uSit9V+dHnsljQZGMcmVilBHuX1mvpRo093
	pEoVaYi4+ORoURUxA5SZdcTqCcgXrx6XE4TjwSm4kVjWIkVfx0ibMLKz/avFJhQd
	T4eKJO5kVXI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C1B981B61D;
	Thu, 12 May 2016 18:50:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3815E1B61C;
	Thu, 12 May 2016 18:50:11 -0400 (EDT)
In-Reply-To: <1463083168-29213-3-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Thu, 12 May 2016 19:59:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E201D4C2-1893-11E6-9F1C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294487>

I think this patch is better than what is already in 'next', so let
me see if I can make it into an incremental update.

We'd need your sign-off, of course.

-- >8 --
Subject: i18n: unpack-trees: avoid substituting only a verb in sentences

Instead of reusing the same set of message templates for checkout
and other actions and substituting the verb with "%s", prepare
separate message templates for each known action.  That would make
it easier for translation into languages where the same verb may
conjugate differently depending on the message we are giving.

---

diff --git a/unpack-trees.c b/unpack-trees.c
index 4bc6b4f..edb1ee5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -58,27 +58,61 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	int i;
 	const char **msgs = opts->msgs;
 	const char *msg;
-	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
 
-	if (advice_commit_before_merge)
-		msg = _("Your local changes to the following files would be overwritten by %s:\n%%s"
-			"Please, commit your changes or stash them before you can %s.");
+	if (!strcmp(cmd, "checkout"))
+		msg = advice_commit_before_merge
+		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
+			  "Please, commit your changes or stash them before you can switch branches.")
+		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
+	else if (!strcmp(cmd, "merge"))
+		msg = advice_commit_before_merge
+		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"
+			  "Please, commit your changes or stash them before you can merge.")
+		      : _("Your local changes to the following files would be overwritten by merge:\n%%s");
 	else
-		msg = _("Your local changes to the following files would be overwritten by %s:\n%%s");
+		msg = advice_commit_before_merge
+		      ? _("Your local changes to the following files would be overwritten by %s:\n%%s"
+			  "Please, commit your changes or stash them before you can %s.")
+		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
-		xstrfmt(msg, cmd, cmd2);
+		xstrfmt(msg, cmd, cmd);
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in it:\n%s");
 
-	if (advice_commit_before_merge)
-		msg = _("The following untracked working tree files would be %s by %s:\n%%s"
-			"Please move or remove them before you can %s.");
+	if (!strcmp(cmd, "checkout"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be removed by checkout:\n%%s"
+			  "Please move or remove them before you can switch branches.")
+		      : _("The following untracked working tree files would be removed by checkout:\n%%s");
+	else if (!strcmp(cmd, "merge"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be removed by merge:\n%%s"
+			  "Please move or remove them before you can merge.")
+		      : _("The following untracked working tree files would be removed by merge:\n%%s");
 	else
-		msg = _("The following untracked working tree files would be %s by %s:\n%%s");
-
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, "removed", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, "overwritten", cmd, cmd2);
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be removed by %s:\n%%s"
+			  "Please move or remove them before you can %s.")
+		      : _("The following untracked working tree files would be removed by %s:\n%%s");
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, cmd, cmd);
+
+	if (!strcmp(cmd, "checkout"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be overwritten by checkout:\n%%s"
+			  "Please move or remove them before you can switch branches.")
+		      : _("The following untracked working tree files would be overwritten by checkout:\n%%s");
+	else if (!strcmp(cmd, "merge"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be overwritten by merge:\n%%s"
+			  "Please move or remove them before you can merge.")
+		      : _("The following untracked working tree files would be overwritten by merge:\n%%s");
+	else
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be overwritten by %s:\n%%s"
+			  "Please move or remove them before you can %s.")
+		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, cmd, cmd);
 
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
