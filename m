From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/10] mark private symbols static
Date: Wed, 14 Jan 2015 15:40:45 -0800
Message-ID: <1421278855-8126-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:41:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXYe-0002Zt-2Q
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbbANXk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:40:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751160AbbANXk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:40:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59E5C2DB76;
	Wed, 14 Jan 2015 18:40:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=HEw8uAmij78Bjp3Bg58NzrSsuK8
	=; b=TYcOf2Ffn64vD15VrJl4ey6KOIGGp6XsfZEv5LwchsbBAkNAkzMpYm+6lLp
	10GEW7tzBpkpBTGcpMwT/LK3nAHspnQjfQ4XgQ2jDP2Vlihwl7nPq9f7pqOiv3lj
	jefuJqgOGPA8hAU9R1jmzBNK8RRBZcVZIqB72TqWTOC55S9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=XgOG3Id4aw1PrTngBUQNQP4HYYv4t
	ba1q6mRKhr5WxabbX8sfAPATpy3jKVowInohGJrjeyxz2T8UQjNwTGGfDaSkvLwX
	AfFWIX7BpJCV5awjzA1CD+bYU/HaLyYCPNU6ljYYC/UtRQ4Y9A6joT5eVQiK6Idu
	w5DJnjRSYMnHXw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 506192DB73;
	Wed, 14 Jan 2015 18:40:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7D1A2DB71;
	Wed, 14 Jan 2015 18:40:56 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc0-134-g109a908
X-Pobox-Relay-ID: C958A470-9C46-11E4-8608-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262439>

Here are a handful of patches to make symbols that are only used
within a .c file as static.  This is not the kind of changes we
would want to do in the pre-release freeze period, and it is just
for reference.  I may later come back to them after 2.3 final is
tagged.

Note that I did not blindly make everything that _could_ be made
static; the ones I deliberately left untouched are:

 * config.c: this has a lot of git_configset_*() API functions that
   were developed but not yet used (as part of 3/4-way done GSoc
   project that did not fully convert users of the config subsystem
   to these new style functions); making them static merely because
   they are not yet used goes backwards.

 * ewah/* and xdiff/*: I consider these borrowed code, which we
   would want to avoid touching in the same series as our own code.

 * graph.c: graph_next_line() and graph_set_column_colors() are not
   called externally, but I suspect that they are API functions
   waiting for a new caller to appear.

 * line-log.c: range_set_append() is not called externally, but this
   is only because a caller calls range_set_append_unsafe(), its
   sibling, which may want to be cleaned up.

 * refs.c: rollback_packed_refs() is not called externally, but the
   codebase around refs API is in flux and I did not want to add to
   the code churn.

 * strbuf.c: xstrvfmt() is not called externally, but this is a
   reasonable API function to keep; its friend xstrfmt() is used by
   many places.

 * string-list.c: print_string_list() may want to go, but it may
   be useful for debugging, so I kept it in.

 * wrapper.c: rmdir_or_warn() is not used externally, but this is a
   reasonable API function as its friends like unlink_or_warn() that
   are used.


The last patch in the series is very questionable.  Instead of
hiding unused author_ident_sufficiently_given() function (and
possibly removing it), it adds external callers to justify its
existence ;-)


Junio C Hamano (10):
  http.c: make finish_active_slot() and handle_curl_result() static
  line-log.c: make line_log_data_init() static
  prompt.c: remove git_getpass() nobody uses
  revision.c: make save_parents() and free_saved_parents() static
  urlmatch.c: make match_urls() static
  remote.c: make clear_cas_option() static
  shallow.c: make check_shallow_file_for_update() static
  pack-bitmap.c: make pack_bitmap_filename() static
  read-cache.c: make fill/match_stat_data() static
  commit: show "Author:" hint when the ident is not given explicitly

 builtin/commit.c |   6 ++--
 cache.h          |  14 --------
 commit.h         |   1 -
 http.c           |  64 ++++++++++++++++-----------------
 http.h           |   2 --
 line-log.c       |   2 +-
 line-log.h       |   2 --
 pack-bitmap.c    |  28 +++++++--------
 pack-bitmap.h    |   1 -
 prompt.c         |   5 ---
 prompt.h         |   1 -
 read-cache.c     |  14 ++++++--
 remote.c         |   2 +-
 remote.h         |   1 -
 revision.c       | 106 +++++++++++++++++++++++++++++--------------------------
 revision.h       |  12 +++----
 shallow.c        |   2 +-
 urlmatch.c       |   6 ++--
 urlmatch.h       |   1 -
 19 files changed, 127 insertions(+), 143 deletions(-)

-- 
2.3.0-rc0-134-g109a908
