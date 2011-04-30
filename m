From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git sparse checkout exclusions not working?
Date: Sat, 30 Apr 2011 17:06:58 +0700
Message-ID: <BANLkTikU_Qjs9jo2MmPdbwVNBj1V9vJJSw@mail.gmail.com>
References: <BANLkTinPg_jaxiF8yFtnf4BrT4fx-BQ=+A@mail.gmail.com> <BANLkTi=m4hcs7pVgn0rkQktmZaqK_ORxaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: skillzero@gmail.com, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 12:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QG75M-0000K6-1u
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 12:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab1D3KHb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Apr 2011 06:07:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52703 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab1D3KH3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2011 06:07:29 -0400
Received: by bwz15 with SMTP id 15so3628584bwz.19
        for <git@vger.kernel.org>; Sat, 30 Apr 2011 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=k7VV3KP6NcFTlGYrDiTX9aq7Iyv5t1AQ22N5g1pxCGI=;
        b=o2zZW9oJn2/svT5aB3oODrb4Mml5XWiWtBQrmXqjv3v8g8iPix34cthpblViCmC90s
         Cj98MAymW9mXQVU1Z1+eP19dHpbJpsRhpjVw4iaVgbkq8o8tklGqyw27o7AKFQOzNOrv
         loy3pd6GxIi/xgHzyuggXCZJKcdB2gDheddIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NlsOk4mUqj4YMrKrYXOWqzcaDfwbgWH+TOeOu86XG4BgswP0X8+h0PdF2ZNgCUJQUP
         DuNdDy72icINtXJ5PmQBg6gVhWdY7RW6OFmHdEzmCWPj39bC7DA7xXZvPZH+SMqvpK4v
         Pyc+M1U361LwCJ/mAB+h9BOiQ9vQYkhpfeoo4=
Received: by 10.204.75.23 with SMTP id w23mr1637228bkj.200.1304158048225; Sat,
 30 Apr 2011 03:07:28 -0700 (PDT)
Received: by 10.204.17.14 with HTTP; Sat, 30 Apr 2011 03:06:58 -0700 (PDT)
In-Reply-To: <BANLkTi=m4hcs7pVgn0rkQktmZaqK_ORxaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172520>

On Fri, Apr 29, 2011 at 7:10 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Wed, Apr 27, 2011 at 11:35 PM, =C2=A0<skillzero@gmail.com> wrote:
>> It seems like ! patterns in the sparse-checkout file don't exclude
>> individual files in a directory. Here's what I did:
>>
>> ...
>>
>> The "test1" directory was included, but "test1/file2.txt" wasn't
>> excluded even though I added a ! pattern for it. The test2 directory
>> was correctly excluded so that makes me think sparse was working in
>> general, but just not respecting the ! pattern in this case.
>>
>> Is this a bug or am I doing something wrong?
>
> I can reproduce it too. It looks like a regression from
> whole-directory matching. If a directory is matched, all files inside
> are considered "in". Let's see if I can come up with something this
> weekend.

sparse checkout rules are not the only ones falling for this trap.
=2Egitignore has the same problem:

pclouds@do /tmp/z $ cat .gitignore
t
!t/1
pclouds@do /tmp/z $ ls t
1  2  3
pclouds@do /tmp/z $ git init
Initialized empty Git repository in /tmp/z/.git/
pclouds@do /tmp/z $ ~/w/git/git add .
pclouds@do /tmp/z $ git ls-files
=2Egitignore

I wonder if we can convert struct exclude to struct pathspec and solve
the problem all at the same place. Granted .gitignore's '*' is
different from pathspec's '*' (ie. FNM_PATHNAME vs no flag to
fnmatch), but struct pathspec can be taught to do it both ways and the
pathspec magic can expose FNM_PATHNAME to users too.
--=20
Duy
