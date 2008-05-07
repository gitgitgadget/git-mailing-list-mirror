From: David Kastrup <dak@gnu.org>
Subject: Re: Sort of a feature proposal
Date: Wed, 07 May 2008 19:39:48 +0200
Message-ID: <86k5i6rp23.fsf@lola.quinscape.zz>
References: <86fxsutbke.fsf@lola.quinscape.zz>
	<alpine.LFD.1.10.0805070924300.3024@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 19:41:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtndT-0000nI-If
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 19:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbYEGRkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 13:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120AbYEGRkK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 13:40:10 -0400
Received: from main.gmane.org ([80.91.229.2]:52914 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbYEGRkH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 13:40:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JtncQ-000110-M2
	for git@vger.kernel.org; Wed, 07 May 2008 17:39:54 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 May 2008 17:39:54 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 May 2008 17:39:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:4UqE0kYnk3ycammLxjb45LxTmeI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81467>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 7 May 2008, David Kastrup wrote:
>> 
>> Hi, I have some large git repositories on a USB drive (ext3 file
>> system).  That means that when replugging the drive, the recorded st_dev
>> data in the index is off, meaning that the whole repo directory
>> structure gets reread as the stat data of all directories has changed.
>> 
>> That's a nuisance.  Can't we have some heuristic or configuration option
>> where we, say, record the st_dev of the _index_ file, and if that has
>> changed, we propagate that change to the st_dev of its contents?  I'd
>> like to see something that works more efficiently than rescanning the
>> whole disk every time I hibernate my computer.
>
> Hmm. We shouldn't even be using st_dev any more.
>
> How did you compile your git version? By default USE_STDEV should be off, 
> and it's been that way for a long time (because st_dev is also not 
> reliable on NFS etc).

Looks that way in my Makefile.  Maybe I am confused: I just did some
timings (this is ext3 on a USB drive) and got

    git svn rebase
    Current branch master is up to date.
    dak@lisa:/lisa/texlive$ time git svn rebase
    Current branch master is up to date.

    real	0m4.581s
    user	0m2.244s
    sys	0m1.492s
    dak@lisa:/lisa/texlive$ cd
    dak@lisa:~$ sudo umount /lisa;sudo mount /dev/mapper/Medion-reps /lisa;cd /lisa/texlive;time git svn rebase
    Current branch master is up to date.

    real	0m53.588s
    user	0m2.248s
    sys	0m2.388s
    dak@lisa:/lisa/texlive$ cd;sudo umount /lisa;sudo dmsetup remove /dev/mapper/Medion-reps
[Unplug and replug the USB drive]
    dak@lisa:~$ sudo mount /dev/mapper/Medion-reps /lisa;cd /lisa/texlive;time git svn rebase
    Current branch master is up to date.

    real	0m53.101s
    user	0m2.324s
    sys	0m2.380s
    dak@lisa:/lisa/texlive$ 

If my guess that the device number of LVM does not change when merely
un- and remounting, but does change when unplugging and replugging is
correct, it would appear that my idea where the time went was wrong and
that the device number has nothing whatsoever to do with the large
amount of lookups (this is a USB2.0 device at High Speed).

Is there a way to completely invalidate the disk cache without
unmounting?  How do I verify device numbers?

Thanks,

-- 
David Kastrup
