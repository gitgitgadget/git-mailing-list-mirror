From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] utf8.c: print warning about disabled iconv
Date: Mon, 08 Jun 2015 09:16:16 -0700
Message-ID: <xmqqfv62ch0v.fsf@gitster.dls.corp.google.com>
References: <1433624551-20730-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:16:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ziq-00007M-Bo
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbbFHQQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:16:21 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34994 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbbFHQQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:16:19 -0400
Received: by igbzc4 with SMTP id zc4so65638758igb.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ag8JPo5oZVmQEvE4x/9pTEA10txGaktLV4b00SGomFA=;
        b=IRooD2w5so64tVzpqHPv1+4iMS1BxtlHO0IDofcF+xK245iYa5UPU8bsi9vsHYMV2a
         bmoEeXENOnozesKfvgAWZ6HF8uYY27eNhWySuh6DDqvjFUvG9iVVH1EVYg9h2+aXN+Ie
         JPitIyimE+jNPWpM9dyei9DReAv+jM8i3bV7ECvuazQnqj9lc41h9fIMIXhQ7vfShldK
         D3E3QgrzLlVbiuD5NRq/WT1AlT24PRM2/pEfdftKYFk+lDpcjS7CRNipGupQ2gbA+IWH
         l5xG8osw2BWf0ZKmAGQg0lLw7vLyDldWj7Lx9HvEuRsaad/qqoLYstp1rOLfVIlfy+wf
         gDqw==
X-Received: by 10.50.20.200 with SMTP id p8mr14444076ige.28.1433780178643;
        Mon, 08 Jun 2015 09:16:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d91a:edb1:b738:fb03])
        by mx.google.com with ESMTPSA id d81sm2010868ioe.12.2015.06.08.09.16.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 09:16:17 -0700 (PDT)
In-Reply-To: <1433624551-20730-1-git-send-email-max@max630.net> (Max
	Kirillov's message of "Sun, 7 Jun 2015 00:02:31 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271064>

Max Kirillov <max@max630.net> writes:

> It is an allowed compile-time option to build git without iconv
> support. Resulting build almost always functions correctly, and
> never displays that it is missing anything, but reencode_string_len()
> just never modifies its input.

Correct.

> This gives undesirable result that
> returned data or even data written into repository is incorrect
> and user is not aware about it.

I do not necessarily agree with that.  The user knows what s/he is
doing, data written to or shown from the repository is correct as
far as the user is concerned, and the user takes the full
respoinsibility when compiling out certain features.

> +	if (!same_encoding(in_encoding, out_encoding) && !noiconv_warning_shown) {
> +		warning("Iconv support is disabled at compile time. It is likely that\nincorrect data will be printed or stored in repository.\nConsider using other build for this task.");
> +		noiconv_warning_shown = 1;
> +	}

I actually am OK if the user gets exactly the same warning between
the two cases:

 - iconv failed to convert in the real reencode_string_len()

 - we compiled out iconv() and real conversion was asked.

and this patch is about the latter; I do not think it is reasonable
to give noise only for the latter but not for the former.  The
latter is expected by users who compile out the feature, but the
former is not and deserves the wranings more, so the patch is
backwards in that sense.

Thanks.
