From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Where is information of "git read-tree" stored?
Date: Mon, 19 Sep 2011 15:09:22 -0700
Message-ID: <7vobyg89rh.fsf@alter.siamese.dyndns.org>
References: <loom.20110919T103707-867@post.gmane.org>
 <7vzki0a0yd.fsf@alter.siamese.dyndns.org> <j586pb$emh$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Tue Sep 20 00:09:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5m1s-0002YG-8D
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 00:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429Ab1ISWJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 18:09:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50704 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755169Ab1ISWJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 18:09:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE38E5F0F;
	Mon, 19 Sep 2011 18:09:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fvs9zGZRbP/eel7NwAzdk8abRBI=; b=NpEBkE
	cZQ3fYQEyvOmpH2gA2otIPMaIS1u6qYnNjsddujaACWN8bwvReW3mLMbbnRWZDZ7
	LAAF/ZHAtQi9opKzjs6BxxWNiaN8HUzg6HCYZoisuMMQwfWh4dpcHrA3jWnnWo4O
	6c051sMbb2+pkJFqfho1H/c+x1LpvvIZakhXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x1QwchcshzQegWgP+Raz7VzqVH7o8jND
	DXIf5yGIUSMOCt+FAZ+gnL0IWTHk5KRbnLrA2D+qmv42K6dchs6llEpVCcGSXdpX
	niE3JmMbvlJSQSjYtbKFrPQBFwVy3kxZtehrggwVcLJE9Ed5/EgfbLpIqGVcJhRS
	PAMSa98Bh+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6B265F0E;
	Mon, 19 Sep 2011 18:09:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 066E35F0C; Mon, 19 Sep 2011
 18:09:23 -0400 (EDT)
In-Reply-To: <j586pb$emh$1@dough.gmane.org> (Manuel Reimer's message of "Mon,
 19 Sep 2011 21:52:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 085A6BC4-E30C-11E0-BAD0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181713>

Manuel Reimer <Manuel.Spam@nurfuerspam.de> writes:

>> That "how to" may be badly written and this may have been unclear to you
>> but the first four steps are to be done _only once_ to set things up, and
>> after that you need to run only the fifth step whenever you want to update
>> from the Bproject. Could you suggest a better wording to update the doc?
>
> As long as I don't understand what's going on here, I can't suggest
> how to improve the documentation.
>
>> The very first "subtree merge" (the one that is recorded with the commit
>> after the read-tree) records all paths from Bproject renamed to elsewhere
>> in the merge result (you can view it with "git show -M
>> $that_merge_commit")
>
> Tried that, but the stuff, I saw on screen, doesn't make clear how GIT
> knew about what to do here.

To a certain degree, the point of a tool is that the user does not need to
know about the details, but if you are interested...

Suppose you have this tree structure in your "original" project:

        Documentation/README.txt
        hello.c
	Makefile

and then somebody else has this structure in his project (in your case, it
may happen to be stored in SVN but once it is slurped in a git repository,
it does not matter):

        goodbye.c
	Makefile

Further suppose that you would want to end up with this tree structure:

        Documentation/README.txt
	Makefile
        hello.c
        imported/Makefile
        imported/goodbye.c

i.e. you would want to move stuff that came from the other project in imported/
hierarchy.  There may be many other files, and even subdirectories, in the
other project, but they all are shifted one level down and placed in imported/
hierarchy.

The first four steps of the howto is to create such a final tree structure
and make a merge commit out of that tree.

After you update your project (which now has both the original files such
as hello.c etc., may have added new files, and may even have updated stuff
inside imported/ hierarchy) and the other side updated their project (e.g.
it may have updated goodbye.c whose change you would want to carry over to
your imported/goodbye.c, or it may have added a new file welcome.c, which
you would want to import as imported/welcome.c), you would invoke "pull -s
subtree", which in turn runs "merge -s subtree".

The subtree strategy first compares the shapes of two trees being merged,
and tries to find how much they have to be shifted to match.  Your tree
may now have:

        Documentation/README.txt
	Makefile
	hello.h (added)
        hello.c
        imported/Makefile
        imported/goodbye.c

while the other side may now have:

        goodbye.c
	Makefile
	welcome.c

The subtree strategy notices that by prefixing "imported/" in front of the
paths, the tree from the other side will match the shape of the subtree
you have under "imported/". Thus it can pair:

	their "goodbye.c" with your "imported/goodbye.c"
        their "Makefile" with your "imported/Makefile"
        their "welcome.c" with your "imported/welcome.c"

and merge the changes. The common ancestor commit of this merge will be
the initial merge you made with the first 4-step, so the three-way merge
logic would notice that there wasn't "welcome.c" in the beginning, they
added that path, while you did not do anything to the path that
corresponds to it (namely, "imported/welcome.c"), so the new "welcome.c"
file from the other project would simply be copied as "imported/welcome.c"
to your tree, and the change they made to "goodbye.c" and your changes you
made to your "imported/goodbye.c" will be merged and result is recorded in
your "imported/goodbye.c".

If "compares the shape and figures out how much to shift" makes you feel
uneasy (and it probably should), you can give an explicit directory prefix 
as the backend option "subtree" (see "git merge help" for details).
