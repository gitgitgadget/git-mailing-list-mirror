From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Bug report: Duplicate CRLF rewrite warnings on commit
Date: Fri, 13 May 2016 14:49:53 +0100
Message-ID: <20160513134953.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:50:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1DTk-0003YE-6P
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 15:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbcEMNt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 09:49:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33630 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbcEMNt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 09:49:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so3861596wme.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=drz6ypCBFo7aHLELjNcq0qlE9ZOfSTEwGn5qPgjYfT4=;
        b=OhrVPXCafQWGH8mE08fvLPp7heaFSu0YapMr6QeC7EJNprZsH/ff8UeKZ2XqX9xuak
         /GJAG+f6RCCxBFulQG/v3AKzG8C+JOwV9+LbQ5weNYOxprcUtS8crjiWYSO3zCFnhHyB
         hpZq2xXYNXR+YXhhog8fQq95cCCdxBi1P8n6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=drz6ypCBFo7aHLELjNcq0qlE9ZOfSTEwGn5qPgjYfT4=;
        b=bPIyRAwagA5I2cDYKEQu227nAQrN36BUHpAMbV/7YGo8vja5dqnJepQt26SS7ELDrZ
         Qq0w4qj+c9W3YzD7PjLfwflLlFTIp8l5yr3A2rq9qjM8jT8hM2+w7dLrDYphfFF4vHfX
         1Zzk48LVNKzHOtnHccy9pqGLYgYmAGevW3o5yYj+Z+IuKbAJ2k5kSKj4g85GTbye6bWE
         DBtg3Rr3LLS7tobLWzCYANwz912QlTw+kKenq8pnJldKM1gAHxuz1kgcPwhrPLycbYqI
         Zkvme1yuDBAq2NNhq0Z88ivDIL3qiQZXgRj9K7ZtT2h3yJnV3UlmuDQBDEbZD1vjwqyY
         FUSQ==
X-Gm-Message-State: AOPr4FXkqj1Fus8oHO46Ouwng5iSRAyrCo/AmvfAGYmtVmsrAkRhwuanuMW/X82eSS1TNA==
X-Received: by 10.194.42.69 with SMTP id m5mr16110825wjl.89.1463147396495;
        Fri, 13 May 2016 06:49:56 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id c16sm3410220wme.16.2016.05.13.06.49.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 May 2016 06:49:55 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294537>

If you use .gitattributes to enable CRLF->LF rewriting, then commit a
file that would have its line endings rewritten, the "CRLF will be
replaced by LF" warning is printed several times over; I'd expect it to
be printed only once.

There's a test case in t0020 -- "safecrlf: print warning only once" --
that checks the warning is only printed once when using `git add`, but
nothing that seems to check the same thing on `git commit`.  The
unnecessary multiple warnings seem to have existed since at least v1.6.0
(the warnings appear to have been added in v1.5.5 in 21e5ad5, but I
couldn't get that to build on my current box), and I'm seeing them on my
Cygwin box's build of the current next branch (d10caa2) and on my CentOS
box's v2.8.1 release.

Example:

    $ git init
    Initialized empty Git repository in /home/Adam/test/.git/

    $ echo '* text' >.gitattributes

    $ echo 'lf-terminated line' >text

    $ git add .gitattributes text && git commit -m 'Initial commit'
    [master (root-commit) 9a18d39] Initial commit
     2 files changed, 2 insertions(+)
     create mode 100644 .gitattributes
     create mode 100644 text

    $ echo 'crlf-terminated line' | unix2dos >text

    $ git add text  # Single CRLF warning as expected
    warning: CRLF will be replaced by LF in text.
    The file will have its original line endings in your working directory.

    $ git commit -m 'CRLF'  # Should have one CRLF warning, actually get two
    warning: CRLF will be replaced by LF in text.
    The file will have its original line endings in your working directory.
    [master 4a8b1cb] CRLF
    warning: CRLF will be replaced by LF in text.
    The file will have its original line endings in your working directory.
     1 file changed, 1 insertion(+), 1 deletion(-)

(Tangentially: what's the accepted practice for submitting failing test
scripts?  I've written a short test case to add to t0020 that shows this
bugged behaviour, but I've got the vague impression from past emails
that leading with the patch email adding the failing test case is not
the expected way to do things on this list...)

Cheers,

Adam
