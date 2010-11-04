From: Christian Couder <christian.couder@gmail.com>
Subject: Re: cherry-pick fail when a symbolic link has been changed into a
 file or directory
Date: Thu, 4 Nov 2010 14:55:12 +0100
Message-ID: <AANLkTimq8SP-gxZQiXW3Pxg3-1Z98zyPAoNA8JDn0=6A@mail.gmail.com>
References: <20101104125641.2ef90853@cortex>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Camille Moncelier <moncelier@devlife.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 14:55:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE0Hj-0008D0-Q7
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 14:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab0KDNzQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 09:55:16 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44986 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0KDNzP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 09:55:15 -0400
Received: by ewy7 with SMTP id 7so954544ewy.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k5OGbpHjD/ESqqEbz7h7EvobeKISh5kB8N7zDxASrFg=;
        b=ZWNArL+cW6W2wnufP6RzIbRpiCDIufmVbZWs1lOookFVbU4WzA60iFGozOKJCBXNHq
         tMxnWKq+sJpe5uOjb3TuqdszLKUGYnv7i2r0ExKyjXz7YZAYI+IT4sirunjc/JnC8QfX
         78drteMoBS+2YZdDx7oVEEMu6DqsEkyyyM0PA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qDt8au9d2zUhgCM7u+P1TWzCiKk51SSkgspmHsM9s3bVPEnrEzXSoFjOEreZsynTCd
         kKQYvz1/E+tLx4SJGezKd4/zL7S2ECf4Gbzk58DA+EkCvx7zDJIf2PtWZTX0lSE+LyFH
         32fLZKzhYdFZh2MGOP+fd+n+lef8UWyIEY/RA=
Received: by 10.216.30.10 with SMTP id j10mr1961162wea.8.1288878912701; Thu,
 04 Nov 2010 06:55:12 -0700 (PDT)
Received: by 10.216.26.208 with HTTP; Thu, 4 Nov 2010 06:55:12 -0700 (PDT)
In-Reply-To: <20101104125641.2ef90853@cortex>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160719>

Could you try to cherry-pick with other strategies?
=46or example with:

git cherry-pick --strategy resolve test1

I remember there were some problems with the default "recursive"
strategy and I am not sure they were fixed.
By the way could you tell which version of git you are using?

Thanks,
Christian.

On Thu, Nov 4, 2010 at 12:56 PM, Camille Moncelier
<moncelier@devlife.org> wrote:
> I'm reposting this since I didn't get any responses and I think my
> message didn't contained enought context.
>
> I think I may have spotted a bug, or a unhandled case when doing a
> cherry-pick
>
> Consider a repository like this:
>
> # Initialize a dummy repository
> =A0 =A0mkdir -p repo1 ; cd repo1
> =A0 =A0git init .
>
> # Create a new directory `dir1' and a link to it `dir2'
> =A0 =A0mkdir dir1
> =A0 =A0echo file1 > dir1/file1
> =A0 =A0ln -s dir1 dir2
> =A0 =A0git add dir1 dir2
> =A0 =A0git commit -m "Initial status: dir2 -> dir1"
>
> # Create a branch named `test1' remove the `dir2' link and
> # replace it by a new directory
> =A0 =A0git checkout -b test1
> =A0 =A0git rm dir2
> =A0 =A0mkdir dir2
> =A0 =A0touch file2 > dir2/file1
> =A0 =A0git add dir2/file1
> =A0 =A0git commit -m "Removing link: dir1/ and dir2/"
>
> # Now create a new file in `test1' branch
> =A0 =A0message=3D"New file in test1"
> =A0 =A0echo $message > new_file_test1
> =A0 =A0git add new_file_test1
> =A0 =A0git commit -m "$message"
>
> # Now try to cherry-pick last commit from `test1' into master
> =A0 =A0git co master
> =A0 =A0git cherry-pick test1
>
> The cherry-pick fails saying if failed to merge `dir2' despite the fa=
ct
> that the commit doesn't affect `dir2' and
>
> git diff test1~..test1 | git apply
>
> is working. Am I doing something wrong ?
>
> --
> Camille Moncelier
> http://devlife.org
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
