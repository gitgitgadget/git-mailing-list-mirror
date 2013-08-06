From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] OPT__DRY_RUN(): use OPT_BOOL, not OPT_BOOLEAN
Date: Tue,  6 Aug 2013 16:31:28 -0700
Message-ID: <1375831889-9610-4-git-send-email-gitster@pobox.com>
References: <7viozihh26.fsf@alter.siamese.dyndns.org>
 <1375831889-9610-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 01:31:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6qjH-0003DW-KV
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 01:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276Ab3HFXbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 19:31:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073Ab3HFXbi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 19:31:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14AEE36D2F;
	Tue,  6 Aug 2013 23:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=aQIU
	EFd9VaKbQHeTLhn/E2GDReQ=; b=fhktbpbI4KiAD9hFXgczNK01U9gUCRRhIMVM
	q8UQoZs/l9Ro02agD4KetaIbm60KCzOxcTkWCRXwMBQmNAUYsI6/6UnrIsxOOBFB
	vkq7tO+YXK8BPkFqIEPNml8zJcATBLpXc9jseqUZeEaainfN5wgnfblCaKua1BPl
	7z/BP0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Zyk6/SAGYm8XeobXW7qYRS/M6qzLEXTLnDtjObz0IEDF6lT3if7ov30rHaEjnP5x
	bErL1FwT3so+/ZJ8Y8CeQ8PQD3Ak3WB+cGgpklIKJgLIJ6fumVbdcTVFRE0sJcmy
	0tzUZf9f8SKrTutMykjgFPPeU45A1r1v4bOx++heZZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BC2436D2E;
	Tue,  6 Aug 2013 23:31:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CDCD36D2B;
	Tue,  6 Aug 2013 23:31:37 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc1-210-gf6d87e2
In-Reply-To: <1375831889-9610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 569C7B2C-FEF0-11E2-96F9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231799>

There cannot be "git cmd -n -n" that behaves even less drier than
"git cmd -n", and no existing users of the macro implements such
a semantics (a summary of the audit at the end).

Instead of OPT_BOOLEAN, use OPT_BOOL to clarify.

    builtin/add.c:

	uses "show_only" as a bool.

    builtin/clean.c:

	uses "dry_run" as a bool, and passes it to the parameter
	with the same name of remove_dirs(), which is also used as a
	bool.

    builtin/mv.c:

	uses "show_only" as a bool.

    builtin/notes.c:

	uses "show_only" as a bool.

    builtin/prune.c:

	uses "show_only" as a bool (including its use as a bool to
	decide use of PRUNE_PACKED_DRY_RUN as a parameter to
	prune_packed_objects()).

    builtin/read-tree.c:

	opts.dry_run is used as a bool, in this file and also in
	unpack_trees() that is called from here.

    builtin/remote.c:

	dry_run is passed to prune_remote() and used as a bool.

    builtin/rm.c:

	show_only is used as a bool.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index 582dd4b..78f52c2 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -237,7 +237,7 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
 	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, N_("be more quiet"), \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
-#define OPT__DRY_RUN(var, h)  OPT_BOOLEAN('n', "dry-run", (var), (h))
+#define OPT__DRY_RUN(var, h)  OPT_BOOL('n', "dry-run", (var), (h))
 #define OPT__FORCE(var, h)    OPT_BOOLEAN('f', "force",   (var), (h))
 #define OPT__ABBREV(var)  \
 	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
-- 
1.8.4-rc1-210-gf6d87e2
