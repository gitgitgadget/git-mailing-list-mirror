From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH] git-svn: Make it scream by minimizing temp files
Date: Sat, 09 Aug 2008 11:45:14 -0400
Message-ID: <489DBB8A.2060207@griep.us>
References: <1218235313-19480-1-git-send-email-marcus@griep.us> <20080809062521.GA10480@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Aug 09 17:46:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRqeG-0001Rj-8b
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 17:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbYHIPpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 11:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbYHIPpa
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 11:45:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:65392 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYHIPp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 11:45:28 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1023280wri.5
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=dQ7XOp5IXRcuzddH5P7foIY8nEVvuZU92J/GUS/3C8k=;
        b=c+CCoqxvXKfUWGp8bIR0G670PKaw3YjuiLKpHcj11xiR/OyQJRBWxbXiR3PVlZZ/sX
         NnZaari5Y3fSIFYVLj1xi3Jtqyk5qhiRRKBN+ZgHDkQd3NSolj1tsrqE1tgx0+vWP+EJ
         I9Putr3LQYg5PNT1xzyPCt+HrO/tiNGVGym6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=xwMWbEBcCWV9314rloZMozId74ALCOHzaA57PHqIusqgGqTCaiGUfiGtAEljsiH5I8
         AQCeEKpPuwsnorW97r/QIvged8tG2mufuf9gD50bUKWo3SRV8Ye7iyg5nPy7XoZegnnf
         HeMs1hmaGr0mTVk2A8dVbzkkw+tDeT4nxTD/8=
Received: by 10.90.72.3 with SMTP id u3mr8262755aga.45.1218296727375;
        Sat, 09 Aug 2008 08:45:27 -0700 (PDT)
Received: from ?192.168.1.64? ( [71.174.65.78])
        by mx.google.com with ESMTPS id 24sm2892805wrl.8.2008.08.09.08.45.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Aug 2008 08:45:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080809062521.GA10480@untitled>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91769>

Eric Wong wrote:
> Wow.  I've considered this in the past didn't think there would be a
> significant difference (of course I'm always network I/O bound).  Whi=
ch
> platform and filesystem are you using are you using for tests?
>=20
> I don't notice any difference running the test suite on Linux + ext3
> here, but the test suite is not a good benchmark :)

Yeah, much of the test suite uses small repositories without much histo=
ry.
Where you see the benefit is with large repositories with many files.
In such cases, even a small speedup can reduce the total import time=20
significantly.

My benchmark against a large repository uses the svn we have at work, b=
ut
there is currently a planned power outage, so I'll have to wait until=20
tonight to run my benchmarks there (and they'll take significant time).

Nonetheless, my tests against the smaller Boo repository showed almost =
no
change in user time, but a 10% reduction in system time used.  There wa=
s
also a small (1%) drop in minor page faults.  I'm confident in these
results, but won't certify them until I'm able to run the tests on a mu=
ch
larger repository.

>> +use File::Temp qw/ :seekable /;
>=20
> qw/ :seekable / does not appear in my version of Perl (5.8.8-7etch3 f=
rom
> Debian stable)  Just having "use File::Temp;" there works for me.

My newbishness in perl shows.  I'll change it to a simple 'use'.

>> +		seek $TEMP_FILES{$fd}, 0, 0 or croak $!;
>=20
> Perhaps a sysseek in addition to the seek above would help
> with the problems you mentioned in the other email.
>=20
> 		sysseek $TEMP_FILES{$fd}, 0, 0 or croak $!;
>=20
> (It doesn't seem to affect me when running the test suite, though).

Sounds like a good idea, but I found the source of my cygwin issue,
namely that /tmp (which perl uses for its temp files) was mounted
in textmode.  I fixed that by remounting that folder in binmode.

Nonetheless, if consumers may use sysread, after getting the file handl=
e
then we'll want to use sysseek.

>> +	} else {
>> +		$TEMP_FILES{$fd} =3D File::Temp->new(
>> +									TEMPLATE =3D> 'GitSvn_XXXXXX',
>> +									DIR =3D> File::Spec->tmpdir
>> +									) or croak $!;
>=20
> Way too much indentation :x

That's what I get for assuming a tab width of 4.  I'll redo it with
about half as many tabs.

>> +		if (defined $autoflush) {
>> +			$TEMP_FILES{$fd}->autoflush($autoflush);
>> +		}
>=20
> Given how much we interact with external programs, I'd rather force
> every autoflush on every file handle to avoid subtle bugs on
> different platforms.  It's faster in some (most?) cases, too.

That sounds good to me.

> Also, this seems generic enough that other programs (git-cvsimport
> perhaps) can probably use it, too.  So maybe it could go into Git.pm =
or
> a new module, Git/Tempfile.pm?

I'd advocate the latter since it's not really Git functionality, but
rather a support, so a submodule would perhaps be the better placement.

Also, I came up with one more optimization inside 'sub close_file', so
I'll roll that in too.  Tell me where you/the community would prefer=20
the tempfile functionality, and I'll submit a new patch series with=20
one patch for the module and one patch for git-svn.

By then, I should have some better benchmark results.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
