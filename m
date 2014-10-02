From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously set variables
Date: Thu,  2 Oct 2014 06:24:47 -0700
Message-ID: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 15:25:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZgOI-0006Jp-Io
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 15:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbaJBNZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 09:25:50 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:56763 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbaJBNZu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 09:25:50 -0400
Received: by mail-pa0-f48.google.com with SMTP id eu11so2372772pac.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nfMsK0YzIshhYi/S8jtiplJYlfkSkvezRDT4kVJyUvY=;
        b=c+xDZ6etSva4m2ptPNXBOJUjPgVYrQqznWm+OtsnYI0oEKXQLbcq73qS84Q0MyyDSI
         boYEeQxqEwzteVWPuE9AMyZX6SSOSseAA+VPxudgGa47jQ/IImrx4hUUr2WAhfCOscRQ
         P+7t6qtw4cmIXOzl89SsnrMBW0T2iktgs31xrUF3/dpk7UWf7Sno6qffoA0xQ+Cu+LbR
         bV97U9ciz9JFs7zx3z9baQTPMhAtNqRav6IEHYcJA3gESHHbRrz6H988iKkfy1NdmXvO
         n3vcBqrI64mBux3vFhFo+RKiNN9wBkTouYX9VC+cIn54sIR/2Frjg5iA1zVD+gyg+k/7
         RXCg==
X-Received: by 10.68.175.99 with SMTP id bz3mr87767254pbc.112.1412256349508;
        Thu, 02 Oct 2014 06:25:49 -0700 (PDT)
Received: from localhost.localdomain ([182.67.148.232])
        by mx.google.com with ESMTPSA id qp9sm3612065pbc.31.2014.10.02.06.25.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Oct 2014 06:25:49 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257800>

Hi,

This series aims to add a method to filter previously set variables.
The patch series can be best described by the 3/5 log message
which I have pasted below verbatim.

"
Add a new config variable "unset.variable" which unsets previously set
variables. It affects `git_config()` and `git_config_get_*()` family
of functions. It removes the matching variables from the `configset`
which were added previously. Those matching variables which come after
the "unset.variable" in parsing order will not be deleted and will
be left untouched.

It affects the result of "git config -l" and similar calls.
It may be used in cases where the user can not access the config files,
for example, the system wide config files may be only accessible to
the system administrator. We can unset an unwanted variable declared in
the system config file by using "unset.variable" in a local config file.

for example, /etc/gitconfig may look like this,
	[foo]
		bar = baz

in the repo config file, we will write,
	[unset]
		variable  = foo.bar
to unset foo.bar previously declared in system wide config file.
"

Now, I have some points of
contention which I like to clarify,

1> The name of the variable, I could not decide between "unset.variable"
and "config.unset", or may be some other name would be more appropriate.

2> It affects both the C git_config() calls and, git config shell
invocations. Due to this some variables may be absent from the git config -l
result which might confuse the user.

3> I also have an another implementation for this series which just marks the config
variables instead of deleting them from the configset. This can be used to
provide two versions of git_config(), one with filtered variables other without
it.

4> While hacking on this series, I saw that git_config_int() does not print
the file name of the invalid variable when values are fed by the configset.
I will correct this regression in another patch.

Cheers,
Tanay


 Documentation/config.txt | 12 +++++++
 config.c                 | 93 +++++++++++++++++++++++++++++++++++++-----------
 t/t1300-repo-config.sh   | 56 ++++++++++++++++++++++++++++-
 3 files changed, 139 insertions(+), 22 deletions(-)

-- 
1.9.0.GIT
