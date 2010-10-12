From: Chase Brammer <cbrammer@gmail.com>
Subject: [PATCH] Fix to push --progress. The --progress flag was not being
 passed into tranport.c from send-pack.h, making the --progress flag unusable
Date: Tue, 12 Oct 2010 16:21:20 -0600
Message-ID: <AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 13 00:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5nDs-0005Ki-Lz
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 00:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab0JLWVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 18:21:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49359 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab0JLWVW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 18:21:22 -0400
Received: by wyb28 with SMTP id 28so486658wyb.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 15:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=lxp6KJIqsqyd0iAsEwRLZ2TSBe71Z8wjL3HcII92zEQ=;
        b=erQUXm2YGGK671Sd4VOXW6AwE3Jn3vUBZB9EFtZqnVNrFuW5GEumqdgDl1nbDo1Rnz
         ZRFijCFgzXe/Cic5D6efoB2K1nNRTyKB7vSEPGncKv8r1QKqsIyCLfOPEYb4as5J3VHz
         T7P0wro9DDWPl7K4lbjK5cm3AQEQB7q6TX6HE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Rr7L2FYw59n0HpfFNk1Yi6SY1OUVSK7p1jJNTqw720gopMtOq/NHD/wJ2OPzPJK2UD
         83gtUnvTk5AfddlTHgs13YC6HGZc8LJ76P8MTEbOWYfOs5vi4yLxktdJYrzLyhpt69LK
         Jcifpp5klYeAI6putKMUADBlhgGZbMjTjCCx0=
Received: by 10.216.138.65 with SMTP id z43mr106334wei.12.1286922080912; Tue,
 12 Oct 2010 15:21:20 -0700 (PDT)
Received: by 10.216.29.195 with HTTP; Tue, 12 Oct 2010 15:21:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158885>

The result of this is external tools and tools writing standard error
to a file from bash would not be able to receive progress information
during a push.  Similar functionality is seen in fetch, which still
works.

An example that previously would output no information for --progress:
git push origin master --progress > ~/push_error_output.txt 2>&1

The above example and others now work with this patch.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Chase Brammer <cbrammer@gmail.com>
---
 builtin/send-pack.c |    3 +++
 send-pack.h         |    1 +
 transport.c         |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..efd9be6 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -48,6 +48,7 @@ static int pack_objects(int fd, struct ref *refs,
struct extra_have_objects *ext
 		NULL,
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po;
 	int i;
@@ -59,6 +60,8 @@ static int pack_objects(int fd, struct ref *refs,
struct extra_have_objects *ext
 		argv[i++] = "--delta-base-offset";
 	if (args->quiet)
 		argv[i++] = "-q";
+	if (args->progress)
+		argv[i++] = "--progress";
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
diff --git a/send-pack.h b/send-pack.h
index 60b4ba6..fcf4707 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -4,6 +4,7 @@
 struct send_pack_args {
 	unsigned verbose:1,
 		quiet:1,
+		progress:1,
 		porcelain:1,
 		send_mirror:1,
 		force_update:1,
diff --git a/transport.c b/transport.c
index 4dba6f8..0078660 100644
--- a/transport.c
+++ b/transport.c
@@ -789,6 +789,7 @@ static int git_transport_push(struct transport
*transport, struct ref *remote_re
 	args.use_thin_pack = data->options.thin;
 	args.verbose = (transport->verbose > 0);
 	args.quiet = (transport->verbose < 0);
+	args.progress = transport->progress;
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);

-- 
1.7.3.1
