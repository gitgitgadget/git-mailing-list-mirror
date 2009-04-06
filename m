From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 6 Apr 2009 13:10:57 +1000
Message-ID: <fcaeb9bf0904052010p34e3246bwd7e1f5297acf37e2@mail.gmail.com>
References: <20090404220743.GA869@curie-int> <20090405195714.GA4716@coredump.intra.peff.net> 
	<20090405T230552Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 05:16:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqfJa-0001UU-RL
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 05:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbZDFDLP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 23:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbZDFDLP
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 23:11:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:60962 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbZDFDLO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 23:11:14 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1995698rvb.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 20:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FcDIsjgiKBB4V3KAwafhVaeIcz+45QHCgEQDoX3uyt0=;
        b=eLN0YyjruuH/zWUB3Qcs8U2ukV5xC4+eXrB4vbfZEkXcL6Ak4JKGAVBo3UTnX9RhZi
         4jRD8FNWy1a0DFGu80JZ4Sqz0jJqoWsQ8TqzA8ZMLAebZ+s0OXsXq1dKPFZsZkfhdx+T
         T/XKcnQt8RKMwyCGp0GLQJtGpEnZ+CFfGo9BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Bg1I0PVkEjzGAS/oIkZyRsUNfOxAhiPRIIfHkEnWGSi8r0cZnN32xbLWNIr9ncYxoY
         JYKA9d2+TRPchs64Z8jGxNnN5yIoiGBoi2X413zLf/yURH12wBevjwi1/EGnI8yF1b2i
         n3zanwq1+sY/hwGN7DOhGyOrB6H7UMgJ1vOzQ=
In-Reply-To: <20090405T230552Z@curie.orbis-terrarum.net>
Received: by 10.142.68.5 with SMTP id q5mr1152948wfa.12.1238987472819; Sun, 05 
	Apr 2009 20:11:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115755>

On Mon, Apr 6, 2009 at 9:38 AM, Robin H. Johnson <robbat2@gentoo.org> w=
rote:
> Looking at the source, I agree that it should be buffering, however t=
op and ps
> seem to disagree. 3GiB VSZ and 2.5GiB RSS here now.
>
> %CPU %MEM =C2=A0 =C2=A0 VSZ =C2=A0 =C2=A0 RSS STAT START =C2=A0 TIME =
COMMAND
> =C2=A00.0 =C2=A00.0 =C2=A0140932 =C2=A0 =C2=A01040 Ss =C2=A0 16:09 =C2=
=A0 0:00 \_ git-upload-pack /code/gentoo/gentoo-git/gentoo-x86.git
> 32.2 =C2=A00.0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 Z =C2=A0=
 =C2=A016:09 =C2=A0 1:50 =C2=A0 =C2=A0 \_ [git-upload-pack] <defunct>
> 80.8 44.2 3018484 2545700 Sl =C2=A0 16:09 =C2=A0 4:36 =C2=A0 =C2=A0 \=
_ git pack-objects --stdout --progress --delta-base-offset
>
> Also, I did another trace, using some other hardware, in a LAN settin=
g, and
> noticed that git-upload-pack/pack-objects only seems to start output =
to the
> network after it reaches 100% in 'remote: Compressing objects:'.
>
> Relatedly, throwing more RAM (6GiB total, vs. the previous 2GiB) at t=
he server
> in this case cut the 200 wallclock minutes before any sending too pla=
ce down to
> 5 minutes.

Searching back the archive, there was memory fragmentation issue with
gcc repo. I wonder if it happens again. Maybe you should try Google
allocator. BTW, did you try to turn off THREADED_DELTA_SEARCH?
--=20
Duy
