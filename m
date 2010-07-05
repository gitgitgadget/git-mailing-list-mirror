From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git commit --short' without touching index?
Date: Mon, 05 Jul 2010 14:28:16 -0700
Message-ID: <7vk4p9wrdb.fsf@alter.siamese.dyndns.org>
References: <loom.20100703T102242-536@post.gmane.org>
 <20100703091748.GA11714@sigill.intra.peff.net>
 <7veifhy9j0.fsf@alter.siamese.dyndns.org>
 <20100705205651.GA32728@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel <friedan@muon.rutgers.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 23:28:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVtDO-0001Hf-FD
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 23:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab0GEV23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 17:28:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab0GEV22 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 17:28:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 249A5C27EB;
	Mon,  5 Jul 2010 17:28:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SQmt3ppK6kYE4hmW+T2JxPAklck=; b=Wky+Qc
	BLDztOEaJ0qjTotDNNona0i8KKdyXfOKWJdfG+OU0E61on3zuSJjBZxIdIHSgKkm
	4jh/9R/72jy05hRljx7s6ICvlZJfVEXdo6lpi7o0HndJtQx2F11k4nH1FY/xpJlk
	fGZKVLblrLuNCjwAS5I5XtE5JyCo0vrVodyuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T13XM2pgP/GIE9KhT+seE+IYmArBWQvn
	xJYDkpHH9/WSepuAAIxcuQlPFMMyvaFj437u0X1KLJwlTkIKCKBmZ4hdk207aA+R
	bVwaSQzz05rg1Jtvlr1cC+OtL4GY37DsfH0ilOoOLrUz7/XtVdhwa1BZfpuWZKSY
	UldmQlNjIwU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE1D7C27EA;
	Mon,  5 Jul 2010 17:28:23 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62DE8C27E6; Mon,  5 Jul
 2010 17:28:18 -0400 (EDT)
In-Reply-To: <20100705205651.GA32728@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 5 Jul 2010 16\:56\:52 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3DB2E06C-887C-11DF-950C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150295>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 05, 2010 at 01:10:43PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > It would be nice if the index-refreshing code only wrote to the index if
>> > there was something worth writing. I'm not sure how hard that would be
>> > to implement, though.
>> 
>> Hmm, don't we already do that with "istate->cache_changed"?
>
> Apparently not:
>
>   $ stat .git/index | grep -i modify
>   Modify: 2010-07-05 16:52:11.000000000 -0400
>   $ git status
>   # On branch master
>   nothing to commit
>   $ stat .git/index | grep -i modify
>   Modify: 2010-07-05 16:53:09.000000000 -0400
>
> and it is not just updating some stat-dirtiness. Doing it over and over
> will keep updating the index. It looks like we unconditionally do the
> lock and write in cmd_status, but I haven't looked further.

Something like this, plus possibly a similar fix to "git commit $path"
codepath, perhaps?

We may want to audit all uses of write_cache() and write_index() that are
not protected with active_cache_changed (or istate->cache_changed); I am
reluctant to suggest placing that logic into write_index() at this point,
though, as we may be updating the index in bulk, without marking
active_cache_changed bit, exactly because we know we will unconditionally
write the result out.

 builtin/commit.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c101f00..86d3926 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -343,9 +343,13 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	if (!pathspec || !*pathspec) {
 		fd = hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
-		if (write_cache(fd, active_cache, active_nr) ||
-		    commit_locked_index(&index_lock))
-			die("unable to write new_index file");
+		if (active_cache_changed) {
+			if (write_cache(fd, active_cache, active_nr) ||
+			    commit_locked_index(&index_lock))
+				die("unable to write new_index file");
+		} else {
+			rollback_lock_file(&index_lock);
+		}
 		commit_style = COMMIT_AS_IS;
 		return get_index_file();
 	}
