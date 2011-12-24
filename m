From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Sat, 24 Dec 2011 17:49:42 +0700
Message-ID: <CACsJy8C1o_Ryf0QDJXz8xEqFYxprWx01AeNT4CC=3DwbAT1JFg@mail.gmail.com>
References: <cover.1322830368.git.trast@student.ethz.ch> <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
 <CACBZZX6hboo4wu3fOs+CHnxsdmedxw72GFMVttQzmHzpcZbqoQ@mail.gmail.com>
 <87mxaihpiq.fsf@thomas.inf.ethz.ch> <CACBZZX67WhcdhXdqOm8gZHW7C3YMbV2KzeytwjHwsnF=8-M_+w@mail.gmail.com>
 <20111224070715.GA32267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Eric Herman <eric@freesa.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 24 11:50:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RePBX-0006xl-PM
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 11:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774Ab1LXKuR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Dec 2011 05:50:17 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46998 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab1LXKuP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2011 05:50:15 -0500
Received: by eaad14 with SMTP id d14so3285232eaa.19
        for <git@vger.kernel.org>; Sat, 24 Dec 2011 02:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gD/hTXSws+vOHktXYLr+GU8GCjoB5Rs71I3jAvBYAbg=;
        b=WSEQK96HvXB7ycC4EPHEmp35VNw/uELLw3ZTXSlfxvFqEM0NMUNAplcU2cKfXBuJdl
         TzfZzPECAPejHODRamGvUEyp7vMvEXgWgKhF0om7x17Wf/Bp4UUZJ7vFOjpPAlN/B18j
         sv6uqwjFTPtz92hP9FQrgAq1bbNzvEC3qjKiQ=
Received: by 10.204.9.218 with SMTP id m26mr4941522bkm.44.1324723813187; Sat,
 24 Dec 2011 02:50:13 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Sat, 24 Dec 2011 02:49:42 -0800 (PST)
In-Reply-To: <20111224070715.GA32267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187657>

On Sat, Dec 24, 2011 at 2:07 PM, Jeff King <peff@peff.net> wrote:
> I tried to get some timings for this, but ran across some quite
> surprising results. Here's a simple grep of the linux-2.6 working tre=
e,
> using a single-threaded grep:
>
> =C2=A0$ time git grep SIMPLE >/dev/null
> =C2=A0real =C2=A0 =C2=A00m0.439s
> =C2=A0user =C2=A0 =C2=A00m0.272s
> =C2=A0sys =C2=A0 =C2=A0 0m0.160s
>
> and then the same thing, via xargs, without even turning on
> parallelization. This should give us a measurement of the overhead fo=
r
> going through xargs at all. We'd expect it to be slower, but not too
> much so:
>
> =C2=A0$ time git ls-files | xargs git grep SIMPLE -- >/dev/null
> =C2=A0real =C2=A0 =C2=A00m11.989s
> =C2=A0user =C2=A0 =C2=A00m11.769s
> =C2=A0sys =C2=A0 =C2=A0 0m0.268s
>
> Twenty-five times slower! Running 'perf' reports the culprit as paths=
pec
> matching:
>
> =C2=A0+ =C2=A063.23% =C2=A0 =C2=A0git =C2=A0git =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [.] match_pathspec_depth
> =C2=A0+ =C2=A028.60% =C2=A0 =C2=A0git =C2=A0libc-2.13.so =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[.] __strncmp_sse42
> =C2=A0+ =C2=A0 2.22% =C2=A0 =C2=A0git =C2=A0git =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [.] strncmp@plt
> =C2=A0+ =C2=A0 1.67% =C2=A0 =C2=A0git =C2=A0git =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [.] kwsexec
>
> where the strncmps are called as part of match_pathspec_depth. So ove=
r
> 90% of the CPU time is spent on matching the pathspecs, compared to l=
ess
> than 2% actually grepping.
>
> Which really makes me wonder if our pathspec matching could stand to =
be
> faster. True, giving a bunch of single files is the least efficient w=
ay
> to use pathspecs, but that's pretty amazingly slow.

We could eliminate get_pathspec_depth() in grep_directory() when
read_directory() learns to filter path properly using (and at the cost
of) tree_entry_interesting(). The latter function has more
optimizaions built in and should be faster than the former. This is a
good test case for my read_directory() rewrite. Thanks.

get_pathspec_depth() can still use some optimizations though for
grep_cache() case.
--=20
Duy
