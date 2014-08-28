From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge, pull: stop advising 'commit -a' in case of conflict
Date: Thu, 28 Aug 2014 11:36:56 -0700
Message-ID: <xmqqppfka2bb.fsf@gitster.dls.corp.google.com>
References: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
	<1409219218-9475-1-git-send-email-Matthieu.Moy@imag.fr>
	<20140828181638.GB20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:47:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN4iw-0002Iu-5r
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 20:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbaH1ShM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 14:37:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62107 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbaH1ShI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 14:37:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B579235AAB;
	Thu, 28 Aug 2014 14:37:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+de2UAVOvhKtpahNPmA5JcVuvLE=; b=VlGfnM
	bBus/i9NwRYkEb0Sz3PudIG/jT4VhSrLxfmSy9Zj9UJzIMustN6MXv/rs4/vlbWn
	KrZ9/SCR1Uii7eEVt1buqhcjnkD7Tm1StXc2EfgY2S6yoycMhorjgK7ciRujNTO8
	ViP8YRakNlsgSmn72nRg9Diy1ulBmuFsJG+vY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=haGwEhLmxL8p1CQPVJjzzDccCQTFKeb2
	xXi4OxyMtHz/pISqaMckzQ85kUuxRRCWM5JPt4E/WdgYvyXD6nnKPuoZqsVXIdum
	nBnJKyWvapjHtwx0GXVs0HGem2jUjpAZ/b/MMvFhUsXsRr52uiJgPcto8+0VTnZW
	JYKGCMw/EMU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A809235AAA;
	Thu, 28 Aug 2014 14:37:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 836BE35A97;
	Thu, 28 Aug 2014 14:36:58 -0400 (EDT)
In-Reply-To: <20140828181638.GB20185@google.com> (Jonathan Nieder's message of
	"Thu, 28 Aug 2014 11:16:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4B1AED42-2EE2-11E4-BF03-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256113>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> It was already on my todo-list, as a friend of mine semi-beginner with
>> Git complained about the mis-advice the other day, and I had to agree.
>
> That's a useful sort of thing to put in a commit message. :)
>
>> Eventually, git could detect that conflicts have been resolved, but
>> then that would be a different message, as not only "use git commit
>> -a" could be resurected, but "Fix them up in the work tree" should be
>> dropped when it is the case.
>
> As is this --- when I wonder why code isn't a certain way, ideas for
> future work found in the description for the blamed commit are often
> helpful in explaining the current state and saving me from blind
> alleys in changing it.

Yes.

> Anyway, this is already a very good change as-is.
>
> Actually, I'd be nervous about suggesting "use git commit -a" without
> at least also saying "inspect the result or run tests" in the
> no-conflict-markers-found case.  Rerere sometimes makes mistakes, and
> the result of picking one side when merging binary files can be even
> worse.

Here is how I phrased in the one queued tentatively.

-- >8 --
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Thu, 28 Aug 2014 11:46:58 +0200
Subject: [PATCH] merge, pull: stop advising 'commit -a' in case of conflict

'git commit -a' is rarely a good way to mark conflicts as resolved:
the user anyway has to go manually through the list of conflicts to
do the actual resolution, and it is usually better to use "git add"
on each files after doing the resolution.

On the other hand, using 'git commit -a' is potentially dangerous,
as it makes it very easy to mistakenly commit conflict markers
without noticing, and even worse, the user may have started a merge
while having local changes that do not overlap with it in the
working tree.

While we're there, synchronize the 'git pull' and 'git merge'
messages: the first was ending with '...  and make a commit.', but
not the latter.

Eventually, git should detect that conflicts have been resolved in
the working tree and tailor these messages further.  Not only "use
git commit -a" could be resurected, but "Fix them up in the work
tree" should be dropped when it happens.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/advice.c b/advice.c
index 9b42033..3b8bf3c 100644
--- a/advice.c
+++ b/advice.c
@@ -86,8 +86,7 @@ int error_resolve_conflict(const char *me)
 		 * other commands doing a merge do.
 		 */
 		advise(_("Fix them up in the work tree, and then use 'git add/rm <file>'\n"
-			 "as appropriate to mark resolution and make a commit, or use\n"
-			 "'git commit -a'."));
+			 "as appropriate to mark resolution and make a commit."));
 	return -1;
 }
 
diff --git a/git-pull.sh b/git-pull.sh
index 18a394f..4d4fc77 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -20,7 +20,7 @@ die_conflict () {
     if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
 	die "$(gettext "Pull is not possible because you have unmerged files.
 Please, fix them up in the work tree, and then use 'git add/rm <file>'
-as appropriate to mark resolution, or use 'git commit -a'.")"
+as appropriate to mark resolution and make a commit.")"
     else
 	die "$(gettext "Pull is not possible because you have unmerged files.")"
     fi
