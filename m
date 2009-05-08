From: Dave O <cxreg@pobox.com>
Subject: Re: [PATCH] Fix segfault in merge-recursive
Date: Fri, 8 May 2009 16:54:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905081624230.30999@narbuckle.genericorp.net>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de> <alpine.DEB.2.00.0905072131470.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905082229520.4601@intel-tinevez-2-302>
 <alpine.DEB.2.00.0905081436070.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905090012410.4601@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Dave O <cxreg@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 09 01:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2ZvT-0002H2-TF
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 01:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbZEHXys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 19:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbZEHXys
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 19:54:48 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:55501 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751039AbZEHXyr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 19:54:47 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id n48NsiCe022607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 8 May 2009 18:54:45 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <alpine.DEB.1.00.0905090012410.4601@intel-tinevez-2-302>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118640>

On Sat, 9 May 2009, Johannes Schindelin wrote:

> Hi,
>
> On Fri, 8 May 2009, Dave O wrote:
>
>> On Fri, 8 May 2009, Johannes Schindelin wrote:
>>
>>> When there is no "common" tree (for whatever reason), we must not
>>> throw a segmentation fault.
>>>
>>> Noticed by Dave O.
>>
>> While this patch does prevent a segfault, it totally fails to recognize
>> any conflicts in the merge.  Reverting 36e3b5e produces an ordinary
>> merge conflict with some rename/delete conflicts, and others including
>> content related conflicts.  I'm not sure I wouldn't rather have the
>> segfault than the grossly incorrect automerge.
>>
>> I'll continue debugging the triggering condition to see if I can
>> understand why the index is left dirty, leading to this NULL tree.
>
> One thing I realized while trying to quickly fix the issue for you was
> that the recognized merge base was NULL.  I.e. merge-recursive did _not_
> find a merge base.
>
> but due to too many renames, maybe it did not.
>
> Probably that is the issue.

That's not what I witnessed, although it's possible I missed something:

./git-merge-crash: line 127: 29751 Segmentation fault      git merge F
count@bokonon:~/git-crash/crash-test$ git merge-base -a F G
8ffd08037781ab7811f9e7983b87a29ea9ea21d9
79ac36c0bd8525e087fdb278bac9cabfa655ba47
count@bokonon:~/git-crash/crash-test$ git merge-base -a 8ffd080 79ac36c
03ca38c681cd9f832fe68d30ea2d8dfa54cbaf75

What I did find, is that the tree is coming back NULL due to the early
return in write_tree_from_memory(), which in turn is due to
unmerged_cache() returning true.  If verbosity is up high enough, that
function will indicate that the paths of the unmerged entries are
exactly the ones affected in the commit I referenced earlier:

   There are unmerged index entries:
   3 data/moved-99
   3 data/moved-990
   [...]

Interestingly, I was able to remove quite a bit of the script and still
induce the crash, including the part where it causes too many renames.
It appears that all that's needed is a delete/rename conflict in a
recursive call.

The new version is here:
http://genericorp.net/~count/git-merge-crash-shorter

Once again, I don't really know what the implications of the index
operations that are happening here are, but the update_stages() call
in a recursive merge must be doing surprising.

     Dave
