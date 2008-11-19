From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 15:17:39 +0100
Message-ID: <81b0412b0811190617t4a9df151m886700672a21fad8@mail.gmail.com>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
	 <4923FE58.3090503@viscovery.net>
	 <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
	 <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com>
	 <49241AEF.1080808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 15:19:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2ntu-0008KW-Eh
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 15:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbYKSORl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 09:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753638AbYKSORl
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 09:17:41 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:19478 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbYKSORk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 09:17:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1737003wah.21
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 06:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eqobnbLao8EqqeBA5ebmSddnSB9ejBFeyStZoZnZyA8=;
        b=QqPBpz5PAgZzNG8v2dVwlByim3yndS2LvwfC5F/6OWFV2VzXEEpHVuGor6HJEAqcuS
         pKZvGTW7axXCG7JusJMS6MgI6EEam71YvWtX/RIYkcWxxHEhxUiyGXtLURtlb8iZpjVM
         kRXg3WHIa8D22t0ZNxaL3h0GqBErmQ2iJ9h/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HBkawYFA7Zo5ZcU4nI2KJa1S8jol7lMkqtZBIJuGKZ5NK6n12HSIg0AR8ELIw7LVIz
         cg5MCUoVUolfkliFoZZ2u/vcfVjmmVrw51OFXi6tvKHNI6EtZdU3ovhTlVT2d8npZjFt
         kgHGT9vmF8F0z8At0ReMUXBu8ahugPcwb5nvE=
Received: by 10.114.201.1 with SMTP id y1mr679395waf.154.1227104259761;
        Wed, 19 Nov 2008 06:17:39 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Wed, 19 Nov 2008 06:17:39 -0800 (PST)
In-Reply-To: <49241AEF.1080808@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101346>

2008/11/19 Johannes Sixt <j.sixt@viscovery.net>:
> Alex Riesen schrieb:
>> 2008/11/19 Nicolas Pitre <nico@cam.org>:
>>> On Wed, 19 Nov 2008, Johannes Sixt wrote:
>>>> The work-around is to write the repacked objects to a file of a different
>>>> name, and replace the original after git-pack-objects has terminated.
>>>>
>>>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>>> Acked-by: Nicolas Pitre <nico@cam.org>
>>
>> Are you sure? Will it work in a real repository? Were noone does
>> rename the previous pack files into packtmp-something?
>
> Oh, the patch only works around the failure in the test case. In a real
> repository there is usually no problem because the destination pack file
> does not exist.
>
> The unusual case is where you do this:
>
>  $ git rev-list -10 HEAD | git pack-objects foobar
>
> twice in a row: In this case the second invocation fails on Windows
> because the destination pack file already exists *and* is open. But not
> even git-repack does this even if it is called twice. OTOH, the test case
> *does* exactly this.
>

Still bad...

BTW, the patch _does_ fix the "unusual case" for me. IOW, I plainly copied
your rev-list|pack-objects into command line. As expected, it fails for Junio's
master (after the second run) and works with the patch:

  $ git rev-list -10 HEAD | ./git pack-objects .git/objects/pack/foobar
  Counting objects: 10, done.
  Compressing objects: 100% (9/9), done.
  82864ec14cd06e6089543a1419762e4cd40f7988
  Writing objects: 100% (10/10), done.
  Total 10 (delta 1), reused 10 (delta 1)

  $ git rev-list -10 HEAD | ./git pack-objects .git/objects/pack/foobar
  Counting objects: 10, done.
  Compressing objects: 100% (9/9), done.
  fatal: unable to rename temporary pack file: Permission denied

  $ git cherry-pick fix-fd-leak
  Finished one cherry-pick.
  [master]: created e629465: "Fix handle leak in builtin-pack-objects"
   1 files changed, 1 insertions(+), 0 deletions(-)

  $ git rev-list -10 HEAD | ./git pack-objects .git/objects/pack/foobar
  Counting objects: 10, done.
  Compressing objects: 100% (9/9), done.
  0e43d919a2a8336fd740d8d9b8f9f78d49e855e5
  Writing objects: 100% (10/10), done.
  Total 10 (delta 1), reused 9 (delta 1)

  $ git rev-list -10 HEAD | ./git pack-objects .git/objects/pack/foobar
  Counting objects: 10, done.
  Compressing objects: 100% (9/9), done.
  0e43d919a2a8336fd740d8d9b8f9f78d49e855e5
  Writing objects: 100% (10/10), done.
  Total 10 (delta 1), reused 10 (delta 1)

  $ git rev-list -10 HEAD | ./git pack-objects .git/objects/pack/foobar
  Counting objects: 10, done.
  Compressing objects: 100% (9/9), done.
  0e43d919a2a8336fd740d8d9b8f9f78d49e855e5
  Writing objects: 100% (10/10), done.
  Total 10 (delta 1), reused 10 (delta 1)
