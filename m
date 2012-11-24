From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] fast-export: Allow pruned-references in mark file
Date: Sat, 24 Nov 2012 10:47:12 +0100
Message-ID: <1353750432-17373-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 10:47:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcCL1-0004xI-33
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 10:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206Ab2KXJre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2012 04:47:34 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63799 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030181Ab2KXJrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2012 04:47:33 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so1059038wgb.1
        for <git@vger.kernel.org>; Sat, 24 Nov 2012 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=LwBsHdf/SkMwkZRcIXeYQ5EdXkt5yVQtKtuDk07t9Ys=;
        b=Bfqf93SzDuHECGWqXquLC8/NVMihWCoZulHaCMLzRojqTOIZ0oBJLYCSl2T0XI92Hf
         Um0TY7k2i25oV9JjGwrXdICfA+okp1cRUjncomKFROoillW/kUhr5EWsvl7V+gUYhfga
         Zyaox9v4Cm0fhh2kU4G1PZvooXiKlrODnNhGJY0uhV65mx6O9wglwfg80C6NesLMYUgq
         7CNQdJ2XA086SNjFwHVrtjKj4PVuNSaCbW/H6Ygy6rZFMUlFySiY9g845xFO9YuntRGb
         L7wEgrcFqOEhRyomdpiOrmkW8msAvduvmlcL+JEPAbMDF3Qq5AsBjHgxLfRgIcb67ksZ
         k1ww==
Received: by 10.180.81.170 with SMTP id b10mr9322952wiy.16.1353750451825;
        Sat, 24 Nov 2012 01:47:31 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id gk9sm11939648wib.4.2012.11.24.01.47.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Nov 2012 01:47:31 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210317>

fast-export can fail because of some pruned-reference when importing a
mark file.

The problem happens in the following scenario:

    $ git fast-export --export-marks=MARKS master
    (rewrite master)
    $ git prune
    $ git fast-export --import-marks=MARKS master

This might fail if some references have been removed by prune
because some marks will refer to non-existing commits.

Let's warn when we have a mark for a commit we don't know.
Also, increment the last_idnum before, so we don't override
the mark.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 builtin/fast-export.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 12220ad..141b245 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -607,16 +607,19 @@ static void import_marks(char *input_file)
 			|| *mark_end != ' ' || get_sha1(mark_end + 1, sha1))
 			die("corrupt mark line: %s", line);
 
+		if (last_idnum < mark)
+			last_idnum = mark;
+
 		object = parse_object(sha1);
-		if (!object)
-			die ("Could not read blob %s", sha1_to_hex(sha1));
+		if (!object) {
+			warning("Could not read blob %s", sha1_to_hex(sha1));
+			continue;
+		}
 
 		if (object->flags & SHOWN)
 			error("Object %s already has a mark", sha1_to_hex(sha1));
 
 		mark_object(object, mark);
-		if (last_idnum < mark)
-			last_idnum = mark;
 
 		object->flags |= SHOWN;
 	}
-- 
1.7.9.5
