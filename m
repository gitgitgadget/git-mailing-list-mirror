From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git stash: Avoid data loss when saving a stash
Date: Fri, 28 Jun 2013 14:30:15 -0700
Message-ID: <7vhaghnct4.fsf@alter.siamese.dyndns.org>
References: <20130628150532.GD12252@machine.or.cz>
	<7vbo6qni1d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Jun 28 23:30:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsgFL-0007Bt-Tk
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 23:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab3F1VaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 17:30:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52684 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab3F1VaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 17:30:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF0202C1FF;
	Fri, 28 Jun 2013 21:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g5/najB/tQ4Ch2tADxtEKdPOglI=; b=oUJP59
	9WbwUw7IwlttLmPGRAciHMKtVff6f10FQPHrn9Y8Ur10VfrNKlwMfX9hVErl85SY
	xEItf7G8o6H4qmVE6aq1L2zJLAWj3zI9PG2Z+f4fnhIoslmVoFy9V+Kmr/a5HN3p
	Usof+PrIYk/uaWD9TZOV7dDpxwCE9Mp4TnCaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tap4HZ9E110vUgmiWhjTNEKh2hlQgZPr
	dfVgiFiq09C9GDy+0K1qVOuBGjbXDFelgYLT2xAhD1a9vs+lLkKx1+VRZNfDJytj
	DmsdnoW9FCMuYNvBqI3AzQ+afDFxSbY+RMOko6/WKDAyRR0g7HvAurIwQrOEtK7W
	ERz1c4+a6G0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C42B62C1FE;
	Fri, 28 Jun 2013 21:30:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42AC02C1FD;
	Fri, 28 Jun 2013 21:30:17 +0000 (UTC)
In-Reply-To: <7vbo6qni1d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 28 Jun 2013 12:37:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED41DA70-E039-11E2-8E33-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229241>

Junio C Hamano <gitster@pobox.com> writes:

> Petr Baudis <pasky@ucw.cz> writes:
>
>> diff --git a/git-stash.sh b/git-stash.sh
>> index 1e541a2..3cb9b05 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -258,6 +262,12 @@ save_stash () {
>>  		say "$(gettext "No local changes to save")"
>>  		exit 0
>>  	fi
>> +	if test -z "$untracked$force" -a -n "$(git ls-files --killed | head -n 1)"; then
>> +		say "$(gettext "The following untracked files would NOT be saved but need to be removed by stash save:")"
>
> I think "ls-files --killed" was not adjusted for the new world order
> when submodules were introduced.  With this change, you see t7402
> break,...
> Exactly the same breakage this patch introduces triggers in t7610,
> too.
>
> I think another patch to teach "ls-files --killed" what to do with
> submodules is needed as a preliminary step before this patch.

Which may be just the matter of doing this.

-- >8 --
Subject: treat_directory(): do not declare submodules in index to be untracked

When the working tree walker encounters a directory, it asks this
function if it should descend into it, show it as an untracked
directory, or do something else.  When the directory is the top of
the submodule working tree, we used to say "That is an untracked
directory", which was quite bogus.  It is an entity that is tracked
in the index of the repository we are looking at, and that is not to
be descended into it.  Return path_none.

The existing case that path_untracked is returned for a newly
discovered submodule that is not tracked in the index (this only
happens when DIR_NO_GITLINKS option is not used) is unchanged and
returns path_untracked, but that is exactly because the submodule is
not tracked in the index.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 897c874..b99c40e 100644
--- a/dir.c
+++ b/dir.c
@@ -1038,7 +1038,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	case index_gitdir:
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			return path_none;
-		return path_untracked;
+		return path_none;
 
 	case index_nonexistent:
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
