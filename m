From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum
 member
Date: Mon, 7 Nov 2011 15:32:19 -0600
Message-ID: <20111107213219.GA13537@elie.hsd1.il.comcast.net>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
 <1320581184-4557-4-git-send-email-avarab@gmail.com>
 <20111107194912.GA12469@elie.hsd1.il.comcast.net>
 <7vlirr1vi5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 22:32:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNWnx-0000hm-AJ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 22:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab1KGVc2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 16:32:28 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56395 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab1KGVc1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 16:32:27 -0500
Received: by iage36 with SMTP id e36so6294351iag.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 13:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4fd8J0KYWnO1hYa2GZ5HwVv19xzUrZA2t0ixnwInH7Q=;
        b=VAYLfdTircZT0wUaMdXJ20jRGMAwt1YtWssW0rIGrOLuPPbmrCTnVpgNAgVQ46tn04
         RPsm//uJYnOVfrJZGYJ0oQsyWDWvbAqN8pYu0gcX4GJ6hWqO93fQUcEt/xMkjoEG4pEF
         Xef1rdwYUs0f5QS5aGnfYhvVbMwzc6znqLLsA=
Received: by 10.42.153.74 with SMTP id l10mr49528750icw.52.1320701547081;
        Mon, 07 Nov 2011 13:32:27 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j1sm19269365igq.2.2011.11.07.13.32.25
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 13:32:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vlirr1vi5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185030>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> [jn: drop the GREP_HEADER_FIELD_MAX <=3D p->field check, too,
>>  for symmetry]
>
> Umm, why is this removal of defensive programming practice an improve=
ment?

Checking "p->filed < 0" makes static analyzers complain.  There's no
clean way I know of[*] to get them to shut up and keep the check.  The
fundamental question is whether the -Wtype-limits check is worth it or
not:

 - on one hand, it catches real bugs, such as the mistaken check for
   negative size_t =C3=86var mentioned;

 - on the other hand, it trips for cases like this in which the type
   only happened to be unsigned on the build platform.  I consider
   that a gcc bug (and apparently clang shares it) --- see
   <http://bugs.debian.org/615525>.

So, the purpose of this patch was to work around this common bug in
static analyzers.

Checking "GREP_HEADER_FIELD_MAX <=3D p->field" without checking for
"p->field < 0", like the original patch did, would be only checking
half of what it intends to and not add any real guarantees.  And
more importantly, it would be distracting to people like me and
Andreas who would wonder "why doesn't this check p->field < 0, too?".

I guess the commit message should have said

	grep: remove a defensive check to work around common static analyzer b=
ug

> This part is mostly my code and because I know what I wrote is almost
> always perfect, so I do not think there is any real harm done, but st=
ill...

Heh.

[*] There are plenty of cryptic, hackish ways possible, though. :)

	if ((size_t) p->field >=3D GREP_HEADER_FIELD_MAX)
		die(...);
