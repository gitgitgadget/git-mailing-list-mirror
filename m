From: Junio C Hamano <junkio@cox.net>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 13:27:44 -0800
Message-ID: <7vodp52qzz.fsf@assigned-by-dhcp.cox.net>
References: <20070111125726.GJ1759@mellanox.co.il>
	<Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
	<Pine.LNX.4.64.0701111109070.3594@woody.osdl.org>
	<45A6A97F.5080008@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 22:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H57Sw-0006zY-F7
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 22:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbXAKV2D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 16:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXAKV2D
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 16:28:03 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:36969 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbXAKV2B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 16:28:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111212800.NYUO18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 16:28:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9xT91W00A1kojtg0000000; Thu, 11 Jan 2007 16:27:09 -0500
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <45A6A97F.5080008@shadowen.org> (Andy Whitcroft's message of
	"Thu, 11 Jan 2007 21:17:51 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36612>

Andy Whitcroft <apw@shadowen.org> writes:

> The call was intended to replace a common idiom:
>
> if (xwrite(fd, buf, size) != size)
> 	error
>
> write_in_full() is intended as a drop in replacement for that.  On a
> short write we will return a short count and that will fail such a test.
> The call basically implements the standard write() call semantic with
> maximum attempts to complete.

You are both right ;-).  I would have these fixups on top of
Linus's.

---

diff --git a/config.c b/config.c
index 2cd0263..733fb1a 100644
--- a/config.c
+++ b/config.c
@@ -694,11 +694,9 @@ int git_config_set_multivar(const char* key, const char* value,
 
 		store.key = (char*)key;
 		if (!store_write_section(fd, key) ||
-		    !store_write_pair(fd, key, value)) {
-			ret = write_error();
-			goto out_free;
-		}
-	} else{
+		    !store_write_pair(fd, key, value))
+			goto write_err_out;
+	} else {
 		struct stat st;
 		char* contents;
 		int i, copy_begin, copy_end, new_line = 0;
@@ -777,31 +775,33 @@ int git_config_set_multivar(const char* key, const char* value,
 
 			/* write the first part of the config */
 			if (copy_end > copy_begin) {
-				write_in_full(fd, contents + copy_begin,
-				copy_end - copy_begin);
-				if (new_line)
-					write_in_full(fd, "\n", 1);
+				if (write_in_full(fd, contents + copy_begin,
+						  copy_end - copy_begin) <
+				    copy_end - copy_begin)
+					goto write_err_out;
+				if (new_line &&
+				    write_in_full(fd, "\n", 1) != 1)
+					goto write_err_out;
 			}
 			copy_begin = store.offset[i];
 		}
 
 		/* write the pair (value == NULL means unset) */
 		if (value != NULL) {
-			if (store.state == START)
-				if (!store_write_section(fd, key)) {
-					ret = write_error();
-					goto out_free;
-				}
-			if (!store_write_pair(fd, key, value)) {
-				ret = write_error();
-				goto out_free;
+			if (store.state == START) {
+				if (!store_write_section(fd, key))
+					goto write_err_out;
 			}
+			if (!store_write_pair(fd, key, value))
+				goto write_err_out;
 		}
 
 		/* write the rest of the config */
 		if (copy_begin < st.st_size)
-			write_in_full(fd, contents + copy_begin,
-				st.st_size - copy_begin);
+			if (write_in_full(fd, contents + copy_begin,
+					  st.st_size - copy_begin) <
+			    st.st_size - copy_begin)
+				goto write_err_out;
 
 		munmap(contents, st.st_size);
 		unlink(config_filename);
@@ -824,6 +824,11 @@ out_free:
 		free(lock_file);
 	}
 	return ret;
+
+write_err_out:
+	ret = write_error();
+	goto out_free;
+
 }
 
 int git_config_rename_section(const char *old_name, const char *new_name)
diff --git a/index-pack.c b/index-pack.c
index 8d10d6b..72e0962 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -814,7 +814,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		char buf[48];
 		int len = snprintf(buf, sizeof(buf), "%s\t%s\n",
 				   report, sha1_to_hex(sha1));
-		write_in_full(1, buf, len);
+		write_or_die(1, buf, len);
 
 		/*
 		 * Let's just mimic git-unpack-objects here and write
