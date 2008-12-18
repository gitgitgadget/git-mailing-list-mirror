From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add git-edit-index.perl
Date: Wed, 17 Dec 2008 23:37:34 -0500
Message-ID: <20081218043734.GD20749@coredump.intra.peff.net>
References: <20081217204749.GA18261@janet.wally>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neil Roberts <bpeeluk@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Thu Dec 18 05:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDAf3-0001bT-EM
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 05:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYLREhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 23:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbYLREhi
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 23:37:38 -0500
Received: from peff.net ([208.65.91.99]:1261 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbYLREhh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 23:37:37 -0500
Received: (qmail 31958 invoked by uid 111); 18 Dec 2008 04:37:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Dec 2008 23:37:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Dec 2008 23:37:34 -0500
Content-Disposition: inline
In-Reply-To: <20081217204749.GA18261@janet.wally>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103433>

On Wed, Dec 17, 2008 at 08:47:49PM +0000, Neil Roberts wrote:

> This script can be used to edit a file in the index without affecting
> your working tree. It checkouts a copy of the file to a temporary file
> and runs an editor on it. If the editor completes successfully with a
> non-empty file then it updates the index with the new data.

Hmm. Neat idea. I have used add-interactive's "e"dit patch option to do
a similar thing, but it is often unwieldy (e.g., just yesterday I had a
patch that removed about 30 lines and added 1 -- rather than munging the
diff, it would have been simpler to re-add the line in a staged
version).

Thinking out loud: One thing that would make this more useful would be
providing the content of the work tree file in some way. Like seeing the
whole file but with "conflict markers" showing two versions of each
hunk, like:

  a line in both files
  <<<<<<< staged
  a line only in the staged version
  =======
  a line only in the working tree version
  >>>>>>> working tree

and then you can edit around that. Of course, then you _have_ to
edit every hunk since you have just stuck the conflict marker cruft. I
guess a savvy user could just open both versions in their editor and
pull content from one buffer to the other other.

> This is useful to fine tune the results from git add -p. For example
> sometimes your unrelated changes are too close together and
> git-add--interactive will refuse to split them up. Using this script
> you can add both the changes and later edit the index file to
> temporarily remove one of the changes.

Have you tried using the edit-patch option in "git add -p"? I'm curious
if you would like that better for your cases, or if you find this way
more natural.

>  .gitignore          |    1 +
>  Makefile            |    1 +
>  git-edit-index.perl |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++

I have to wonder if this wouldn't be better as part of
git-add--interactive? I guess technically you aren't "adding" from the
work tree since it is purely looking at the staged version. But it seems
to be part of the same workflow, as you are munging content in the
index.

> +sub check_file_size {
> +        my ($fn) = @_;
> +        my ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size,
> +            $atime, $mtime, $ctime, $blksize, $blocks) = stat($fn);
> +
> +        $size;
> +}

FYI, a shorthand for this is:

  (stat $fn))[7];

or you may consider:

  use File::stat;
  stat($fn)->size;

which is nicely readable.

> +        unless (system($editor, $tmp_fn) == 0
> +                && check_file_size($tmp_fn)) {
> +                # If the editor failed, the file has disappeared or it
> +                # has zero size then give up
> +                delete_temp_files(@file_list);
> +                die("Editor failed or file has zero size");

I guess you are aborting on a zero-size file to allow the user a chance
to say "oops, I want to scrap the changes I've saved so far". But you
are disallowing making a file empty by this process. Which I guess is
not all that common, but it still seems restrictive.  I wonder if asking
for confirmation might make more sense.

Also, does it make sense to delete the temp files if the editor failed?
The user may have put work into the file, but we are not successfully
updating the index; so we may be deleting useful work that could be
recovered.

> +        unless (defined($hash) && $hash =~ /\A[0-9a-f]{40}\z/) {
> +                delete_temp_files(@file_list);
> +                die("Failed to add new file");

Again, if we fail to hash for whatever reason, we should not delete the
useful work that the user might have done.

-Peff
