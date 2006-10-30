X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/3] Teach git-index-pack how to keep a pack file.
Date: Sun, 29 Oct 2006 22:47:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0610292232440.11384@xanadu.home>
References: <20061029094159.GE3847@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 30 Oct 2006 03:47:34 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061029094159.GE3847@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30483>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeO7J-0004AP-UY for gcvg-git@gmane.org; Mon, 30 Oct
 2006 04:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030504AbWJ3DrK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 22:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbWJ3DrK
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 22:47:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52099 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030504AbWJ3DrJ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 22:47:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7X000M6JUK2V20@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Sun,
 29 Oct 2006 22:47:08 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Sun, 29 Oct 2006, Shawn Pearce wrote:

>  I'm throwing a pair of pipes around index-pack so I can capture
>  the pack name thus allowing receive-pack to delete the correct
>  .keep file after its completed the ref updates.  At that point
>  receive-pack can easily examine the object count in the pack header
>  and compare that against a config entry to decide if it should be
>  keeping the pack or exploding it.

Is it really worth the trouble?  Especially if you've already written 
the pack out, why just not keep it instead of burning more CPU cycles 
exploding it?  The next repack will delete it anyway.

At least for the fetch/pull case here's what I've done so far.  It is 
not complete as the .keep file is not deleted as I'm not clear exactly 
where in git-fetch.sh it can be safely deleted.  But at least it works 
to the point of displaying the name of the file it should consider for 
deletion.

diff --git a/fetch-clone.c b/fetch-clone.c
index 96cdab4..c5747f4 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -81,7 +81,7 @@ int receive_unpack_pack(int xd[2], const
 
 int receive_keep_pack(int xd[2], const char *me, int quiet, int sideband)
 {
-	const char *argv[5] = { "index-pack", "--stdin", "--fix-thin",
+	const char *argv[6] = { "index-pack", "--stdin", "--fix-thin", "--keep",
 				quiet ? NULL : "-v", NULL };
 	return get_pack(xd, me, sideband, argv);
 }
diff --git a/git-fetch.sh b/git-fetch.sh
index 539dff6..dd0c00b 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -378,6 +378,10 @@ fetch_main () {
 	  failed)
 		  echo >&2 "Fetch failure: $remote"
 		  exit 1 ;;
+	  pack)
+		  pack_lockfile="$GIT_OBJECT_DIRECTORY/pack/pack-$remote_name.keep"
+		  [ -e "$pack_lockfile" ] && echo >&2 "$pack_lockfile exists"
+		  continue ;;
 	  esac
 	  found=
 	  single_force=
diff --git a/index-pack.c b/index-pack.c
index b37dd78..8db3c93 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -767,18 +767,6 @@ static void final(const char *final_pack
 		if (err)
 			die("error while closing pack file: %s", strerror(errno));
 		chmod(curr_pack_name, 0444);
-
-		/*
-		 * Let's just mimic git-unpack-objects here and write
-		 * the last part of the buffer to stdout.
-		 */
-		while (input_len) {
-			err = xwrite(1, input_buffer + input_offset, input_len);
-			if (err <= 0)
-				break;
-			input_len -= err;
-			input_offset += err;
-		}
 	}
 
 	if (keep_msg) {
@@ -818,6 +806,27 @@ static void final(const char *final_pack
 		if (move_temp_to_file(curr_index_name, final_index_name))
 			die("cannot store index file");
 	}
+
+	if (!from_stdin) {
+		printf("%s\n", sha1_to_hex(sha1));
+	} else {
+		char buf[48];
+		int len = snprintf(buf, sizeof(buf), "pack\t%s\n",
+				   sha1_to_hex(sha1));
+		xwrite(1, buf, len);
+
+		/*
+		 * Let's just mimic git-unpack-objects here and write
+		 * the last part of the input buffer to stdout.
+		 */
+		while (input_len) {
+			err = xwrite(1, input_buffer + input_offset, input_len);
+			if (err <= 0)
+				break;
+			input_len -= err;
+			input_offset += err;
+		}
+	}
 }
 
 int main(int argc, char **argv)
@@ -921,8 +930,5 @@ int main(int argc, char **argv)
 	free(index_name_buf);
 	free(keep_name_buf);
 
-	if (!from_stdin)
-		printf("%s\n", sha1_to_hex(sha1));
-
 	return 0;
