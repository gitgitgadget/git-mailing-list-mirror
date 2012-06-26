From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: fast-import [mis?]-honors core.ignorecase
Date: Mon, 25 Jun 2012 21:45:52 -0600
Message-ID: <4FE93070.1050507@workspacewhiz.com>
References: <CAG+J_DygPXtjD-0gv8XXpV0JErw_jpwRLOZ00H9bem5hN8g7ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 06:01:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjMxV-0008Ff-Vh
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 06:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab2FZDwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 23:52:41 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:33098 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627Ab2FZDwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 23:52:41 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jun 2012 23:52:40 EDT
Received: (qmail 3263 invoked by uid 399); 25 Jun 2012 21:45:59 -0600
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@67.182.221.164)
  by hsmail.qwknetllc.com with ESMTPAM; 25 Jun 2012 21:45:59 -0600
X-Originating-IP: 67.182.221.164
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <CAG+J_DygPXtjD-0gv8XXpV0JErw_jpwRLOZ00H9bem5hN8g7ZA@mail.gmail.com>
X-Antivirus: avast! (VPS 120625-1, 06/25/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200625>

----- Original Message -----
From: Jay Soffian
Date: 6/25/2012 2:48 PM
> I was using a "fast-export | <filter program> | fast-import" as a much
> faster filter-branch --env-filter (I needed to rewrite
> author/committer email-addresses) and was surprised that after the
> pipeline was done, the new ref's trees didn't match the old ref's
> trees. i.e.:
>
>    $ cmp <(git log old-ref --pretty='%T')  <(git log --pretty='%T' new-ref)
>
> didn't return 0. Comparing one of the differing tree-pairs indicated
> it was due to a case-difference in a file which had been renamed.
> After some experimenting I finally tracked this down to having
> core.ignorecase set to "true" on the repo in which I was running the
> pipeline. By setting it to "false" the filtering pipeline completes
> with new-ref (and all its ancestors) being tree-identical to old-ref.
>
> Is there any reason for fast-import to honor ignorecase?
I provided this change in ac1c80f7645b6fa90534890e1f83005d40d98281.

In my mind, core.ignorecase=true means that the file system cannot 
handle case-sensitive filenames.  Files held in the repository should 
conform to a single case.

When I was getting a 'fast export' of our Perforce repository, I found 
file case was all over the map.  Perforce internally handles its files 
for a case preserving case insensitive file system in a case insensitive 
manner.  File case can change from changelist to changelist!  The 
fast-exported file was a mess.  In the original fast-imported version, 
'git status' thought that one case of file was modified when another 
case of the same file was the same.  Git could not follow the history 
over all of the filename case changes.

The case folding patches were created to handle this.  Specifically, the 
fast-import patch serves as a catch-all to handle repositories that do 
not conform to a single case as they were created and in operation.  It 
folds the incoming file case to match that of what is in the existing 
repository.  The end result is a clean repository with one file case for 
a given filename.  'git status' works.  File history can be followed.  
'git add' knows which name to match against.

(I am a firm believer that Git should handle *all* case _internally_ as 
insensitive when core.ignorecase=true, and I have work-in-progress 
patches that illustrate this behavior.  Others here (particularly on the 
msysgit mailing list) are adamantly against those patches.  Nonetheless, 
there would be no need to fold case if the Git internals handled 
comparisons in a case insensitive fashion.)

I do understand your point above, and I have no good answer.  Your file 
case was changed during a rename.  The fast-import core.ignorecase=true 
process did not preserve that case change despite it being right and 
appropriate for your repository. core.ignorecase=false did preserve the 
case.  I guess the solution here depends on what core.ignorecase=true 
should mean.

Nevertheless, I am certain Git fast-import needs to retain the case 
folding behavior during fast-import, even if it means enabling it via a 
command-line flag instead of core.ignorecase=true.

-Josh
