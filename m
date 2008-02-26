From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Support TEST_GIT_PATH variable for the path for the git to
 test
Date: Tue, 26 Feb 2008 10:46:35 -0800
Message-ID: <7v63wb5zec.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251600220.19024@iabervon.org>
 <7v63wch9ia.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802261242210.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 19:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU4ps-0000qz-1q
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 19:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbYBZSqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 13:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbYBZSqv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 13:46:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbYBZSqu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 13:46:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 119101A75;
	Tue, 26 Feb 2008 13:46:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7A1B01A71; Tue, 26 Feb 2008 13:46:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75158>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 25 Feb 2008, Junio C Hamano wrote:
> ...
>> Also we tend to avoid "test -e" unless absolutely needed.
>
> This is supposed to be: don't complain if .git/hooks already doesn't 
> exist; also, create .git/info if it doesn't exist. What is the right style 
> for that? I've been only reading git shell code and writing C, other than 
> this little bit.

What I meant to say was we have tried to stick to "test -d" or
"test -f" and avoided a newer "test -e" when able.  It's not a
style but more about courtesy to porters.  Majority of platforms
do not care.

>> I have bunch of gits installed under $HOME/git-vX.Y.Z/bin and
>> when I need to test one from a different vintage, I just say:
>> 
>> 	PATH=$HOME/git-vX.Y.Z/bin:/usr/bin:/bin
>> 	... do git stuff which all use version X.Y.Z
>> 
>> and have $HOME/git-vX.Y.Z/bin/git find its corresponding friends
>> on the GIT_EXEC_PATH embedded in it.  Because you are interested
>> in testing installed versions, I suspect something like:
>> ...
>> would be easier to read and more to the point....
>
> That doesn't make test_create_repo() work right.

I did not mean to imply I was presenting the whole solution; I
was trying to hint at a different direction which may or may not
work.  I did not look at what test_create_repo() actually did
when I wrote the message, but you are right.  It too needs to
be made conditional, and when trying an installed version, it
should not do the "template" dance but let the installed "git init"
figure it out.

> There's additionally the problem that things which are built for testing 
> in the git directory won't be installed anywhere.

To test without installing, in order to make them call out their
siblings, I have this piece that I source to a new shell:

        GIT_EXEC_PATH=`pwd`
        PATH=`pwd`:/usr/bin:/bin
        GITPERLLIB=`pwd`/perl/blib/lib
        export GIT_EXEC_PATH PATH GITPERLLIB

(and this is not enough if what is being tested is a change to
the templates, but that is rare so I haven't bothered).  We
could do something similar and tell the test scripts where that
directory is via GIT_TEST_SOURCE_DIR perhaps, if we were to
support this third variant?

I originally thought that the problem you are trying to solve
was more like "My WIP does not work well with the tests yet, but
how does the one from my distro sitting in /usr/bin/git (and
calling /usr/bin/git-clone when told to 'git clone') work on
them?" (i.e. as opposed to "testing the one we just built here",
which our test scripts are about originally, "testing an
installed version" --- let's call that the second variant).

And for that, not setting nor exporting is the right way (you
run tests as if they are just a random set of user scripts that
happen to call "git" as intended).  

If you want to test git that you just have built, you arrange
that your use of "git-foo" and "git foo" both refer to what's in
$(pwd) and that is something t/test-lib.sh already knows how to
take care of.  The third variant of testing git that you built
elsewhere else should be easier to implement by borrowing the
current setup, just replacing $(pwd) with $elsewhere, I would
imagine.  But that depends on the target git version --- it may
have different rules and expect different settings, so we cannot
have a perfectly futureproof support for this kind of testing.

We would ideally want both (installed vs potentially different
vintage built elsewhere), but they have different requirements.
The latter wants more than just $PATH tweaked, while the former
do not want anything to be tweaked but use the environment the
user has as-is.  Maybe the user is always running with a strange
$GIT_EXEC_PATH and he wants to test _that_ configuration.

So how about making these two separate changes?

 (1) a patch that lets you say "We are going to test a built but
     not installed git, but that build directory is not in this
     tree" (i.e. the third variant) with TEST_GIT_SOURCE_TREE.
     When unset, we will test a built but not installed git here
     in this tree.  I would imagine it would mostly be the
     matter of replacing use of $(pwd) to specify where the
     built stuff is, with $TEST_GIT_SOURCE_TREE (use of
     GIT_EXEC_PATH to find template in test_create_repo needs to
     be fixed);

 (2) a patch that lets you say "Test what is installed on my
     $PATH using my $GIT_EXEC_PATH and friends if they exist.
     Do not muck with my environment", with TEST_GIT_INSTALLED
     or something.
