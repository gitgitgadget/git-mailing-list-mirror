From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 15:55:43 -0800
Message-ID: <7vfym88g74.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
	<7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602241029360.23719@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 00:55:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCmmr-0002ST-DX
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 00:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWBXXzq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 18:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWBXXzq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 18:55:46 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11666 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964805AbWBXXzp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 18:55:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224235428.TNEU15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Feb 2006 18:54:28 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602241029360.23719@localhost.localdomain>
	(Nicolas Pitre's message of "Fri, 24 Feb 2006 10:37:46 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16748>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 24 Feb 2006, Junio C Hamano wrote:
>
>> In Linux 2.6 repository, these object pairs take forever to
>> delta.
>> 
>>         blob 9af06ba723df75fed49f7ccae5b6c9c34bc5115f -> 
>>         blob dfc9cd58dc065d17030d875d3fea6e7862ede143
>>         size (491102 -> 496045)
>>         58 seconds
>> 
>>         blob 4917ec509720a42846d513addc11cbd25e0e3c4f -> 
>>         blob dfc9cd58dc065d17030d875d3fea6e7862ede143
>>         size (495831 -> 496045)
>>         64 seconds
>
> Thanks for this.  I'll see what I can do to tweak the code to better 
> cope with those.  Just keep my fourth delta patch in the pu branch for 
> now.

If apply this on top of pack-objects.c, you can find more of
them yourself.

---
diff --git a/pack-objects.c b/pack-objects.c
index be7a200..3f88e86 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -62,6 +62,7 @@ static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
 static volatile int progress_update = 0;
+static volatile int progress_update_cnt = 0;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -826,6 +827,7 @@ static int try_delta(struct unpacked *cu
 	struct object_entry *old_entry = old->entry;
 	int old_preferred = (old_entry->preferred_base ||
 			     old_entry->based_on_preferred);
+	int last_up;
 	unsigned long size, oldsize, delta_size, sizediff;
 	long max_size;
 	void *delta_buf;
@@ -890,8 +892,17 @@ static int try_delta(struct unpacked *cu
 	}
 	if (sizediff >= max_size)
 		return -1;
+	last_up = progress_update_cnt;
 	delta_buf = diff_delta(old->data, oldsize,
 			       cur->data, size, &delta_size, max_size);
+	if (last_up + 1 < progress_update_cnt) {
+		/* It took more than one second */
+		fprintf(stderr, "%d -> %d: %s -> ",
+			last_up, progress_update_cnt,
+			sha1_to_hex(old_entry->sha1));
+		fprintf(stderr, "%s (%lu -> %lu)\n",
+			sha1_to_hex(cur_entry->sha1), oldsize, size);
+	}
 	if (!delta_buf)
 		return 0;
 	cur_entry->delta = old_entry;
@@ -906,6 +917,7 @@ static void progress_interval(int signum
 {
 	signal(SIGALRM, progress_interval);
 	progress_update = 1;
+	progress_update_cnt++;
 }
 
 static void find_deltas(struct object_entry **list, int window, int depth)
