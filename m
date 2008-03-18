From: Junio C Hamano <gitster@pobox.com>
Subject: Re: renaming a file into a directory causes a pull error on older
 repos
Date: Mon, 17 Mar 2008 17:16:41 -0700
Message-ID: <7vlk4ganti.fsf@gitster.siamese.dyndns.org>
References: <20080316043138.GA7942@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 01:17:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbPWG-0001GC-HT
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 01:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbYCRAQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 20:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbYCRAQw
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 20:16:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbYCRAQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 20:16:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F14220D0;
	Mon, 17 Mar 2008 20:16:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CBF3520CF; Mon, 17 Mar 2008 20:16:44 -0400 (EDT)
In-Reply-To: <20080316043138.GA7942@kroah.com> (Greg KH's message of "Sat, 15
 Mar 2008 21:31:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77471>

Greg KH <greg@kroah.com> writes:

> The problem:
>   If you turn a file in a repository into a directory, and place files
>   in that dir and commit it, any other person who had that repo cloned
>   somewhere else will get an error when they try to pull and update
>   their version.
>
> The error for me is:
> 	fatal: Entry 'stats/results-18-22.txt' would be overwritten by merge. Cannot merge.
> 	Merge with strategy recursive failed.
>
> I had turned the file "stats" into a directory.

So...

 - originally "stats" was a file.

 - then one branch removes it and creates stats/results-18-22.txt file.

 - another branch keeps working elsewhere in the tree but has not touched
   the "stats" file.

Now, the above error message complains about stats/results-18-22.txt being
overwritten, so I presume that:

 - You have checked out the branch that has stats/results-18.22.txt;

 - You are merging the other branch that still had stats as a file into
   that checked out branch with stats/results-18.22.txt file.

Are these presumptions correct?

Now, merge-recursive may be riddled with bugs in directory-file conflict
detection area.  The way it detects conflicts is quite bogus --- it builds
a list of files and directories in ancestor, our side and the other side,
and anything that changes directoryness is marked as conflict, when the
right thing to do is to complain only if the checking out of the result
needs to have a file and a directory at the same place.

But I do not think the above error message is from merge-recursive proper.
"Entry X would be overwritten by merge. Cannot merge." is an error message
the 3-way read-tree (driven from merge-recursive) issues when you have
local changes to file X that will go away as the result of the merge, to
prevent us from losing your local changes to the file.  Didn't you have
changes to that file when you did the merge?

I have spotted an unrelated bug in git-merge-one-file.sh that would have
caused something similar symptom when you had used "resolve" strategy, by
the way (unfortunately I do not think it applies to merge-recursive).
