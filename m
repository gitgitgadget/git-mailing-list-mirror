From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Silent failure to add Windows-style paths in Cygwin Git
Date: Mon, 25 Apr 2016 13:07:05 +0100
Message-ID: <20160425120705.GN2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 14:07:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aufIK-00064f-Ma
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 14:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbcDYMHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 08:07:11 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35836 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603AbcDYMHK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 08:07:10 -0400
Received: by mail-wm0-f49.google.com with SMTP id e201so83224807wme.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 05:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PIhaLiSswv3+R2tx7inVbRQ0PSDLdNCCtnUPPpEHshk=;
        b=vh7nc1ThK2S8Jp0r5qly50S7gq8N9sU1yYwWbJ8/b4cSW672EZ9UnbsM4+Ou6d9mXU
         UDxCTYtjQNOA54zrU5HWc/17mNM7PbOpYfnYfRGuZVoYu3HIpVNrJwVwiziev3dhW/22
         BwG/m14U1iCPsNBSOR/ah4vlRdh/ku6SK/auw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PIhaLiSswv3+R2tx7inVbRQ0PSDLdNCCtnUPPpEHshk=;
        b=NX2oXtfw0jet4E+tiq/lvEF3iiudjUBnX+NVcNNoVIa3JoIbeq7vmABrS9+EPW+sKR
         K4WL//vOiPyPABeuXUJU6ZqJAoLmYpQcsYnKq+EDw+cif9mIPNPckrNCSFnWJQZYi0XS
         l3BZmsTRVeScUmb511xJlAFr7nJyIexArBGsjZbZP+GK0sN1+A035Vs6mMqhwwK1RHgM
         L91hy5t5kcgt8G3Qewu63GSDAeAJdXrrklHmf8jgchQitq1NuOCWYp2pfxhEamNXK0Wa
         k5FZMidsnvhjIioLpmsDPrGPKIRHGaYk+PDEEY0gc16sjlMCBcbCQKi90Nwt2vwy7Ga3
         FJoQ==
X-Gm-Message-State: AOPr4FXyYSRAhbPTsrb8mDSxhlAzRY2XYK0J02EKtLzjtxo82P/CVE9zu/kYptUuE04kKg==
X-Received: by 10.28.113.218 with SMTP id d87mr12604460wmi.52.1461586028858;
        Mon, 25 Apr 2016 05:07:08 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id u12sm2354716wmu.12.2016.04.25.05.07.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 05:07:07 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292469>

[Resending as my initial attempt appears to have not made it to the
list.  Apologies if this results in a double-post.]

If I attempt to `git add` an extant file specified using a Windows-style
path on Cygwin Git, this doesn't add the file, and produces no error
message:

    $ pwd  # As seen by Cygwin
    /cygdrive/c/tmp

    $ cygpath -aw .  # As seen by Windows
    C:\tmp

    $ git init
    Initialized empty Git repository in /cygdrive/c/tmp/.git/

    $ git add 'c:\tmp\file' || echo non-zero exit code  # Errors out as expected
    fatal: pathspec 'c:\tmp\file' did not match any files
    non-zero exit code

    $ touch file

    $ git add 'c:\tmp\file' || echo non-zero exit code  # No error this time...

    $ git status  # ...even though the file didn't get added
    On branch master

    Initial commit

    Untracked files:
      (use "git add <file>..." to include in what will be committed)

            file

    nothing added to commit but untracked files present (use "git add" to track)

I wouldn't expect adding the file to actually succeed, but I would
expect it to either succeed or produce an error, rather than silently
failing.

Experimentation shows I get the same behaviour for 'c:\tmp\file',
'c:/tmp/file' and 'subdir\file'.  I'm seeing this on v2.8.0; the
downstream report says the same behaviour occurs on v2.7.4[0], and I've
also seen what appears to be the same behaviour on a v2.0.5 build I
produced to check.

Adam

[0]: https://cygwin.com/ml/cygwin/2016-04/msg00474.html
