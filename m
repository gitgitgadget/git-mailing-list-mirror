From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 0/7] Flags and config to sign pushes by default
Date: Thu, 13 Aug 2015 15:00:44 -0400
Message-ID: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 21:01:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxkh-0003Kw-Sp
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbbHMTA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:00:57 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36006 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbbHMTA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:00:56 -0400
Received: by igxp17 with SMTP id p17so27217161igx.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Dha4krB441oxyQNJrVpBNom5wPSIHn5muGFblri3VI0=;
        b=SnzC5DXQIAG29nL14zgzTt0wWQzhCzZOXOKKpycy3BRK2HYBnl0Jb6WUVm9Ngg+4/x
         TShVpS2CBhg4XX8/2mU8ljZdbLYAB6rXW9xWikF8s6E4yfxYmrrytDhURix+19TgIQrR
         a4Bzl8+IcgHROI7Wk8WUPBkEzjCzq/LjUV8cjsDFcfrQaygK6Ksr0tmODbRNZQ0ED+T4
         qAkQ/t1hNhkc5Ch8Zuqt4TJwU4xfnJp8QGUWlct2Pi8M/ln/TEj+ujCHtIQgajy4vCpQ
         c0l4s1r2amZc+nMHtykNCEOJB2cMMxyaUBb0PanrM0qazIChstST6lB0LRkGsvNkbwT4
         CwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dha4krB441oxyQNJrVpBNom5wPSIHn5muGFblri3VI0=;
        b=T7BmYb/hYkDIbh/ZdDHGNEoLZY7uuHiPDxomgP+jEzIRI0Mm2x0UBn8TSpTGZbDvlh
         qffB0PoyMyqdvaMs4Ln2LDPtHNJ89+ndchQwNUqg9p0FOHir3GILtxVuNrrdJXhbs704
         0HE8NVBT1QkBWWyFICzRK3lyXsNysatSkmP7xufOIZh9XPa2Bt61GJIK/R+p2vZlpu87
         ZNJz7axs4a2HNxMlam71UM85POcRubNBo/c4vK1izs2AEu5Ir/Kdh6fijT8Pu3LVYnrD
         X0ElCL+qP9ITS5BNmqPrZU4/f7E5YSlQGqdAMPtxFiD9eZcgpeRrh2x7OX5MDNIpDWur
         /xKQ==
X-Gm-Message-State: ALoCoQmla2quvm1N5DnjdX8k8Zmv1Hz9aoi+9iyCD9en/vP8R5e6xWhIuKPuXnMjje0ERSXHMGCu
X-Received: by 10.50.79.129 with SMTP id j1mr4415466igx.16.1439492455459;
        Thu, 13 Aug 2015 12:00:55 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id c91sm2078646ioj.43.2015.08.13.12.00.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 12:00:54 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275881>

Remembering to pass --signed to git push on every push is extra typing that is
easy to forget, and just leads to annoyance if the remote has a hook that makes
signed pushes required. Add a config option push.gpgSign, analogous to
commit.gpgSign, allowing users to set this flag by default.

Since --signed push will simply fail on any remote that does not advertise a
push cert nonce, actually setting this to true is not very useful (except for
the super-paranoid who would never want to push to a server that does not
support signed pushes). So, add a third state to this boolean, "if-possible",
to sign the push if and only if supported by the server. To keep parity between
the config and command line options, add a --signed-if-possible flag to git
push as well.

The "if-possible" name and weird tri-state boolean is basically a straw man,
and I am happy to change if someone has a clearer suggestion.

Dave Borowitz (7):
  Documentation/git-push.txt: Document when --signed may fail
  Documentation/git-send-pack.txt: Flow long synopsis line
  Documentation/git-send-pack.txt: Document --signed
  gitremote-helpers.txt: Document pushcert option
  transport: Remove git_transport_options.push_cert
  Support signing pushes iff the server supports it
  Add a config option push.gpgSign for default signed pushes

 Documentation/config.txt            |  8 ++++++++
 Documentation/git-push.txt          | 11 +++++++++--
 Documentation/git-send-pack.txt     | 17 ++++++++++++++++-
 Documentation/gitremote-helpers.txt |  3 +++
 builtin/push.c                      | 26 +++++++++++++++++++++++++-
 builtin/send-pack.c                 | 33 +++++++++++++++++++++++++++++++--
 remote-curl.c                       | 14 ++++++++++----
 send-pack.c                         | 18 +++++++++++++++---
 send-pack.h                         |  8 +++++++-
 transport-helper.c                  | 34 +++++++++++++++++-----------------
 transport.c                         | 11 +++++++----
 transport.h                         |  6 +++---
 12 files changed, 151 insertions(+), 38 deletions(-)

-- 
2.5.0.276.gf5e568e
