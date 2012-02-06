From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] On compresing large index
Date: Mon, 6 Feb 2012 08:35:29 +0700
Message-ID: <CACsJy8AnGg11PeCGFs_BxOM3wAjwzs2tOCWJV31_2_KMFTxhDA@mail.gmail.com>
References: <1328430605-4566-1-git-send-email-pclouds@gmail.com> <87ehu9ug9i.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Joshua Redstone <joshua.redstone@fb.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 06 02:36:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuDV3-00018T-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 02:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326Ab2BFBgD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 20:36:03 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44515 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237Ab2BFBgA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 20:36:00 -0500
Received: by wics10 with SMTP id s10so3844232wic.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 17:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ceS3Wdnq9qX+f5gaQ9o97a1Atpq7D68O2KIwSsARH8Y=;
        b=aJAFQnFA7sd+XQ+wZ69s6dZUA3GZjyrWyujAExKmrhJpxYBUoS5IJ2e6/GWutznNqi
         wbMFeHLDFGR4tOP5yQKqjMcnrqAaOHtdL7PZTrNO0J9FZg3WSIBCN+P+C06TmZlVK7Xr
         byTHf2mSN4cHX+da3FmUQZdNv+hLMCjwWwWxA=
Received: by 10.181.13.113 with SMTP id ex17mr24459476wid.15.1328492159203;
 Sun, 05 Feb 2012 17:35:59 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Sun, 5 Feb 2012 17:35:29 -0800 (PST)
In-Reply-To: <87ehu9ug9i.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189996>

2012/2/6 Thomas Rast <trast@inf.ethz.ch>:
>> We need to figure out what git uses 4s user time for.
>
> When I worked on the cache-tree stuff, my observation (based on
> profiling, so I had actual data :-) was that computing SHA1s absolute=
ly
> dominates everything in such operations. =C2=A0It does that when writ=
ing the
> index to write the trailing checksum, and also when loading it to ver=
ify
> that the index is valid.

You're right. This is on another machine but with same index (2M
files), without SHA1 checksum:

$ time ~/w/git/git ls-files --stage|head > /dev/null
real    0m1.533s
user    0m1.228s
sys     0m0.306s

and with SHA-1 checksum:

$ time git ls-files --stage|head > /dev/null
real     0m7.525s
user    0m7.257s
sys     0m0.268s

I guess we could fall back to cheaper digests for such a large index.
Still more than one second for doing nothing but reading index is too
slow to me.

> ls-files shouldn't be so slow though. =C2=A0A quick run with callgrin=
d in a
> linux-2.6.git tells me it spends about 45% of its time on SHA1s and a
> whopping 25% in quote_c_style(). =C2=A0I wonder what's so hard about
> quoting...

That's why I put "| head" there, to cut output processing overhead (hop=
efully).
--=20
Duy
