From: Dana How <danahow@gmail.com>
Subject: [PATCH] pack-objects: clarification & option checks for --max-pack-size
Date: Wed, 23 May 2007 10:11:33 -0700
Message-ID: <465475C5.6000404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 19:11:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HquNE-0003Zm-8r
	for gcvg-git@gmane.org; Wed, 23 May 2007 19:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759412AbXEWRLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 13:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759019AbXEWRLj
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 13:11:39 -0400
Received: from nz-out-0506.google.com ([64.233.162.236]:11530 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758225AbXEWRLi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 13:11:38 -0400
Received: by nz-out-0506.google.com with SMTP id o37so303938nzf
        for <git@vger.kernel.org>; Wed, 23 May 2007 10:11:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=XaD/IeaL7hIdz2RzAFf5p/ss1fCCURI82MlAM9r3CVZQRFaepOlNGRRoECrH2qWv10zE5VMTCvAB4xk7ScLs5otdUMOaMNnYgfv+gcz8FhJAO4oHMzUQmfRaPOLr7o71iZsMQJcsMGF2HaHTC9RQqHnq1c8GsHb9zI9UapG867o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=cr6OoqO0BD8wPpziiJel3XucvQB8tfCTgZPflRt+Nd1VOypPceOI2iAdVea3gSUZ1O5QEAEsWqDfSIAMcYzfZiR3QFqKF9wQjTZ9pc4o2VYaTgR6rQsyLP+w5CRcfLUS5MuNZa3Tmh1wGBfOEATtoltYXTRAAyuqJ70CGzblZrE=
Received: by 10.115.22.1 with SMTP id z1mr403093wai.1179940295961;
        Wed, 23 May 2007 10:11:35 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id m27sm176794pof.2007.05.23.10.11.34;
        Wed, 23 May 2007 10:11:35 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48164>


Explain the special code for detecting a corner-case error,
and complain about --stdout & --max-pack-size being used together.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 19b0aa1..a5bade6 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -679,6 +679,12 @@ static void write_pack_file(void)
 		stop_progress(&progress_state);
 	if (written != nr_result)
 		die("wrote %u objects while expecting %u", written, nr_result);
+	/*
+	 * We have scanned through [0 ... i).  Since we have written
+	 * the correct number of objects,  the remaining [i ... nr_objects)
+	 * items must be either already written (due to out-of-order delta base)
+	 * or a preferred base.  Count those which are neither and complain if any.
+	 */
 	for (j = 0; i < nr_objects; i++) {
 		struct object_entry *e = objects + i;
 		j += !e->offset && !e->preferred_base;
@@ -1852,6 +1858,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name)
 		usage(pack_usage);
 
+	if (pack_to_stdout && pack_size_limit)
+		die("--max-pack-size cannot be used to build a pack for transfer.");
+
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
 
-- 
1.5.2.762.gd8c6-dirty
