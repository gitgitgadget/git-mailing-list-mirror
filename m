From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH next] don't let mailmap provoke use of freed memory
Date: Fri, 15 Oct 2010 02:59:54 -0500
Message-ID: <20101015075954.GA8557@burratino>
References: <87tyksd9er.fsf@meyering.net>
 <20101011162153.GG25842@burratino>
 <AANLkTimpN5CAC5UbhC2Kydhu_BMouriQn1d6OL5vt09m@mail.gmail.com>
 <20101015061821.GE21830@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 10:03:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6fGJ-0001CD-1W
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 10:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab0JOID1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 04:03:27 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40398 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab0JOIDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 04:03:25 -0400
Received: by gxk6 with SMTP id 6so210378gxk.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 01:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=s1Og8QZFkKlEsg5eQyeuiYmS/STboKSIO2VZ0+hTKik=;
        b=qqpHnoiD8plnhjnJMwPhtl9hLvqJ63rRMb1Z5ORxnYf2MxmBMBcbKftN3Tm2r/jkR4
         Y+HDXVzd6baCTiwBytQrSf+wy9Wyh+Mdw9R+y5t1dBKKdHbqwjSxps429yygYxNu4r4n
         Ig8DIXhu/ea53uSVw0XmGBK1ceFRyQPFx0OZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Zqo1pp/GoU5JTKojXOPpcOWaqRtN3GldCyCeuOFjJkTwMwZFDk8c4X9iqGiWWkzNpw
         +KKxg4uwNfqCnpJ+BBrNC5BV6+fMEbmiDy+wtV0Dg6tFslLKiDDPk1XLrt7ITLVkA4Fr
         nbRHxZJE7dh+sI1hlDgeKUQltNO2wN3URuWYs=
Received: by 10.100.93.17 with SMTP id q17mr6950549anb.16.1287129803838;
        Fri, 15 Oct 2010 01:03:23 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u3sm15671065ani.39.2010.10.15.01.03.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 01:03:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101015061821.GE21830@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159103>

Jonathan Nieder wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>> ok 6 - mailmap.file non-existant
>> not ok - 7 name entry after email entry
>> not ok - 8 name entry after email entry, case-insensitive
>> ok 9 - No mailmap files, but configured
>> ok 10 - Shortlog output (complex mapping)
>> ok 11 - Log output (complex mapping)
>> not ok - 12 Blame output (complex mapping)
>> # failed 3 among 12 test(s)
>
> Odd.  I can reproduce test 12 failing with commit ids changed
> (embarrassed I didn't notice before) but the others pass here.
> Trying a --valgrind run.

Well, this is embarrasing.  Here's a minimal fix for the test #12
failure (for squashing --- it just undoes a change that should never
have escaped the lab in the first place).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index f4f82c0..3c5188f 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -11,7 +11,6 @@ test_expect_success setup '
 	git commit -m initial &&
 	echo two >>one &&
 	git add one &&
-	test_tick &&
 	git commit --author "nick1 <bugs@company.xx>" -m second
 '
=20
--=20
