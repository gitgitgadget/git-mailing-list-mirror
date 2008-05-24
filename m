From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: bug in "git log --graph" at the tail end?
Date: Fri, 23 May 2008 18:05:56 -0700
Message-ID: <20080524010555.GA5385@adamsimpkins.net>
References: <7vve14rbu7.fsf@gitster.siamese.dyndns.org>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 03:31:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzibd-0003ms-0L
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 03:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbYEXBam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 21:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754632AbYEXBam
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 21:30:42 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:42285 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbYEXBal (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 21:30:41 -0400
X-Greylist: delayed 1481 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 May 2008 21:30:41 EDT
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 3E62B206FA6;
	Fri, 23 May 2008 21:06:00 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 04FA2206280;
	Fri, 23 May 2008 21:06:00 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id A56E514100C8; Fri, 23 May 2008 18:05:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vve14rbu7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82786>

On Fri, May 23, 2008 at 01:42:56PM -0700, Junio C Hamano wrote:
> It appears that "log --graph" output has a bug at its tail end.
> 
>     $ git log --pretty=oneline --abbrev-commit --graph 9d88058^..1af8bca
>     M   1af8bca... Merge branch 'maint'
>     |\  
>     | M   008442f... Merge branch 'maint-1.5.4' into maint
>     | |\  
>     | * e77b0b5... git-am: fix typo in usage message
>     | * 74190d2... doc/git-daemon: s/uploadarchive/uploadarch/
>     M   9d88058... Merge branch 'ar/add-unreadable'
>     |\  
>     * dad25e4... Add a config option to ignore errors for git-add
>     * 8959743... Add a test for git-add --ignore-errors
>     * 984b83e... Add --ignore-errors to git-add to allow it to sk...
>     * 7ae02a3... Extend interface of add_files_to_cache to allow ...
>     * 960b8ad... Make the exit code of add_file_to_index actually...
> 
> Ideally, I think the output should look like this:
> 
>     M   1af8bca... Merge branch 'maint'
>     |\  
>     | M   008442f... Merge branch 'maint-1.5.4' into maint
>     | |\  
>     | * e77b0b5... git-am: fix typo in usage message
>     | * 74190d2... doc/git-daemon: s/uploadarchive/uploadarch/
>     M   9d88058... Merge branch 'ar/add-unreadable'
>     |\  
>     | * dad25e4... Add a config option to ignore errors for git-add
>     | * 8959743... Add a test for git-add --ignore-errors
>     | * 984b83e... Add --ignore-errors to git-add to allow it to sk...
>     | * 7ae02a3... Extend interface of add_files_to_cache to allow ...
>     | * 960b8ad... Make the exit code of add_file_to_index actually...
> 
> This is purely cosmetic, but because --graph is only about the cosmetics,
> we may want to do something about it.

Yes, you're right.  There are a couple bugs in handling commits with
parents flagged as UNINTERESTING.  There are two problems:

- The code that determines where each branch line should go in the next
  commit completely ignores the uninteresting parent.  Instead, it
  really should use two blank spaces in its computation, to account for
  where the parent would have been.

  This is more than just a cosmetic issue, since it results in branch
  lines being mis-aligned.  This makes the graph show incorrect parent
  child relationships.

  For example, the code should draw this:

  | * | <- commit with uninteresting parent
  |  /
  * |
  | *

  But instead, it currently draws this:

  | * | <- commit with uninteresting parent
  * |
  | *

  This is a simple one-line fix.  I'll submit a patch for it.


- Merge commits that have uninteresting parents print branch lines for
  all of their parents, even the uninteresting ones.

  This is just a cosmetic issue, but I agree it looks bad.  Perhaps the
  best thing to do is not to display anything for the uninteresting
  parents.  It might look a little confusing to some users though, since
  you can have a merge commit that is printed as 'M', but it only has
  one parent displayed in the graph.

  This change would make the output from the command you mentioned
  above look like:

    M   1af8bca... Merge branch 'maint'
    |\  
    | M   008442f... Merge branch 'maint-1.5.4' into maint
    | * e77b0b5... git-am: fix typo in usage message
    | * 74190d2... doc/git-daemon: s/uploadarchive/uploadarch/
    M   9d88058... Merge branch 'ar/add-unreadable'
    * dad25e4... Add a config option to ignore errors for git-add
    * 8959743... Add a test for git-add --ignore-errors
    * 984b83e... Add --ignore-errors to git-add to allow it to sk...
    * 7ae02a3... Extend interface of add_files_to_cache to allow ...
    * 960b8ad... Make the exit code of add_file_to_index actually...

-- 
Adam Simpkins
adam@adamsimpkins.net
