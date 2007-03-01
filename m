From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Thu, 1 Mar 2007 19:01:20 +0100
Organization: Dewire
Message-ID: <200703011901.21474.robin.rosenberg.lists@dewire.com>
References: <200703011206.47213.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 19:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMpZl-0004c7-95
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 19:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965472AbXCAR7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 12:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965474AbXCAR7p
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 12:59:45 -0500
Received: from [83.140.172.130] ([83.140.172.130]:8784 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S965472AbXCAR7o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 12:59:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A317A802E29;
	Thu,  1 Mar 2007 18:54:37 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28804-03; Thu,  1 Mar 2007 18:54:37 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id DD03D802809;
	Thu,  1 Mar 2007 18:54:34 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <200703011206.47213.andyparkins@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41109>

torsdag 01 mars 2007 13:06 skrev Andy Parkins:
> Junio was working on a gitattributes system.  Rather than be useful and
> write code, I wrote this document to show how an attribute system might
> work.
> 
> The ideas in this document come primarily from the "unresolved issues"
> thread from the git mailing list.  gmane/28388.  In particular, from:
>  - Brian Gernhardt
>  - Johannes Schindelin
>  - Junio Hamano
>  - Linus Torvalds
>  - Martin Waitz
>  - Nicolas Pitre
>  - Robin Rosenberg
>  - Theodore Tso
> So they deserve the credit for the ideas, and I deserve the blame for
> the description.
> 
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> This one is better.  I've included some of the points raised in the
> "unresolved issues" thread from January.
> 
>  Documentation/attributes.txt |  222 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 222 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/attributes.txt
> 
> diff --git a/Documentation/attributes.txt b/Documentation/attributes.txt
> new file mode 100644
> index 0000000..9877786
> --- /dev/null
> +++ b/Documentation/attributes.txt
> @@ -0,0 +1,222 @@
> +Git Attributes System
> +=====================
> +
> +This document is a work-in-progress.  It's only purpose is to assemble
> +attribute ideas into one place.
> +
> +== Attributes
> +
> +Individual paths are assigned attributes.  Typically they will only have
> +one attribute, typically named after the corresponding mime type of that
> +file.  However, it is not required that the attribute be a mime type nor
> +is it required that this be the only attribute.
> +
> +Attributes are attached to paths in one of two ways:
> +
> + - Via the .gitattributes file.  This will work in the same way as the
> +   .gitignore file.  That is, there can be multiple .gitattributes files
> +   throughout the working directory.
> +
> +   Typically the .gitattributes file will be a version controlled file,
> +   just like .gitignore.
> +
> +   The format of this file will be similar to .gitignore.  "#" starting
> +   a comment.  Globbing allowed.  Paths to subdirectories allowed.  Each
> +   path will be followed by the list of attributes that applies to that
> +   path.  Additionally, we would probably want a way of disabling an
> +   attribute.  For example
> +
> +   -------------------------------------
> +   # Sample .gitattributes file
> +   *.png image/png
> +   *.txt text/plain
> +   *.c text/plain source-file
> +   script/*.sh text/plain source-file
> +   # Disable text/plain for a particular file
> +   file-isnt-text-despite-extension.txt !text/plain
> +   -------------------------------------
> +
> + - Via the git configuration file system.  i.e. /etc/gitconfig,
> +   $HOME/.gitconfig and $GIT_DIR/config.
> +
> +   This supplies the same facility as the .gitattributes file but allows
> +   the attributes to be specifed out-of-tree.  This will give the
> +   advantage that standard attributes can be specified per-system via
> +   /etc/gitconfig; per-user via $HOME/config or per-repository via
> +   $GIT_DIR/config.
> +
> +   It will obviously be of different format from the .gitattributes
> +   file, but the attribute names and path specification will be
> +   identical (and specified as if from the root of the repository tree).
> +   For example:
> +
> +   ------------------------------------
> +   [attributes "*.png"]
> +       attribute = image/png
> +   [attributes "*.c"]
> +       attribute = text/plain
> +	   attribute = source-file
> +   ------------------------------------
> +
> +   (This is pretty ugly, because of the "*" and "." in the section name,
> +   however I can't think of another way of doing this without resorting to
> +   just copying the format of the .gitattributes file; like
> +   -------------------------------------
> +   [attributes]
> +       path = *.png image/png
> +	   path = *.txt text/plain
> +	   path = *.c text/plain source-file
> +   -------------------------------------
> +   but perhaps people would like that more?)
> +
> +With these two in place, attributes for files can be specified and
> +overridden easily.  The priority of the various files will be (from
> +lowest to highest)
> +
> + - /etc/gitconfig
> + - $HOME/.gitconfig
> + - .gitattributes
> + - $GIT_DIR/config
> +
> +The $GIT_DIR/config file is highest priority so that a user can always
> +override an attribute that is in a .gitattributes managed by someone
> +else.
> +
> +
> +== Handlers
> +
> +At this point git would be in a position to answer the question "what
> +attributes does this file have?" for any file in the tree.
> +
> +The handler system will allow us to specify operations that should be
> +performed on files with particular attributes.  For example, we might
> +want to have text files automatically filtered to match local line
> +ending conditions.
> +
> +----------------------------------------
> +[handler "fix-line-endings"]
> +  attribute = text/plain
> +  infilter = eol_lf
> +  outfilter = eol_local
> +----------------------------------------
> +
> +This definition creates a handler named "fix-line-endings" (don't suppose
> +they actually need names) that would run the "eol_lf" filter on check
> +in, and the "eol_local" filter on checkout.
> +
> +Similarly, we might want to tell git-show how to show images:
> +
> +----------------------------------------
> +[handler "show-images"]
> +  attribute = image/png
> +  attribute = image/jpeg
> +  attribute = image/gif
> +  prettyfilter = pipe display -
> +----------------------------------------
> +
> +With this filter in place,
> +----------------------------------------
> + $ git-show v1.0.0:images/picture.png
> +----------------------------------------
> +Would run "display -" and pipe the picture to it.
> +
> +Multiple filters can be supplied, and order will be important.  So, to
> +transparently decompress a file and fix the line endings for a text file
> +we might do:
> +
> +---------------------------------------
> +[handler "decompress-text"]
> +  attribute = compressed-text
> +  infilter = gunzip
> +  infilter = eol_lf
> +  outfilter = eol_local
> +  outfilter = gzip
> +---------------------------------------
> +
> +This might be useful for documentation files that come compressed (like
> +README.gz used by Debian).
> +
> +Similarly, we might want to be able to look at compressed files stored
> +in the repository:
> +
> +---------------------------------------
> +[handler "show-compressed-file"]
> +  attribute = application/gzip
> +  prettyfilter = gunzip
> +  prettyfilter = eol_auto
> +---------------------------------------
> +
> +=== Handler Types
> +
> + - infilter
> +   Run by git-add when content is added to the repository.
> + - outfilter
> +   Run by git-checkout or git-reset when copying content from the index
> +   to the working directory.  (Actually, more likely this would be done
> +   at low level in git-read-tree)
> + - prettyfilter
> +   Run by git-cat-file or git-show when content is being pretty-printed
> +   for display to the user.  If no prettyfilter is set, then it should
> +   default to outfilter.
> + - merge
> +   Git has built in, good support for merging standard text files.
> +   However, if you wanted to add an external merge tool for merging,
> +   say, XML files, you could supply it here
> + - diff
> +   If you wanted to use an external diff for certain files, you would
> +   specify it in in the diff handler
> +
> +
> +
> +=== Filter list
> +
> + - eol_lf
> +   Force all line endings to line-feed.
> +
> + - eol_cr
> +   Force all line endings to carriage-return.
> +
> + - eol_crlf
> +   Force all line endings to carriage-return, line-feed.
> +
> + - eol_local
> +   Force all line endings to local default (LF on UNIX; CRLF on Windows).
> +
> + - eol_auto
> +   Do the "right thing" depending on the file content and local default.
> +
> + - pipe <cmd>
> +   Open a bidirectional pipe and run <cmd>; which will transform the
> +   file in whatever way one wishes.
> +
> + - keywords
> +   The traditional CVS keywords are substituted in the file.  Maybe:
> +     $Id$, $Author$, $URL$, $Date$, $Rev$
> +   This filter would behave differently depending on whether it was an
> +   infilter or an outfilter.  On infilter it would remove the extra
> +   information.  On outfilter it would add the extra information.
> +
> + - gunzip, gzip / zip, unzip
> +   Some files are stored compressed in their natural state (like ODF for
> +   example).  This isn't optimum for getting the best out of git.  Git
> +   (when making pack files) can store the delta between two files, and
> +   compresses all objects in its store anyway.  So, a compressed text
> +   file that changes over time will actually take up more disk space
> +   than the uncompressed file would take up.  These compression filters
> +   would fix that problem by transparently decompressing/compressing the
> +   files on their way in and out.
A good option to have, but not a default. A problem with zip is ofcourse that it represent many files. 
Presumably 
> +
> +
> +== Problems
> +
> + - Initial Checkout
> +   The .gitattributes file is not in the working directory, so how git
> +   find out what to apply to a file?  The potential solution might be to
> +   use the in-repo .gitattributes for checking out; and the working-tree
> +   .gitattributes when checking in.
Git can read the file from the tree it is about to check out. On check in it should read
the version in the index for consitency. That still leaves the problem of which file
to check when updating the index. Should the index be recomputed when the copy
of the file in the index gets updated? Probably. The .gitattributes must be the first file
in each tree to check in order to make all other blobs consistent with it.

> + - Merge of .gitattributes
Since they are text files it shold be possible to merge, but is the format "merge friendly", i.e.
unlikely to cause conflicts and  most importantly unlikely to cause incorrect merges. The
file is not likely to be updated very often. Maybe the first case for special merge programs?

> +   What happens when .gitattributes conflicts during a merge?
Ouch, ... need more thinking 

> + - Change of .gitattributes without change of files.
Recompute index, and possible change of files in git (.e.g files with CRLF get normalized
to LF is that is the change indicated by .gitattributes).

> +   What happens when .gitattributes changes, but the files that would be
> +   affected by that change do not?  Those files really should be checked
> +   out again, to apply any new outfilter settings.

Only on git-reset/checkout.

-- robin
