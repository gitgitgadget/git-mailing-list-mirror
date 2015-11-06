From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 2/4] git-p4: add p4d timeout in tests
Date: Fri, 6 Nov 2015 14:20:38 +0100
Message-ID: <499A69EE-4037-4865-8707-44157AD5A32C@gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com> <1446800323-2914-3-git-send-email-larsxschneider@gmail.com> <CAPig+cSnhxEQdjiLt8+hjMnYYAxaLRVAYX-S5s3BHTpFOMcWqA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jean-Noel Avila <avila.jn@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	David Turner <dturner@twopensource.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 14:20:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zugwe-00088D-GH
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 14:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033346AbbKFNUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 08:20:40 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33580 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1033190AbbKFNUk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 08:20:40 -0500
Received: by wmec201 with SMTP id c201so17865484wme.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QPnqEZlRt6Z3Wi7PMJdNbBjJo7eNzS/lWb6cJosSqcE=;
        b=GVy3qtrf8/ppoH2LU6DS1taxBpqGL3UKZGPSFWRnrXHTQeMEyWJ43SrP49XmeQy5A9
         9iRfgB0YtOi80EZ3D3o5Z3Glo5IhBWu74mc5A5PKO3Jpo37had3wK7swHHmaggD/3y1f
         JI5lbLr4mi4WWBU8N3nRLLs3vqXz3NNey7phxxPp1QPicHEZG5LgVTkPeGqd7o4wdzFb
         p/Ks3SuAOCpreWD7cappF/E2ZQjGt6tcCq2r/MbMDRP8fc1qeqhnC9Z6Fe/3Rz7vk6hj
         9n2q3anJxEvvHrxt3vPiKrWccG+aoO2WuPoK/c+SwtrIWAbnTAy0PYWvBTQU3DbJhlgX
         eXbw==
X-Received: by 10.28.55.209 with SMTP id e200mr9604291wma.79.1446816038797;
        Fri, 06 Nov 2015 05:20:38 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r9sm99133wjz.35.2015.11.06.05.20.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2015 05:20:38 -0800 (PST)
In-Reply-To: <CAPig+cSnhxEQdjiLt8+hjMnYYAxaLRVAYX-S5s3BHTpFOMcWqA@mail.gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280978>


> On 06 Nov 2015, at 10:23, Eric Sunshine <sunshine@sunshineco.com> wrote:
> 
> On Fri, Nov 6, 2015 at 3:58 AM,  <larsxschneider@gmail.com> wrote:
>> In rare cases p4d seems to hang. This watchdog will kill the p4d
>> process after 300s in any case. That means each individual git p4 test
>> needs to finish before 300s or it will fail.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
>> @@ -81,6 +85,19 @@ start_p4d() {
>>        # will be caught with the "kill -0" check below.
>>        i=${P4D_START_PATIENCE:-300}
>>        pid=$(cat "$pidfile")
>> +
>> +       timeout=$(($(date +%s) + $P4D_TIMEOUT))
>> +    while true
> 
> The 'while' line is incorrectly indented with spaces rather than tabs.'

Oh, you're right. One more thing that I will add to my pre mailing list submit check script :-)

> 
>> +       do
>> +               if test $(date +%s) -gt $timeout
> 
> I don't know how portable you intend this to be, but 'date +%s' is not
> universally supported (it's missing on Solaris, for instance, and
> perhaps AIX). For 6a9d16a (filter-branch: add passed/remaining seconds
> on progress, 2015-09-07), we ultimately settled upon detecting +%s
> support dynamically:
> 
>    if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
>        # it's supported
>    fi
> 
> Perhaps you'd want to detect this via a lazy prerequisite and skip
> this if not supported?

AFAIK Perforce does not run on Solaris and AIX anyways (see supported platforms [1]). Therefore these tests should not be executed on these platforms. A lazy prerequisite sounds like a good idea to make this explicit!

Thanks,
Lars

[1] https://www.perforce.com/perforce/doc.current/user/relnotes.txt
