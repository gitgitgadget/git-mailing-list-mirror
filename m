From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] attr.c: fix matching "subdir" without the trailing slash
Date: Mon, 25 Mar 2013 14:20:31 +0700
Message-ID: <CACsJy8CNjKP1y925mb8_t_hs0QCZwaY6mYTe6EMvbJk2pPifew@mail.gmail.com>
References: <20130319175756.GA13760@sigill.intra.peff.net> <1364191510-8900-1-git-send-email-pclouds@gmail.com>
 <1364191510-8900-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, avila.jn@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 08:21:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK1iw-0005dX-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 08:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784Ab3CYHVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 03:21:03 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51286 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab3CYHVB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Mar 2013 03:21:01 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so6123758oag.33
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 00:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=tnz2aFETsIY22dMgZP33K80CJ5oDxd72tY56D1NO0lQ=;
        b=rRaitxcdcnSPZ4CtgEIF6CMAtwjA3aa+Scj7iyoHnW8Bk7DFo0zf8mJNx/r22u3Sp6
         AKIOgV6f7fyVX/XsmkMIvypHaqa1dJ4QPRkJLpFNIqvFIEz8PGrZPMt8to3Xu8n4dIEy
         b5yUbUDO9IHsM55iXSBAnG2eVilc3TPf7Oapegd3n0AYW0DRhRK/mb6wbGGQKZ8AquSj
         i7qY7l5XxmnuVufqWihVTiRB4hwv/abS0p/IlynOZ1KC5fYiiOlZTkSRNVWI47WypR4p
         LUE8cY9M3VQw0rbr+PhgHs2M1FHoFf5TZcUPSS/P7VpPcNy2zh8iRKLMvPy9GRBAq/yZ
         J7Wg==
X-Received: by 10.60.125.1 with SMTP id mm1mr9771293oeb.52.1364196061196; Mon,
 25 Mar 2013 00:21:01 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Mon, 25 Mar 2013 00:20:31 -0700 (PDT)
In-Reply-To: <1364191510-8900-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219014>

On Mon, Mar 25, 2013 at 1:05 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> The story goes back to 94bc671 (Add directory pattern matching to
> attributes - 2012-12-08). Before this commit, directories are passed
> to path_matches without the trailing slash. This is fine for matching
> pattern "subdir" with "foo/subdir".
>
> Patterns like "subdir/" (i.e. match _directory_ subdir) won't work
> though. So paths are now passed to path_matches with the trailing
> slash (i.e. "subdir/"). The trailing slash is used as the directory
> indicator (similar to dtype in exclude case). This makes pattern
> "subdir/" match directory "subdir/". Pattern "subdir" no longer match
> subdir, which is now "subdir/".
>
> As the trailing slash in pathname is the directory indicator, we do
> not need to keep it in the pathname for matching. The trailing slash
> should be turned to dtype "DT_DIR" and stripped out of pathname. This
> keeps the code pattern similar to exclude.

On second thought, maybe we should not pass path "subdir/" at all.
Instead we create a fake dtype based on the trailing slash and pass it
down to attr.c:fill() -> path_matches(), just like how
last_exclude_matching_from_list() is called.
--=20
Duy
