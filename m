From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: git_getpass regression?
Date: Fri, 29 Jun 2012 12:06:31 +0200
Message-ID: <CABPQNSa4uvgijjGCSJDXDMqHC3UkqQKKujG3xDFqnQ13LNrKdQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 29 12:07:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkY6i-0007bT-LL
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 12:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab2F2KHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 06:07:13 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64170 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab2F2KHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 06:07:12 -0400
Received: by dady13 with SMTP id y13so4169483dad.19
        for <git@vger.kernel.org>; Fri, 29 Jun 2012 03:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc
         :content-type;
        bh=Q64MVUnFd6EvXUMZ2TjUZkg3//kZyR87qu/hx6v0lYM=;
        b=xqTNwFeJARpWQuNye+ANZpTTjCinkp6YoywrCWmhlumVoK9M9/ZiwZXTyJQQuQeWaN
         KUa/2hUmzC9LKd/6cq2hsX0yq6F6t43p0tQCb0I3sUag/TEhcnXCG0BOjbZFOEuA/4R9
         XkXJOikDgO4cqaOh53Xo5kSxApr0Wj5ZYe870pSvM61GQW+qnIZ4Ku2Du7xjVQl9bAal
         1TyM7MbFNV5yx5T80pC7Xzok9wjXjRlippB+t5w3GVAnzLF2kQwGcJ17K+ElBsYx0kb0
         VLQf8SL2Ely0rrwh4yIrhxBBYTJ3YLoIiPTBYwYTf9Nw9qmmxDv9SFz1iMPpW6r2lPyy
         F4pA==
Received: by 10.68.203.7 with SMTP id km7mr5547214pbc.7.1340964431926; Fri, 29
 Jun 2012 03:07:11 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Fri, 29 Jun 2012 03:06:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200813>

Since 9b4b894 ("Makefile: linux has /dev/tty", 2011-12-10) we're
reading input from the terminal using strbuf_getline instead of
getpass. But at least on my linux-box, getpass treats the
backspace-key ('\b') as an actual deletion. strbuf_getline obviously
shouldn't do this, as it's a utility function. But I think as a
user-interface feature, it would be much more pleasant to be allowed
to edit the entered text ;)

I can't find anything in POSIX that standardize this behavior, but for
most text-input use-cases it's probably what the user intended.

I guess this is technically a regression, but probably not a very important one.

I think we have multiple possible solutions:
 1) Read a character at the time, and special-case '\r' to erase the
previously entered character.
 2) Post-process the strbuf to explicitly perform the erasing.
 3) Do nothing.

I'm in favor of 2) because I'm a Windows-user, and we never had the
erasing-behavior to begin with. And it's a nice feature, so we could
make the post-processing a function that can be reusable by the
Windows-version of git_terminal_prompt. We could even use it on the
plain getpass-fallback, to unify the user-experience across platforms.

We can probably also be do 1) in a reusable form by adding some kind
of on_char-callback, but it's probably something that'd end up more
confusing than than the alternative.

Thoughts?
