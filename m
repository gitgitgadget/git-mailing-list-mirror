From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] apply, ls-files: simplify "-z" parsing
Date: Mon, 01 Feb 2016 14:52:30 -0800
Message-ID: <xmqqio28t55d.fsf@gitster.mtv.corp.google.com>
References: <20160131112215.GA4589@sigill.intra.peff.net>
	<20160131113546.GF5116@sigill.intra.peff.net>
	<xmqqzivkt86j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 23:52:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQNKn-000296-W8
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 23:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317AbcBAWwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 17:52:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754298AbcBAWwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 17:52:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 184A241A25;
	Mon,  1 Feb 2016 17:52:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1tWbsh0PF9F9H2S7pWFAMshREsA=; b=d0uZl7
	/dOeA8Ox/4Rb0ue6QPr0vLt7zSOPw/r7qjgHZVPvIijFX56v1091DoaTlF41ihfC
	xEEWNFKOOGPXZg0Cd6rSt3q+n0i+ja6FDvoU6VkbSQBUrSxVnGyB/VTn7NMrg3dO
	WYs8+WHbxoJEtU0U40lOqLL4Nhlquabk577zU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ct/uNOL8pvrmWPbqTf2y/I5IXHqe0+0T
	AoK1vjtYgee6rtxs1EEkeOkC927exYlZIICfpnsoUsFjtehhAZ4WY5p4GDMABWZ5
	0ELoCS7TW9OCM1lGqSbyZCuhU2cSxqAHkIcihMRgE2eMQVdGFQuE8DAAqEzaktR5
	dGruV+ZRUxQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0EEEF41A24;
	Mon,  1 Feb 2016 17:52:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7CC0941A23;
	Mon,  1 Feb 2016 17:52:31 -0500 (EST)
In-Reply-To: <xmqqzivkt86j.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Feb 2016 13:47:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 79E6C278-C936-11E5-888D-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285224>

Junio C Hamano <gitster@pobox.com> writes:

> Of course, a patch adding a "--nul" can be the one that does the
> polarity flipping, so in that sense, this simplification is probably
> OK, as long as there is some comment that warns a time-bomb you just
> planted here ;-)

I'll queue it with this tweak for now.

The idea is to have them run "blame" to find the last paragraph of
the commit log message.

Thanks.

    From: Jeff King <peff@peff.net>
    Date: Sun, 31 Jan 2016 06:35:46 -0500
    Subject: [PATCH] apply, ls-files: simplify "-z" parsing

    As a short option, we cannot handle negation. Thus a callback
    handling "unset" is overkill, and we can just use OPT_SET_INT
    instead to handle setting the option.

 +  Anybody who adds "--nul" synonym to this later would need to be
 +  careful not to break "--no-nul", which should mean that lines are
 +  terminated with LF at the end.

    Signed-off-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/builtin/apply.c b/builtin/apply.c
index 565f3fd..d61ac65 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4536,6 +4536,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			 N_( "attempt three-way merge if a patch does not apply")),
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
+		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &line_termination,
 			N_("paths are separated with NUL character"), '\0'),
 		OPT_INTEGER('C', NULL, &p_context,
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 59bad9b..467699b 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -400,6 +400,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	struct exclude_list *el;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct option builtin_ls_files_options[] = {
+		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &line_terminator,
 			N_("paths are separated with NUL character"), '\0'),
 		OPT_BOOL('t', NULL, &show_tag,
