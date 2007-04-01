From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] Alternate index output file
Date: Sat, 31 Mar 2007 23:27:54 -0700
Message-ID: <7v4po04nit.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwt11itbz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703280759230.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 01 08:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXtXr-0007Z5-HG
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 08:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbXDAG14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 02:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbXDAG14
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 02:27:56 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45632 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710AbXDAG1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 02:27:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070401062755.QFHN792.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Apr 2007 02:27:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hiTu1W00C1kojtg0000000; Sun, 01 Apr 2007 02:27:55 -0400
In-Reply-To: <Pine.LNX.4.64.0703280759230.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 28 Mar 2007 08:13:38 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43579>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> (Looking at git-commit.sh, the thing I *really* think we should do is to 
> have a "GIT_INDEX_FILE_OUTPUT" environment variable that does locking on 
> the input file, but writes the result to another file: rigth now 
> git-commit.sh (a) wastes time copying the old index file by hand and (b) 
> as a result doesn't even honor any locking on it.

I've done this with an environment variable, and it passes all
the tests, but I think for this application an environment is
really a mistake.  As expected, the change to git-commit.sh
looks like:

        diff --git a/git-commit.sh b/git-commit.sh
        index 292cf96..20c0dc8 100755
        --- a/git-commit.sh
        +++ b/git-commit.sh
        @@ -370,8 +370,8 @@ t,)
                        # the same way.
                        if test -z "$initial_commit"
                        then
        -			cp "$THIS_INDEX" "$TMP_INDEX"
        -			GIT_INDEX_FILE="$TMP_INDEX" git-read-tree -i -m HEAD
        +			_GIT_INDEX_OUTPUT="$TMP_INDEX" \
        +			GIT_INDEX_FILE="$THIS_INDEX" git-read-tree -i -m HEAD
                        else
                                rm -f "$TMP_INDEX"
                        fi || exit

However, I had to say something like this in the documentation:

        diff --git a/Documentation/git.txt b/Documentation/git.txt
        index dceacfa..bc025d6 100644
        --- a/Documentation/git.txt
        +++ b/Documentation/git.txt
        @@ -311,6 +311,15 @@ git so take care if using Cogito etc.
                index file. If not specified, the default of `$GIT_DIR/index`
                is used.

        +'_GIT_INDEX_OUTPUT'::
        +	When this environment is defined, plumbing level
        +	commands that update the index writes the resulting
        +	index to this file, instead of the usual
        +	`GIT_INDEX_FILE` (or its default `$GIT_DIR/index`).
        +	This is solely meant to be used by Porcelain to drive
        +	low-level plumbing.  Defining this in user's environment
        +	is always an error.  Do not use it.
        +
         'GIT_OBJECT_DIRECTORY'::
                If the object storage directory is specified via this
                environment variable then the sha1 directories are created

If a curious user has the environment variable set to something
other than the file GIT_INDEX_FILE points at, almost everything
will break.  This should instead be a command line parameter to
tell these plumbing commands to write the result in the named
file, to prevent stupid mistakes.
