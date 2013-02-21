From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files
Date: Thu, 21 Feb 2013 15:18:40 -0800
Message-ID: <CAMB+bf+whVFD03neCh-gBORXOBoNjgaCbfP_mh8HgDy6UqGFZA@mail.gmail.com>
References: <CAMB+bfKYLjmDavcLaO7scBPfTLmzqAmH+k9uBj0WJ+dzj9vuyA@mail.gmail.com>
	<20130221224319.GA19021@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:19:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8fPw-0001Kh-HH
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 00:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209Ab3BUXSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 18:18:43 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:42454 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab3BUXSm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 18:18:42 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so67932lab.9
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 15:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=XN3JJmHzDjShSNN6QTEPDDBuM5EAObZXubNOvwxjzMk=;
        b=RwkwP04UUJIBNtsAZD6cQLlh6aifm6qsxLrtNjNc+GQbZvX+ke3GhSWKSgjI0uOW5B
         AekjDSDCXsQbUitxHG6ioTBWimyss0afZOoohnFYlykTdDuCrhEqA8Z+5BptKj2erML/
         0Wz+9B8FlX5Vn6oBjbaY6FZy+DGQuWBnhp+61npGDxv3+O2UIXpiqtnLo3eLNCqWhz6l
         LjkhG7kz+w/Q7h05zxaWXFoCnO5rq/OqfWmF2BgAASjCxsCw64i+mzWKTAU2/CsrHJzY
         GmhHDb7tSXFBKWj6m/bv2CNRZG6yLA/y+IUfAlJuyaBnLN8ZxiiDOysIG+CZHFuRQKRX
         vPsw==
X-Received: by 10.112.42.162 with SMTP id p2mr165311lbl.103.1361488721026;
 Thu, 21 Feb 2013 15:18:41 -0800 (PST)
Received: by 10.114.38.67 with HTTP; Thu, 21 Feb 2013 15:18:40 -0800 (PST)
In-Reply-To: <20130221224319.GA19021@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216804>

On Thu, Feb 21, 2013 at 2:43 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 21, 2013 at 02:13:32PM -0800, Joshua Clayton wrote:
>
>> Greetings.
>> This is my first patch here. Hopefully I get the stylistic & political
>> details right... :)
>> Patch applies against maint and master
>
> I have some comments. :)
>
> The body of your email should contain the commit message (i.e., whatever
> people reading "git log" a year from now would see). Cover letter bits
> like this should go after the "---". That way "git am" knows which part
> is which.
>
>>         Developer's Certificate of Origin 1.1
>
> You don't need to include the DCO. Your "Signed-off-by" is an indication
> that you agree to it.
>
>> Affects git svn clone/fetch
>> Original code loaded entire file contents into a variable
>> before writing to disk. If the offset within the variable passed
>> 2 GiB, it becrame negative, resulting in a crash.
>
> Interesting. I didn't think perl had signed wrap-around issues like
> this, as its numeric variables are not strictly integers. But I don't
> have a 32-bit machine to test on (and numbers larger than 2G obviously
> work on 64-bit machines). At any rate, though:
>
>> On a 32 bit system, or a system with low memory it may crash before
>> reaching 2 GiB due to memory exhaustion.
>
> Yeah, it is stupid to read the whole thing into memory if we are just
> going to dump it to another filehandle.
>
>> @@ -949,13 +951,21 @@ sub cat_blob {
>>               last unless $bytesLeft;
>>
>>               my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
>> -             my $read = read($in, $blob, $bytesToRead, $bytesRead);
>> +             my $read = read($in, $blob, $bytesToRead, $blobSize);
>>               unless (defined($read)) {
>>                       $self->_close_cat_blob();
>>                       throw Error::Simple("in pipe went bad");
>>               }
>
> Hmph. The existing code already reads in 1024-byte chunks. For no
> reason, as far as I can tell, since we are just loading the blob buffer
> incrementally into memory, only to then flush it all out at once.
>
> Why do you read at the $blobSize offset? If we are just reading in
> chunks, we be able to just keep writing to the start of our small
> buffer, as we flush each chunk out before trying to read more.
>
> IOW, shouldn't the final code look like this:
>
>   my $bytesLeft = $size;
>   while ($bytesLeft > 0) {
>           my $buf;
>           my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
>           my $read = read($in, $buf, $bytesToRead);
>           unless (defined($read)) {
>                   $self->_close_cat_blob();
>                   throw Error::Simple("unable to read cat-blob pipe");
>           }
>           unless (print $fh $buf) {
>                   $self->_close_cat_blob();
>                   throw Error::Simple("unable to write blob output");
>           }
>
>           $bytesLeft -= $read;
>   }
>
> By having the read and flush size be the same, it's much simpler.

My original bugfix did just read 1024, and write 1024. That works fine
and, yes, is simpler.
I changed it to be more similar to the original code in case there
were performance reasons for doing it that way.
That was the only reason I could think of for the design, and adding
the $flushSize variable means that
some motivated person could easily optimize it.

So far I have been too lazy to profile the two versions....
I guess I'll try a trivial git svn init; git svn fetch and check back in.
Its running now.

>
> Your change (and my proposed code) do mean that an error during the read
> operation will result in a truncated output file, rather than an empty
> one. I think that is OK, though. That can happen anyway in the original
> due to a failure in the "print" step. Any caller who wants to be careful
> that they leave only a full file in place must either:
>
>   1. Check the return value of cat_blob and verify that the result has
>      $size bytes, and otherwise delete it.
>
>   2. Write to a temporary file, then once success has been returned from
>      cat_blob, rename the result into place.
>
> Neither of which is affected by this change.
>
> -Peff

In git svn fetch (which is how I discovered it) the file being passed
to cat_blob is a temporary file, which is checksummed before putting
it into place.
