From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 'git add' corrupts repository if the working directory is
 modified as it runs
Date: Sat, 13 Feb 2010 06:12:38 -0600
Message-ID: <20100213121238.GA2559@progeny.tock>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100212002741.GB9883@progeny.tock>
 <20100212012314.GC24809@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
X-From: git-owner@vger.kernel.org Sat Feb 13 13:12:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgGrb-0006Vy-0I
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 13:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808Ab0BMMMi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 07:12:38 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:60973 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab0BMMMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 07:12:37 -0500
Received: by iwn39 with SMTP id 39so761529iwn.1
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 04:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NiyZJAoDwsNmF5dEZjgt76/z+fSdDRUAZx1732axvTY=;
        b=n/PLVCLsCnTDQddRONoOWZCwZygkYIqYpeNMKcbNrHIh7H3ip4KooYlQ2y88LSYp31
         g4swpK+AOQ9UTDp9GrY2l6ZYU0zRCvNNtc15QZYa5tR4swNhnmFH4wwZpESS4AQ13UZ4
         Mmt99+fcl4z+XM/TgCCAsPZg85zrFGsgUFUtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=aDKmCNu0rltCeNGvzViHTWpdbbHjLOVITCuPxVE8qFE7A47xeO6KM2I1MSfFphw2Lo
         vQfxcm8I/6xK5d6aZcwJY0EfAVgOZNWWdfdr/yFp4cYY7YK/nKT3rOLLoEnx8pFFpXoC
         Fl370jvCZq5efvwJTsKERtw42RjCThmNTLrwg=
Received: by 10.231.59.7 with SMTP id j7mr1927492ibh.12.1266063156468;
        Sat, 13 Feb 2010 04:12:36 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3937994iwn.4.2010.02.13.04.12.34
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 04:12:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100212012314.GC24809@gibbs.hungrycats.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139792>

Zygo Blaxell wrote:
> On Thu, Feb 11, 2010 at 06:27:41PM -0600, Jonathan Nieder wrote:

>>  - Low-hanging fruit: it should be possible for update-index to chec=
k
>>    the stat information to see if the file has changed between when =
it
>>    first opens it and when it finishes.
>
> I don't think this is a good idea.  stat() is very coarse-grained

You=E2=80=99re probably right.  For many file types, st_size is likely =
to
change (in this way your script is testing something unusual), but
that is no excuse to behave poorly when it doesn=E2=80=99t.

> What would be a good idea is to make sure that the code that copies a
> file into the index and calculates its hash does both in a single pas=
s
> over the same input data.  That might require replacing a simple mmap=
()
> of the input file with a read-hash-copy loop.

This leaves me nervous about speed.  Consider the following simple
case: someone the file to be added is already in the object
repository somewhere (maybe the user has tried this code before, or
a file was renamed with 'mv', or a patch applied with 'patch', or an
unmount and remount dirtied the stat information).

With the current code, write_sha1_file() will hash the file, notice
that object is already in .git/objects, and return.  With a
read-hash-copy loop, git would have to store a (compressed or
uncompressed) copy of the file somewhere in the meantime.

But I=E2=80=99d be happy to see code appear that proves me wrong. ;-)  =
One
simple benchmark to try is running the git test suite.

Cheers,
Jonathan
