From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] fast-import: add special '-' blob reference to use the previous one.
Date: Mon, 22 Dec 2008 04:08:28 +0200
Message-ID: <94a0d4530812211808r147cbd40na7266abe5ac0e6f3@mail.gmail.com>
References: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com>
	 <1229825502-963-2-git-send-email-felipe.contreras@gmail.com>
	 <20081221221149.GB17355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 03:09:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEaEv-0005Qk-6v
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 03:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbYLVCIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 21:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbYLVCIa
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 21:08:30 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:65121 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYLVCIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 21:08:30 -0500
Received: by fg-out-1718.google.com with SMTP id 19so709913fgg.17
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 18:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kLux6ekl/JdHBbiSYH0B5dneSQsAsWqAFdViuKCOiXA=;
        b=F/KLaLCsX2xvjErllsMYq6iZKPJLq1xJgdZNiNt1xyXZ/s4PIYz2wTVWf1dnwy9D8x
         xjn9slhvUvWzmt94VjeWWOxEzZrgbiOprvVtiK0765DnmtUhn6DXUWoyHmlYgo0Yz3UO
         eLGnPEdPr9vPb0ZKX4xpwO0NpuwgXd6lCpOtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GzqX0n5Zfe7765+fGY9YcZWvAxPIjXkSBqwnxbWY92tUV41X5SzbIHs9mRH9u3z0Kc
         7MWa9D1NZ3aI8XKrifBKrTuncVhtlfEDNCjliVfsI+FkWFXSZbD89UGDlfR5X9CsrKMP
         5mUEALxBQo89Z1OeIrk19bW5FNHJbeEF5IfHI=
Received: by 10.86.53.8 with SMTP id b8mr3339091fga.13.1229911708170;
        Sun, 21 Dec 2008 18:08:28 -0800 (PST)
Received: by 10.86.77.17 with HTTP; Sun, 21 Dec 2008 18:08:28 -0800 (PST)
In-Reply-To: <20081221221149.GB17355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103736>

On Mon, Dec 22, 2008 at 12:11 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> @@ -1862,7 +1864,7 @@ static void file_change_m(struct branch *b)
>>       const char *endp;
>>       struct object_entry *oe = oe;
>>       unsigned char sha1[20];
>> -     uint16_t mode, inline_data = 0;
>> +     uint16_t mode, inline_data = 0, empty_blob = 0;
>
> Its not the empty blob, its the inherited/assumed blob...

Right. I thought: in order to use the inherited blob, you should not
specify any blob (leave it empty, or blank).

But yeah, 'inherited' does the job too.

>> @@ -1893,6 +1895,10 @@ static void file_change_m(struct branch *b)
>>       } else if (!prefixcmp(p, "inline")) {
>>               inline_data = 1;
>>               p += 6;
>> +     } else if (!prefixcmp(p, "- ")) {
>> +             hashclr(sha1);
>> +             empty_blob = 1;
>> +             p += 1;
>
> Hmph, so if create a new path with a blob of "-" the repository
> will be corrupt because the zero id was used and error was produced.
>
> Actually I think you have the same bug in the prior patch with the
> mode being inherited.  I wonder if we shouldn't put error checking
> in too to validate that versions[0] describes a file entry.

Yes, in my tests I found that issue in the previous patch and I have a
fix for that (set a default mode), but I haven't fixed this one. Do
you know what should be the behavior? I think it should 'die'.

-- 
Felipe Contreras
