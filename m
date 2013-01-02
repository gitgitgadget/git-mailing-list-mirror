From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Makefile dependency from 'configure' to 'GIT-VERSION-FILE'
Date: Tue, 1 Jan 2013 23:21:41 -0800
Message-ID: <20130102072141.GB18974@elie.Belkin>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 08:22:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqIeM-0006aB-Eh
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 08:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297Ab3ABHVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 02:21:48 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:64048 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab3ABHVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 02:21:47 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so7875318pad.39
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 23:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=i8stSylS/yzdl2sQScz/OYhOQVhrcHo+/IrjDMkFhjc=;
        b=rA2vrYeN42SkoM06QSunbPXahXNUFrS9tSLyr5tBmKLa9sJAW6PKhPMJytuNPfT/v+
         t7eWhKDyd5B5ypjEtOmleC+QB2xDU+/GBbSfkmC0ULTxBTZnUuhJaDSHq/L8R0azLddP
         PTvxXL1m/XtaCqrCysOJ5v7ic4tHHGnZbTrfO/TTJY565NVoERmz2nOGHogC44wl8ERU
         XHynjCySfbZq9/QDJFXMDzQSqPLTJGiBxdVVl3d2ZZI78lY+G8b5UJ8QDidGbkpGcsme
         0rpl3QVa5NRUOQFKPkXieqKFV2s4n/S/7wJX7yZxU9kFTSZ34Hq5PsmChGWvsKbVSiJ4
         /GRQ==
X-Received: by 10.66.72.198 with SMTP id f6mr134057237pav.42.1357111307164;
        Tue, 01 Jan 2013 23:21:47 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id l8sm14905957pax.9.2013.01.01.23.21.44
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Jan 2013 23:21:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212497>

Hi Martin,

Martin von Zweigbergk wrote:

> I use autoconf with git.git. I have noticed lately, especially when
> doing things like "git rebase -i --exec make", that ./configure is run
> every time. If I understand correctly, this is because of 8242ff4
> (build: reconfigure automatically if configure.ac changes,
> 2012-07-19).

How about this patch (untested)?

-- >8 --
Subject: build: do not automatically reconfigure unless configure.ac changed

Starting with v1.7.12-rc0~4^2 (build: reconfigure automatically if
configure.ac changes, 2012-07-19), "config.status --recheck" is
automatically run every time the "configure" script changes.  In
particular, that means the configuration procedure repeats whenever
the version number changes (since the configure script changes to
support "./configure --version" and "./configure --help"), making
bisecting painfully slow.

The intent was to make the reconfiguration process only trigger for
changes to configure.ac's logic.  Tweak the Makefile rule to match
that intent by depending on configure.ac instead of configure.

Reported-by: Martin von Zweigbergk <martinvonz@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
[...]
> --- a/Makefile
> +++ b/Makefile
> @@ -2267,12 +2267,9 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplemented.sh
>         mv $@+ $@
>  endif # NO_PYTHON
> 
> -configure: configure.ac GIT-VERSION-FILE
> +configure: configure.ac
[...]
> --- a/configure.ac
> +++ b/configure.ac
> @@ -142,7 +142,10 @@ fi
>  ## Configure body starts here.
> 
>  AC_PREREQ(2.59)
> -AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
> +AC_INIT([git],
> +       m4_esyscmd([ ./GIT-VERSION-GEN &&
> +                    { sed -ne 's/GIT_VERSION = //p' GIT-VERSION-FILE | xargs echo -n; } ]),
> +       [git@vger.kernel.org])

I don't think that would warrant dropping the GIT-VERSION-FILE
dependency, since the resulting configure script still hard-codes the
version number.

Sane?

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 736ecd45..2a22041f 100644
--- a/Makefile
+++ b/Makefile
@@ -2275,7 +2275,7 @@ configure: configure.ac GIT-VERSION-FILE
 	$(RM) $<+
 
 ifdef AUTOCONFIGURED
-config.status: configure
+config.status: configure.ac
 	$(QUIET_GEN)if test -f config.status; then \
 	  ./config.status --recheck; \
 	else \
-- 
1.8.1
