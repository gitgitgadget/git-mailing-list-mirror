From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add notes that some $GIT_DIR/info/ files are not
	copied by clone, etc.
Date: Thu, 27 Mar 2008 00:51:44 -0400
Message-ID: <20080327045144.GB6426@coredump.intra.peff.net>
References: <47EB246A.1030402@rea-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Toby Corkindale <toby.corkindale@rea-group.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 05:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jek6R-0006nc-Hu
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 05:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbYC0Evs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 00:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbYC0Evs
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 00:51:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2742 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbYC0Evr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 00:51:47 -0400
Received: (qmail 5648 invoked by uid 111); 27 Mar 2008 04:51:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 27 Mar 2008 00:51:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2008 00:51:44 -0400
Content-Disposition: inline
In-Reply-To: <47EB246A.1030402@rea-group.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78332>

On Thu, Mar 27, 2008 at 03:36:58PM +1100, Toby Corkindale wrote:

> ---
>  Documentation/gitattributes.txt |    4 ++++
>  Documentation/gitignore.txt     |    3 +++
>  2 files changed, 7 insertions(+), 0 deletions(-)

Generally git patches should be:

  - included inline rather than attached (it looks like you are using
    Thunderbird, which does have some whitespace munging issues; there
    is a section in SubmittingPatches that discusses Thunderbird
    specifically)

  - signed-off (see SubmittingPatches)

Comments on the content are below.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 84ec962..b3b497b 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -63,6 +63,10 @@ path in question, and its parent directories (the further the
>  directory that contains `.gitattributes` is from the path in
>  question, the lower its precedence).
>  
> +The $GIT_DIR/info/attributes file is used when you wish to only affect certain
> +repositories. It will not be copied to other repositories by automatic
> +operations such as clone, fetch, etc.
> +

I think this paragraph is OK, and in a reasonable spot. Though it might
read easier for a user if it is inside-out from what you have written.
IOW, you have "X does Y" but I wonder if "if you want Y, then use X"
might be a better wording. See below.

> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -34,6 +34,9 @@ precedence, the last matching pattern decides the outcome):
>     files generated as part of the project build.
>  
>   * Patterns read from `$GIT_DIR/info/exclude`.
> + * The $GIT_DIR/info/exclude file is used when you wish to only affect
> +   certain repositories. It will not be copied to other repositories by
> +   automatic operations such as clone, fetch, etc.
>  
>   * Patterns read from the file specified by the configuration
>     variable 'core.excludesfile'.

I don't like this one. There are actually _three_ different
places you can put ignore patterns, so I think you do better to wait
until after the precedence list is finished, and then discuss the
reasons for using each. How about this instead of your second hunk?

-- >8 --
Documentation: clarify differences between gitignore files

Since gitignore patterns can be read from three different
files, let's provide some hints to the user about how they
are typically used.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitignore.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index e847b3b..613dca0 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -38,6 +38,18 @@ precedence, the last matching pattern decides the outcome):
  * Patterns read from the file specified by the configuration
    variable 'core.excludesfile'.
 
+Which file to place a pattern in depends on how the pattern is meant to
+be used. Patterns which should be version-controlled and distributed to
+other repositories via clone (i.e., files that all developers will want
+to ignore) should go into a `.gitignore` file. Patterns which are
+specific to a particular repository but which do not need to be shared
+with other related repositories (e.g., auxiliary files that live inside
+the repository but are specific to one user's workflow) should go into
+the `$GIT_DIR/info/exclude` file.  Patterns which a user wants git to
+ignore in all situations (e.g., backup or temporary files generated by
+the user's editor of choice) generally go into a file specified by
+`core.excludesfile` in the user's `~/.gitconfig`.
+
 The underlying git plumbing tools, such as
 linkgit:git-ls-files[1] and linkgit:git-read-tree[1], read
 `gitignore` patterns specified by command-line options, or from
-- 
1.5.5.rc1.133.g360d
