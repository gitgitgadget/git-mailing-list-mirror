From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] pretty: Fix bug in truncation support for %>, %< and %><
Date: Mon, 29 Apr 2013 10:55:51 -0700
Message-ID: <20130429175551.GA24467@google.com>
References: <517C2A68.4030802@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 19:56:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWsJ7-0007T2-3C
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758890Ab3D2R4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:56:03 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:62572 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758854Ab3D2Rz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:55:59 -0400
Received: by mail-da0-f43.google.com with SMTP id h21so594356dal.16
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bHwL5Iqsu93WllGJMWY4YnnMO446+JcMX3t1Gw7kyM8=;
        b=l7tz7H+ey1DDK4Relv6ESOTi6ioTr/3EF1Faoe23L4YNWEOeTWySUBEBMQyoAgZM21
         jQcvSFhzduccW9szi7j4g+Uq007ecfSMdLEONMpj72o0KBNVSvcZGHdsu1l2GmZoD691
         57AjLKBD/XpLaTBz3uqinTAzLII/rDXLzItK19uv2JlGvui7uEL89UKWNvIl4IH/HikP
         Jibt7iEfccwZbnHoQRZKEqWiAG1fwy4HbW5ghfUh2oZClKADuBpI2fnIgBdgCr+08JiH
         3pemyPZRjYPTcO5d0BV1XZDlag5u2IEyJSaMZAHepFdUCqFGoRCJqCJtlkm6j5p6PwbL
         2Llg==
X-Received: by 10.66.162.67 with SMTP id xy3mr43169884pab.94.1367258159196;
        Mon, 29 Apr 2013 10:55:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fx2sm26863941pac.4.2013.04.29.10.55.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 10:55:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <517C2A68.4030802@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222829>

Hi,

Ramsay Jones wrote:

> Some systems experience failures in t4205-*.sh (tests 18-20, 27)
> which all relate to the use of truncation with the %< padding
> placeholder. This capability was added in the commit a7f01c6b
> ("pretty: support truncating in %>, %< and %><", 19-04-2013).

This is reproducible when running the test suite for 1.8.3-rc0 on some
Debian test machines (ARM, ia64, powerpc) using gcc 4.6:

  https://buildd.debian.org/status/logs.php?pkg=git&ver=1%3A1.8.3~rc0-1

> The truncation support was implemented with the assistance of a
> new strbuf function (strbuf_utf8_replace). This function contains
> the following code:
>
>        strbuf_attach(sb_src, strbuf_detach(&sb_dst, NULL),
>                      sb_dst.len, sb_dst.alloc);
>
> Unfortunately, this code is subject to unspecified behaviour. In
> particular, the order of evaluation of the argument expressions
> (along with the associated side effects) is not specified by the
> C standard. Note that the second argument expression is a call to
> strbuf_detach() which, as a side effect, sets the 'len' and 'alloc'
> fields of the sb_dst argument to zero.

Makes sense.

[...]
> In order to remove the undesired behaviour, we replace the above
> line of code with:
>
>        strbuf_swap(sb_src, &sb_dst);
>        strbuf_release(&sb_dst);
>
> which achieves the desired effect without provoking unspecified
> behaviour.

Nice cleanup.  I haven't tested the patch but it looks obviously
correct and I assume you've tested it, so for what it's worth,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
