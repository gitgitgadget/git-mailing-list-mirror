From: Richard Weinberger <richard@nod.at>
Subject: Re: broken repo after power cut
Date: Sun, 21 Jun 2015 15:07:41 +0200
Message-ID: <5586B71D.2070407@nod.at>
References: <5585C1B6.50407@nod.at> <330ab8f498e1b435d5b210384200b649@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, David Gstir <david@sigma-star.at>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: linux-fsdevel-owner@vger.kernel.org Sun Jun 21 15:07:48 2015
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Envelope-to: lnx-linux-fsdevel@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-fsdevel-owner@vger.kernel.org>)
	id 1Z6eyS-0006tF-BR
	for lnx-linux-fsdevel@plane.gmane.org; Sun, 21 Jun 2015 15:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbbFUNHq (ORCPT <rfc822;lnx-linux-fsdevel@m.gmane.org>);
	Sun, 21 Jun 2015 09:07:46 -0400
Received: from a.ns.miles-group.at ([95.130.255.143]:65275 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbbFUNHp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
	Sun, 21 Jun 2015 09:07:45 -0400
Received: (qmail 3950 invoked by uid 89); 21 Jun 2015 13:07:44 -0000
Received: by simscan 1.3.1 ppid: 3945, pid: 3948, t: 0.0958s
         scanners: attach: 1.3.1
Received: from unknown (HELO ?192.168.0.11?) (richard@nod.at@213.47.235.169)
  by radon.swed.at with ESMTPA; 21 Jun 2015 13:07:44 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <330ab8f498e1b435d5b210384200b649@www.dscho.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272260>

Hi Johannes,

[CC'ing linux-fsdevel and tytso]

Am 21.06.2015 um 14:28 schrieb Johannes Schindelin:
> Hi Richard,
> 
> On 2015-06-20 21:40, Richard Weinberger wrote:
> 
>> Yesterday our git server faced a power cut and a git repository broke.
>> The server is running a ext4 filesystem on top of Linux 3.16 (stable
>> from openSUSE) and git 2.1.4.
>> We had a backup, so no data was lost but I really would like to figure out
>> what happened.
>>
>> This is the output of git fsck:
>> Checking object directories: 100% (256/256), done.
>> error: object file objects/ce/f7627fc160ad7294b1f728db0c1ddb65a38b1d is empty
>> error: object file objects/ce/f7627fc160ad7294b1f728db0c1ddb65a38b1d is empty
>> fatal: loose object cef7627fc160ad7294b1f728db0c1ddb65a38b1d (stored
>> in objects/ce/f7627fc160ad7294b1f728db0c1ddb65a38b1d) is corrupt
>>
>> To me it seems like git was creating a new object and got interrupted
>> before fsync/fdatasync'ing it.
>> As the object was referenced before syncing the data to disk the repo broke.
>> Could this have happened?
>> Also, is git designed to survive power cuts? Then referencing an
>> object before synching it do disk would make no sense.
> 
> I had similar issues with ext4 in the past, even with local repositories when using Git without pushing. My then-current laptop would not report battery power correctly, so I ran into out-of-power situations that would result in a loose object file that was simply empty, i.e. its length was zero. As far as my analysis back then went, this was not Git's fault, because its `write_loose_object()` function would write to a temporary file first and only move that file into place once it was written fully.
> 
> I was then shocked to learn that ext4 apparently has a default setting that allows it to truncate files upon power failure (something about a full journal vs a fast journal or some such) when I had expected the default to be a true journaled file system with proper atomicity regarding writes and moves. I remember that back then, I angrily fixed that setting to make my file system fully journaled.

You mean the ext4 delayed block allocation feature/issue?
IIRC Ted added some hacks to ext4 to detect misbehaving applications (Gnome and KDE).
But to my knowledge such an file corruption must not happen if the application behaves well. And it can happen on all file systems.
Ted, maybe you can help us? BTW: I'm using ext4's default mount options from openSUSE, data=ordered.

> Maybe this leads you into the direction of a work-around in your setup?

I'm still not sure who to blame. ;-)

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
