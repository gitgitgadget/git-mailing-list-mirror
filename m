From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] config: add options to list only variable names
Date: Thu, 28 May 2015 12:36:43 -0700
Message-ID: <xmqq7frsh4tw.fsf@gitster.dls.corp.google.com>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
	<1432816175-18988-1-git-send-email-szeder@ira.uka.de>
	<1432816175-18988-2-git-send-email-szeder@ira.uka.de>
	<xmqqbnh4h5k4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu May 28 21:36:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy3br-0008Si-OF
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 21:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbbE1Tgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 15:36:47 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36719 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbE1Tgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 15:36:45 -0400
Received: by iepj10 with SMTP id j10so46430875iep.3
        for <git@vger.kernel.org>; Thu, 28 May 2015 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BIzjHC1usdPZDuFRAIuvrtNEDqR55kO3XJw0GJROgzw=;
        b=j1PuVADbMNOSI2aqiEToWJbkaeGnu+o5Ny1HUY0otzrq4mcwqRxHeIsWY50qmEBEj5
         0H6GewmAVkV8Y2XzY43jDnN61CkDJiyxzaZwssCjihV0ov1e6/ro2vfrEw+x14Eo8+2W
         CzZOfoWoLlrXcfgOvrJue5DC4WiSd3catzfMteXN3+bB2HYRMz9FxW3xCe8m50/IRJ2I
         rHjVVQIYULJE0QxoDTo6aM/sBJERxhzDfu/Jwv4a3MmB4f4jSlPTE+Rmn9/gl8+Dpm/q
         TPy46r67RCEEHFRuy+982ORNeH9N/cxe2sAeP+6rva6Zy1cVye2Q7CQxZOmxoE4mBTyP
         YTDg==
X-Received: by 10.107.154.70 with SMTP id c67mr5520225ioe.22.1432841805045;
        Thu, 28 May 2015 12:36:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id cy11sm4994864igc.14.2015.05.28.12.36.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 12:36:44 -0700 (PDT)
In-Reply-To: <xmqqbnh4h5k4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 May 2015 12:20:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270184>

Junio C Hamano <gitster@pobox.com> writes:

> The 'type' may also be shared between these two options, no?  It
> would be logically consistent if you can say
>
> 	git config --bool --get-name-regexp '.*' 'no'
>
> to find all configuration variables that are set to 'false' in
> different spellings like '0', 'false', 'no', etc.  And I suspect
> that the code already supports that.

Not really.  This of course inherits the same breakage from the
existing --get-regexp code in that the value part is still matched
as string.  I am sure you could argue that "but read the name of the
last optional argument; it says value_REGEX and it is clearly about
matching textually", and it may technically not be incorrect per-se,
but I'd say it is merely a justification for a lazy implementation
to defend the current less-than-useful behaviour.

In any case, because it is still a textual match, user.name='Junio
Hamano' matches with the above.  The only reason why it does not
barf is because it does not try to interpret and format that value
as a boolean.

So I would say that the feature supports [type] and [value_regex]
to exactly the same degree as --get-regexp, i.e. with breakage.

Which means we should document it the same way, even though both are
equally broken.  So that other people can later visit it and correct
the issue for both options.

-- >8 --
Subject: [PATCH] SQUASH???

The new option --get-name-regexp is a variant of --get-regexp; show
them next to each other, and also document [type] and [value_regex]
that the option seems to support.
---
 Documentation/git-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index b69c859..9fc78d8 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -15,8 +15,8 @@ SYNOPSIS
 'git config' [<file-option>] [type] [-z|--null] --get name [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-all name [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [type] [-z|--null] --get-name-regexp name_regex [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-urlmatch name URL
-'git config' [<file-option>] [-z|--null] --get-name-regexp name_regex
 'git config' [<file-option>] --unset name [value_regex]
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
-- 
2.4.2-521-g2db3d00
