From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 07/24] Added findWorkTree method to Repository class.
Date: Mon, 12 May 2008 20:24:09 -0400
Message-ID: <20080513002409.GC29038@spearce.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-8-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Tue May 13 02:25:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JviKH-0007Wi-DV
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 02:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbYEMAYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 20:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbYEMAYO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 20:24:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35421 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbYEMAYN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 20:24:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JviJE-0007L7-Li; Mon, 12 May 2008 20:24:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E1CE920FBAE; Mon, 12 May 2008 20:24:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1210623222-24908-8-git-send-email-florianskarten@web.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81974>

Florian Koeberle <florianskarten@web.de> wrote:
> @@ -1242,4 +1247,89 @@ public class Repository {
>  		}
>  	}
>  
> +	/**
> +	 * Find the git repository for the current working directory.
> +	 * 
> +	 * @return a {@link Repository}.
> +	 * @throws IOException
> +	 *             if the system property user.dir isn't set or if it is
> +	 *             invalid.
> +	 */
> +	public static WorkTree findWorkTree() throws IOException {
> +		final String workingDirectoryPath = System.getProperty("user.dir");
> +		if (workingDirectoryPath == null) {
> +			throw new IOException("unable to get working directory");
> +		}
> +		final File workingDirectoryFile = new File(workingDirectoryPath);

Isn't `final File workingDirectoryFile = new File(".")` easier to write?

And if we are going to throw a checked exception because we cannot
find a repository in ".", maybe that should be a new checked
exception, like NoGitRepositoryFoundException?

> +	/**
> +	 * Checks if a path is a valid git repository. Works similar like the method
> +	 * is_git_directory from the original setup.c file.

References to C Git aren't common in jgit source code.  We aren't
a reference implementation, but that hasn't stopped people from
finding out code a sane description of "how things work".  I'd rather
not describe our code in terms of C Git's code; especially what
happens if C Git refactors one day, this reference might no longer
make sense.  Anyone coming back here to improve jgit or use this
method will be confused about what we are doing.

> +	 * 
> +	 * @param directory
> +	 *            the path which should be checked.
> +	 * @return true if the path is a valid git repository.
> +	 */
> +	private static boolean isRepository(File directory) {
> +		if (!directory.isDirectory()) {
> +			return false;
> +		}

We usually omit { and } on simple conditions like this.  Its a coding
pattern we stole from C Git, which stole it from the Linux kernel.

> +	private static WorkTree findWorkTree(File directory) throws IOException {
> +		File currentDirectory = directory.getAbsoluteFile();
> +		while (true) {
> +			final File commonGitDirectory = new File(directory,
> +					REPOSITORY_DIRECTORY_NAME);
> +			if (isRepository(commonGitDirectory)) {
> +				return new WorkTree(currentDirectory, new Repository(
> +						commonGitDirectory));
> +			}
> +
> +			if (isRepository(currentDirectory)) {
> +				return new WorkTree(null, new Repository(currentDirectory));
> +			}
> +			currentDirectory = currentDirectory.getParentFile();
> +			if (currentDirectory == null) {
> +				throw new IOException("Can't find git repository");
> +			}
> +		}

Would this perhaps be a shorter, easier to follow variant of the
same algorithm?

	directory = directory.getAbsoluteFile();
	File workdir = directory;
	while (workdir != null) {
		final File gitdir = new File(workdir, REPOSITORY_DIRECTORY_NAME);
		if (isRepository(gitdir))
			return new WorkTree(workdir, new Repository(gitdir));
		if (isRepository(workdir))
			return new WorkTree(null, new Repository(workdir));
		workdir = workdir.getParentFile();
	}
	throw new NoGitRepositoryFoundException("No repository for " + directory);

I often do write infinite loops with "for (;;) {", but usually its
because the loop condition is based on an iterator-style method
returning null at the end and I want to store the result in a local
variable scoped to only the body of the loop:

	for (;;) {
		final RevCommit next = walk.next();
		if (next == null)
			break;

		// use next somehow
	}

Otherwise I try to avoid infinite loops in my final version
of something.  Though on a recent job interview the interviewer
noticed I tend to start writing code with an infinite loop, then
go back and correct the loop condition before saying "done".  ;-)

-- 
Shawn.
