From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On the behavior of checkout <branch> with uncommitted local changes
Date: Thu, 19 Sep 2013 10:43:16 -0700
Message-ID: <xmqqfvt0u2q3.fsf@gitster.dls.corp.google.com>
References: <8904036.vOg3y5OkbU@ipht-ia-004976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: r.ductor@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 19 19:43:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMiGB-00005O-Ug
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 19:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab3ISRnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 13:43:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689Ab3ISRnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 13:43:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D040742037;
	Thu, 19 Sep 2013 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IH82W6L4Gg+JuAFTYinmr2liNY4=; b=s1LZ3T
	SrS3KhKldflIahN6ELekgiP31SZ/xYiI6MmOFCKHq6UpFyF8o75fOBM006HZoZya
	h8z5dV5sHstiGpDP4oXkoR4CYOT1Tm8nF90TZPMfQwTs6wAWrqH2rsGq3cgkwEPJ
	HgAoD5p7SX9oEy88MYFY4zurqwMbv2qafp+GY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CDA+XPitkoPne6Ls31cxKP6VR/LNuDV9
	0ZR27Nu8AWagkPmHUwgNvvUK7dGHBs4KhSE0FyGQE8NDzGFCM4bJHp/cGhDQlBJv
	kN0EPKzpZEhPVsm+d352E5EaF9VH1QUhVrvuh4Y/F+LWRXAdmzL0ofpiswio/3E2
	kBoPRztsXPg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE10D42036;
	Thu, 19 Sep 2013 17:43:18 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2A9742034;
	Thu, 19 Sep 2013 17:43:17 +0000 (UTC)
In-Reply-To: <8904036.vOg3y5OkbU@ipht-ia-004976> (r. ductor's message of "Thu,
	19 Sep 2013 02:23:11 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F7D273BE-2152-11E3-B434-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235022>

r.ductor@gmail.com writes:

> The man section for git checkout ... In
> particular it is not clearly (unambiguously) stated what happens
> to index and worktree whenever local uncommitted changes are
> around.

In the current text, the key information is in two places:

    'git checkout' <branch>::
            To prepare for working on <branch>, switch to it by updating
            the index and the files in the working tree, and by pointing
            HEAD at the branch. Local modifications to the files in the
            working tree are kept, so that they can be committed to the
            <branch>.

    -m::
    --merge::
            When switching branches,
            if you have local modifications to one or more files that
            are different between the current branch and the branch to
            which you are switching, the command refuses to switch
            branches in order to preserve your modifications in context.

Let's see how we can improve the text.  Points to notice are:

 * "by updating the index and the files" does not say "how" they are
   updated and can be clarified:

    - The index is made to match the state the commit at the tip of
      <branch> records.

    - The working tree files without local modifications are updated
      the same way.

    - The working tree files with local modifications are not
      touched.

 * Because "the command refuses to checkout another branch under
   this and that condition" does not have its own section, the
   description of "-m" needs to say it as a background information
   to explain in what situation the option may be useful.  It can be
   moved to the main "'git checkout' <branch>" part and it may make
   the result read easier.

 * "in order to preserve your modifications in context" is correct
   and sufficient description, but it requires some thinking in
   readers' part to understand why it is a good thing.  It can be
   clarified.  The thinking goes like this.

   Suppose your current branch has file X whose contents is X0 (that
   is, the commit at the tip of this branch records file X with
   content X0).  You have local changes to this file and its
   contents is X1.  The index at path X is unchanged and still
   records X0.

   The branch you are checking out has contents X2 at the path.

   If we allowed "git checkout <the other branch>" and simply kept
   the local changes, you will end up in a funny state in which:

    - The tip commit, that will become the parent commit when you
      make the next commit, has X2 at path X.

    - The index has X2 at path X to match the tip commit.  You could
      change this to keep X0 but it does not matter in the larger
      picture, because you will be editing the working tree version
      and updating the index from there to prepare for the next
      commit.

    - The working tree has contents X1 at path X.  But realize that
      the change "you" made is the difference between X0 and X1, not
      X2 and X1.

   If we allowed such a checkout and then you did "git commit -a",
   you will end up reverting the state between X0 (contents in your
   original branch) and X2 (contents in the new branch), even though
   the change you wanted to make was only the difference between X0
   and X1.

Also, if you did "git add X" and then "checkout <branch>", unless
the version in the index at path X match either your original branch
or the branch you are checking out, the command will stop you, and
the "-m" option does not resolve this with a 4-way merge (it will be
too complex for users to understand if we did so).
