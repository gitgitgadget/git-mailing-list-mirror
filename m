From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Mon, 11 Jul 2011 09:58:28 -0700
Message-ID: <CAJo=hJvv7a_8FJfHERxdwvMLVkpun-u-hR+ds40JuVNn2Lyb7A@mail.gmail.com>
References: <20110711161332.GA10057@sigill.intra.peff.net> <20110711161754.GB10418@sigill.intra.peff.net>
 <20110711164635.GB29781@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 11 18:58:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgJot-0001tx-PD
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 18:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205Ab1GKQ6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jul 2011 12:58:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49744 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758096Ab1GKQ6u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2011 12:58:50 -0400
Received: by bwd5 with SMTP id 5so3400432bwd.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 09:58:48 -0700 (PDT)
Received: by 10.204.9.203 with SMTP id m11mr2800132bkm.56.1310403528529; Mon,
 11 Jul 2011 09:58:48 -0700 (PDT)
Received: by 10.204.165.130 with HTTP; Mon, 11 Jul 2011 09:58:28 -0700 (PDT)
In-Reply-To: <20110711164635.GB29781@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176872>

On Mon, Jul 11, 2011 at 09:46, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 11, 2011 at 12:17:54PM -0400, Jeff King wrote:
>
>> +Storage
>> +-------
>> [...]
>> +The disk storage consists of a single file per cache, located in th=
e
>> +`$GIT_DIR/cache` directory. Each file contains a list of rows order=
ed by
>> +sha1. Each row contains a binary sha1, followed by the fixed-size d=
ata
>> +mapped to that sha1.
>
> There's nothing else in the file, not even a header. I should probabl=
y
> add at least a version byte, in case we ever do want to change what g=
oes
> into a cache (in which case we could just blow away what's there and
> regenerate).

Please do. We don't always need to invent a new version... but for a
cache file its probably more common than the PACK network stream, or
the pack-*.idx file. And its painful to shoehorn in a version change
after the fact.

> We could also have a "validity" field that must match for the cache t=
o
> be valid. Junio mentioned earlier that you would want to regenerate a
> generations cache whenever grafts or replace objects changed. It
> wouldn't be hard to do something like:
>
> =A0validity =3D sha1(grafts + replace);
> =A0if (validity !=3D cache_validity)
> =A0 =A0empty_disk_cache();
>
> And then it would just automatically work, without the user having to
> remember to clear the cache. =A0Calculating the validity would be che=
ap in
> the common case (you have no grafts or replace objects), and not much
> more expensive when you do have them (we have to read that data anywa=
y
> to respect the replacements).

This is a pretty good idea too. Saves the hapless user from surprises
when they forget the cache exists, but they changed grafts or replace
data.

--=20
Shawn.
