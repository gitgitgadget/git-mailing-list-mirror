From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] sha1_file: do not add own object directory as alternate
Date: Tue, 15 Jul 2014 15:33:46 -0400
Message-ID: <CAPig+cQDbU6Qii4we-8oPdSeXiqhBWmjJ+VwTwBivnAOxBzS_A@mail.gmail.com>
References: <53BFB055.206@gmail.com>
	<xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>
	<53C26309.5040401@gmail.com>
	<53C39CB0.6040909@gmail.com>
	<CACsJy8B-QFu4SU6HHZukAmmjLrgb+L8KsHPn3GgQhcX6-LGXLg@mail.gmail.com>
	<53C3D2AD.9050204@gmail.com>
	<53C4BFC7.2000507@kdbg.org>
	<53C510A9.4010208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ephrim Khong <dr.khong@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 21:33:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X78U7-0002H7-Gg
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 21:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933416AbaGOTdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 15:33:50 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:56877 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933264AbaGOTdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 15:33:47 -0400
Received: by mail-yh0-f51.google.com with SMTP id f73so2623701yha.10
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kFEuRrI2AYRW9nlyK5sqxsIKnJwu0hPgaY7oe3NYBsY=;
        b=AyRBrAA4b5k/2/SD/xHjhCOP/Bt5h55y/HnUEf+FiJu42gvsOeKhd4r1ZVYw34JZqd
         BPDdrq0C8PA4xNKdiCeOaCeIbTHFb4dB/+MKLGT9u9xTl1PYtUgTBbA9fqqIbG/466NJ
         l6mslvGS/Mt/VLg1WVqfNwO7unH4S9SVoaaN3jhLUOIHJzxPShmcQzpbLU9fw+ehOjjN
         W8cQjURU16aaDuD7GTqBJL+wSSgdhMtBBiIhxZ4fhx0eCwvz7WkVwrkcXkfb8ru0UxlR
         AW82uiqVGtpWFGAj9MATKZABLV1EhatrOMDvT6MZi9T8nRDSGmYWCDNrOOd4f88hGHs/
         4hbw==
X-Received: by 10.236.137.242 with SMTP id y78mr7400342yhi.152.1405452826738;
 Tue, 15 Jul 2014 12:33:46 -0700 (PDT)
Received: by 10.170.115.148 with HTTP; Tue, 15 Jul 2014 12:33:46 -0700 (PDT)
In-Reply-To: <53C510A9.4010208@gmail.com>
X-Google-Sender-Auth: uSRvbFvAcLMMiFaC0TaHFot5M2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253591>

On Tue, Jul 15, 2014 at 7:29 AM, Ephrim Khong <dr.khong@gmail.com> wrote:
> When adding alternate object directories, we try not to add the
> directory of the current repository to avoid cycles.  Unfortunately,
> that test was broken, since it compared an absolute with a relative
> path.
>
> Signed-off-by: Ephrim Khong <dr.khong@gmail.com>
> ---
> diff --git a/t/t7702-repack-cyclic-alternate.sh b/t/t7702-repack-cyclic-alternate.sh
> new file mode 100755
> index 0000000..8341d46
> --- /dev/null
> +++ b/t/t7702-repack-cyclic-alternate.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Ephrim Khong
> +#
> +
> +test_description='repack involving cyclic alternate'
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +       GIT_OBJECT_DIRECTORY=.git//../.git/objects &&
> +       export GIT_OBJECT_DIRECTORY &&
> +       touch a &&

Since the existence of 'a' is significant here, not its timestamp, it
would be clearer to create the file with:

    >a &&

> +       git add a &&
> +       git commit -m 1 &&
> +       git repack -adl &&
> +       echo "$(pwd)"/.git/objects/../objects >.git/objects/info/alternates
> +'
> +
> +test_expect_success 're-packing repository with itsself as alternate' '
> +       git repack -adl &&
> +       git fsck
> +'
> +
> +test_done
> --
> 1.8.4.3
