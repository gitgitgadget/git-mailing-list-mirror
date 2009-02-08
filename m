From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Propose author and committer in the commit dialog
Date: Sun, 8 Feb 2009 12:24:05 -0800
Message-ID: <20090208202405.GB30949@spearce.org>
References: <498C5F4E.1040200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 21:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWGEk-0004vg-Ls
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 21:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbZBHUYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 15:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbZBHUYK
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 15:24:10 -0500
Received: from george.spearce.org ([209.20.77.23]:42655 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZBHUYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 15:24:09 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id F3F6A38210; Sun,  8 Feb 2009 20:24:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <498C5F4E.1040200@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109010>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> Add a field 'committer'.
> The fields 'author' and 'committer' are populated with the values
> found in the configuration.
> 
> Validate the author and the committer.
> 
> Add the signed-off line in the comment text box when the user clicks
> on the signed-off checkbox.
> 
> Use Text.DELIMITER as line break for plateform independance.

Far too many things in one change.  Please break these apart into
multiple commits so they are easier to review and test in isolation.
 
> I remove the modifications of PersonIdent and send them in another patch.

Thanks, that one is now applied.
 
> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
> index ae26770..9a9d494 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
> @@ -99,15 +99,16 @@ public void run(IAction act) {
>  		}
>  
>  		String author = null;
> +		String committer = null;
>  		if (repository != null) {
>  			final RepositoryConfig config = repository.getConfig();
>  			author = config.getAuthorName();
> -			if (author != null && author.length() != 0) {
> -				final String email = config.getAuthorEmail();
> -				if (email != null && email.length() != 0) {
> -					author = author + " <" + email + ">";
> -				}
> -			}
> +			final String authorEmail = config.getAuthorEmail();
> +			author = author + " <" + authorEmail + ">";
> +
> +			committer = config.getCommitterName();
> +			final String committerEmail = config.getAuthorEmail();
> +			committer = committer + " <" + committerEmail + ">";

Don't you mean getCommitterEmail() here?

> @@ -117,9 +118,13 @@ public void run(IAction act) {
>  		commitDialog.setAmendAllowed(amendAllowed);
>  		commitDialog.setFileList(files);
>  		commitDialog.setAuthor(author);
> +		commitDialog.setCommitter(committer);
>  
> -		if (previousCommit != null)
> +		if (previousCommit != null) {
>  			commitDialog.setPreviousCommitMessage(previousCommit.getMessage());
> +			PersonIdent previousAuthor = previousCommit.getAuthor();
> +			commitDialog.setPreviousAuthor(previousAuthor.getName() + " <" + previousAuthor.getEmailAddress() + ">");

Isn't this a bug fix for "amend" so that the original author is
reused when amending the prior commit?  Please mention it in the
commit message; and ideally this should be its own change.

> @@ -312,6 +352,7 @@ private static String getFileStatus(IFile file) {
>  			}
>  
>  		} catch (Exception e) {
> +			e.printStackTrace();

Would it be better to log this through an Activator so it shows
up in the Error Log view?

> @@ -321,6 +362,7 @@ private static String getFileStatus(IFile file) {
>  	 * @return The message the user entered
>  	 */
>  	public String getCommitMessage() {
> +		commitMessage.replaceAll(Text.DELIMITER, "\n"); //$NON-NLS-1$
>  		return commitMessage;

String is immutable.  This replaceAll is a noop.  You probably
meant to return the return value of the replaceAll method.

There may be other comments for these changes; it would be easier
to review if they were more broken up into independent commits.

-- 
Shawn.
