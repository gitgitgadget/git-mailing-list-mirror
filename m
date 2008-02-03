From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 0 of 7] - Improve handling remotes, origin, and submodules
Date: Sun,  3 Feb 2008 12:20:42 -0500
Message-ID: <1202059249-3532-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Sun Feb 03 18:21:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLiX5-0005uj-71
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758098AbYBCRU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757833AbYBCRU6
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:20:58 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:26412 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbYBCRU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:20:57 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1624551fkz.5
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=WuQr0Oy+v9vn+MWlL6odHBRz6b8Qqxqo0eYOEL/V6BY=;
        b=FUWmPeNPFQfe5ELni6ysGTU7Zqyj+Fr+MQCAMiGF6SCumEvEX5CvQosAZRK03/EfGiHeEOFmnvbBH+NhDe/IR06d/nlIALWhRwhoP71S+e9kA6ngWOe128BaV/elks9C4ohglcHpb7N9Dw0HbxEaZYLtfhHuHZmidFt3o8loQj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=apQe0aSTsF9CJLINPRuZ7W/vbm0GGw+Kw2fDF7mJooRJo91QaoyB5FkIqiKODOuboyjxN1jAdsxANPRL3LHNKjrq8daKdLaVWrWK1MbZoQ3xxehwroatKg/gJO76F6ERl+pHzN/kp4awTckdOUScloshPoq7bv28/rjAP9egLHk=
Received: by 10.78.186.9 with SMTP id j9mr10578628huf.24.1202059255161;
        Sun, 03 Feb 2008 09:20:55 -0800 (PST)
Received: from localhost.localdomain ( [71.191.242.88])
        by mx.google.com with ESMTPS id x6sm4293526gvf.0.2008.02.03.09.20.52
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:20:53 -0800 (PST)
X-Mailer: git-send-email 1.5.4.18.g43c18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72369>

This patch series was inspired by several issues dealing with
multiple remotes and submodules. The tests added as the last
patch demonstrate the specific use pattern to be supported,
and that does not work currently.

1 - user A creates a project on server "frotz" with a submodule.
2 - user B clones the project, forks it, adds a submodule, and
publishes the fork on server "fork"

user A adds the fork to his working tree, via git remote add +
git fetch. The desire is that:
1 - git submodule init + git submodule update include the new
submdule added in the fork.
2 - The top-level project and all submodules use the same
remote nickname to refer to the same server.

Breakage in 1.5.4 without this patch series is in several places:

1 - git submodule does not follow the top-level project's
branch.<name>.remote in fetching, so does not try to clone
the new submodule from remoe "fork" where the fork exists.
2 - If 1 were fixed, git submodule still invokes clone without "-o
<remotenick>" when cloning, so each submodule would have "origin"
point to a different remote.
3 - If 2 were fixed, submodule update leaves submodules on detached
heads, so the remotes machinery cannot supply a remote name, and thus
"origin" is used for further updates. As origin may not be defined,
(e.g., for the submodule fetched from "fork" this also fails.)

The underlying design issue is the assumption that all projects
revolve around a single server, so that *the* server can be called
"origin" without confusion.  Given a project with multiple servers and
no one server being *the* server, origin cannot be usefully defined.
Absent submodules, the remotes machinery largely masks this: origin is
referred to only as the default remote and it is easy to avoid using
the default remote.  With submodules, this becomes more of an issue.

Following this patch series, the following is true:

1) The existing workflow of top-level and all sub-modules always
cloned from and interacting with a single default remote
nick-named "origin" is unchanged.
2) Via clone -o <nick> (or git confit core.origin <nick>), the
default remote is changed from origin to <nick>, and that default
is used instead of origin everywhere.
3) git-submodule uses the top-level's branch.<name>.remote to
choose which remote to fetch from, uses that in all submodules,
including defining that in existing submodules whose url is
relative (../* or ./*) indicating the submodule is maintained on
same server as top-level.

The penultimate patch addresses a basic usability issue, allowing
addition of a submodule in place in a project, rather than requiring
it be cloned from a remote.  This hole in the porcelain became evident
in creating a test (t7401) for this series.
submodules except by cloning).
