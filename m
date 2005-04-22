From: Zach Welch <zw@superlucidity.net>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Fri, 22 Apr 2005 02:14:24 -0700
Message-ID: <4268C070.3010706@superlucidity.net>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org> <7vis2fbr0p.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@siamese.dyndns.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 11:12:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOuBv-00029o-KK
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 11:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVDVJPn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 05:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVDVJPn
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 05:15:43 -0400
Received: from ns2.superlucidity.net ([63.224.205.131]:10435 "EHLO
	linux.superlucidity.net") by vger.kernel.org with ESMTP
	id S262014AbVDVJPb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 05:15:31 -0400
Received: from [10.0.0.160] (fluffy.superlucidity.net [63.224.205.132])
	by linux.superlucidity.net (8.11.6/8.11.6) with ESMTP id j3M9EO829517;
	Fri, 22 Apr 2005 02:14:25 -0700
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050326)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Howdy,

Linus Torvalds wrote:
> On Thu, 21 Apr 2005, Junio C Hamano wrote: 
>>I am thinking about an alternative way of doing the above by
>>some modifications to the git core.  I think the root of this
>>problem is that there is no equivalent to GIT_INDEX_FILE and
>>SHA1_FILE_DIRECTORY that tells the core git where the project
>>top directory (i.e. the root of the working tree that
>>corresponds to what $GIT_INDEX_FILE describes) is.
> 
> I'd _really_ prefer to just try to teach people to work from the "top" 
> directory instead.

Would it be okay if that were settable on a per-repository basis? :)
Or do you have specific subset of operations you want restricted?

>> - A new environment variable GIT_WORKING_TREE points at the
>>   root of the working tree.
[snip]
> I really don't like it that much, but to some degree it obviously is
> exactly what "--prefix=" does to checkout-cache. It's basically saying 
> that all normal file operations have to be prefixed with a magic string. 

I'm going to script it one way or the other, but the environment route
allows me to set things up after a fork and before exec in Perl. This
works regardless of what git command I'm running, and should work even
with ithreads. This ease of use would not be the case with the
'--prefix' solution, as scripting the commands would requiring passing
arguments to those commands that need/support them at a higher level
than is desirable.

At present, I have implemented Yogi to support being able to run
commands from a different working directory than the root of the
repository, and that behavior might be per-repository settable
(someday). If I had my way, I would like to see git support the
following variables:

  GIT_WORKING_DIRECTORY   - default to '.'
  GIT_CACHE_DIRECTORTY    - default to ${GIT_WORKING_DIRECTORY}/.git
  GIT_OBJECT_DIRECTORY    - defaults to ${GIT_CACHE_DIRECTORY}/objects

The reasoning is simple: One object repository can be shared among
numerous working caches, which can be shared among multiple working
directories (e.g. any directories under the project root, but maybe also
import/exports, or other magic...). There are two layers of one to many
relationships between the three classes of directories, and my scripts
want to make use of that flexibility to the hilt.

Also, do you really think git will only ever have the index file, and
not someday possibly other related bits? (You may have said that
elsewhere, but I missed it.) If that's ever the case, the directory
variable is the way to go; scripts can be forward compatible and won't
risk accidentally mingling repository data when their scripts have only
set GIT_INDEX_FILE and not GIT_SOME_OTHER_FILE.

That said, I think GIT_INDEX_FILE would supplement the above scheme
nicely, overriding a default of ${GIT_CACHE_DIRECTORY}/index, because of
use cases you've described.

Cheers,

Zach
