From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/7] Reject non-ff pulls by default
Date: Sat, 12 Oct 2013 02:01:56 -0500
Message-ID: <1381561322-20059-2-git-send-email-felipe.contreras@gmail.com>
References: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:08:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtJ9-0002B3-5L
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab3JLHII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:08:08 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:52657 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab3JLHIH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:08:07 -0400
Received: by mail-ob0-f177.google.com with SMTP id wm4so3391003obc.8
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=68OISSu/3w+52LuGx5tQQ3bfo8VRZZZQzVIC8GQ1Pys=;
        b=E5f4dYSSRPyMec6XTDCKxFuZ/OvhuV1RMdDeclWdBAgXqLa4ZeTSa7c89zPomUMQ+I
         JODS6zc6clIkDzzpIWVBtb/apgqruIXcVQBAsz0f+Z95pqNOeO7ft2mkP+/6zmTQKRGu
         t+DogZ2Yh4H3jsLO+0me9zF8owIUNPwoSQg9DrYCkmM8zneVGt3Vzw9TCLmwpEfuI9Dr
         a97V+/bDMPPwerea+zOG6Z4erewMPWbcbI03awCr4+JSL1vDJ2+MsEe/iYGOHEqWRiKL
         fZAceVkPT9GVfNdq/CWVKA8C3h9JKAKm33b/dnnnfbJ9n8j0uD8dienb5LgROg3qaZzr
         uRrw==
X-Received: by 10.182.75.201 with SMTP id e9mr17836216obw.28.1381561686441;
        Sat, 12 Oct 2013 00:08:06 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm28654990obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:08:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235949>

Minor changes since v3.

Junio already sent a similar patch, but I think this is simpler.

It is very typical for Git newcomers to inadvertently create merges and worst:
inadvertently pushing them. This is one of the reasons many experienced users
prefer to avoid 'git pull', and recommend newcomers to avoid it as well.

To avoid these problems and keep 'git pull' useful, it has been suggested
that 'git pull' barfs by default if the merge is non-fast-forward, which
unfortunately would break backwards compatibility.

This patch series leaves everything in place to enable this new mode, but it
only gets enabled if the user specifically configures it; pull.mode =
merge-ff-only.

Later on this mode can be enabled by default (e.g. in v2.0).

To achieve that first some configurations are renamed: for example: pull.rebase
=> pull.mode = rebase, but the old ones remain functional, thus there are no
functional changes.

Then the new mode 'merge-ff-only' is added, but not enabled by default, and
finally, a warning is added so the users will know what to do when the new
mode is indeed enabled by default.

Diff from last version:

--- a/git-pull.sh
+++ b/git-pull.sh
@@ -293,12 +293,13 @@ case "$merge_head" in
        then
                case "$mode" in
                merge-ff-only)
-                       die "The pull was not fast-forward, please either merge or rebase."
+                       die "$(gettext "The pull was not fast-forward, please either merge or rebase.
+If unsure, run 'git pull --merge'.")"
                        ;;
                default)
-                       say "The pull was not fast-forward, in the future you would have to choose
+                       echo "$(gettext "warning: the pull was not fast-forward, in the future you would have to choose
 a merge or a rebase, falling back to old style for now (git pull --merge).
-Read 'git pull --help' for more information."
+Read 'git pull --help' for more information.")" >&2
                        ;;
                esac
        fi

Felipe Contreras (7):
  pull: rename pull.rename to pull.mode
  pull: refactor $rebase variable into $mode
  pull: add --merge option
  pull: add merge-ff-only option
  pull: add warning on non-ff merges
  pull: cleanup documentation
  pull: add documentation about non-ff merges

 Documentation/config.txt   | 24 +++++++++--------
 Documentation/git-pull.txt | 32 +++++++++++++++++++----
 branch.c                   |  4 +--
 git-pull.sh                | 64 +++++++++++++++++++++++++++++++++++++---------
 t/t3200-branch.sh          | 40 ++++++++++++++---------------
 t/t5520-pull.sh            | 62 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5601-clone.sh           |  4 +--
 7 files changed, 178 insertions(+), 52 deletions(-)

-- 
1.8.4-fc
