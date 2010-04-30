From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: How to efficiently blame an entire repo?
Date: Fri, 30 Apr 2010 16:16:13 -0400
Message-ID: <o2m76718491004301316tfbaf434alb94e6bfd001d36b6@mail.gmail.com>
References: <r2l76718491004291612qbe0834ela89f0606e5f477e2@mail.gmail.com>
	 <x2s32541b131004301245o46d8e855va0b51ebce279398b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 22:16:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7wdV-0005d2-SR
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 22:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758332Ab0D3UQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 16:16:17 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:47516 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554Ab0D3UQO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Apr 2010 16:16:14 -0400
Received: by iwn12 with SMTP id 12so707132iwn.15
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ByCBAshcREBTx/wUyu1qtNAyuVazoagOslkxEy5tsAo=;
        b=xNo3hmJA67d5E7g037+4ZCRi89aLGax6/U63823ZRUgITB6DFRlr7KhhAl/W5h4jkF
         IPdqtK932Zv8tqt/gCW4SoNRycCpLXtJTzOK1szlKd5wbU8a8vqKrarvO6hcbn3uXZB4
         waUsTg1sDm10BB+oe4cOawk9uqfWtdt+O8nt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HxQC8s3SpolkRu+o+AMpq6ZlBwQIUlnM/tvmtye+4v+/XBjkKeneUTBWIAP3Fnz0Ib
         TmrCksdnw2A9HIDNsVWOKVPbJLwoR0CUk6MomFrMtf3STyTk4iAUT+yuR5RGReD/gRHS
         Ja5r7BHlgDCaf/Mu6tVpugXA9+h3QJEjMZrWM=
Received: by 10.231.172.210 with SMTP id m18mr2733411ibz.21.1272658573574; 
	Fri, 30 Apr 2010 13:16:13 -0700 (PDT)
Received: by 10.231.17.141 with HTTP; Fri, 30 Apr 2010 13:16:13 -0700 (PDT)
In-Reply-To: <x2s32541b131004301245o46d8e855va0b51ebce279398b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146061>

On Fri, Apr 30, 2010 at 3:45 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Thu, Apr 29, 2010 at 7:12 PM, Jay Soffian <jaysoffian@gmail.com> w=
rote:
>> Let's say you've got a repo with ~ 40K files and 35K commits.
>> Well-packed .git is about 800MB.
>>
>> You want to find out how many lines of code a particular group of
>> individuals has contributed to HEAD.
>>[...]
>> Am I missing a clever solution?
>
> How often do you need to do this? =C2=A0If it's just once in your lif=
e,
> then the brute force solution of just letting 'git blame' grind
> through it for a few hours is probably the cleverest :)

Yeah, I ended up doing this basically.

Setup a .mailmap mapping the authors I was interested in to domain.com.=
 Then:

$ git log --pretty=3D'%H %aE' HEAD | grep domain.com |
  awk '{print $1}' |
  git log --no-walk --stdin --name-only --pretty=3D%n |
  grep -v '^$' | sort -u > files1
$ git ls-files | sort > files2
$ comm -12 files1 files2 > files
$ xargs < files -n1 git annotate | grep domain.com

I didn't use --author=3Ddomain.com w/the first log invocation because I
wasn't sure if it respected .mailmap and was too lazy to look it up.

I probably I could've used --diff-filter in the second log invocation, =
but, meh.

So that worked. Took about 12 minutes to run on a recent Macbook Pro.
Aside, blame's --porcelain switch is rather poorly documented and
annotate seemed to have the right output for the job.

j.
