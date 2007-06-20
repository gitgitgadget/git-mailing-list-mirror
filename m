From: Sam Vilain <sam@vilain.net>
Subject: Re: post-update script to update wc - suggestions welcome
Date: Thu, 21 Jun 2007 08:14:46 +1200
Message-ID: <46798AB6.6060403@vilain.net>
References: <E1I0tZY-0001Uz-00@www.watts.utsl.gen.nz> <7vr6o7uhwz.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthias Lederhofer <matled@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:15:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I16aB-00032Y-Ky
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 22:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbXFTUPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 16:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbXFTUPN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 16:15:13 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:60852 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbXFTUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 16:15:11 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 3783513A4F8; Thu, 21 Jun 2007 08:15:09 +1200 (NZST)
Received: from [192.168.1.2] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 3953A13A4EA;
	Thu, 21 Jun 2007 08:15:02 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <7vr6o7uhwz.fsf@assigned-by-dhcp.pobox.com>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50564>

Junio C Hamano wrote:
> Also you would want to see if the thing is bare.
>
> Unfortunately, git-sh-setup's is_bare_repository does a wrong
> thing because receive-pack already runs GIT_DIR set to '.' after
> chdir to it.  Matthias's long set of patches currently parked in
> 'pu' is supposed to clarify the semantics of bare/non-bare, so
> it may help though (it has "rev-parse --is-bare-repository).
>
> I think 80% of the time (because other 20% of bare repositories
> are initialized, following an often repeated incorrect procedure
> of making a worktree-full repository and moving its .git/ to
> another place, $name.git --- that is wrong for at least three
> reasons), if $GIT_DIR/index exists, you can treat it as a
> non-bare repository.
>   

Great, well in lieu of that, Matthias suggests a reasonable extra
heuristic of whether or not the pathname ends in "/.git" (or "\.git").
Which falls into the "why didn't I think of that" category ;-).

No doubt with those patches the hook can be simplified, especially if it
sets GIT_WORK_TREE.

>>   cd ..
>>   success=
>>   if git-diff-files
>>   then
>>     
>
> I would suggest running update-index --refresh before running
> diff-files.  The user may have cache-dirty file and only that.
>   

Ah yes, is that what git-status does that checks the filestamps in the
index and updates them... Handy to know.

>>     git-diff-index -z -R --name-status HEAD | perl -n0 -le \
>> 	'if ($z^=1) {
>> 		$status=$_;
>> 	 }
>> 	 else {
>>         	$filename=$_;
>> 		printf STDERR "$status\t$filename\n";
>> 		if($status eq "D"){
>> 			unlink($filename)
>> 				or die("unlink($filename) failed; $!")
>> 		}
>>          }' &&
>>     
>
> With "--name-only --diff-filter=D" you would not have to do most
> of the above ;-)  Use --diff-filter=A without -R, perhaps, to
> make it even shorter.
>   

You're right, it was right there!

I think it's a good thing to echo back to the user the output of the
--name-status command, so they can see the changes that were made.

>>     git-reset --hard HEAD && success=1
>>   fi
>>     
>
> Wouldn't "reset --hard HEAD" pretty much unconditionally nuke
> your local changes, including added files to the index?  For
> example, if I do this:
>
> 	$ >foo && git add foo && git reset --hard HEAD
>
> it would remove the newly added 'foo' from both the index and
> the working tree.  So I am not quite sure what you are trying to
> achieve with "diff-index | perl" magic.
>   

Right, but we've already checked using diff-files that there weren't any
local changes. So all we're saying is "remove all files which won't be
written by git reset --hard, then checkout new versions of files".

Actually there is a slight deficiency in the above script - empty
directories will not be removed, so replacing a directory with a file
will be broken.

> I'll cook up an alternative patch perhaps tomorrow.
>   

Cool! I'm sure bzr and darcs users will thank you :-)

Sam.
