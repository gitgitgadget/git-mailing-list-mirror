From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [POC PATCH 5/5] sha1_file: make the pack machinery thread-safe
Date: Mon, 9 Apr 2012 21:43:56 +0700
Message-ID: <CACsJy8AyphUD-vFwwgaW0eWG3ekgHA+tcAwV2zk5YGorkW0TzQ@mail.gmail.com>
References: <cover.1323419666.git.trast@student.ethz.ch> <dd2bf650b382f5aca727b7d93a48598fb1a2f7d9.1323419666.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 09 16:44:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHFpi-0005ni-8q
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 16:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757258Ab2DIOo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Apr 2012 10:44:29 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62190 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756461Ab2DIOo1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2012 10:44:27 -0400
Received: by wejx9 with SMTP id x9so2666050wej.19
        for <git@vger.kernel.org>; Mon, 09 Apr 2012 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Du7JcujRgs1JNHyOixlGLEOS7G/YWs1MwzSTXdxMZus=;
        b=QmbVIiCeOrF/P9etpgyLGIUNH5o51oZMR3pdBG3EtIrHIRjw7TfuJ/toJ16TmzZCYt
         mhx8s43o7n2BQJup6m7iw/PS5VQf7aRkvBCAd/3Lx821Idy0DSzXksisc2tIXfS1u0tG
         EGFQQMVGX98H7WHR91I2Egvbw/VdcUf0q8YsOSOxbvR8Yj5NRhQ3BnhPttoHSh9uVuiq
         tf6fNC6++Dbf07gIP4vflmp3MKQvfkPLU1TjlhVzZaOT2ScAqix84qGwnYID2csMh5jp
         mn5KRQnWK3cBuqoYNNwh2iULbCP4KVCu16MqRychYDZ+Eo+ol5kGZ8+V6y2OZvPHqMY2
         i+Jw==
Received: by 10.216.135.20 with SMTP id t20mr3846945wei.99.1333982666552; Mon,
 09 Apr 2012 07:44:26 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Mon, 9 Apr 2012 07:43:56 -0700 (PDT)
In-Reply-To: <dd2bf650b382f5aca727b7d93a48598fb1a2f7d9.1323419666.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195017>

On Fri, Dec 9, 2011 at 3:39 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> More precisely speaking, this pushes the locking down from
> read_object() into bits of the pack machinery that cannot (yet) run i=
n
> parallel.
>
> There are several hacks here:
>
> a) prepare_packed_git() must be called before any parallel accesses
> =C2=A0 happen. =C2=A0It now unconditionally opens and maps all index =
files.
>
> b) similarly, prepare_replace_object() must be called before any
> =C2=A0 parallel read_sha1_file() happens
>
> This simplification lets us avoid locking outright to guard the index
> accesses; locking is then mainly required for open_packed_git(),
> [un]use_pack(), and such.
>
> The ultimate goal would of course be to let at least _some_ pack
> accesses happen without any locking whatsoever. =C2=A0But grep alread=
y
> benefits from it with a nice speed boost on non-worktree greps.

(I'm running into multithread pack access problem in rev-list..)

Why not put the global pointer "struct packed_git *packed_git" to
"struct pack_context" and avoid locking entirely? Resource usage is
like we run <n> different processes, I think, which is not too bad. We
may want to share a few static pack_* variables such as
pack_open_fds.. to avoid hitting system limits too fast.
--=20
Duy
