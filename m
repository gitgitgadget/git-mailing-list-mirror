From: Nicolas Pitre <nico@cam.org>
Subject: Re: getting list of objects for packing
Date: Fri, 31 Oct 2008 16:40:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810311625450.13034@xanadu.home>
References: <TtAUShKh7lOR5rkf1iyWwpMOWoYpT8Mnw-t3Wemdy3tTCd0XiQHdag@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Oct 31 21:42:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw0oj-0004IC-7s
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 21:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbYJaUkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 16:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbYJaUkr
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 16:40:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60083 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbYJaUkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 16:40:46 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9M001MOERSUIG0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 31 Oct 2008 16:40:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <TtAUShKh7lOR5rkf1iyWwpMOWoYpT8Mnw-t3Wemdy3tTCd0XiQHdag@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99640>

On Fri, 31 Oct 2008, Brandon Casey wrote:

> 
> I'm trying to write a script that will repack large binary or compressed
> objects into their own non-compressed, non-delta'ed pack file.
> 
> To make the decision about whether an object should go into this special
> pack file or not, I want the output from 'git cat-file --batch-check'.
> I get it with something similar to:
> 
>    git rev-list --objects --all |
>       sed -e 's/^\([0-9a-f]\{40\}\).*/\1/' |
>       git cat-file --batch-check
> 
> First question: Is the rev-list call correct?

yes.

>   -If I am understanding things right, then the list of objects produced
>    by rev-list will be in the right order for piping to pack-objects. 
>   -The sed statement is stripping off anything after the sha1. Any way to
>    get rev-list to print out just the sha1 so that sed is not necessary?

If you strip the data after the SHA1 when pipping into pack-objects then 
you'll have horrible delta compression results.  The path names after 
each SHA1 is used to sort objects when trying to find best matches for 
delta compression. So you should preserve those and feed it back 
especially with those packs that you still want delta compression for.

> ISSUE TWO:
> 
> I have placed these two packs into my own personal repo, and I have unpacked all
> of the other objects so that they are loose.
> 
> I thought I could use a similar sequence of commands to pack those loose objects
> into a normal and special pack. I added the --unpacked option to my rev-list
> command, but it still lists many more objects than exist loosely in the repository.
> 
>    git rev-list --objects --unpacked --all
> 
> The man page says:
> 
>    --objects
>           Print  the  object  IDs  of any object referenced by the listed
>           commits. --objects foo ^bar thus means "send me all object  IDs
>           which  I  need to download if I have the commit object bar, but
>           not foo".
> 
>    --unpacked
>           Only useful with --objects; print the object IDs that  are  not
>           in packs.
> 
> Is this the correct behavior for rev-list --unpacked?

Well, don't think so.  Although I have zero unpacked objects in my git 
repository, the listing still gives me a hundred objects or so, and they 
all appear to be tag objects.  There is probably a bug here.


Nicolas
