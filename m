From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/4] implement submodule config API for lookup of .gitmodules values
Date: Mon, 13 Jul 2015 08:49:33 -0700
Message-ID: <xmqqa8v012ia.fsf@gitster.dls.corp.google.com>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
	<ef740bdea9af35564c75efd2a6daae65f3108df5.1434400625.git.hvoigt@hvoigt.net>
	<CABURp0pyYcKvmbEeDSYqm15DtXvH7g_UXASR3utGco+=D95bOA@mail.gmail.com>
	<20150709120900.GA24040@book.hvoigt.net>
	<20150709154903.GA14320@peff.net> <559ECE6A.2070802@web.de>
	<xmqqoajlumnp.fsf@gitster.dls.corp.google.com>
	<20150713111725.GB27160@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>,
	Karsten Blees <karsten.blees@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jul 13 17:49:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEfzB-0005Ej-I8
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 17:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbbGMPth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 11:49:37 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33889 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbGMPtg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 11:49:36 -0400
Received: by iebmu5 with SMTP id mu5so237157996ieb.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/TWdXiYP9YFv4M5FaVP7gWhJOy2a0cVfsLBhBmQpKuM=;
        b=SlVPBDC1eHYCEEZRXu4sAAKPPrGPINLD+fNCyRIo1VWanffqijiP4YOI7Jy//EW/Nu
         tPm8bVvaKXvAbBNEf3N+hfSmUeekdcUMr4wuReFmOZ7RJ5yIrmh+hQBCoNJx7gdNiRSj
         H89M873hI8F8jX1LJ31jBn/2CoWIoDY/r8qiyt7e/M5GNelPTQ54fPxyTFGObNflgQq7
         TLRB2QMrYpR2M34uHY+ZPem096wAD7GovWUivO8/EoM80fcuum3xhxEZfooyJh0saLKV
         bhNN7hMRpwGKDuxWvI+E796m805dbnCR2GpDo52FFvDUG6cmK09feGKUGPOzNVgAtklg
         tvlQ==
X-Received: by 10.50.7.68 with SMTP id h4mr13845149iga.40.1436802575761;
        Mon, 13 Jul 2015 08:49:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4d10:ec6a:e89:91cb])
        by smtp.gmail.com with ESMTPSA id 191sm9042745iof.18.2015.07.13.08.49.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Jul 2015 08:49:34 -0700 (PDT)
In-Reply-To: <20150713111725.GB27160@book.hvoigt.net> (Heiko Voigt's message
	of "Mon, 13 Jul 2015 13:17:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273919>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Thu, Jul 09, 2015 at 01:00:10PM -0700, Junio C Hamano wrote:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> 
>> > The git-submodule script doesn't need this and is fine using plain old
>> > "git config", as by the time it is run the .gitmodules file is already
>> > updated in the work tree. Heiko's series is about adding infrastructure
>> > to allow builtins like checkout and friends to access the configuration
>> > values from the .gitmodules file of the to-be-checked-out commit when
>> > run with "--recurse-submodules". And yes, if we want to expose this
>> > functionality to users or scripts some day "git config" looks like the
>> > best place to do that to me too.
>> 
>> Did you mean "git submodule config"?
>
> I think he actually meant "git config" and that is already implemented.
> When I implemented the infrastructure to read configurations from blobs,
> Peff extended it so it will be exposed via the config command line. E.g.
> you can do:
>
> 	git config --blob HEAD^^^:.gitmodules <value>
>
> to get .gitmodules configurations from the history, so that is already
> implemented.  And for reading .gitmodules values we probably do not need
> more,...

Ah, I see.  Thanks.
