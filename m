From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Tue, 18 Nov 2014 12:46:28 -0500
Message-ID: <s934mtwo0zv.fsf@mad-scientist.net>
References: <1416073760.9305.174.camel@homebase>
	<xmqqy4r9yc5u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 20:20:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqoJz-0006cn-BG
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 20:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbaKRTUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 14:20:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:34012 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753829AbaKRTUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 14:20:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XqoJp-0006Zw-AJ
	for git@vger.kernel.org; Tue, 18 Nov 2014 20:20:05 +0100
Received: from 173-9-45-73-newengland.hfc.comcastbusiness.net ([173.9.45.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 20:20:05 +0100
Received: from paul by 173-9-45-73-newengland.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 20:20:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 173-9-45-73-newengland.hfc.comcastbusiness.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Cancel-Lock: sha1:+wOwr0OK0aw8vknKHigXejeqWo4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Paul Smith <paul@mad-scientist.net> writes:

> No need to resend only to correct the above, even though there may
> be comments on the patch itself from me or others that may make you
> want to reroll this patch, in which case I'd like to see these nits
> gone.

I'll fix in the next iteration.

>> -# don't recreate a workdir over an existing repository
>> -if test -e "$new_workdir"
>> +# make sure the links use full paths
>> +git_dir=$(cd "$git_dir"; pwd)
>
> With this change, the comment gets much harder to understand.  "What
> links?"  would be the reaction from those who are reading the patch.

I just moved this line; I don't think it had much more context
beforehand, but I'll definitely rewrite the comment to be more clear.

>> +	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2

> I wonder if this check is portable for all platforms we care about,
> but that is OK, as it should be so for the ones I think of and care
> about ;-)

Do you mean "." and ".." representing an empty directory?  That will
work on any system where /bin/sh works, for sure.

Or do you mean using "ls" and "wc"?  I can easily avoid this.

Recall that new-workdir itself only works on systems that support
symlinks; this limits its portability.  For example it doesn't work on
Windows (unfortunately).  I spent the better part of a day a few months
ago playing with the various "symlink-ish" capabilities of Windows NTFS
and couldn't find any reliable way to make this work (although I have
virtually no Windows fu).

> The script chdirs around; did you turn $new_workdir into an absolute
> path already, or given a relative $new_workdir this is attempting to
> remove a hierarchy that is different from what you created?

Good point, I'll fix this up

>> +}
>> +siglist="0 1 2 15"
>> +trap cleanup $siglist
>>  
>> -# create the workdir
>> -mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!"
>> +# create embedded directories
>> +for x in logs
>> +do
>> +	mkdir -p "$new_workdir/.git/$x" || failed
>> +done
>>  
>>  # create the links to the original repo.  explicitly exclude index, HEAD and
>>  # logs/HEAD from the list since they are purely related to the current
>> working
>>  # directory, and should not be shared.
>>  for x in config refs logs/refs objects info hooks packed-refs remotes
>> rr-cache svn
>>  do
>> -	case $x in
>> -	*/*)
>> -		mkdir -p "$(dirname "$new_workdir/.git/$x")"
>> -		;;
>> -	esac
>
> What's this removal about?  If $new_workdir/.git/logs does not
> exist, would "ln -s $there/logs/refs $new_workdir/.git/logs/refs"
> succeed without first creating $new_workdir/.git/logs directory?

I split the creation of the directories from the symlinks: see the new
loop above.  This allows us to avoid the icky dirname stuff.

New iteration will follow shortly.

Cheers!
