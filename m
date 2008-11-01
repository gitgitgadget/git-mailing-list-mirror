From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: getting list of objects for packing
Date: Fri, 31 Oct 2008 19:00:06 -0500
Message-ID: <1S3xpaVP1Cy1Rei_ODwlXsBdu64BGiPve-lj_4fN6cA@cipher.nrlssc.navy.mil>
References: <TtAUShKh7lOR5rkf1iyWwpMOWoYpT8Mnw-t3Wemdy3tTCd0XiQHdag@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0810311625450.13034@xanadu.home> <JhY9the71dfsAJuojZF2S4BG-SEkshM7XxIWGPBeY9M@cipher.nrlssc.navy.mil> <7v7i7o8nc5.fsf@gitster.siamese.dyndns.org> <fAUegZ3bxPo8HquZjUM9syW-giYefuAzBtb1XXHQ-TwbmvJvMZvmDA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 01:01:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3vl-0000XX-JR
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 01:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbYKAAAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 20:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbYKAAAP
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 20:00:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43961 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbYKAAAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 20:00:14 -0400
Received: by mail.nrlssc.navy.mil id mA1007kx029699; Fri, 31 Oct 2008 19:00:07 -0500
In-Reply-To: <fAUegZ3bxPo8HquZjUM9syW-giYefuAzBtb1XXHQ-TwbmvJvMZvmDA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 01 Nov 2008 00:00:07.0223 (UTC) FILETIME=[CCC2A470:01C93BB4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99685>

Brandon Casey wrote:
> Junio C Hamano wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>>
>>> Nicolas Pitre wrote:
>>>> On Fri, 31 Oct 2008, Brandon Casey wrote:
>>>>>   -The sed statement is stripping off anything after the sha1. Any way to
>>>>>    get rev-list to print out just the sha1 so that sed is not necessary?
>>>> If you strip the data after the SHA1 when pipping into pack-objects then 
>>>> you'll have horrible delta compression results.  The path names after 
>>>> each SHA1 is used to sort objects when trying to find best matches for 
>>>> delta compression. So you should preserve those and feed it back 
>>>> especially with those packs that you still want delta compression for.
>>> Ah, I'll have to rethink my script then. Thanks!
>> Yeah, but wasn't the purpose of your whole exercise to list objects that
>> do not delta nor compress well with each other, in which case the delta
>> compression order (aka name hash) would not matter, no?
> 
> The script I wrote actually starts up two pack-objects instances and I was
> writing the objects I wanted to pack _normally_ to one, and the ones that I
> did not want compressed/deltafied to the other (which was started with
> --no-reuse-object --window=0 --depth=0 --compression=0).

So, my script created two pack files: one packed normally, and one packed without
compression or delta. I removed my original packs, and put these two new ones in
my pack directory and ran 'git fsck --full' and it completed successfully. There
are no loose objects in the repo.

I added a .keep file for each pack.

Since my script removed the extra info from rev-parse's output, I removed the
.keep file from the appropriate pack and ran 'git gc --aggressive'.

The 1.7GB pack that had the .keep file removed has been replaced with a +3GB
pack file. The other pack file which still has the .keep file is 2.3GB.

In another repo with 3 packs marked .keep, and one 388KB pack with ~300
objects in it, and 3 loose dangling objects, the 388KB pack was replaced with
a 3.5GB pack.

It appears that the entire repository is being packed into the new pack file
even though there are existing pack files with .keep files.

If I compare the output from 'git verify-pack -v' I can see that many of the
objects in the packs marked with a .keep file are indeed in the new pack file.
But not all of them.

-brandon
