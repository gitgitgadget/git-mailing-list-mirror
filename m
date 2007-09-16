From: david@lang.hm
Subject: Re: metastore
Date: Sun, 16 Sep 2007 14:12:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709161346150.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161054380.5298@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 23:13:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX1Qk-000718-Hh
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 23:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbXIPVNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbXIPVNV
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 17:13:21 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:47132
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbXIPVNV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 17:13:21 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8GLCNL2025622;
	Sun, 16 Sep 2007 14:12:23 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <Pine.LNX.4.64.0709161054380.5298@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58346>

On Sun, 16 Sep 2007, Daniel Barkalow wrote:

>> I however think your idea to have extra "permission information
>> file" is very interesting.  What would be more palatable, than
>> mucking with the core level git, would be to have an external
>> command that takes two tree object names that tells it what the
>> old and new trees our work tree is switching between, and have
>> that command to:
>>
>>  - inspect the diff-tree output to find out what were checked
>>    out and might need their permission information tweaked;
>>
>>  - inspect the differences between the "permission information
>>    file" in these trees to find out what were _not_ checked out,
>>    but still need their permission information tweaked.
>>
>>  - tweak whatever external information you are interested in
>>    expressing in your "permission information file" in the work
>>    tree for the paths it discovered in the above two steps.
>>    This step may involve actions specific to projects and call
>>    hook scripts with <path, info from "permission information
>>    file" for that path> tuples to carry out the actual tweaking.
>
> Why not have the command also responsible for creating the files that need
> to be created (calling back into git to read their contents)? That way,
> there's no window where they've been created without their metadata, and
> there's more that the core git doesn't have to worry about.

my initial thoughts were to have git do all it's normal work and hook into 
git at the point where it's writing the file out (where today it chooses 
between writing the data to a file on disk, pipeing to stdout, or pipeing 
to a pager) by adding the option to pipe into a different program that 
would deal with the permission stuff. this program would only have to 
write the file and set the permissions, it wouldn't have to know anything 
about git other then where to find the permissions it needs to know.

it sounds like you are suggesting that the hook be much earlier in the 
process, and instead of one copy of git running and calling many copies of 
the writing program, you would have one copy of the writing program that 
would call many copies of git.

I'll admit that my initial reaction is that it's probably a lot more 
expensive to do all the calls into git. git just has a lot more complex 
things to do.

> I could see the program getting the index, the target tree, and the
> directory to put files in, and being told to do the whole 2-way merge
> (except, perhaps, updating the index to match the tree, which git could do
> afterwards). As far as git would be concerned, it would mostly be like a
> bare repository.

if this functionality does shift to earlier in the process, how much of 
the git logic needs to be duplicated in this program?

if this program needs to do the merge, won't it have to duplicate the 
merge logic, including the .gitattributes checking for custom merge calls?


I have been thinking primarily in terms of doing a complete checkout, 
overwriting all files, and secondarily how do do a checkout of just a few 
files, but again where all files selected overwrite the existing files.

I wasn't thinking of the fact that git optimizes the checkout and avoids 
writing a file that didn't change.

this changes things slightly

prior to this I was thinking that the permission file needed to be handled 
differently becouse writing it out needed to avoid doing any circular 
refrences where you would need to check the contents of it to write it 
out.

it now appears as if what really needs to happen is that if the permission 
file changes a different program needs to be called when it's written out 
then when the other files are written out. by itself this isn't hard as 
.gitattributes can have a special entry for this filename and that entry 
can specify a different program, and that program fixes all the 
permissions (and/or detects that they can't be fixed due to 
user/filesystem limits, records the error, checks if the repository is set 
appropriately, and screams to the user if it isn't)

it would be a nice optimization to this permission checkout for it to 
compare the old and the new permissions so that it only tries to change 
the permissions where it needs to, but is that really nessasary? the 
program can look at the permissions of the existing files to see what they 
are and decide if it needs to change them (this would tromp on local 
changes that aren't checked in. how big of a problem is this?) my initial 
reaction is that having to know the two commits and do the comparison 
between them is adding a lot of logic and git interaction that I'd rather 
avoid if I could.

David Lang
