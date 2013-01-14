From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Error:non-monotonic index after failed recursive "sed" command
Date: Mon, 14 Jan 2013 13:21:38 +0100
Message-ID: <50F3F852.8060800@viscovery.net>
References: <CAMoGvRKkSZqcoGtiebu6tuPndzOjQ1=JgQHb+iusAHpUbA2HbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: George Karpenkov <george@metaworld.ru>
X-From: git-owner@vger.kernel.org Mon Jan 14 13:22:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuj3C-0000kD-1y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 13:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533Ab3ANMVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 07:21:42 -0500
Received: from so.liwest.at ([212.33.55.24]:9509 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755464Ab3ANMVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 07:21:41 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Tuj2p-0003fs-0y; Mon, 14 Jan 2013 13:21:39 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BF0201660F;
	Mon, 14 Jan 2013 13:21:38 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CAMoGvRKkSZqcoGtiebu6tuPndzOjQ1=JgQHb+iusAHpUbA2HbA@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213485>

Am 1/14/2013 12:40, schrieb George Karpenkov:
> I've managed to corrupt my very valuable repository with a recursive
> sed which went wrong.
> I wanted to convert all tabs to spaces with the following command:
> 
> find ./ -name '*.*' -exec sed -i 's/\t/    /g' {} \;
> 
> I think that has changed not only the files in the repo, but the data
> files in .git directory itself. As a result, my index became
> corrupted, and almost every single command dies:
> 
>> git log
> error: non-monotonic index
> ..git/objects/pack/pack-314b1944adebea645526b6724b2044c1313241f5.idx
> error: non-monotonic index
> ..git/objects/pack/pack-75c95b0defe1968b61e4f4e1ab7040d35110bfdc.idx
> ....
> error: non-monotonic index
> ..git/objects/pack/pack-3da0da48d05140b55f4af1cf87c55a2d7898bdd5.idx
> fatal: bad object HEAD
> 
> Output for git fsck is even worse:
> 
>> git fsck
> error: non-monotonic index
> ..git/objects/pack/pack-434f8445672a92f123accffce651bdb693bd8fcb.idx
> ....
> error: non-monotonic index
> ..git/objects/pack/pack-0c9d5ae4e2b46dd78dace7533adf6cdfe10326ef.idx
> error: non-monotonic index
> ..git/objects/pack/pack-e8bd5c7f85e96e7e548a62954a8f7c7f223ba9e0.idx
> Segmentation fault (core dumped)
> 
> Any advice? I've lost about 2 weeks worth of work.
> Is there anything better I can try to do other then trying to
> reconstruct the data manually from git blobs?

First things first: MAKE A COPY OF THE CURRENT STATE of the repository,
including the worktree, so that you have something to go back to if things
get worse later. (At the very least, we want to debug the segfault that we
see above.)

So far that's all I can say about your case. Everything that follows is
just a shot in the dark, and others may have better ideas. Also, look
here:
https://github.com/gitster/git/blob/master/Documentation/howto/recover-corrupted-blob-object.txt

You can remove the *.idx files, because they do not carry essential
information. Now try git fsck; git repack.

Try the reverse edit:

 find .git -name '*.*' -exec sed -i 's/    /\t/g' {} \;

Remove .git/index; it can be reconstructed (of course, assuming you
started all this with a clean index; if not, you lose the staged changes).

-- Hannes
