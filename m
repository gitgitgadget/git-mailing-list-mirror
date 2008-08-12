From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be cached
Date: Tue, 12 Aug 2008 11:41:28 -0400
Message-ID: <48A1AF28.5000400@griep.us>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us> <20080812030809.GA14051@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Aug 12 17:43:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSw17-0003kg-9E
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 17:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbYHLPle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2008 11:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbYHLPld
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 11:41:33 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:16735 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYHLPld (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 11:41:33 -0400
Received: by qw-out-2122.google.com with SMTP id 3so216493qwe.37
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=JDNwxTvfUP4XY8Hl714gfAQ4ncW3iqm6QnKVS97Neeg=;
        b=LTv9vYTk59axdiJLtYKmi0ZKQLHupJsLigmn/XOBuIBRrXgRAIPfbsCW4c3HFhdSTc
         x0j1vLL4cgz+ilsrZkvQH8Fx2IcLQP6hbSuiB0YuoKsrBWytKYrkHWAjFGSGEgrib6Ca
         G/2SA/5TGpMRdvaG7wl4yD0QQoWyrkF7L3QSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=qHrzPudLY6rwHH545ao7r0d/QO4Uf0tkQ7TDoH6he7gCkQjuonxRN14byX6RYg10AD
         cJTWP7SnnWY8PpNBL3B18XHJB/9KTLdFWuEtryt8A2sVlOmMd592b0n1/0/u1KODla2B
         fqPKPZGK+DrLLf0WqfzuAdTKCCfCTjvQXhgQI=
Received: by 10.214.46.9 with SMTP id t9mr6615880qat.34.1218555691808;
        Tue, 12 Aug 2008 08:41:31 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 39sm802891wrl.29.2008.08.12.08.41.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Aug 2008 08:41:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080812030809.GA14051@untitled>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92103>

Eric Wong wrote:
> I'm not sure if the no-lock version is worth the potential for
> buggy or dangerous code.  I like this new idea of locking the
> files to prevent bugs.

I can agree with that, and the "unsafe" version was just a front to the
common function.  I've removed the unsafe version from @EXPORT_OK and
removed temp_unsafe, but _temp_cached is still available for those
that _really_ want the unsafe version.

> Always truncating on release makes the interface simpler.  With locki=
ng,
> we can probably *only* truncate on release if you're that worried abo=
ut
> the extra overhead :)

I agree with this.  I introduced a nice bug on myself when just startin=
g
with it though, which is why I made it optional.  Careful conversion an=
d
testing should be good enough protection.

> I would do a regular seek() here in addition to the sysseek() below. =
I
> am not certain one of the many userspace buffering layers Perl can
> potentially use doesn't do anything funky with its offset accounting.
>=20
> I would also put a tell() here after the sysseek and throw an error i=
f
> it returns a non-zero value just in case.  Yes, I'm really paranoid
> about this stuff and have a huge distrust of userspace I/O layers :)

I went ahead and threw in a sysseek(,,SEEK_CUR) with the tell and added
a seek to the sysseek(,,SEEK_SET), so we should be protected on the
buffered and unbuffered sides.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
