From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Support TEST_GIT_PATH variable for the path for the git
 to test
Date: Tue, 26 Feb 2008 13:02:04 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802261242210.19024@iabervon.org>
References: <alpine.LNX.1.00.0802251600220.19024@iabervon.org> <7v63wch9ia.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 19:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU48b-0006sh-Fb
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 19:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759172AbYBZSCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 13:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761672AbYBZSCH
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 13:02:07 -0500
Received: from iabervon.org ([66.92.72.58]:47020 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759172AbYBZSCG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 13:02:06 -0500
Received: (qmail 14552 invoked by uid 1000); 26 Feb 2008 18:02:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2008 18:02:04 -0000
In-Reply-To: <7v63wch9ia.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75157>

On Mon, 25 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > @@ -281,7 +281,8 @@ test_create_repo () {
> >  	cd "$repo" || error "Cannot setup test environment"
> >  	"$GIT_EXEC_PATH/git" init --template=$GIT_EXEC_PATH/templates/blt/ >/dev/null 2>&1 ||
> >  	error "cannot run git init -- have you built things yet?"
> > -	mv .git/hooks .git/hooks-disabled
> > +	[ ! -e .git/hooks ] || mv .git/hooks .git/hooks-disabled
> > +	[ -e .git/info ] || mkdir .git/info
> 
> This is just a style issue, but if you try to be old fashioned,
> please say "test frotz || xyzzy".  If you prefer to be modern,
> "if ! test frotz; then xyzzy; fi".  I'd prefer the former, but
> in either case I really do not want to see [ ... ] that do not
> make anything more readable.
> 
> Also we tend to avoid "test -e" unless absolutely needed.

This is supposed to be: don't complain if .git/hooks already doesn't 
exist; also, create .git/info if it doesn't exist. What is the right style 
for that? I've been only reading git shell code and writing C, other than 
this little bit.

> > @@ -321,8 +322,8 @@ test_done () {
> >  
> >  # Test the binaries we have just built.  The tests are kept in
> >  # t/ subdirectory and are run in trash subdirectory.
> > -PATH=$(pwd)/..:$PATH
> > -GIT_EXEC_PATH=$(pwd)/..
> > +GIT_EXEC_PATH=${TEST_GIT_PATH:-$(pwd)/..}
> > +PATH=$GIT_EXEC_PATH:$(pwd)/..:$PATH
> 
> Hmmmm.
> 
> I have bunch of gits installed under $HOME/git-vX.Y.Z/bin and
> when I need to test one from a different vintage, I just say:
> 
> 	PATH=$HOME/git-vX.Y.Z/bin:/usr/bin:/bin
> 	... do git stuff which all use version X.Y.Z
> 
> and have $HOME/git-vX.Y.Z/bin/git find its corresponding friends
> on the GIT_EXEC_PATH embedded in it.  Because you are interested
> in testing installed versions, I suspect something like:
> 
> 	if test -z "$TEST_GIT_ON_PATH"
> 	then
>                 GIT_EXEC_PATH=$(pwd)/..
>         	PATH=$GIT_EXEC_PATH:$PATH
> 	else
>         	: We do not do any customization
> 	fi
> 
> would be easier to read and more to the point.  Perhaps the
> tester even has his own GIT_EXEC_PATH that is unrelated to
> TEST_GIT_PATH.

That doesn't make test_create_repo() work right. Is there some reason it's 
currently using it with an explicit path, or is that just a legacy of when 
it wasn't running the git that gets tested in general? With that 
simplified, it seems to work this way, I think, and that's almost 
certainly the right thing to do.

There's additionally the problem that things which are built for testing 
in the git directory won't be installed anywhere. One possibility would be 
to put $(pwd)/.. at the end of the PATH (instead of the start), but I 
think it would be cleanest to put the built test tools somewhere else and 
include that directory in the PATH no matter what. Does this sound like 
the right track?

	-Daniel
*This .sig left intentionally blank*
