From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Fri, 8 Jan 2016 07:38:58 +0700
Message-ID: <CACsJy8C1R+JVmOXQ87eBP1COFNk3Vfqtb6AKzzT65catUhPczg@mail.gmail.com>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com>
 <20160105150602.GA4130@sigill.intra.peff.net> <20160107234455.GB265296@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Mike McQuaid <mike@mikemcquaid.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 01:39:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHL5e-0004sT-Ni
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 01:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbcAHAjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 19:39:31 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34177 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538AbcAHAj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 19:39:29 -0500
Received: by mail-lf0-f46.google.com with SMTP id d17so245880lfb.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 16:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=IKoavIOW6pOLzXcJk4lTm6nMk+3sx+FcNWGId/cYmuA=;
        b=fIxudxhjB0rvoXtFXXDDzx57mcTPJAoYmfvan4KPiY8P//H8KbIGJNqWQ7iAJ+VbQS
         857jYQ49164OWpdvG0iYn5WQvTq83S8hPVK7IP0Q6ka417YscCKG1Ex5C9lVFY5/it1Y
         /LG2rR8vQGYrRzj3ncFnFlDKunF93U2i46V7Mr+9xSPHmAU0ealaNq7lIzETr6lzOemE
         bLZujfyVXft87RA3Gh4it+dXX3CxJToByMbNAincrK5MBsXfykxdsmr9VXQJiiHezzLn
         TMDFnAaDXouqaV48UpzXT8uNYY9ndVf5tZG6QFE1CHbo2FJi+t5Hbd99trm4Lr0RRZaq
         5XeA==
X-Received: by 10.25.43.212 with SMTP id r203mr33585052lfr.162.1452213568266;
 Thu, 07 Jan 2016 16:39:28 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 7 Jan 2016 16:38:58 -0800 (PST)
In-Reply-To: <20160107234455.GB265296@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283522>

On Fri, Jan 8, 2016 at 6:44 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Tue, Jan 05, 2016 at 10:06:02AM -0500, Jeff King wrote:
>> Thanks for giving a clear example. This bisects to Duy's 57534ee (dir.c:
>> don't exclude whole dir prematurely if neg pattern may match,
>> 2015-09-21). AFAICT (and I don't recall looking over this patch
>> previously), what you are seeing is the intended effect of the patch.
>>
>> Your final line unignores stuff inside of "a", so we're reporting it (if you gave
>> "-uall", you'd see the actual file "a/b"). Older versions of git
>> generally optimized out looking inside "a/" at all. This created a
>> hassle when people wanted to do things like:
>>
>>     a/
>>     !a/precious-file
>>
>> in their .gitignore.
>
> I think there's still a bug in the code here.  If you do
>
>   git init
>   mkdir -p base/a/
>   printf 'base/a/\n!base/a/b.txt\n' >.gitignore

Here we have the ignore rule "base/a/", but gitignore.txt, section
NOTES mentions this

 - The rules to exclude the parent directory must not end with a
   trailing slash.

>   git add .gitignore
>   git commit -m 'Add .gitignore'
>   >base/a/b.txt
>   git add base/a/b.txt
>   git commit -m 'Add base/a/b.txt'
>   >base/a/c.txt
>   git status --porcelain
>
> git status outputs base/a/c.txt as unknown, when it should be ignored.
> We saw this in a repository at $DAYJOB.

If I delete that trailing slash, c.txt is ignored. So it's known
limitation. I think we can make trailing slash case work too, but if I
remember correctly it would involve a lot more changes, so I didn't do
it (there are other conditions to follow anyway to make it work).
-- 
Duy
