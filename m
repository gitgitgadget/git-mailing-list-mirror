X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Teach receive-pack how to keep pack files based on
 object count.
Date: Tue, 31 Oct 2006 16:08:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0610311559150.11384@xanadu.home>
References: <20061031075704.GB7691@spearce.org>
 <Pine.LNX.4.64.0610311447250.11384@xanadu.home>
 <20061031201148.GD23671@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 31 Oct 2006 21:08:47 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061031201148.GD23671@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30597>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf0qb-0002wv-59 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 22:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423644AbWJaVId (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 16:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423645AbWJaVId
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 16:08:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8888 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1423644AbWJaVId
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 16:08:33 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8000D7VQQ82B10@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Tue,
 31 Oct 2006 16:08:32 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Tue, 31 Oct 2006, Shawn Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > I think this should be solved before rx packs are actually stored as 
> > packs though.  Otherwise people will end up with unwanted .keep files 
> > left around.  Maybe having a much bigger default for object number 
> > treshold for the time being?  (unless this patch is applied to "next" at 
> > the same time as another one that actually deals with those .keep 
> > files).
> 
> Its next on my list of things to do.  Hopefully I'll be able to
> implement it today.
> 
> I'm thinking of just brute forcing it: put enough identifying data
> into the .keep file to make it unique, then go through every local
> pack and look at their .keep file; if the content matches what
> receive-pack asked index-pack to put there then remove it.

Ouch.  What about the patch below?  It covers only the pull/fetch case, 
but covering the push case shouldn't be that hard either (simply use a 
pipe to read index-pack's stdout and capture the pack name).

I used "pack" <tab> <sha1> so it is easy to pick out of the list of refs 
that usually comes over the stream in the fetch case (if I understood 
that part right).

diff --git a/fetch-clone.c b/fetch-clone.c
index f629d8d..579307d 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -81,7 +81,18 @@ int receive_unpack_pack(int xd[2], const
 
 int receive_keep_pack(int xd[2], const char *me, int quiet, int sideband)
 {
-	const char *argv[5] = { "index-pack", "--stdin", "--fix-thin",
-				quiet ? NULL : "-v", NULL };
+	const char *argv[6];
+	char my_host[255], keep_arg[128 + 255];
+
+	if (gethostname(my_host, sizeof(my_host)))
+		strcpy(my_host, "localhost");
+	snprintf(keep_arg, sizeof(keep_arg), "--keep=fetch-pack %i on %s",
+		 getpid(), my_host);
+	argv[0] = "index-pack";
+	argv[1] = "--stdin";
+	argv[2] = "--fix-thin";
+	argv[3] = keep_arg;
+	argv[4] = quiet ? NULL : "-v";
+	argv[5] = NULL;
 	return get_pack(xd, me, sideband, argv);
 }
diff --git a/git-fetch.sh b/git-fetch.sh
index 539dff6..366014d 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -368,6 +368,7 @@ fetch_main () {
       ;; # we are already done.
   *)
     ( : subshell because we muck with IFS
+      pack_lockfile=
       IFS=" 	$LF"
       (
 	  git-fetch-pack $exec $keep "$remote" $rref || echo failed "$remote"
@@ -378,6 +379,10 @@ fetch_main () {
 	  failed)
 		  echo >&2 "Fetch failure: $remote"
 		  exit 1 ;;
+	  pack)
+		  # special line coming from index-pack with the pack name
+		  pack_lockfile="$GIT_OBJECT_DIRECTORY/pack/pack-$remote_name.keep"
+		  continue ;;
 	  esac
 	  found=
 	  single_force=
@@ -408,6 +413,7 @@ fetch_main () {
 	  append_fetch_head "$sha1" "$remote" \
 		  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
       done
+      [ "$pack_lockfile" ] && rm -f "$pack_lockfile"
     ) || exit ;;
   esac
 
diff --git a/index-pack.c b/index-pack.c
index a3b55f9..c8f66da 100644
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
@@ -934,8 +943,5 @@ int main(int argc, char **argv)
 	free(index_name_buf);
 	free(keep_name_buf);
 
-	if (!from_stdin)
-		printf("%s\n", sha1_to_hex(sha1));
-
 	return 0;
