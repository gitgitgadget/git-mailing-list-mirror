From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri,  7 May 2010 00:27:32 +0200
Message-ID: <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
Cc: hasan.aljudy@gmail.com, kusmabite@googlemail.com,
	torvalds@linux-foundation.org, prohaska@zib.de, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 00:27:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA9Xu-0003zw-Mc
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab0EFW1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:27:45 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:44803 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab0EFW1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:27:44 -0400
Received: by ey-out-2122.google.com with SMTP id d26so89461eyd.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=V08kfPhdMWUrnGgzSkWOqxx+zi6tuiQkuBbBDjVIJW0=;
        b=Ic8/onItZHNoe8TE1lFcj78+sIFSvuxawP+cesMYqquGQLeqGEc6fQDHbOIStxjVea
         UjthXtjA5rQxOt3khTgt8aEJQrCqKppzE2uHkEFORdir3ri/NlCK1xbIkbmij04bY6T6
         NM0a/N3SF7qSRfjJ4XKv5Vif9WHVMbYIPBdsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pva9dRf+jpP8+zsRvM3nwcNhzCD/LuUc2qYKgfsvPE2bybqum1q7+zHxqhc8VBIvVR
         9Q3BEx4dsU7cbuD/+QelCBE5eRxfoqvW2gwxPCg59ozQu9S7H04Tf/ADVh+mGY7TYkQ9
         erXwVxfO+IMw63GenBrSo6qk3y1qqeuUIq0Vw=
Received: by 10.213.44.67 with SMTP id z3mr20705ebe.57.1273184862757;
        Thu, 06 May 2010 15:27:42 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm843521ewy.15.2010.05.06.15.27.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 15:27:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.3.gb95c9
In-Reply-To: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146503>

This discussion couldn't be more timely, as I've recently acquired a
desperate need to solve CRLF problems at $dayjob.  This patch series
introduces a new way of turning on autocrlf normalization by splitting
the configuration into two:

- An attribute called "auto-eol" is set in the repository to turn on
  normalization of line endings.  Since attributes are content, the
  setting is copied when the repository is cloned and can be changed in
  an existing repository (with a few caveats).  Setting this attribute
  is equivalent to setting "core.autocrlf" to "input" or "true".

- A configuration variable called "core.eolStyle" determines which type
  of line endings are used when checking files out to the working
  directory.

How does this solve the current problems with core.autocrlf?  First,
let's enumerate them:


1. Setting core.autocrlf in your global or system configuration is a
pain since git will get confused whenever you work in a repository which
contains CRLF line endings.  If you have to work in both repositories
with normalization and repositories with mixed line endings, you have no
choice but to set core.autocrlf in each repository individually.

2. Setting core.autocrlf in an individual repository would be okay
except that naive users will do it after they have already cloned:
unless core.autocrlf is set globally, the clone will have the wrong line
endings, and the user needs to know how to refresh it manually (rm -rf *
&& git checkout -f).

3. Once somebody does it, _everyone_ has to do it: if someone checks in
a file with CRLFs, that file will cause trouble for everyone who has
autocrlf set.  That someone can be a Linux user who just copied a file
from Windows and didn't think to convert the line endings (BT, DT).

4. Once a repository contains CRLFs autocrlf can never sanely be
enabled; the CRLFs can be normalized in a commit, but there's no way to
say "all commits after this one are normalized, those that came before
were not".

5. On the other hand, setting core.autocrlf means that git no longer
stores your files in their pristine, natural state; if you _know_ that
your repository will never be used by anyone whose EOL preference
differs from your own, it seems wasteful and dangerous to normalize
those line endings.


I used an attribute to enable line-ending conversion because it seems to
be a good idea to have line ending normalization be a property of the
content rather than the repository's or user's configuration.  "If
anybody wants to clone my repository, they'd better be prepared to
normalize their EOLs".

Which EOLs the user wants to use obviously can't be a part of the
content, so part is still a configuration variable.

"core.autocrlf" is still available and allows someone working on, say,
git.git from Windows to have CRLFs in their working directory without
requiring any changes to the repository.

For backwards compatibility, "core.autocrlf" overrides "auto-eol" if it
is set, and "core.eolStyle" can be set to "false" to disable conversion
even when "auto-eol" is set. 

For my own part, I'll be implementing this change company-wide shortly.
We have an existing repository with a large body of code that contains a
heady mix of CRLF and LF files, but our newly introduced build system
requires everything to be normalized to CRLF (don't ask).  There's no
sane way of handling this using autocrlf; all developers would have to
know when to set core.autocrlf and remember to set it on every clone, or
even on every checkout.

I hope someone else will find it useful.

Eyvind Bernhardsen (3):
  Add "auto-eol" attribute and "core.eolStyle" config variable
  Add tests for per-repository eol normalization
  Add per-repository eol normalization

 Documentation/config.txt        |   11 ++-
 Documentation/gitattributes.txt |   92 +++++++++++++++++---
 Makefile                        |    3 +
 cache.h                         |   19 ++++
 config.c                        |   16 +++-
 convert.c                       |   48 ++++++++---
 environment.c                   |    1 +
 t/t0025-auto-eol.sh             |  180 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 339 insertions(+), 31 deletions(-)
 create mode 100755 t/t0025-auto-eol.sh
