From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-testgit: fix race when spawning fast-import
Date: Sat, 21 Apr 2012 21:50:58 -0700
Message-ID: <xmqqty0cxtcd.fsf@junio.mtv.corp.google.com>
References: <20120415011118.GA4123@ecki> <4F8A8211.2010908@gmail.com>
	<20120415105943.GD6263@ecki> <4F8AAE7C.1020507@gmail.com>
	<20120415114518.GB9338@ecki> <4F8AB7F1.1020705@gmail.com>
	<20120415125140.GA15933@ecki> <20120419233445.GA20790@padd.com>
	<4F9145A1.6020201@gmail.com> <20120421201524.GA18419@padd.com>
	<20120421234555.GA11808@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 06:51:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLolu-0005iu-UR
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 06:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab2DVEvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 00:51:01 -0400
Received: from mail-we0-f202.google.com ([74.125.82.202]:59913 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab2DVEvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 00:51:00 -0400
Received: by wejx9 with SMTP id x9so510996wej.1
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 21:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=qHtbHItKkEfKNMKn7zVIb66dWewd8uRts1AISrwFIAw=;
        b=S9XapqpLXzp2n89SVMAToY3wy70MAt1LVlokr3NeZfq6S0i/DFVFO49Z9p2hqGb4ej
         Mz8C8bwYfTlrJ3bOHF/5IfyB9gE5zeCh8eRX33ohNFrcAsxxPIX8iRkJTS5uDjJvsiOX
         wL7672UZ7xpHiFSYZBBqCfobhQQZxXgGV+f/eHBk2CQ/m2ts9v5h1IVlHgVHpcgMyPw7
         xAns1CcKI+C2BAbiHSjB7AQ4ZLaBO4JoOEksGqafuXMMY1w9eYCzOvfoQ8q62G1/uIaP
         9kdLWp2iwInyx3bnSbolDEC9J9635QLNzVufN5/g08VYTY7+CeW+sv0Qt4axdK/BqQVD
         Uqxw==
Received: by 10.14.188.12 with SMTP id z12mr2994055eem.8.1335070259507;
        Sat, 21 Apr 2012 21:50:59 -0700 (PDT)
Received: by 10.14.188.12 with SMTP id z12mr2994035eem.8.1335070259379;
        Sat, 21 Apr 2012 21:50:59 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si10455069eef.2.2012.04.21.21.50.59
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sat, 21 Apr 2012 21:50:59 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 31FDD5C0050;
	Sat, 21 Apr 2012 21:50:59 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 82804E120A; Sat, 21 Apr 2012 21:50:58 -0700 (PDT)
In-Reply-To: <20120421234555.GA11808@padd.com> (Pete Wyckoff's message of
	"Sat, 21 Apr 2012 19:45:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmBmcPqjr2LLSX1GBzV0dF/ytG7fzuyG1VykHCNzDl52KtqkJdgIy/EBjmwiMat2RjTD5W7FBDI1oluv8WxBkmaFH5UcZWtk6wKcEqoovv/mEiTs3T1zNXHJLG7h0IzFZ09O4npe9uOYb09CY7ACh3LcBktdvl82oaoOeOsRfs99D/hZek=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196074>

Pete Wyckoff <pw@padd.com> writes:

> Fix this by setting stdin to unbuffered.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>
> This is the one that might be suitable for upstream.  It fixes
> the problem with this particular remote helper.
>
>  git-remote-testgit.py     |    7 +++++++
>  t/t5800-remote-helpers.sh |   11 +++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/git-remote-testgit.py b/git-remote-testgit.py
> index 3dc4851..5f3ebd2 100644
> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -22,6 +22,7 @@ except ImportError:
>      _digest = sha.new
>  import sys
>  import os
> +import time
>  sys.path.insert(0, os.getenv("GITPYTHONLIB","."))
>  
>  from git_remote_helpers.util import die, debug, warn
> @@ -204,6 +205,11 @@ def read_one_line(repo):
>      """Reads and processes one command.
>      """
>  
> +    sleepy = os.environ.get("GIT_REMOTE_TESTGIT_SLEEPY")
> +    if sleepy:
> +        debug("Sleeping %d sec before readline" % int(sleepy))
> +        time.sleep(int(sleepy))
> +

If I understand your explanation correctly, the primary purpose of the
remote-testgit is to test the parts of the system that talk to remote
helpers that are used in production in the t/t5800 script, and this
"sleep" is to make it easier to trigger the particular bug you fixed 
in *this* script.  The bug is _not_ in the parts of the system being
tested, but is in this test scaffolding.

If that is the case, then it should not be enabled unconditionally.
When somebody wants to see if remote-testgit was broken again (perhaps
after observing occassional hangs), the environment should be set when
running the test, but not in t5800.
