From: Bill Lear <rael@zopyra.com>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 14:49:47 -0600
Message-ID: <17875.30187.289679.417079@lisa.zopyra.com>
References: <17875.13564.622087.63653@lisa.zopyra.com>
	<7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	<17875.17647.74882.218627@lisa.zopyra.com>
	<7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 21:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHR53-0005ZV-9t
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 21:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbXBNUuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 15:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbXBNUuR
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 15:50:17 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60271 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbXBNUuP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 15:50:15 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1EKoB116582;
	Wed, 14 Feb 2007 14:50:11 -0600
In-Reply-To: <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39742>

On Wednesday, February 14, 2007 at 09:45:14 (-0800) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>
>> % git fsck-objects --full
>> error: Packfile .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack SHA1 mismatch with itself
>> fatal: failed to find delta-pack base object 90bad0d280a6d7c155bbd9582b35ffcf5e3bdd27
>>
>>
>> % /usr/bin/git --version
>> git version 1.4.4.1
>>
>> % /usr/bin/git fsck-objects --full
>> error: Packfile .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack SHA1 mismatch with itself
>> fatal: failed to find delta-pack base object 90bad0d280a6d7c155bbd9582b35ffcf5e3bdd27
>>
>> So, all I did was try to do a commit with the new git ... haven't
>> recloned, or pulled from upstream...
>
>If you haven't packed the repository lately, the above indicates
>this is not an issue between 1.4.4.1 and 1.5.0, but you had a
>corrupt packfile before even started.
>
>How big is this pack, what platform are you working on and whose
>SHA-1 implementation do you use?

In order:

% cd .git/objects/pack
% ls -l
-r--r--r--  1 rael software    77360 Feb 13 10:18 pack-23d1a9af78b4b78d...
-r--r--r--  1 rael software 87874337 Feb 14 10:00 pack-23d1a9af78b4b78d...

[output of ls trimmed to width]

% uname -a
Linux lisa.zopyra.com 2.6.9-34.0.2.ELsmp #1 SMP Fri Jul 7 18:22:55 CDT 2006 x86_64 x86_64 x86_64 GNU/Linux

I don't know which SHA-1 implementation I use --- I just installed git
and off I went.  I do see this:

% which sha1sum
/usr/bin/sha1sum
% sha1sum --version
shasum (coreutils) 5.2.1
Written by Ulrich Drepper and Scott Miller.
[...]

But I'm not sure which library is in use --- how do I know?

>Also, do you have a huge blob in the repository?  I do not know
>if it is related but the write_sha1_file_prepare() function on
>the codepath to write loose objects out would trigger the same
>bug...

I don't know what "huge" is, but the pack file seems to be the largest
and then one of the objects is listed at 28,604,986 bytes, but nothing
else is very large.

So, before I get to Linus's message, I did try doing this:

1) with 1.4.4.1 git, clone my public repo
2) in this new clone, make modifications to my files as before
3) with 1.5.0 git, do a commit

and I got the same blowup on commit, and this on fsck, with 1.5.0 git:

% git fsck-objects --full
error: Packfile .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack SHA1 mismatch with itself
error: 00078437c23cbc04da52233f4f412219f88b8927: object corrupt or missing
fatal: unknown object type 5 in .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack

and with 1.4.4.1 git:

% /usr/bin/git fsck-objects --full
error: Packfile .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack SHA1 mismatch with itself
fatal: corrupted pack file .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack

So (hopefully this is helpful) I look in my public repo for this pack
file:

% ls -l /repos/git/fus/objects/pack
total 88420
-r--r--r--  1 blear software    10376 Feb 14 10:06 pack-1a201381fe465cbf4d771aec681aff6e12648ea0.idx
-r--r--r--  1 blear software   753437 Feb 14 10:06 pack-1a201381fe465cbf4d771aec681aff6e12648ea0.pack
-r--r--r--  1 blear software    77360 Feb 13 10:57 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.idx
-r--r--r--  1 blear software 89576130 Feb 13 10:57 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack

and notice, it is different than the same pack on my just-cloned repo
(that is, the second clone, that I used to reproduce the first
failure):

% ls -l objects/pack/
total 87632
-r--r--r--  1 blear software    77360 Feb 14 12:50 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.idx
-r--r--r--  1 blear software 89548154 Feb 14 12:52 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack

and in my first-cloned repo:

% ls -l objects/pack/
total 85992
-r--r--r--  1 blear software    77360 Feb 13 10:18 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.idx
-r--r--r--  1 blear software 87874337 Feb 14 10:00 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack

The .pack files have the same SHA, but different sizes (don't know
what that means).

I will continue digging and on to Linus's post...


Bill
