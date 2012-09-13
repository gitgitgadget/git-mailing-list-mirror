From: "Devin J. Pohly" <djpohly@gmail.com>
Subject: [PATCH/RFC] remote-helper: allow fetch to discover sha1 later
Date: Thu, 13 Sep 2012 06:10:13 -0400
Message-ID: <1347531013-10371-1-git-send-email-djpohly@gmail.com>
Cc: "Devin J. Pohly" <djpohly@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 12:10:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC6Ni-0008Rn-Pu
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 12:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612Ab2IMKKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 06:10:33 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51962 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab2IMKKa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 06:10:30 -0400
Received: by qaas11 with SMTP id s11so1821155qaa.19
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=VN+HWnd9mcV3U8YpQm6AdN8acKGCPnxFmjjoTzhGOrs=;
        b=i6Fmfx2IvhdzJ4ZH8/EtiKxTG+pacX/jmpItefyOEKVrxo7s+8LNoH5/A778yi6NSY
         CGyxYIbUfKhcaZEqMqKvYAAOaO95kL2CtOsZ+flpyOeCSLmclr+he1u/g6HSHvepNw8r
         4Tsxtuc5bREB+21s5Eacc4Oq/Py48l/hoa8Ku8amt9fjJDIxae1NTVHJb/aJPwShwcUM
         HDre0071ZLFvOi/6orxg01EO3TlSTE7YJ5izgGIr3JhXdkR5ch6ygUOggvWZst95xc6X
         tHuNO9e3odiOOjPZzbvWyr0JHvJlL6aYoDF0eArdn9PfHAxL0r3DWekxjfUEyEAmKpDR
         S5vg==
Received: by 10.224.197.10 with SMTP id ei10mr4479122qab.49.1347531029427;
        Thu, 13 Sep 2012 03:10:29 -0700 (PDT)
Received: from meru.cse.psu.edu (c-71-58-66-108.hsd1.pa.comcast.net. [71.58.66.108])
        by mx.google.com with ESMTPS id r6sm6772277qaa.10.2012.09.13.03.10.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Sep 2012 03:10:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205362>

From: "Devin J. Pohly" <djpohly@gmail.com>

Allow a fetch-style remote helper to issue the notification
  ref <sha1> <name>
to specify a ref's value during the fetch operation.

Currently, a remote helper with the "fetch" capability cannot fetch a
ref unless its sha1 was known when the "list" command was executed.
This limitation is arbitrary, as the helper may eventually be able to
determine the correct sha1 as it fetches objects.

Signed-off-by: Devin J. Pohly <djpohly@gmail.com>
---

Soliciting general opinions - first git patch. :)

The fetch command can be a lot more convenient than import if you're working
with a remote that doesn't give you a commit and the associated objects at the
same time.  And there's no apparent reason that something like this isn't
possible.

How it works: the old_sha1 field is currently set when the output from "list"
is parsed, then not used again until after the "fetch" command completes, just
before updating refs.  Changing it during the fetch only affects the final
value of the ref.  (Forgetting to resolve a ref will result in exactly the
same behavior as before: an error from check_everything_connected.)

Not sure if either or both of the warning()s should be a die() instead.


 Documentation/git-remote-helpers.txt |  8 ++++++--
 transport-helper.c                   | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index f5836e4..fb4240f 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -229,8 +229,12 @@ Supported if the helper has the "option" capability.
 	to the database.  Fetch commands are sent in a batch, one
 	per line, terminated with a blank line.
 	Outputs a single blank line when all fetch commands in the
-	same batch are complete. Only objects which were reported
-	in the ref list with a sha1 may be fetched this way.
+	same batch are complete.
++
+If the named ref was reported in the ref list without a sha1, must
+output a 'ref <sha1> <name>' line once the sha1 is known.  This is
+also required for a symref if its target did not have a sha1 in the
+list.
 +
 Optionally may output a 'lock <file>' line indicating a file under
 GIT_DIR/objects/pack which is keeping a pack until refs can be
diff --git a/transport-helper.c b/transport-helper.c
index cfe0988..6fce419 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -363,6 +363,30 @@ static int fetch_with_fetch(struct transport *transport,
 				warning("%s also locked %s", data->name, name);
 			else
 				transport->pack_lockfile = xstrdup(name);
+		} else if (!prefixcmp(buf.buf, "ref ")) {
+			const char *rest = buf.buf + 4;
+			char *eov, *eon;
+			struct ref *posn;
+
+			eov = strchr(rest, ' ');
+			if (!eov)
+				die("Malformed ref command: %s", buf.buf);
+			eon = strchr(eov + 1, ' ');
+			*eov = '\0';
+			if (eon)
+				*eon = '\0';
+			for (i = 0; i < nr_heads; i++) {
+				posn = to_fetch[i];
+				if (!strcmp(eov + 1, posn->name))
+					break;
+			}
+			if (i == nr_heads || (posn->status & REF_STATUS_UPTODATE)) {
+				warning("Ref %s is not being fetched", eov + 1);
+				continue;
+			}
+			if (!is_null_sha1(posn->old_sha1))
+				warning("Ref %s is being overwritten", eov + 1);
+			get_sha1_hex(rest, posn->old_sha1);
 		}
 		else if (!buf.len)
 			break;
-- 
1.7.12
