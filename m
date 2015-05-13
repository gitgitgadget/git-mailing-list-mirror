From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Wed, 13 May 2015 22:00:03 +0200
Message-ID: <5553AD43.9010807@gmail.com>
References: <1431482407-63642-1-git-send-email-davvid@gmail.com>	<55534F4E.60402@gmail.com>	<3d7e3b09b89c46c39befca7564f5c1d6@www.dscho.org> <CAHGBnuPDSdCyVNM+Gagang1Cf9yw0Tyios45i6pnZSSzaJJC2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 13 22:00:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YscpP-00007R-QE
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 22:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965563AbbEMUAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 16:00:21 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35326 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965515AbbEMUAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 16:00:19 -0400
Received: by widdi4 with SMTP id di4so213335895wid.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7y62HxzLgH0FW9KNvzHJnhrT1tYLB0pGi8GhIAFY4q0=;
        b=oGiT9rwukPnO17RCVrUiaVUZPHaDiKK1Xz8BwOFsT95X7k8RT+rXB8TwRYexulWd4y
         f7XNoGvyFKE3qX+l5ib5PujSmnxn4dMWTfWUJUIExv/IuIPY3TO7eDgLPG6+R6s+34zi
         VKnrUvW5t7AxW4Nhp+1qRvcValJBzcQxDLumX/bdGINQk/97hneIxWh931ygHaRBSB0t
         L2tJPemI5D3G1sMB7OJNTut3yC/pYyCQ+yay7geIHVfKrVkjQThorGXrk1e3XkNPV2mI
         AY7b4O0r+JW/edi415rT0thh4TfbQjUPANNrto5+xptVa+Zmz53JFegzgNZL1MnAITcA
         ie6w==
X-Received: by 10.180.90.236 with SMTP id bz12mr41668456wib.33.1431547218258;
        Wed, 13 May 2015 13:00:18 -0700 (PDT)
Received: from [192.168.188.20] (p4FF45E49.dip0.t-ipconnect.de. [79.244.94.73])
        by mx.google.com with ESMTPSA id u9sm30070055wju.44.2015.05.13.13.00.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2015 13:00:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAHGBnuPDSdCyVNM+Gagang1Cf9yw0Tyios45i6pnZSSzaJJC2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269004>

On 13.05.2015 17:33, Sebastian Schuberth wrote:

>> In my tests, "$PROGRAMFILES(X86)" did *not* work:
>>
>>      $ echo "$PROGRAMFILES(X86)"
>>      bash: syntax error near unexpected token `('
> 
> Interesting. In both MSYS1/2 Git Bashes I get on Windows 7 64-bit:
> 
> $ echo "$PROGRAMFILES(X86)"
> C:\Program Files (x86)(X86)
> 
> So it seems to resolve only the $PROGRAMFILES part and appending the
> literal "(X86)". Not sure how to tell Bash that "(X86)" is part of the
> variable name.
> 
>> Exactly. In my tests, "$ProgramW6432" worked, while "$PROGRAMW6432" did not.
> 
> Very odd indeed that for me it's the exact opposite.

So how about something like this which hopefully covers all cases (including case-sensitivity issues regarding environment variable names and the problem of querying a variable that contains parentheses as part of its name):

for directory in "$(env | sed -nr 's/^PROGRAM(FILES(\(X86\))?|W6432)=//pI')"
do
    test -n "$directory" &&
    test -x "$directory/$winmerge_exe" &&
    echo "$directory/$winmerge_exe" &&
    break
done

sed's "I" seems to be a GNU extension that's not available with OS X' BSD sed. This shouldn't be an issue as WinMerge is Windows only anyway. If it still turns out to be an issue we probably should come up with an equivalent Perl expression.

-- 
Sebastian Schuberth
