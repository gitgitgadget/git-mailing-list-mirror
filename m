From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add more checkout tests
Date: Sun, 09 Dec 2007 19:42:57 -0800
Message-ID: <7vprxfmczi.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712092204200.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 04:43:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ZYP-0006YX-43
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 04:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbXLJDnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 22:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbXLJDnN
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 22:43:13 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:60059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbXLJDnM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 22:43:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 836402D00;
	Sun,  9 Dec 2007 22:43:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BFE7D2CFF;
	Sun,  9 Dec 2007 22:43:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67674>

Daniel Barkalow <barkalow@iabervon.org> writes:

> +test_expect_success "checkout with unrelated dirty tree without -m" '
> +
> +	git checkout -f master &&
> +	fill 0 1 2 3 4 5 6 7 8 >same &&
> +	cp same kept
> +	git checkout side >messages && 
> +	git diff same kept
> +	(cat > messages.expect <<EOF
> +M	same
> +EOF
> +) &&
> +	touch messages.expect &&
> +	git diff messages.expect messages
> +'

What is this "touch" about?

I do not recall the details, but we had problem reports that some shells
do not handle here-documents (i.e. cmd <<EOF) inside test_expect_success
well, and generally tried to keep them outside.  I however see some of
the newer tests do have here-doc inside expect-success, and do not
recall hearing breakage reports on them.  Maybe it was a false alarm and
we were being overly cautious, or maybe not enough people (especially on
more exotic systems) are running tests these days.  Let's keep the
here-doc as-is in your tests and see what happens.

>  test_expect_success "checkout -m with dirty tree" '
>  
>  	git checkout -f master &&
>  	git clean -f &&
>  
>  	fill 0 1 2 3 4 5 6 7 8 >one &&
> -	git checkout -m side &&
> +	git checkout -m side > messages &&
>  
>  	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
>  
> +	(cat >expect.messages <<EOF
> +Merging side with local
> +Merging:
> +ab76817 Side M one, D two, A three
> +virtual local
> +found 1 common ancestor(s):
> +7329388 Initial A one, A two
> +Auto-merged one
> +M	one
> +EOF
> +) &&
> +	git diff expect.messages messages &&

I do not like the idea of testing the exact wording of messages this
way.

I do not think we care about the exact wording of these messages, and I
think our tests should check what we do care about without casting the
UI in stone.  Otherwise, it will make it harder to clean-up the user
experience later.  Perhaps it would be sufficient to make sure that (1)
this checkout succeeds with exit 0 status, and that (2) the contents of
the merged 'one' is a reasonable merge result, i.e. "git diff HEAD one"
gets the same patch-id as "git diff HEAD one" taken before switching the
branches.

> @@ -145,7 +176,16 @@ test_expect_success 'checkout -m with merge conflict' '
>  test_expect_success 'checkout to detach HEAD' '
>  
>  	git checkout -f renamer && git clean -f &&
> -	git checkout renamer^ &&
> +	git checkout renamer^ 2>messages &&
> +	(cat >messages.expect <<EOF
> +Note: moving to "renamer^" which isn'"'"'t a local branch
> +If you want to create a new branch from this checkout, you may do so
> +(now or later) by using -b with the checkout command again. Example:
> +  git checkout -b <new_branch_name>
> +HEAD is now at 7329388... Initial A one, A two
> +EOF
> +) &&
> +	git diff messages.expect messages &&

Same here.  If we want to make sure the head is detached at the intended
commit, make sure "rev-parse HEAD" gives the expected result, and make
sure "symbolic-ref HEAD" says it is not symbolic.

>  	H=$(git rev-parse --verify HEAD) &&
>  	M=$(git show-ref -s --verify refs/heads/master) &&
>  	test "z$H" = "z$M" &&
> -- 
> 1.5.3.6.886.gb204
