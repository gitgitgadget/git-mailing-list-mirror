From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [BUG] git submodule update is not fail safe
Date: Sat, 05 Jan 2013 15:49:55 +0100
Message-ID: <50E83D93.80600@gmail.com>
References: <50E74145.4020701@gmail.com> <7vzk0osjli.fsf@alter.siamese.dyndns.org> <50E83224.2070701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	"W. Trevor King" <wking@drexel.edu>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 05 15:50:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrV4x-0000Xf-Js
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 15:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790Ab3AEOuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 09:50:03 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:65049 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab3AEOuB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 09:50:01 -0500
Received: by mail-we0-f178.google.com with SMTP id x43so8910692wey.9
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 06:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=NeTGobSOSE1B4sp9iqdJZ6cm8tNx4dYX5BXUwdLGGBg=;
        b=JrsHWOSrUHkEa39QV+6vsGqqwPU7VICMWDGTZfxXITnQChL5Ri1/RoSLxDSTds0Y14
         QvMTA6Zvy7+q5EepkLxIKrawdX63wstPYFU582OwNgyisSzAo1erIyLDohY3QKmI37Vw
         Ik927MoG/WgFFXhnkvAWS5KmLIOcc1FlHvbMuhl/hff4yzbsPQe3eyr7ArTEyeBZpTEW
         3mzHn3u4lDFPrPephk5pBrEVW9Gtva+2BZTbfRijeKW7BozikUHPU5pv1AvDsJDSs6wE
         vS3x08jL6Qz8ohY9rM2tApexp1L7Fh/aMwAPIRWoAM6+8QKA/9NXy7JY6Fwo71q3gONn
         pSdg==
X-Received: by 10.194.7.104 with SMTP id i8mr88498796wja.27.1357397399674;
        Sat, 05 Jan 2013 06:49:59 -0800 (PST)
Received: from [192.168.0.3] ([151.70.204.244])
        by mx.google.com with ESMTPS id hu8sm3588380wib.6.2013.01.05.06.49.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 05 Jan 2013 06:49:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <50E83224.2070701@web.de>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212695>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 05/01/2013 15:01, Jens Lehmann ha scritto:
> [...]
>>> $ git submodule update --init
>>> fatal: Needed a single revision
>>> Unable to find current revision in submodule path 'pixman'
>>>
>>> The problem is easy to solve: manually remove the pixman directory;
>>> however IMHO git submodule update should not fail this way since it may
>>> confuse the user.
>>
>> Sounds like a reasonable observation.  Jens, Heiko, comments?
> 
> The reason seems to be that clone leaves a partial initialized .git
> directory in case of connection problems. The next time submodule
> update runs it tries to revive the submodule from .git/modules/<name>
> but fails as there are no objects in it.
> 
> [...]
>
> If this isn't seen as a bug in clone, we could also remove the
> .git/modules/<name> directory in module_clone() of git-submodule.s
> h when the clone fails. Manilo,

Its Manlio, not Manilo ;-).

> does the following patch remove the
> problems you are seeing (after removing .git/modules/pixman manually)?
> 

I don't think I can test it right now, since the problem can only be
reproduced when git clone fails due to network problems.

Without the patch, if I remove the .git/modules/pixman directory,
`git submodule update --init pixamp` fails:

  Unable to find current revision in submodule path 'pixman'
  fatal: Not a git repository: pixman/../.git/modules/pixman


To reproduce the problem, however, it seems all you need to do is to
send SIGINT signal during `git submodule update` :

  $ git submodule update --init pixman
  Cloning into 'pixman'...
  remote: Counting objects: 10137, done.
  ^C

  $ git submodule update pixman
  remote: Counting objects: 10137, done.
  ^C

  $ git submodule update pixman
  fatal: Needed a single revision
  Unable to find current revision in submodule path 'pixman'


Note that I had to send SIGINT two times, in order to corrupt the module.

I suspect your patch does not fix this (since I don't get the "Clone
failed" error message).


I also noted that If I send SIGINT before git starts counting remote
objects, I get a different count number:


  $ git submodule update pixman
  Cloning into 'pixman'...
  ^C

  $ git submodule update pixman
  remote: Counting objects: 9757, done.
  ^C

  $ git submodule update pixman
  fatal: Needed a single revision
  Unable to find current revision in submodule path 'pixman'


Note that git is reporting 9757 remote objects, instead of 10137.


P.S.:
sorry for the mail I sent today.
It reported the exact same problem I reported yesterday: this morning I
was rather sure that I got a different error message from submodule
update...



Regards   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDoPZMACgkQscQJ24LbaUTfNQCdFvhSQwGlJZlvOr+TIHHyDFJY
d8AAn0zuHKjBGIcqr8RH/rftHjomvPtM
=48RN
-----END PGP SIGNATURE-----
