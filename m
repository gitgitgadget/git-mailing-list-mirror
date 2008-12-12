From: "Ramon Tayag" <ramon.tayag@gmail.com>
Subject: Re: Unable to index file
Date: Sat, 13 Dec 2008 04:27:59 +0800
Message-ID: <f25d5ad20812121227o77cf2bw34e6bc15d9801215@mail.gmail.com>
References: <f25d5ad20812120647m646698d7t9849c8ccb08c465e@mail.gmail.com>
	 <alpine.LFD.2.00.0812120956050.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 21:29:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBEdY-0001Pu-1g
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 21:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbYLLU2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 15:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbYLLU2E
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 15:28:04 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:7804 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbYLLU17 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 15:27:59 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1480451wfd.4
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 12:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OaPMjJ/mQppgZvVB2tCxkBChoRHkkdiakgmlYriK+S8=;
        b=e5U0UxgqA6iWQS+MoWV96UzQrzWjgW2r2DBMz9pBVGgr4Bl8L3BBx9IiQ2B3FwprGs
         t3PoWRoM4fJ1n5aHuonEsg7Qj4VXH+4Wa2WOcisH8HI4YCJr1CpFh3IIedXb3H4EWphE
         fT338braz9AsTOgiPx9McMon00fbZlnyg58jE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oDqmns2Ryi3gqnbbdlxq9mInDoi+GPCeg2YyUoG09L01FDqdOlRtol7HhhCXg/E4ln
         vGVJxwV5VrTIxHNOnsc6efLR0sN3BLsNqADXxhOClWehpXLlH8lxSFW/YJzugn/A4xKV
         eNns/+WVB0rKvVCq+2lQYFa+zo7XuSHN1jdEQ=
Received: by 10.143.12.20 with SMTP id p20mr1507161wfi.169.1229113679043;
        Fri, 12 Dec 2008 12:27:59 -0800 (PST)
Received: by 10.142.191.15 with HTTP; Fri, 12 Dec 2008 12:27:59 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812120956050.3340@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102941>

Oh thank you for your very detailed explanation.  I was bothering
people on #rubyonrails and #git but got no answers.

I'm on Ubuntu 8.10.  The files I'm working on live on an NTFS drive
(my "storage" drive; yes, I still have to boot into Windows).  If it
being on NTFS makes a difference I'll try this on ext3 and let you
know what happens :)

Thanks,
Ramon Tayag



On Sat, Dec 13, 2008 at 2:07 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Fri, 12 Dec 2008, Ramon Tayag wrote:
>>
>> I've come across a problem that I don't believe lies in Rails.  You
>> needn't be familiar, I think, with Rails to see what's wrong.
>>
>> I can't seem to add the files that are in
>> http://dev.rubyonrails.org/archive/rails_edge.zip
>>
>> 1) Unpack the zip
>> 2) Initialize a git repo inside the folder that was unpacked
>> 3) git add .
>>
>> See the errors.. :o http://pastie.org/337571
>
> What platform/filesystem is this?
>
> Git is rather particular about symlinks, and it looks like your platform
> does something odd, and that makes git unhappy about your symlink.
>
> In particular:
>
>        ls -l vendor/rails/actionpack/test/fixtures/layout_tests/layouts/
>        ...
>        lrwxrwxrwx 1 root root 48 2008-12-12 18:22 symlinked -> ../../symlink_parent
>
> notice how the symlink content is "../../symlink_parent", but then take a
> look at the _size_ of the symlink: 48 bytes.
>
> Git expects the lstat() information to match the return from readlink(),
> and it doesn't.
>
> For exact details, see "index_path()" in sha1_file.c:
>
>        case S_IFLNK:
>                len = xsize_t(st->st_size);
>                target = xmalloc(len + 1);
>                if (readlink(path, target, len + 1) != st->st_size) {
>                        char *errstr = strerror(errno);
>
> ie we consider it an error if we get less than st_size characters back
> from readlink().
>
> Now, admittedly git is probably being really annoyingly anal about this
> all, and we probably should loosen the restrictions on it a bit, but I'd
> like to know why it happens. I cannot recall this having been reported
> before, so it's some specific filesystem or OS that causes this, I think.
>
>                Linus
>
