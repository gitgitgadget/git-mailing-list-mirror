From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Handling unmerged files with merged entries
Date: Wed, 20 Aug 2014 15:19:03 -0700
Message-ID: <xmqqr40ast2g.fsf@gitster.dls.corp.google.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
	<cover.1408533065.git.jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:19:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKEE7-0005ud-BP
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 00:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbaHTWTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 18:19:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62826 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753352AbaHTWTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 18:19:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DA2333635;
	Wed, 20 Aug 2014 18:19:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GieV7agJ1mIsBiHvkPy2Sez2WWA=; b=AcWk3C
	ZHARLmJTuVN9/LMdTiWxlALXZX7+B9Na9AJldEp3L4NdiwWsQPlchN5oadd+5lVD
	xYrbF77rD4v7Ew5d7MMgq+fElRl6X7hmCIt0TitX03HwRbVHnUSuMFYRcTz6JOqx
	ehTF/dDhN8xyxQ/irwnbWKjKMbwUGE7w9KMmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FmLD2sIpC8MBSNh4Z19V/dj2YGv+YR3o
	J5Yq3oOm6r/eqW9lMhozpcLZuTDRZDcWL6Hb02EiSftDs+aPLSWJbeiEdVyHeEAP
	wtJI2AOqtRYey8uSLdmeFBAk+aqcMXI6ypsaZQskGz7qXLHrl4WTgcD7Jyarwgut
	RrLfyQy2y2Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54C9733633;
	Wed, 20 Aug 2014 18:19:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 05FA833626;
	Wed, 20 Aug 2014 18:19:04 -0400 (EDT)
In-Reply-To: <cover.1408533065.git.jsorianopastor@gmail.com> (Jaime Soriano
	Pastor's message of "Wed, 20 Aug 2014 13:25:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FF01440E-28B7-11E4-B7BD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255592>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> New approach for the case of finding unmerged files with merged entries
> in the index.
> After some discussion the solution tries to:
> - Avoid the problems with infinite loops in this case.
> - Provide better information to the user in the commands affected.
> - Make sure there are ways to clean the index.
> - Provide also a way to specifically recover each one of the files with
>   this problem.
>
> With these patches the behaviour of these commands (for this case) change:
> - git reset is able to finish, cleaning the index, but warning out the
>   information about the removed stages.
> - git merge is able to finish, reporting that there is a merge in progress as
>   usual, it also warns about the unmerged files with merged entries.
> - git add fails when this case happens, telling the user to check the state
>   with 'git ls-files -s', before, it did nothing. The same with git commit -a.
> - git update-index --cacheinfo can be used to select an specific staged
>   version to resolve the conflict, without the need of reseting the working
>   copy. It did nothing before.
>
> Tests added for these cases. Rest of the tests remain unchanged and pass too.

Thanks.

After looking at what you did in 1/4, I started to wonder if we can
solve this in add_index_entry_with_check() in a less intrusive way.
When we call the function with a stage #0 entry, we are telling the
index that any entry in higher stage for the same path must
disappear.  Since the current implementation of the function assumes
that the index is not corrupt in this particular way to have both
merged and unmerged entries for the same path, it fails to remove
the higher stage entries.  If we fix the function, wouldn't it make
your 1/4 unnecessary?  Read-only operations such as "ls-files -s"
would not call add_index_entry() so diagnostic tools would not be
affected even with such a fix.

... which may look something like the one attached at the end.

But then it made me wonder even more.

There are other ways a piece of software can leave a corrupt index
for us to read from.  Your fix, or the simpler one I suggested for
that matter, would still assume that the index entries are in the
sorted order, and a corrupt index that does not sort its entries
correctly will cause us to behave in an undefined way.  At some
point we should draw a line and say "Your index is hopelessly
corrupt.", send it back to whatever broken software that originally
wrote such a mess and have the user use that software to fix the
corrupt index up before talking to us.

For that, we need to catch an index whose entries are not sorted and
error out, perhaps when read_index_from() iterates over the mmapped
index entries.  We can even draw that "hopelessly corrupt" line
above the breakage you are addressing and add a check to make sure
no path has both merged and unmerged entries to the same check to
make it error out.

I suspect that such a "detect and error out" may be sufficient and
also may be more robust than the approach that assumes that a
breakage is only to have both merged and unmerged entries for the
same path, the entries are still correctly sorted.


 read-cache.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 7f5645e..56006a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -943,9 +943,16 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	if (pos >= 0) {
 		if (!new_only)
 			replace_index_entry(istate, pos, ce);
-		return 0;
+		/*
+		 * ... but protect ourselves from a corrupt index
+		 * that has an unmerged entry for the same path.
+		 */
+		if (istate->cache_nr <= pos + 1 ||
+		    !ce_same_name(ce, istate->cache[pos + 1]))
+			return 0;
+	} else {
+		pos = -pos-1;
 	}
-	pos = -pos-1;
 
 	/*
 	 * Inserting a merged entry ("stage 0") into the index





[Footnote]
