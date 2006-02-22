From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] nicer eye candies for pack-objects
Date: Wed, 22 Feb 2006 14:27:00 -0800
Message-ID: <7vy803kp1n.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602221549250.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 23:27:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC2Rv-0008T5-7K
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 23:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWBVW1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 17:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWBVW1E
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 17:27:04 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61069 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751558AbWBVW1B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 17:27:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222222426.LTZL17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 17:24:26 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602221549250.5606@localhost.localdomain> (Nicolas
	Pitre's message of "Wed, 22 Feb 2006 16:00:08 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16619>

I like this, but like the "every second or every percent
whichever comes first" unpack-objects does even better.  How
about something like this on top of your patch?

---
diff --git a/pack-objects.c b/pack-objects.c
index 5e1e14c..d05ab23 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -674,10 +674,14 @@ static void find_deltas(struct object_en
 	int i, idx;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array = xmalloc(array_size);
+	unsigned processed = 0;
+	unsigned last_percent = 999;
 
 	memset(array, 0, array_size);
 	i = nr_objects;
 	idx = 0;
+	if (progress)
+		fprintf(stderr, "Deltifying %d objects.\n", nr_objects);
 
 	while (--i >= 0) {
 		struct object_entry *entry = list[i];
@@ -686,10 +690,15 @@ static void find_deltas(struct object_en
 		char type[10];
 		int j;
 
-		if (progress_update || i == 0) {
-			fprintf(stderr, "Deltifying (%d %d%%)\r",
-				nr_objects-i, (nr_objects-i) * 100/nr_objects);
-			progress_update = 0;
+		processed++;
+		if (progress) {
+			unsigned percent = processed * 100 / nr_objects;
+			if (percent != last_percent || progress_update) {
+				fprintf(stderr, "%4u%% (%u/%u) done\r",
+					percent, processed, nr_objects);
+				progress_update = 0;
+				last_percent = percent;
+			}
 		}
 
 		if (entry->delta)
