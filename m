From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Passing rev-list options in git-filter-branch broken
Date: Fri, 27 Jun 2014 15:20:51 -0700
Message-ID: <xmqq4mz60zb0.fsf@gitster.dls.corp.google.com>
References: <987cd4ccd2b86a840b900a25e0edf0f9@tribut.de>
	<xmqq1tua2oi5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lee Carver <Lee.Carver@servicenow.com>
To: Felix Eckhofer <felix@tribut.de>
X-From: git-owner@vger.kernel.org Sat Jun 28 00:21:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0eW0-0008UD-0P
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 00:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbaF0WU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 18:20:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65452 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbaF0WU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 18:20:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 53B6222839;
	Fri, 27 Jun 2014 18:20:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7ztVI6hRbuVzjuGcPG0AynNjseM=; b=VgHua/
	W/aKoifZTMI98BbAk2uM+SOCAV4uzWpI/duWo7zrnh8wk4wSIwAgrnxPHpKWvUo5
	6Nx5gqsVWW05qwntTkG9GDG0+G3gLgy5vt6rgiAj3vLz1DZ6onv+NeSQ8uuci5cZ
	tIBlB0P/gfpgqNllTgYxynm4HJ55zR/JyER2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z+eVUbVRE8nnSkvMh9SAZ5+u+w2Bdxl5
	Zhx0a7qNDwZUxvDdYSgHHw5f4P0CfGZUDgiLXOzAwvAoPbEqgaf4aIcRk39Ce1sj
	1ZissK3h6Xu5mXMQ5h3XqfRuOhxKx4/tS+Dz4vVABJfRA2Mx3pXM7yevUSfX4eOp
	t8K3MJKFubw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AAE422838;
	Fri, 27 Jun 2014 18:20:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 98A9E22837;
	Fri, 27 Jun 2014 18:20:44 -0400 (EDT)
In-Reply-To: <xmqq1tua2oi5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 27 Jun 2014 11:31:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 481086D0-FE49-11E3-A0DE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252584>

Junio C Hamano <gitster@pobox.com> writes:

> Felix Eckhofer <felix@tribut.de> writes:
>
>> This seems to have been caused by 3361a548db. After reverting this
>> commit, using --date-order appears to work again.
>
> Hmph, unfortunate.
>
> 3361a548 (Allow git-filter-branch to process large repositories with
> lots of branches., 2013-09-10) has this change:
>
>  
>     -rev_args=$(git rev-parse --revs-only "$@")
>     +git rev-parse --revs-only "$@" >../parse
>
> and then later feeds ../parse from the standard input of rev-list.
>
> The --revs-only option, because --date-order *is* a rev-list related
> argument, is emitted by the above rev-parse, along with the tip of
> refs (which come from --all).  But --stdin mode of rev-list is meant
> to receive *only* revisions, not options.  When it gets to the point
> to accept the list of tips to start traversing from, it is too late
> to give it an option.
>
> Changing the above to something like:
>
> 	git rev-parse --revs-only --no-flags "$@" >../parse
>
> would be a better workaround that would not break repositories with
> large number of references, but it obviously will lose --date-order
> option (why would it be even necessary, though?  I suspect that
> forcing the date-order will make the resulting pack a lot worse by
> robbing the data stream of locality).

As the original "../parse" file will have mixture of revs (i.e. the
object names) and whatever rev-list options (e.g. "--date-order")
you gave from the command line, here is a band-aid to sift them into
two, to be applied on top of 3361a548 (Allow git-filter-branch to
process large repositories with lots of branches., 2013-09-10).

I wish there was a way to tell rev-parse "give us only flags
relevant to rev-list, don't include revs in the output", but I do
not think there was ever any such option (we can get revs without
any flags with --no-flags, though).


 git-filter-branch.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ca3d539..ed55c01 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -255,7 +255,9 @@ else
 	remap_to_ancestor=t
 fi
 
-git rev-parse --revs-only "$@" >../parse
+git rev-parse --revs-only "$@" >../parse.revs.flags
+sed -ne '/^[0-9a-f][0-9a-f][0-9a-f]*[0-9a-f]$/p' <../parse.revs.flags >../parse.revs
+sed -e '/^[0-9a-f][0-9a-f][0-9a-f]*[0-9a-f]$/d' <../parse.revs.flags >../parse.flags
 
 case "$filter_subdir" in
 "")
@@ -268,7 +270,8 @@ case "$filter_subdir" in
 esac
 
 git rev-list --reverse --topo-order --default HEAD \
-	--parents --simplify-merges --stdin "$@" <../parse >../revs ||
+	--parents --simplify-merges --stdin "$@" \
+	$(cat ../parse.flags) <../parse.revs >../revs ||
 	die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
