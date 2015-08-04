From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git_open_noatime: return with errno=0 on success
Date: Tue, 04 Aug 2015 14:03:15 -0700
Message-ID: <xmqqfv3y6a24.fsf@gitster.dls.corp.google.com>
References: <20150708123820.GA25269@musxeris015.imu.intel.com>
	<CAPig+cSacM_JwZzagOVZpMJF=oE7m3rMnq1eKr=aNsGY0vvmfQ@mail.gmail.com>
	<20150804082429.GA22271@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin =?utf-8?Q?Schr=C3=B6der?= <martin.h.schroeder@intel.com>
To: Clemens Buchacher <clemens.buchacher@intel.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:03:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMjMp-00008o-AH
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 23:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbbHDVDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 17:03:19 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34459 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbHDVDS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 17:03:18 -0400
Received: by pawu10 with SMTP id u10so17124905paw.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 14:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yAsmnkeklc3K/ewxPFZvKEroWQUmEUq5tbXY8kXGhSg=;
        b=j+wk4dQH8KNWNCaSr7HDt1zvSObfS8XMeQcFXEX0zlxSLd4B0GM8KXEWZo5lB2FWcI
         aUBCh3SMzhMDMK/47CfAA26fWBtcuKc335gjLhtC+3LQFPoWYzLwb8v13E8y7+TC2b35
         l0ZfOTp1r7yten7SNesTpDOTuG3lVUw+edrvc6hb9CkB2iE9CZ9d+AMc0hvK6znxpsa0
         azBiwmuc25oczs0RT0SEPoGUxzLLclcYhf0SmaTxo7/My8HfN9WJ+KaMbJ/9e+y3edL3
         kEyP5E2yABjAzbHBGBIpiwg/UE0ATgdYP5Q0NtaX9yL0FsV/E+GymIRwedsqfNrNLS6i
         a0fA==
X-Received: by 10.68.224.162 with SMTP id rd2mr11843600pbc.33.1438722197802;
        Tue, 04 Aug 2015 14:03:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8df6:f08:8b8d:96a6])
        by smtp.gmail.com with ESMTPSA id m2sm345570pdp.4.2015.08.04.14.03.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Aug 2015 14:03:16 -0700 (PDT)
In-Reply-To: <20150804082429.GA22271@musxeris015.imu.intel.com> (Clemens
	Buchacher's message of "Tue, 4 Aug 2015 10:24:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275334>

Clemens Buchacher <clemens.buchacher@intel.com> writes:

> diff --git a/sha1_file.c b/sha1_file.c
> index 77cd81d..62b7ad6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1453,6 +1453,7 @@ int git_open_noatime(const char *name)
>  	static int sha1_file_open_flag = O_NOATIME;
>  
>  	for (;;) {
> +		errno = 0;
>  		int fd = open(name, O_RDONLY | sha1_file_open_flag);

Please avoid decl-after-stmt, which this codebase does not accept.

>  		if (fd >= 0)
>  			return fd;

More importantly, is this the right place to clear errno?

I would agree it is a good idea to clear it after seeing the first
open fail due to lack of O_NOATIME before trying open for the second
time, iow, more like this?


 sha1_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sha1_file.c b/sha1_file.c
index 1cee438..bf2f229 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1467,6 +1467,7 @@ int git_open_noatime(const char *name)
 
 		/* Might the failure be due to O_NOATIME? */
 		if (errno != ENOENT && sha1_file_open_flag) {
+			errno = 0;
 			sha1_file_open_flag = 0;
 			continue;
 		}
