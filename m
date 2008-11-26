From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 26 Nov 2008 14:18:57 +0100
Message-ID: <81b0412b0811260518o52adb107tbddafb324e7fd97b@mail.gmail.com>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
	 <4923FE58.3090503@viscovery.net>
	 <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
	 <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com>
	 <49241AEF.1080808@viscovery.net>
	 <alpine.LFD.2.00.0811190940480.27509@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 14:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5KJT-0000nn-Fs
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 14:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbYKZNS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 08:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbYKZNS7
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 08:18:59 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:14875 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYKZNS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 08:18:58 -0500
Received: by wa-out-1112.google.com with SMTP id v27so222648wah.21
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 05:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MPZRE7epZm3/+wxj8YMFP8X+pKMKms4yu6YgpCEL4+g=;
        b=HfDjHnyLHGHCOa0I/OZyWq/yg9qB2Cin+PhLBk+FkSzozZRFrKLTmVxso0kUNbtUB+
         Q8Nmu8pF5nSxaAcBLwii8YkzFm3hBJYrz69sNjEuqsf/wALDty/5VYsHvocSIugUjEFF
         kKNVX943O5qiECFE+jRf3g0o9DPv5VMqaAHmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZeZ5PObs/L4/+qy2X9V9MgBLiKZmBpUST0B/k5O1y3zhDch0XZzP6OKlXRZBAyMsfm
         qz38KoXTqrzoO1sdbAZFA0jsC5eUhsG1CWvOYPxR/qUBy+KXMGsEXkeGn0zx4FI+b50q
         iA1TT1pCipE7ty2v1ChSwfWLj882SZtLunAD0=
Received: by 10.114.24.1 with SMTP id 1mr3323550wax.179.1227705537770;
        Wed, 26 Nov 2008 05:18:57 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Wed, 26 Nov 2008 05:18:57 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811190940480.27509@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101732>

2008/11/19 Nicolas Pitre <nico@cam.org>:
> On Wed, 19 Nov 2008, Johannes Sixt wrote:
>> Alex Riesen schrieb:
>> > 2008/11/19 Nicolas Pitre <nico@cam.org>:
>> >> On Wed, 19 Nov 2008, Johannes Sixt wrote:
>> >>> The work-around is to write the repacked objects to a file of a different
>> >>> name, and replace the original after git-pack-objects has terminated.
>> >>>
>> >>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> >> Acked-by: Nicolas Pitre <nico@cam.org>
>> >
>> > Are you sure? Will it work in a real repository? Were noone does
>> > rename the previous pack files into packtmp-something?
>>
>> Oh, the patch only works around the failure in the test case. In a real
>> repository there is usually no problem because the destination pack file
>> does not exist.
>>
>> The unusual case is where you do this:
>>
>>  $ git rev-list -10 HEAD | git pack-objects foobar
>>
>> twice in a row: In this case the second invocation fails on Windows
>> because the destination pack file already exists *and* is open. But not
>> even git-repack does this even if it is called twice. OTOH, the test case
>> *does* exactly this.
>
> OK.... Well, despite my earlier assertion, I think the above should be a
> valid operation.
>
> I'm looking at it now.  I'm therefore revoking my earlier ACK as well
> (better keep that test case alive).
>

Any news here?
