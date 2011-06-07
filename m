From: Junio C Hamano <gitster@pobox.com>
Subject: [rfd] auto-following tags upon "git push"?
Date: Tue, 07 Jun 2011 09:33:35 -0700
Message-ID: <7v4o417g9s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 18:33:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzDu-0004tY-Ol
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 18:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299Ab1FGQdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 12:33:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab1FGQdk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 12:33:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57C68411D;
	Tue,  7 Jun 2011 12:35:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=u
	XwhiGDTOViW4CnANwMbsLKEnWI=; b=ll6fGmppJtUYdsb5oLshMw8hSdOEiS7oi
	GVLmSoofqpxcqoQxBI4argI3lqy77yQ+1iGUMT1fjcc9zjScRqLPzrV2aHFX9xwn
	0hDJuFXgMjkuQQ8+K87nTHc9tvM9RFcZVMA8nFFVDT3hFDl2rYzBpE+GbJSZRvCp
	ET3mS6Rh5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=o1r
	Rl5Gf2x/UuBovEgkXR3msCQAO2T5Htj+OLb093tN369JrUNAFuEOHmBRVUwG7WQc
	neNKL8X3U2SEjEHzWJgOAVZyu/xy1fKMGQO6qcJbctdqmy35rJq4cpqmbnqoNNOr
	9sDeHDGLXEAIjVMmhdVANYJu9HwTbIfE07F7tNro=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44A22411C;
	Tue,  7 Jun 2011 12:35:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 643F3411B; Tue,  7 Jun 2011
 12:35:47 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 339EA820-9124-11E0-BABE-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175212>

It has been a very conscious design decision that "git push" does not push
tags without being told, as opposed to "git fetch" that can fetch tags
that point at commits that are being transferred.

The rationale is quite obvious, once you think about it. When fetching,
you are interacting with a remote repository somebody has published, which
means two important things: (1) the set of tags that exist there are all
the publisher wanted people to see, and (2) not only you but other people
will also see the same tags. In other words, tags in repositories you
fetch from are designed to be public and shared. It will facilitate
communication between developers if it is easy for everybody to fetch
these same tags.

When pushing, you are pushing from your working repository, which most of
the time is not public, and tags in that repository is not designed to be
public. You can use your own local tags to mark your progress, so it does
not make sense to blindly push all tags in your repository to the
repository you are pushing to publish your changes, whose tags are by
definition public.

	Side note: the same logic applies to pushing branches. The
	branches in the remote you fetch from are public, the ones in your
	repository are mixture of branches for your private work and
	branches for public consumption.

So the recommended workflow for publishers has always been:

 - work on private topic branches that do not have corresponding branches
   at the publishing repository to cook your work-in-progress;

 - integrate them when they are done to branches that do have
   corresponding branches at the publishing repository;

 - "git push" without any extra configuration will push "matching"
   branches, so that your private topic branches will stay private, and
   the integration branches used to communicate with everybody else will
   be pushed;

 - You can use a private tag to mark your point if you want to, and
   you can tag a release on a branch that is shared with public.

 - A new branch, or a new tag to be made public needs to be pushed
   explicitly. Requiring an explicit push, instead of blindly pushing
   everything, avoids contaminating the ref namespace of the public
   repository with your private topic branches and private tags by
   accident.

But we could do better.

Tags are designed to promote sharing of common reference points; the goal
is to ensure that within the scope of a project, when somebody says v1.0
is buggy, everybody else knows exactly which version v1.0 refers to (this
is the primary reason why we do not use separate-remote layout for tags).

Which also means that there is a social convention among everybody in the
project how public tags are named. Using a tag v2.4.3 to mark your private
progress point, when the project uses tags that match "v*.*.*" to mark
public releases, is not something any sane person would do.

So, while we still should _never_ automatically push any tag that points
at a commit that is being pushed out (i.e. inverse of "fetch" that auto
follows tags), if the user or the project can give a clear enough hint to
git which tags are for public consumption, we should at least be able to
push tags that are for public consumption and do point at commits that are
being pushed out.

This is just me thinking out loud, but a typical end-user transcript may
look something like this:

   Tell git that v*.* and v*.*.* are release tags (one-time set-up).
   $ git config --unset-all push.autotag
   $ git config --add push.autotag 'v*.*'
   $ git config --add push.autotag 'v*.*.*'

   Usual development process.
   $ git checkout master
   $ work work work

   Not very happy as the result is a mess, but it seems to work Ok.
   $ git tag wip

   Try it again with the wisdom gained from the previous attempt.
   $ rework rework rework

   How much improvement did we make? Hmm, looks good.
   $ git diff wip

   Use that for the release.
   $ git tag v1.2.0

   Push it out, with the usual matching (or "upstream") semantics plus
   the new auto-follow tags feature. Note that "wip" tag will not be sent.
   $ git push
