From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Support TEST_GIT_PATH variable for the path for the git to
 test
Date: Mon, 25 Feb 2008 16:00:29 -0800
Message-ID: <7v63wch9ia.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251600220.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 01:01:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTnG8-0008Ez-6b
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 01:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757913AbYBZAAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 19:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757690AbYBZAAr
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 19:00:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757545AbYBZAAr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 19:00:47 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7305B2E99;
	Mon, 25 Feb 2008 19:00:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 75CB82E98; Mon, 25 Feb 2008 19:00:39 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802251600220.19024@iabervon.org> (Daniel
 Barkalow's message of "Mon, 25 Feb 2008 18:21:34 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75093>

Daniel Barkalow <barkalow@iabervon.org> writes:

> @@ -281,7 +281,8 @@ test_create_repo () {
>  	cd "$repo" || error "Cannot setup test environment"
>  	"$GIT_EXEC_PATH/git" init --template=$GIT_EXEC_PATH/templates/blt/ >/dev/null 2>&1 ||
>  	error "cannot run git init -- have you built things yet?"
> -	mv .git/hooks .git/hooks-disabled
> +	[ ! -e .git/hooks ] || mv .git/hooks .git/hooks-disabled
> +	[ -e .git/info ] || mkdir .git/info

This is just a style issue, but if you try to be old fashioned,
please say "test frotz || xyzzy".  If you prefer to be modern,
"if ! test frotz; then xyzzy; fi".  I'd prefer the former, but
in either case I really do not want to see [ ... ] that do not
make anything more readable.

Also we tend to avoid "test -e" unless absolutely needed.

> @@ -321,8 +322,8 @@ test_done () {
>  
>  # Test the binaries we have just built.  The tests are kept in
>  # t/ subdirectory and are run in trash subdirectory.
> -PATH=$(pwd)/..:$PATH
> -GIT_EXEC_PATH=$(pwd)/..
> +GIT_EXEC_PATH=${TEST_GIT_PATH:-$(pwd)/..}
> +PATH=$GIT_EXEC_PATH:$(pwd)/..:$PATH

Hmmmm.

I have bunch of gits installed under $HOME/git-vX.Y.Z/bin and
when I need to test one from a different vintage, I just say:

	PATH=$HOME/git-vX.Y.Z/bin:/usr/bin:/bin
	... do git stuff which all use version X.Y.Z

and have $HOME/git-vX.Y.Z/bin/git find its corresponding friends
on the GIT_EXEC_PATH embedded in it.  Because you are interested
in testing installed versions, I suspect something like:

	if test -z "$TEST_GIT_ON_PATH"
	then
                GIT_EXEC_PATH=$(pwd)/..
        	PATH=$GIT_EXEC_PATH:$PATH
	else
        	: We do not do any customization
	fi

would be easier to read and more to the point.  Perhaps the
tester even has his own GIT_EXEC_PATH that is unrelated to
TEST_GIT_PATH.
