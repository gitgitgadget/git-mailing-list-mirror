From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Optimize usage of grep by passing -q
Date: Mon, 16 Nov 2015 17:04:24 -0800
Message-ID: <CAGZ79kYCNdDV2cDZSiugx6EuY_0BEgGMJJVm8EBWqPEE77sqbw@mail.gmail.com>
References: <1447710209-13117-1-git-send-email-sbeller@google.com>
	<CAHYJk3S-pBQGDk_PPXw5mgzuXhdKqifRB4Vwz1Nu0TecXz4JQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Mikael Magnusson <mikachu@gmail.com>,
	Andrey Rybak <rybak.a.v@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 02:04:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyUhC-0007JF-7j
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 02:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbbKQBEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 20:04:25 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33623 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbKQBEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 20:04:24 -0500
Received: by ykdv3 with SMTP id v3so269497090ykd.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 17:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oS3miPAguMZKWPt9tKWPkHxSbNGZYgDAWAaoDUXEwSs=;
        b=mbx9/Mt4/I3YmvdZUHNAZbu62ZPtFsdmws00R1neud0teN0eqFnlUlDLYvwskzyQrA
         9wACnKo2mM9Hh/ZnunoDhmtNdfWCghFcOGn6YRw74BdnSHRpnVXKAwzsw9dgQdNMb6xZ
         ODBC1LhWU7MN0k9pIEyLLGtHkLCCBwhVpmhd5F83P9bDWH0FrVOiHZPKqBZNBU/l//ZS
         cnC5j5o48j6m9zFLFqW5CMZGiwNyAAfRxfQ6lN6shpaIsqXQYTOA9HbIHjqzDVEzU2Uy
         o3fL07JCkJUaODakSW3j1201NhaQY+VhqU01oci614GAXiTqPlgaRDcY/Fl1tMOTfmmK
         wGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oS3miPAguMZKWPt9tKWPkHxSbNGZYgDAWAaoDUXEwSs=;
        b=aiTWJJMbeSCdv/b5wonQX/yJLfQPjKSJH6KUWJmNcZ4xPrFW38AylWsWRzDWgvtzzZ
         LzUhK+q5McUzEjQeUOIysflrxlYIF60zXMiemHcGWHyd+BbRM8JEvaKRl2sTmj+/hSaT
         azo19UIzIju6Oa7DtzbDQ+nxDiX0XqViGc4A9FLTbfO1R9Oyc8hkBSqDJ1XwnYPfqOSF
         5iSg/9+Q/gYtr7ebmuJk38py4FuP7yNJADr9DcmiqAv059riuduMFM3Vzjcc/ltMEzA5
         mpahjL6/BBthRNVIMflzdZiumfK8740exSOEMY21zG10nIJbzIf/llH4myxHjH7bI735
         gXRg==
X-Gm-Message-State: ALoCoQnF1cVPHCoxi7uNQ3paJ/lzqkMzstFvXk5fqI9+iEV9qrhk2LYs/ecGB5gOEq6Z116fzydR
X-Received: by 10.129.133.69 with SMTP id v66mr9445002ywf.68.1447722264245;
 Mon, 16 Nov 2015 17:04:24 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Mon, 16 Nov 2015 17:04:24 -0800 (PST)
In-Reply-To: <CAHYJk3S-pBQGDk_PPXw5mgzuXhdKqifRB4Vwz1Nu0TecXz4JQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281376>

+cc Andrey Rybak, who I credit for finding the reasoning below (he
sent to me privately,
without cc'ing the list)

On Mon, Nov 16, 2015 at 4:59 PM, Mikael Magnusson <mikachu@gmail.com> wrote:
> On Mon, Nov 16, 2015 at 10:43 PM, Stefan Beller <sbeller@google.com> wrote:
>> Instead of redirecting all grep output to /dev/null, we can just
>> pass in -q instead. This preserves the exit code behavior, but is faster.
>> As grep returns true if it finds at least one match, grep can exit promptly
>> after finding the first line and doesn't need to find more occurrences
>> which would be redirected to /dev/null anyways.
>>
>> This is true for the gnu version of grep. I am not sure if all
>> versions of grep support this optimization. In case it is not,
>> we'd revert this patch.
>
> POSIX specifies -q, so you should be fine.
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html
>

>From http://www.gnu.org/software/grep/manual/grep.html :
-q
--quiet
--silent
Quiet; do not write anything to standard output. Exit immediately with
zero status if any match is found, even if an error was detected. Also
see the -s or --no-messages option. (-q is specified by POSIX.)
-s
--no-messages
Suppress error messages about nonexistent or unreadable files.
Portability note: unlike GNU grep, 7th Edition Unix grep did not
conform to POSIX, because it lacked -q and its -s option behaved like
GNU grep's -q option.1
USG-style grep also lacked -q but its -s option behaved like GNU
grep's. Portable shell scripts should avoid both -q and -s and should
redirect standard and error output to /dev/null instead. (-s is
specified by POSIX.)

Reading that in full, I think my patch is a bad idea.
