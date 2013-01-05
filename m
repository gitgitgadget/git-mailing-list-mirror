From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [BUG] git submodule update is not fail safe
Date: Sat, 05 Jan 2013 14:52:01 +0100
Message-ID: <50E83001.9000505@gmail.com>
References: <50E74145.4020701@gmail.com> <7vzk0osjli.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	"W. Trevor King" <wking@drexel.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 14:52:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrUAx-0001aM-UA
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 14:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab3AENwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 08:52:17 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:60051 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755686Ab3AENwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 08:52:16 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so8312191wey.33
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 05:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=qkR2UhGC4j29GzzhnPw1QtJCgjEsOWxsa7IRr7Q0PvY=;
        b=RBgOjCgu049RiX58yOGEnwLvGlQnQUmlVnT7tx294EP/3fBwENZ89SQhPuC/zkCFxC
         L5bPMA2kaY4Z5g4DtuK3nWIbP8Ewu2/LLek93ZYeaqTBRn//UWBY2vw98GWdXU8SDdGK
         lI4YduL1WC93qasgf8xJb8WjTR8adAJyNLoB80xeBlzCOAyrXvxd5DALtcaCRGLL6iOO
         CFtxj0iKNb6uXbQ2kIy9GqwLqaK5L4Ys2lIn8TNAsSYMkGJAQUJSq4X0FhTUr9iEwLCt
         uMEO7GpICiBLjNzAAd5U1YzM3mmq6NGSklye2nwpfzHEEoJMPax7E83f8BAKCG7CFALJ
         gCRw==
X-Received: by 10.194.121.74 with SMTP id li10mr77427453wjb.5.1357393934748;
        Sat, 05 Jan 2013 05:52:14 -0800 (PST)
Received: from [192.168.0.3] ([151.70.204.244])
        by mx.google.com with ESMTPS id p2sm3791761wic.7.2013.01.05.05.52.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 05:52:13 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vzk0osjli.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212689>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 04/01/2013 22:51, Junio C Hamano ha scritto:
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> $ git submodule update --init
>> ...
>> Submodule 'roms/vgabios' (git://git.qemu.org/vgabios.git/) registered
>> for path 'roms/vgabios'
>> fatal: unable to connect to anongit.freedesktop.org:
>> anongit.freedesktop.org[0: 131.252.210.161]: errno=Connection timed out
>>
>> Unable to fetch in submodule path 'pixman'
>>
>> $ git submodule update --init
>> fatal: Needed a single revision
>> Unable to find current revision in submodule path 'pixman'
>>
>> The problem is easy to solve: manually remove the pixman directory;
>> however IMHO git submodule update should not fail this way since it may
>> confuse the user.
> 
> Sounds like a reasonable observation.  Jens, Heiko, comments?

I have found another, related problem.

Today I tried to update qemu submodules again, however the command
failed with an "obscure" error message:

$ git submodule update pixman
fatal: Needed a single revision
Unable to find current revision in submodule path 'pixman'


The pixman submodule is the one that I failed to update in the very begin.
The problem is not with the pixman or qemu repository: if I clone again
qemu (with the --recursive option), all is ok.

The problem is with the private working copy (in .git/modules/pixman)
being corrupted:

$git log
fatal: bad default revision 'HEAD'.

The HEAD file contains "ref: refs/heads/master", but the refs/heads
directory is empty.


By the way: since git submodule is a porcelain command, IMHO it should
not show to the user these low level error message; at least it should
give more details.
As an example, in this case it could say something like:

  the local module "pixmap" seems to be corrupted.
  Run xxx to remove the module and yyy to create it again.

The ideal solution is, for submodule update, to never leave an
incomplete directory; that is: the update command should be atomic.


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDoMAEACgkQscQJ24LbaUQVugCggdl36Hx5JIW/hd1SVXWv+ths
zpYAnR+93BfDLaFhXEiaQvu/TickmDA0
=2Mnw
-----END PGP SIGNATURE-----
