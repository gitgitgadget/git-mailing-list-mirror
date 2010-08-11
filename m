From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] WIP: Report intra-test progress with TAP subtests
Date: Tue, 10 Aug 2010 19:44:25 -0500
Message-ID: <20100811004425.GI2099@burratino>
References: <1281473829-2102-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 02:46:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OizSB-0001qW-17
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 02:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274Ab0HKApz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 20:45:55 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47675 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758041Ab0HKApx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 20:45:53 -0400
Received: by qwh6 with SMTP id 6so8803469qwh.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 17:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BmqyVTLHGhPXOGLjoi3kvD5Evc46KWTdn4mk09JrpDw=;
        b=Q8HeLtCGWF92wzuuiJLRArEkom/EVjJRsZLl4lD6RaPtJ29fVkHPaRFv9EuKi/6U1c
         wKhS+zEKro7icD2ccqD1kXT3/uYwKJcUwUfaEZC5VhkqRnKQ/Jp0RnUKJ+JO45up4E/w
         cJZFQcCKHLMB54QCiQT8ZdqPvjjctvniEibFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dcntT3Dv1ZrLI66pQz17TAvkE1MqWewDiMLg36P9P6iIQMqo6SsnzbygRTKzEYC90W
         Mm07/nWEvLvT6v4Yp2iyMUzjA2/ldfdv5zLWsawuZFtyuTIF4woguuzIPuE3bu+M4CPc
         6VROQ1P/vo99X3AgB8bbkUFCf5ULCb1MhQKJU=
Received: by 10.224.2.147 with SMTP id 19mr10198821qaj.61.1281487552893;
        Tue, 10 Aug 2010 17:45:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id l8sm1255892qck.30.2010.08.10.17.45.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 17:45:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281473829-2102-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153177>

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>    ok 1 - A git test
>        ok 1 - doing test -f file
>        ok 2 - git commit ...
>        ok 3 - test_tick...
>        1..3
>    ok 2 - A git test
>    1..2
>=20
> Here's an attempt at that, I've convented test_commit, test_merge and
> test_cmp to report intra-test progress.

What if a test uses none of those commands?

The ultimate conclusion of such an approach would be to use
replacements for common commands like =E2=80=9Cgit=E2=80=9D and =E2=80=9C=
cd=E2=80=9D, making tests a
lot harder to read and write for the uninitiated.

If we get peeks where the infrastructure has a chance to provide
them, maybe it would be nice to allow explicitly inserting such
checkpoints, too?  Like:

	mv init init2 &&
	checkpoint &&
	git config -f .gitmodules submodule.example.url "$(pwd)/init2" &&
	checkpoint &&
	git config --remove-section submodule.example &&
	checkpoint &&
	[...]

while debugging.

However, I would rather see those inserted automatically.
Two ideas without code to back them up:

1. Script parsing.

Yes, parsing shell command language is hard, but tests use only
a subset of it.  In particular the &&-chaining means it might
be relatively easy to find where each command starts and ends.

The hard bits: =E2=80=9Cif=E2=80=9D, =E2=80=9Cwhile=E2=80=9D, and =E2=80=
=9Cfor=E2=80=9D flow control constructs.

The payoff of even partial progress in this would be very high,
since it should make static analysis of &&-chaining possible.

2. Letting the shell trace for us.

When tests fail, I generally use

	sh -x ./failing-test.sh -v -i

and scroll back through the log to the important part.

Maybe the test harness could automate that a little, by using
set -x at the beginning and set +x at the end of each test.

Hope that helps,
Jonathan
