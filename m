From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Inconsistency with -a vs -A
Date: Mon, 18 Apr 2011 02:56:34 -0700
Message-ID: <7vbp03ann1.fsf@alter.siamese.dyndns.org>
References: <loom.20110418T051443-551@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bradly Feeley <bradlyf@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 11:57:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBlCW-0004L2-Fd
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 11:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab1DRJ4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 05:56:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab1DRJ4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 05:56:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B974344F;
	Mon, 18 Apr 2011 05:58:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6PPTCowmsFXJqLVABN+i2/6ytvc=; b=HwGWCo
	/FXjyUPSqkVGaOoFTb62+cthcs1zSqFxEplZjHVGpi60TL+Tl9UymdBpgLZgsVji
	GcqhU60iVk9+spn3+FZSjyA6t7X4S386TX5rZfu+SPzV4NnWRLb6c+NDIIsHg24C
	aYFcT5UlPmoEqRc4wNRu/ztHjqvrUqLsNt3a8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iSt2SH6yYYlWwoqvQO0VadFhFZo3YhU6
	QSEgC/qCoP3eusdtwqgo1Izdpis8ob/rZWq1HRpzBJ3zPjsLy2WqYcSqOP0W5ydj
	nAJfBg+YzKEOxES+xHtZ1VlFTUIPf3Pue+4B+GWwLFVd/aJpdzC+yzeVRhHVqBoZ
	fo8BM4Ux4V8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 096FF344E;
	Mon, 18 Apr 2011 05:58:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1BBC1344B; Mon, 18 Apr 2011
 05:58:35 -0400 (EDT)
In-Reply-To: <loom.20110418T051443-551@post.gmane.org> (Bradly Feeley's
 message of "Mon, 18 Apr 2011 03:20:55 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F086076-69A2-11E0-AEAB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171741>

Bradly Feeley <bradlyf@gmail.com> writes:

> I was curious if there was a reason that some command use -a and some command
> use -A.

In the context of SCM, the word "all" is unfortunately ambiguous. In most
cases, when you say "all", you do not mean everything under the sun, but
only mean the tracked subset of everything.

For example, "commit -a" only includes the paths that have been tracked,
and grabs the up-to-date contents in them in your working tree. It does
not add paths that have been untracked to the set of tracked paths. This
was historically useful because we started out without a good .gitignore
support and "commit ." is not "everything" when run from a subdirectory.

Also many commands (e.g. "git diff", "git grep") work on "all tracked"
when you do not explicitly name what to operate on.  Even when you specify
what subset to operate on, that subset is still taken from "all tracked",
not "everything in the working tree" (e.g. "git grep -e frotz ." does not
look into any untracked paths).

When you think about "tracked" vs "untracked", you would realize that
"add" is and has to be an oddball. It is the primary mechanism to start
tracking hitherto untracked paths.  For this reason, "git add ." has to
look at untracked paths and add them (contrast this with the "git grep"
example above).

We named the "update contents for all tracked paths" option "-u", avoiding
to say "-a" on purpose, because "all" is an ambiguous word, especially in
the context of "git add" command.  It perhaps was being overly cautious in
hindsight.

One important case to think about is that "git commit -a". Most commands
limit the set of paths they operate on from all tracked paths, and this
command has to mean "take the up-to-date contents from all tracked files
and make a commit".  So does "git commit ." run from the top-level of the
tree.

Now, what if you have a bunch of hitherto untracked paths, have a well
maintained .gitignore file, want to add and commit them, and want to be
lazy (i.e. you hate that "git add . && git commit" are two commands)?
There needs a way to say "everything under the sun" to please such people.

That is where "git commit -A" came from. "add -A" is an option that is
unnecessary ("git add ." would do just fine), but was added to give a
warm-fuzzy feel of consistency between "commit" and "add", in preparation
of the planned addition of "git commit -A" that didn't happen.

The only uppercase "-A" I am aware of are these two, and both are about
"everything under the sun", which is a special case in the context of SCM.
All the other usual "all" options are spelled "-a".

I think we could give "add -a" as a synonym to "add -u", which would be a
safe addition that would not break any existing user, if we wanted to be
picky and really make things more consistent.

Also in the longer term, I suspect we probably should deprecate "add -A"
as a failed experiment, if we are not going to do "commit -A" after all.
"add ." and "add :/" (from a subdirectory) would be much less ambiguous,
and it will get rid of the only instance of "-A" that means something
slightly different from the usual "all".
