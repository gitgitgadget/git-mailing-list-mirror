From: Junio C Hamano <gitster@pobox.com>
Subject: [puzzled and solved] "shortlog" not quite understanding all "log" options
Date: Fri, 30 May 2014 12:28:47 -0700
Message-ID: <xmqqzjhz83rk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 21:28:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqSU6-000576-2c
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 21:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388AbaE3T2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 15:28:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53017 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbaE3T2x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 15:28:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8BC511AE93;
	Fri, 30 May 2014 15:28:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	vEHZZNWo/s+qc+fOwFueXLP2gk=; b=WIX4Ip7utpVYRdjapQr1e8SSTE9VJzk6v
	kylf0kBXXqRaVvsU4c0I90vA4waZCRg1ZWmqUTY3GaCQIa0pzePnpASO2tSiCb/r
	Kaiq3TuegrMAhvQmf5vq72cdKP2z0h572X379QKEwPdOFdfLnskAHIc6UNOk6Hjl
	8CydO3/3J4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=V/Y
	sh0AqIb3z/zZ+eZWYdYTaDA67jQYjoZq7IamD4IXHBBQYKbXxKhY2nVCAIh72oMl
	7EdXvfi82tRH/lcLV6K7oQ49wA78dd5OKh4mQDWxyaxJH2KxqBwHmYzpCFVdV1n5
	jtupQrWEhxp18rBf33YpLnb7qflN7dl0Ee7YOdiM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 824691AE92;
	Fri, 30 May 2014 15:28:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E879B1AE8C;
	Fri, 30 May 2014 15:28:48 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9FE08984-E830-11E3-B523-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250469>

This gives the list of all recent commits but not the ones that are
only reachable from the notes hierarchy:

$ git log --exclude=refs/notes/\* --all --no-merges --since=18.hours |
  git shortlog

and we are supposed to be able to write the same with shortlog
itself, i.e.

$ git shortlog --exclude=refs/notes/\* --all --no-merges --since=18.hours

but this does not understand the ref exclusion command-line option.

A funny and puzzling thing is that this is understood:

$ git shortlog --all --no-merges --since=18.hours

What is strange is that --all, --no-merges, etc. and the ref
exclusion option all are handled in revision.c and only one of them
is being rejected.

.... Aaaand, it turns out that the answer is in the big comment at
the beginning of handle_revision_pseudo_opt().

-- >8 --
Subject: shortlog: allow --exclude=<glob> to be passed

e7b432c5 (revision: introduce --exclude=<glob> to tame wildcards,
2013-08-30) taught a new option to the command-line parser of "log"
and friends, but did not wire it fully so that it can also be used
by "shortlog".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 71e2337..3818b46 100644
--- a/revision.c
+++ b/revision.c
@@ -1633,6 +1633,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
 	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk") ||
 	    !strcmp(arg, "--bisect") || starts_with(arg, "--glob=") ||
+	    starts_with(arg, "--exclude=") ||
 	    starts_with(arg, "--branches=") || starts_with(arg, "--tags=") ||
 	    starts_with(arg, "--remotes=") || starts_with(arg, "--no-walk="))
 	{
