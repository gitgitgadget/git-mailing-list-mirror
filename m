From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: problem with cherry-picking a commit which comes before
 introducing a new submodule
Date: Tue, 11 Jan 2011 07:27:10 -0600
Message-ID: <20110111132710.GA14905@burratino>
References: <20110107172432.GA6040@onerussian.com>
 <20110107181501.GA28980@burratino>
 <20110107183226.GG6040@onerussian.com>
 <20110107230017.GA15495@burratino>
 <20110108000131.GR6040@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 14:27:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PceG2-0000ps-5o
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 14:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824Ab1AKN1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 08:27:25 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63086 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab1AKN1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 08:27:24 -0500
Received: by gxk9 with SMTP id 9so5331204gxk.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 05:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hOChebg34LZjuvxHx53RCsbOP67/MBnhF0KEKOckbdo=;
        b=VFLmeOH0/RF2aZ13qvC6YheVLV2UGrd9OubCIK/47/aCv7jL61DHeBfXj0hB+4CpkY
         Y0+M6G1cwHSU0rROeZX4sTdv2mBuRZ6owB+b5ImQucN2brMY74xG5vgVYcg1vfZQublY
         WtCR6AXPj1b/g/Jl48uUOvSC8y/OmTQ5OiOdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aW2omXqSfOLn/lMZysPhxk4UxQyQKDr2Jj6ljEIf1NQQY3uXzqiWfzTZSQa+ZBMue9
         8fh0JRhL4muNlan2TIxqGHIwhx+0LyiFyOAEb6v0w8XaN0+L9UVxc/L+9VWc03NBwt0k
         0JEDri0RbrYyPiqk1nzxjIQaiJrv2SEQsaL/A=
Received: by 10.150.203.20 with SMTP id a20mr42517ybg.389.1294752443249;
        Tue, 11 Jan 2011 05:27:23 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id n67sm17966510yha.26.2011.01.11.05.27.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 05:27:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110108000131.GR6040@onerussian.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164940>

Yaroslav Halchenko wrote [abbreviated]:

> CONFLICT (file/directory): There is a directory with name frontiers/code in todonotloose. Adding frontiers/code as frontiers/code~HEAD
> % git ls-files -u
> 160000 a2b5787 2   frontiers/code
> % git diff-tree todonotloose
> a00c497
> :040000 040000 40427e3 c7ba910 M  poster-hbm2011_neurodebian
> % git diff-tree todonotloose^ HEAD
> :100644 100644 378e137 c39ced7 M  .gitmodules
> :000000 040000 0000000 141dbc1 A  challenge-execpapers
> :040000 040000 401fd66 ee190f0 M  frontiers
> :040000 040000 26c884a ad3e829 M  sty

Here is what happens.

In the heart of merge_trees:

	/*
	 * If there are D/F conflicts, and the paths currently exist
	 * in the working copy as a file, remove them to make room
	 * for the corresponding directory.  Such paths will later be
	 * processed in process_df_entry() at the end.
	 *
	 * If the corresponding directory ends up being removed by the
	 * merge, then the file will be reinstated at that time;
	 * otherwise, if the file is not supposed to be removed by the
	 * merge, the contents of the file will be placed in another
	 * unique filename.
	 */
	make_room_for_directories_of_df_conflicts(o, entries);

In this case I suppose it is rather a directory/submodule conflict; in
any case, there are no regular files involved, so this logic does not
kick in and the directory is left alone.

Next comes rename handling, which is irrelevant for our purposes.

Next comes the per entry merge.

	/*
	 * Per entry merge.  D/F conflicts are deferred so files
	 * contained in such a directory can be resolved first.
	 */
	for (i = 0; i < entries->nr; i++) {
		const char *path = entries->items[i].string;
		struct stage_data *e = entries->items[i].util;
		if (!e->processed
			&& !process_entry(o, path, e))
			clean = 0;
	}

This is case B: "added in one" (like all directories, the
frontiers/code directory does not have an index entry, while the
submodule does have one).  Since that path is in the current directory
set, it is deferred for later processing.

Next comes the per entry merge for D/F conflicts (process_df_entry in
merge-recursive.c).  This is the case "directory -> (directory,
file)".  Unfortunately the check that the old and new directories
match is not implemented.  Even worse, git checks for a directory
(which was not moved out of the way before) and does not realize that
a submodule might be another reason for a directory in the worktree.
In any event, we get a spurious conflict.

Thanks, that was interesting (no patch yet, alas).
