From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mv: allow moving nested submodules
Date: Mon, 18 Apr 2016 14:13:05 -0700
Message-ID: <xmqqfuui4o4e.fsf@gitster.mtv.corp.google.com>
References: <1460998489-2155-1-git-send-email-sbeller@google.com>
	<xmqqk2ju4ozy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gmane@otterhall.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:13:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asGU3-0001ud-Ro
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 23:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbcDRVNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 17:13:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752260AbcDRVNI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 17:13:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 06549140CF;
	Mon, 18 Apr 2016 17:13:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OhDOWV6DCZ4M9eqckWnhkvjQf2k=; b=RNVhoU
	AK0SQ7FExE8YYYMj7wo4yCiyue7VTSpRsqfbYCIkSe7jaJ256QDTQHHG2eADzV/v
	UDYHtXkkv5yf6u6yMsUZF1+lFvZKAMq8PwZ3vPsTjqv5JbN6TM86/gTC7qIp9pOf
	0S1p2XJgYXVzPuWuSpQGXFLKBv0fNsZ8d2gp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qMbMyghm440bRh4x2JhDe2Y4XXELmU8N
	nBUl21mKS6N9IVS0QMIAZlhEQdi0qOFP0fz0AX4KGaXJX83DdYBP+NM3sdsE3j2K
	cfub7sleSDuBFZUCaCysBl6/9hXWUkKe8DlZOiG+Nv9IYEBAgPV9DMJoDVrdVBzn
	Iab+iv+fRXE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F29A9140CE;
	Mon, 18 Apr 2016 17:13:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A42F140CD;
	Mon, 18 Apr 2016 17:13:06 -0400 (EDT)
In-Reply-To: <xmqqk2ju4ozy.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 18 Apr 2016 13:54:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 583EACDE-05AA-11E6-888D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291829>

Junio C Hamano <gitster@pobox.com> writes:

> If ignore-errors is set and rename fails, this would fall through
> and try to touch this codepath...
>
>>  			if (submodule_gitfile[i]) {
>>  				if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
>>  					connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
>
> ... but I am not sure if this thing is prepared to cope with such a
> case?  src should have been moved to dst but if rename() failed we
> wouldn't see what we expect at dst, or would we?

In other words, I was wondering if this part should read more like
this:

 builtin/mv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index aeae855..37ed0fc 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -252,9 +252,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		int pos;
 		if (show_only || verbose)
 			printf(_("Renaming %s to %s\n"), src, dst);
-		if (!show_only && mode != INDEX) {
-			if (rename(src, dst) < 0 && !ignore_errors)
+		if (show_only)
+			;
+		else {
+			if (mode != INDEX && rename(src, dst) < 0) {
+				if (ignore_errors)
+					continue;
 				die_errno(_("renaming '%s' failed"), src);
+			}
 			if (submodule_gitfile[i]) {
 				if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
 					connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
