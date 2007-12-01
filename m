From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Sat, 01 Dec 2007 10:58:53 -0800
Message-ID: <7v4pf25jiq.fsf@gitster.siamese.dyndns.org>
References: <20071128165837.GA5903@laptop>
	<Pine.LNX.4.64.0711281703470.27959@racer.site>
	<fcaeb9bf0711280910x40fecdd5mf6d86e4a9b656d01@mail.gmail.com>
	<Pine.LNX.4.64.0711281717460.27959@racer.site>
	<fcaeb9bf0711280924v34160eddsf8a75f8f8cee389c@mail.gmail.com>
	<Pine.LNX.4.64.0711281810410.27959@racer.site>
	<7v3aunb0q4.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711302250ldfb543evd6d5f70d95ae51f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 19:59:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyXYz-0001KW-6X
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 19:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbXLAS7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 13:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbXLAS7J
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 13:59:09 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36024 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbXLAS7H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 13:59:07 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E09AE2F0;
	Sat,  1 Dec 2007 13:59:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 24AE59AD56;
	Sat,  1 Dec 2007 13:59:16 -0500 (EST)
In-Reply-To: <fcaeb9bf0711302250ldfb543evd6d5f70d95ae51f7@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Sat, 1 Dec 2007 13:50:36 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66731>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On Dec 1, 2007 9:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Looks sensible, but can this be accompanied with a trivial test to
>> demonstrate the existing breakage?
>
> How can I reliably check setup_git_directory_gently()? I can pick one
> command that uses setup_git_directory_gently(). But commands change.
> Once they turn to setup_git_directory(), the test will no longer be
> valid.

The commands' implementation may change but what I meant was to test the
intent.

What's the difference between commands that call "gently" kind and
non-gently kind?  The former is "I do not _have_ to be in a git
repository but if I am then I want to know about it and use some
information from that repository", as opposed to "I need to be in a git
repository and will find one otherwise I barf" which is the latter kind.

The intent of the change, from reading your patch, is that currently the
former kind of commands that take "an optional git repository" are happy
if they find a directory that looks like a git repository and go ahead
with their operation without checking the repository format version, and
your patch addresses this issue by making sure that the git repository
found via "gently" are also checked for the format version.

Examples of commands that do not necessarily require a valid git
repository are:

 * apply: when being used as a "patch that is better than GNU", that is,
   without --index, --cached, nor --check option.

 * bundle: when verifying and listing the contained head of an existing
   bundle file.

 * config: without being in a git repository, you can still interact with
   $HOME/.gitconfig and /etc/gitconfig [*1*].

 * ls-remote: without being in a git repository, you can still list refs
   from a remote repository.  If you are in a git repository, you can
   use nicknames you have in your repositories' remote.$nickname.url
   configuration.

So what I would suggest would be:

 * The directory your tests run in, t/trash, is a valid git repository.
   Leave it as is.

 * mkdir test inside t/trash, cd there, and run "git init" there to
   initialize t/trash/test/.git (the shell function test_create_repo can
   be used for this).

 * corrupt this by updating the core.repositoryformatversion to a large
   value, by doing something like:

        V=$(git config core.repositoryformatversion)
	(
		cd test
		N=$(( ${V:-0} + 99 ))
	        git config core.repositoryformatversion $N
	)

 * make sure t/trash/test/.git/config file, and not t/trash/.git/config
   file, got that change by doing something like:

	GIT_CONFIG=.git/config git config core.repositoryformatversion
	GIT_CONFIG=test/.git/config git config core.repositoryformatversion

   The former would report the current version ($V above) while the
   latter should error out.

Up to this step is the "test setup".  The actual tests would be done in
t/trash/test directory.

 * Use a few commands that have the "we can run in git repository but we
   do not have to" behaviour, in modes that _require_ git repository.
   For example, "git apply --check" wants a valid repository to check
   the patch against the index.  They should fail because the repository
   format is too new for them to understand.

 * Similarly, run a few commands in modes that do not require git
   repository.  For example, "git apply --stat" of an existing patch
   should be viewable no matter where you are (that is just a "better
   diffstat" mode), so ideally it should not barf only because you
   happen to be in a repository that is too new for you to understand.
   I do not know offhand how your patch would handle this situation.

Note that making sure the latter works is tricky to do right, for a few
reasons.

 (1) It is not absolutely clear what the right behaviour is.  It could
     be argued that we should just barf saying we found a repository we
     do not understand, refraining from doing any damange on it [*2*].

 (2) If we choose not to barf on such a repository, it remains to be
     decided what "gently" should do --- if it should still treat
     t/trash/test (which has too new a version) as the found repository,
     or ignore it and use t/trash (which we can understand) as the found
     repository.  I think it should do the former.

     IOW, the repository we are working against is t/trash/test/.git in
     this case, and not t/trash/.git.  We do not actually touch the
     repository because we do not know the repository format version of
     it, but we do not barf when doing operations that we do not have to
     touch it.  And we never touch t/trash/.git.  We need to make sure
     of these, which means that it is not enough to make sure
     non-repository operations do not barf in t/trash/test. We also need
     to make sure the reason they do not barf is not because we ignored
     that repository with unknown version and went one level up and
     found a repository with a known version.  The reason for success
     must be because we correctly ignored the version mismatch because
     we knew the operations do not affect the repository.

[Footnotes]

*1* Tangent. "git grep etc/gitconfig" reveals a few instances of 
    $(prefix)/etc/gitconfig left behind, which was corrected in
    v1.5.1.3.  We need documentation updates.

*2* However, "we do not have to be in git repository" mode of operations
    by definition do not touch any repository data (only work tree
    files), so I do not think it is justfied to barf in such a case.
