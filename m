From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Sun, 20 Jul 2014 02:29:53 +0200
Message-ID: <53CB0D81.1070404@gmail.com>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com> <53C80265.5030903@web.de> <53C8562C.4000304@gmail.com> <CACsJy8D5X5svApB9edHK+1EaGi+q2ZRSOvyDYaDieVV2psgZPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 02:30:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8f0r-00078T-Ji
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 02:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200AbaGTA36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 20:29:58 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:42919 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbaGTA35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 20:29:57 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so2440127wiv.7
        for <git@vger.kernel.org>; Sat, 19 Jul 2014 17:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=WpKfgnwPvrW6vjOk8b27MOZ49TDO+JE4hPklKpINJO0=;
        b=evMbPvfWN7Tjk5qFm5WCSVQbaIwQT9FZNqxJ9+CtSWBGb/kdjFRd+nb+zoRIG+Sz3a
         H5iiohZ/XGIDSR7j+uofYPOdQLEOh9qHaami/xfAqFBTrMyyuHxVTyscSCLBr2u2gJIw
         wf9EL9XhJTON/ShbY8cpm3IaapjqX0EKJLbDk/OdNG010iGw0NS76H8/4P7ehgYEK55Y
         O/OY1rl/WojB2fGXFQljRdugzR5qu8rlAy3W4HlJAQME1fXMOfj/QzeJbOf//FSJnXo/
         JURGyn9J/uwkQ3hFO6+JA92ktQiDsVgMTq3PS8eT2vKJDKmR5/w3H07J522BB08XmSf4
         l/dA==
X-Received: by 10.194.89.168 with SMTP id bp8mr8921442wjb.73.1405816195858;
        Sat, 19 Jul 2014 17:29:55 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id o2sm23710324wij.24.2014.07.19.17.29.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jul 2014 17:29:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8D5X5svApB9edHK+1EaGi+q2ZRSOvyDYaDieVV2psgZPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253909>

Am 18.07.2014 12:49, schrieb Duy Nguyen:
> can be used, else we fall back to chdir. I think there are only four
> places that follow this pattern, here, setup.c (.git discovery), git.c
> (restore_env) and unix-socket.c. Enough call sites to make it worth
> the effort?
> 

real_path(): here we actually don't want to cd / cd back, we just do
this because getcwd reolves symlinks.

setup.c: AFAICT this sets up the work dir and stays there (no cd back).

git.c: Only does a 'preliminary' repo setup so that the alias mechanism
reads the correct config files. Then it reverts the setup if the
resulting git command doesn't need it. Perhaps it would be better (and
faster) to teach the alias code to read the right config file in the
first place?

unix-socket.c: This looks pretty broken. The cd / cd back logic is only
ever used if the socket path is too long. In this case, after cd'ing to
the parent directory of the socket, unix_stream_listen tries to unlink
the *original* socket path, instead of the remaining socket basename in
sockaddr_un.sun_path. I.e. the subsequent bind() will fail on second
invocation of the credential daemon.
