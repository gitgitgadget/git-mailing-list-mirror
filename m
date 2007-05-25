From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Split packs from git-repack should have descending timestamps
Date: Thu, 24 May 2007 18:04:44 -0700
Message-ID: <7vbqg9vhlf.fsf@assigned-by-dhcp.cox.net>
References: <465612CE.4080605@gmail.com> <20070525004610.GP28023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 25 03:05:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrOEm-0001Ku-Tp
	for gcvg-git@gmane.org; Fri, 25 May 2007 03:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbXEYBEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 21:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbXEYBEz
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 21:04:55 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64232 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXEYBEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 21:04:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525010454.OGMB13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 24 May 2007 21:04:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3D4l1X00V1kojtg0000000; Thu, 24 May 2007 21:04:53 -0400
In-Reply-To: <20070525004610.GP28023@spearce.org> (Shawn O. Pearce's message
	of "Thu, 24 May 2007 20:46:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48321>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Dana How <danahow@gmail.com> wrote:
>> 
>> If git-repack produces multiple split packs because
>> --max-pack-size was in effect,  the first pack written
>> should have the latest timestamp because:
>> (1) sha1_file.c:rearrange_packed_git() puts more recent
>>     pack files at the beginning of the search list;  and
>> (2) the most recent objects are written out first
>>     while packing.
>> 
>> This is based on next rather than master to avoid merge
>> conflicts with changes already in git-repack.sh due to
>> the --max-pack-size patchset.
>
> Ack.  Given our mtime based sorting routine, even without your
> recent patch to improve it, I think we definately want this type
> of behavior built into git-repack.sh.  Good follow-on to your
> --max-pack-size series.

Gee, I do not want to touch this, unless we can do something
about that sleep 2, even if you have & at the end (actually,
especially because you have that -- it makes me worried).

At the minimum, I think you do not have to restamp at all if the
result is a single pack (i.e. the usual case), like so:

case "$restamp" in
?*' '?*)
	# we have more than one.
        # for split packs,  the first created should have most recent timestamp
	for file in $restamp ; do touch $file; sleep 2; done &
	;;
esac

Come to think of it, can't you do this "re-touching" business at
the end of pack-objects without sleeping?  You could keep track
of the names of the packs you produced, and if you have produced
5, like so:

	1
        2
        3
        4
        5

you would swap timestamp of #1 and #5, #2 and #4 using stat()
and utime(), and you are done.  Each of these huge packs would
take more than one second to write it out, but if that is not
the case, you could even start with timestamp of #5, subtract 1
and stamp #4, subtract 1 and stamp #3, ... You may end up using
timestamp from the past, but that would not be a problem.

And I am really hoping that the other "use object density in
reordering" patch would make this irrelevant.  You would have
commit and then the rest in the normal input object stream, and
recenty ordering done by git-pack-objects should keep commits
together early in the resulting split pack, and earlier parts
that have the commits would be hopefully denser.
