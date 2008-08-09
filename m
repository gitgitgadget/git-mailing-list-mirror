From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH] git-svn: Make it scream by minimizing temp files
Date: Fri, 08 Aug 2008 21:12:38 -0400
Message-ID: <489CEF06.7050204@griep.us>
References: <1218235313-19480-1-git-send-email-marcus@griep.us> <7vd4kjazaz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 03:14:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRd1u-0004Ij-HJ
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 03:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbYHIBM5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 21:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbYHIBM4
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 21:12:56 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:22959 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbYHIBMz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 21:12:55 -0400
Received: by wx-out-0506.google.com with SMTP id h29so592312wxd.4
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 18:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=BfrUcc2tlJJy+E1Ebwq5xAx2RfNuFDV3vszM/D8fpRs=;
        b=n1Rq0x5EhOIRPhF+qNzA1ujMwNHFnqdIkW6/FM8JGAzkxfqFZbqTh7qaLU2Uqa8uY1
         EG8Tvwt/rUAkXFNXp7lvxr2tYwYj5INnu8QNbaXu/HKDWqtOYv3FnybqRGwNN8AvzQOP
         hFd6pDxPm1llI/Xaq6ph9n61hAvqzqG0HEnaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=Kk/gur5Pk1R3bnNlIk2XJR81Y4yL+BOGlqdX/Z3RwsQmhNc1WHxw/GtkZXOhesyWvX
         nauWqcGU1H1DvZBOw6Oe5KW8vr4JwP1ExvDfgc4LXqyoUcx4Pa5dMC97tdQ3AscV2Qyg
         koIyXVeu0ampN2TPYlIbZoiFnBx/5WpRl88d0=
Received: by 10.70.8.12 with SMTP id 12mr6827447wxh.89.1218244373622;
        Fri, 08 Aug 2008 18:12:53 -0700 (PDT)
Received: from ?192.168.1.64? ( [71.174.65.78])
        by mx.google.com with ESMTPS id h8sm1486762wxd.11.2008.08.08.18.12.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Aug 2008 18:12:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7vd4kjazaz.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91737>

I am working on that right now; however, against master I am getting
checksum mismatches with my svn repository, so generating benchmarks
against that requires committing a revert of ffe256f9, which makes
things even slower. My work comp is running cygwin, and that could be=20
why ffe256f9 is a problem.

I am, however using a smaller repository, namely that of the Boo
Programming Language, to run some benchmarks.  I'm running it on a=20
Linux box, and I'll publish the results as soon as they are ready. =20

I'll include:

ffe256f9 and my patch
ffe256f9 and no patch
revert ffe256f9 and my patch
revert ffe256f9 and no patch

Marcus

Junio C Hamano wrote:
> Marcus Griep <marcus@griep.us> writes:
>=20
>> Currently, git-svn would create a temp file on four occasions:
>> 1. Reading a blob out of the object db
>> 2. Creating a delta from svn
>> 3. Hashing and writing a blob into the object db
>> 4. Reading a blob out of the object db (in another place in code)
>>
>> Any time git-svn did the above, it would dutifully create and then
>> delete said temp file.  Unfortunately, this means that between 2-4
>> temporary files are created/deleted per file 'add/modify'-ed in
>> svn (O(n)).  This causes significant overhead and helps the inode
>> counter to spin beautifully.
>>
>> By its nature, git-svn is a serial beast.  Thus, reusing a temp file
>> does not pose significant problems.  "truncate and seek" takes much
>> less time than "unlink and create".  This patch centralizes the
>> tempfile creation and holds onto the tempfile until they are deleted
>> on exit.  This significantly reduces file overhead, now requiring
>> at most three (3) temp files per run (O(1)).
>=20
> Beautifully written analysis of the issue being tackled.
>=20
> But optimization patch should be backed by numbers --- do you have a
> benchmark result of some sort that you would want to include here?
>=20
>=20

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
