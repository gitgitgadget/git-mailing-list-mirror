From: Phil Hord <phil.hord@gmail.com>
Subject: [RFC/PATCH] stash: Delete MERGE_RR before stash apply
Date: Thu, 5 Jul 2012 09:48:22 -0400
Message-ID: <CABURp0pNsRQgbf7_iYc-xVaySa9-gGiA++Lw4-WgSCQ4QGCXsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com, tytso@mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 15:49:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmmQy-0008Mq-I0
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 15:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374Ab2GENso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 09:48:44 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:54358 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab2GENsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 09:48:43 -0400
Received: by gglu4 with SMTP id u4so7376631ggl.19
        for <git@vger.kernel.org>; Thu, 05 Jul 2012 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=MoQBFIQG9BNMePzbuRAAH0lX/9foFkXZ3Zv0Qr8n6BU=;
        b=xslkWP9VX5xkSD0eH9mEoOdTCtCYfsJKVOrUlVL8u7fAoptchts3+o68XJTONvEZKU
         hbPI3FRVuiIPqS7FoMp71rTsInGx8Jz+VHU/TMmT+y9Bqt+5vSeViPZGuU8/gIJJQ4gY
         YeLWiILd11IjR4vEGD+vP7wwhKv6GrcfNOfoC57pVjrm0Zy/r4zYi7NEfh9sygmeKR7z
         ZASRZuUOYv/dKSbNGmiPHQtB7WVnZ/LDFajSeQhx+DzrzopvqhEiWODHpmjrabVAOCg5
         Bjn+5zjgEMlL69mkwZzQGp4WFND+5S+eZ+9KhjWaaAFGXDzqbOUFqKyEe6BGEuHRDSHI
         gVgg==
Received: by 10.236.183.168 with SMTP id q28mr19250311yhm.45.1341496122955;
 Thu, 05 Jul 2012 06:48:42 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Thu, 5 Jul 2012 06:48:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201045>

The presence of a GIT_DIR/MERGE_RR file indicates we
were resolving a merge which had rerere candidates for
recording.  But the file does not get deleted after
all resolutions are completed.  This is ok for most
cases because the file will get replaced when the
next merge happens.  But stash apply does not use
a merge that supports rerere, and so the old
MERGE_RR does not get replaced with a current one.

This then confuses mergetool who thinks a rerere
operation is in play when it is not.

Fix this by ensuring there is no leftover
MERGE_RR file whenever we are beginning a git stash
apply.

Signed-off-by: Phil Hord <hordp@cisco.com>
---

This feels like a hack and like it is in the wrong location.
However, the change is minimal and should fix my
specific problem[1].

[1] http://comments.gmane.org/gmane.comp.version-control.git/200178

 git-stash.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index 4e2c7f8..0b96e2f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -409,6 +409,9 @@ apply_stash () {

        assert_stash_like "$@"

+       test -f "$GIT_DIR/MERGE_RR" &&
+               git rerere clear
+
        git update-index -q --refresh || die "$(gettext "unable to
refresh index")"

        # current index state
-- 
1.7.11.1.161.g0f17059.dirty
