From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH/RFC] git-svn: New flag to add a file in empty directories
Date: Wed, 18 May 2011 09:22:53 +0200
Message-ID: <4DD373CD.6010607@alum.mit.edu>
References: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Ray Chen <rchen@cs.umd.edu>
X-From: git-owner@vger.kernel.org Wed May 18 09:23:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMb6D-0007k8-Bq
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 09:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801Ab1ERHW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 03:22:59 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:43251 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab1ERHW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 03:22:58 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p4I7MrBD017135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 18 May 2011 09:22:53 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173853>

On 05/18/2011 12:00 AM, Ray Chen wrote:
> Adds the --preserve-empty-dirs flag to the clone and fetch operations that
> will detect empty SVN directories, and create a placeholder file within them.
> This allows "empty" directories to exist in the history of a Git repository.
> 
> Also adds the --placeholder-file flag to control the name of any placeholder
> files created.  Default value is ".gitignore".
> 
> Signed-off-by: Ray Chen <rchen@cs.umd.edu>
> ---
> 
> I needed this functionality when I was migrating a repository from SVN to
> Git.  It seems well known that Git only tracks files, not directories, so
> any revision I checked out would be missing the empty directories that
> existed in the SVN repository.
> 
> My knowledge of SVN is limited, so I'm not sure how correct this patch is.
> I created a little test SVN repo, and `git svn clone --preserve-empty-dirs`
> did the right thing, but that's hardly a complete test.
> 
> Specifically, I experimentally noticed that my patch worked with lines 4532
> and 4533 commented out.  I'm not sure what problems might occur when adding
> a file Git without associated SVN properties.
> 
> Finally, I added the --preserve-empty-dirs and --placeholder-file only to
> the clone and fetch operations.  Is that appropriate?  The functionality
> is really only applicable to full migrations.  I'm not sure that the fetch
> operation should have it.

I'm not familiar enough with the code to critique your code, but I have
some questions/comments about the feature's intended behavior:

1. What happens if a previously empty directory is deleted from
Subversion?  It seems to me that consistency would demand that the
placeholder file be deleted so that git also forgets about the
directory.  On the other hand, if the user has edited the placeholder
file since it was created, it might be advisable to emit a warning or error.

2. What happens if, in Subversion, content is added to a previously
empty directory?  Is the placeholder left around?

3. I believe that this feature would be useful to people who are
tracking a Subversion repository over time (not just for full
migrations).  What happens if the user sometimes uses the new options
and sometimes not?  Are the missing directories that have "accumulated"
since the last invocation with --preserve-empty-dirs all added in the
first commit resulting from a later use of --preserve-empty-directories,
or are they skipped forever?  I'm talking about this scenario:

Subversion                   git
----------                   ---
Add empty directory "a"
                             git svn fetch --preserve-empty-dirs
Add empty directory "b"
                             git svn fetch
Add empty directory "c"
                             git svn fetch --preserve-empty-dirs

After the third "git svn fetch", does the git repository contain
directory "b"?

4. If it is a goal to support long-term tracking of a Subversion
repository, then it would be good to add a config option to turn on this
feature permanently for a git-svn repository, so that the user doesn't
have to enter the extra options with each command invocation.

5. It might be useful to allow the placeholder files to be committed to
Subversion, so that other git-svn users based off the same Subversion
repository don't have to worry about empty directories.  This would
typically be something that people would want to do semi-manually in
specific Subversion commits.  To support this user case, one could add a
similar option to "git svn mkdirs" that causes the placeholder files to
be created in the working copy but not committed.  Then the user could
review the suggested changes, perhaps add lines to the .gitignore files,
commit to git, then dcommit to Subversion.

6. Documentation patches would also be required.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
