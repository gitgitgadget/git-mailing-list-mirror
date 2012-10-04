From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] Tying loose ends of extended "grep"
Date: Wed,  3 Oct 2012 18:33:33 -0700
Message-ID: <1349314419-8397-1-git-send-email-gitster@pobox.com>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:03:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtMz-0001DP-GN
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975Ab2JDBdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 21:33:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab2JDBdm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 21:33:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 372BE805A;
	Wed,  3 Oct 2012 21:33:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=DNUs
	8VKXlKit5AReYnkC21IzE/4=; b=yOVjqqKEyEYmPlzeKMTZh4oYy9IvG4w8K4Sl
	oRVwZP5IRtyFe9oJotIA6LLI8onVzL0QVzSNr+72UnDrMF5eSEWKvN/GKAmq3HyV
	vpDodQj95VuGMGp76kzZ2YMvpcxwc5JkkR6Rclx1ujdlHj9NHmMi12eJVFCJLIHA
	KyYK+XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	E4DYFYSjK81rDgJHKWaxd9RzK9rx56RJopKlo8PWDLZfb+9cTlo7mrUlqkBMry5G
	diwl+7WjK/lvGsrNHl9WjN4TEsfq+pmwgykjJ8J0iT/thnmcNUENvxKXxIWaMhfw
	SfRGM09VW9TgksWAqjAFbHdIEdxnnHOzzBZfq6MoMJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 255868059;
	Wed,  3 Oct 2012 21:33:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 933AE8058; Wed,  3 Oct 2012
 21:33:40 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc0.57.g712528f
In-Reply-To: <7v626r48cv.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 86D01EC6-0DC3-11E2-8E8C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206959>

Over time we have added a few things to our "git grep" front-end,
such as

 - grep.extendedregexp configuration (v1.7.5)
 - use of pcre (v1.7.6)
 - grep.patterntype configuration (v1.8.0)

But all the time, we forgot that "git log --grep" would need to
honor them.

The first three patches should be uncontroversial.  We move helpers
out of builtin/grep.c to a more generic place, and fix a bug in the
command line parser for "git log -F -E --grep='<ere>'" (this did not
correctly enable regular expression).

The fourth patch adds "git log --perl-regexp --grep='<pcre>'".

The last two teaches "log --grep" to honor the same grep.*
configuration variables.

color.grep and grep.linenumber should not matter, as the use of grep
mechanism in "log --grep" is about boolean result "do we have hits?"
and not about actually showing the hits in the output, but the users
would expect that grep.extendedregexp and its more generalized
version grep.patterntype are honored, which was not the case.

Junio C Hamano (6):
  grep: move configuration support to top-level grep.[ch]
  grep: move pattern-type bits support to top-level grep.[ch]
  log --grep: use the same helper to set -E/-F options as "git grep"
  log --grep: accept --basic-regexp and --perl-regexp
  log: pass rev_info to git_log_config()
  log --grep: honor grep.patterntype etc. configuration variables

 builtin/grep.c | 105 ++-------------------------------------------------------
 builtin/log.c  |  19 +++++------
 grep.c         |  99 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 grep.h         |   3 ++
 revision.c     |   8 +++--
 t/t4202-log.sh |   6 ++++
 6 files changed, 126 insertions(+), 114 deletions(-)

-- 
1.8.0.rc0.57.g712528f
