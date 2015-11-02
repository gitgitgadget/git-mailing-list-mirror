From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/5] Add watchman support to reduce index refresh cost
Date: Mon, 02 Nov 2015 16:19:34 -0500
Organization: Twitter
Message-ID: <1446499174.4131.20.camel@twopensource.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
	 <1446386146-10438-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 22:19:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtMW1-0004rE-LQ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 22:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbbKBVTl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 16:19:41 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35853 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbbKBVTh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 16:19:37 -0500
Received: by qkcl124 with SMTP id l124so60294476qkc.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 13:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=UjUH4kJPNyViLgmsInI6K950kI2GRNVZ9nG/ULkijlQ=;
        b=bGE8LsMSW72iXciTp1JYmaQWprvYTfRthlkziwZdoyPgcUGXtqM7LeFht8M/Bcr+3D
         op149+t6aYUTbRfCvGMK1TPb8EVY5IS2wJsIHQqIMrBZ0aTs/0VbV/sFmy8KlRw8XkZg
         lKkHFUDRwI0Z4rroWKDXLxaU5dSvPRBwKoW4bPH4BB1iZaTraezauYmCAcl08+9oEnbc
         XobMaiEChyybAWr77ChZzlYrjydkVQaqEG74QHvkIpUdrTQklRHLCPiFLXCKO2k+7BiY
         wqFivBFRQ14U3H0Kqzk8BZXy8Z37G0cpfINpZi6zvRtf6RGmqapUz3zsa1DqQGq8Z5bR
         OkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=UjUH4kJPNyViLgmsInI6K950kI2GRNVZ9nG/ULkijlQ=;
        b=Iz7ah+Km80sDW4uJe6IjXQWhsHOlJSrfQUNbhUofiXQRLPCxOSZ5kjEawY2M6tCZjN
         IjhS4NitktLbX6YO+OKtF2nzBJ9bTTyJPhqrYDzXAnH/TUYYaiK+wgyu4y+M6hAdUMtm
         DGFljpZmT2GdKPJGa1CbLB/QmmchLNOT9qAu5vEpTkNZyoKposudmhhNyMlBO58eNJY6
         RorNpFm8ZoEZ6U1lUPIESwl0g4nUU4fw4E4R7eNGC3H1vsWzwZPvi2H3mqLrHSvZeSIu
         2XTg5roLKEw7GNc0bu02Xj8s42KLxMXgLQ7N3bcv6egF+OMjUskZzww6n4j9N84cHsom
         M2EQ==
X-Gm-Message-State: ALoCoQnvIl3fvlo+TQIN70KOVSzWUxsT8bvug0zJuaHuUdzN4FaXkd38pKfA4u3SFF4RBtoZ8mcl
X-Received: by 10.55.79.86 with SMTP id d83mr32556750qkb.87.1446499176781;
        Mon, 02 Nov 2015 13:19:36 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v63sm8626112qkl.2.2015.11.02.13.19.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 13:19:35 -0800 (PST)
In-Reply-To: <1446386146-10438-3-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280722>

On Sun, 2015-11-01 at 14:55 +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
> The previous patch has the logic to clear bits in 'WAMA' bitmap. This
> patch has logic to set bits as told by watchman. The missing bit,
> _using_ these bits, are not here yet.
>=20
> A lot of this code is written by David Turner originally, mostly from
> [1]. I'm just copying and polishing it a bit.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/248006

Our code has evolved somewhat from there[1].  It looks like you've
incorporated some of these updates.  But I wanted to call out one thing
in particular that it doesn't look like this patch handles: there's som=
e
real ugliness on at least OSX around case-changing renames.=20

You probably won't be able to use our code directly as-is, but we'll
want to do something about this situation.  This is thicket of TOCTOU
issues.  For instance, watchman learns that a file called FOO has
changed, but by the time it goes to the filesystem to look up the
canonical case, FOO has been renamed to foo already (or renamed and the=
n
deleted). =20

I won't say for sure that your code is insufficient as I haven't yet
tried it out, but we should ensure this case is handled before this is
merged.

[1] https://github.com/dturner-tw/git/tree/dturner/watchman

> +
> +		pos =3D index_name_pos(istate, wm->name, strlen(wm->name));

This is the bit where case matters.
