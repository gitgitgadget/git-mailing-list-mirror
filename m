From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] multi_ack protocol v2
Date: Thu, 27 Oct 2005 20:04:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510272003060.22251@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmov4elu.fsf@assigned-by-dhcp.cox.net> <20051027141619.0e8029f2.vsu@altlinux.ru>
 <Pine.LNX.4.63.0510271227490.2724@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwtjy3lch.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergey Vlasov <vsu@altlinux.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 20:05:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVC7A-0006VT-OF
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 20:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVJ0SEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 14:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVJ0SEd
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 14:04:33 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:10646 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751391AbVJ0SEc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 14:04:32 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1712713F273; Thu, 27 Oct 2005 20:04:31 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 000A7B4ED8; Thu, 27 Oct 2005 20:04:30 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CF0E4B4EC4; Thu, 27 Oct 2005 20:04:30 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AF34E13F301; Thu, 27 Oct 2005 20:04:30 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtjy3lch.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10722>

Hi,

On Thu, 27 Oct 2005, Junio C Hamano wrote:

> Another thing that would probably be helpful is to redo
> get_remote_heads() slightly differently, so that it can return
> information on *all* refs the other end has.  We need to extend
> "struct ref" to mark which one was actually matched/ignored by
> path_match() and ignore_funny.  An completely untested patch is
> attached, based on fetch-pack that still runs rev-list as an
> external process, to outline the idea.

A completely tested patch (unfortunately in the middle of my work) does 
not touch get_remote_heads() at all:

diff --git a/fetch-pack.c b/fetch-pack.c
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -274,7 +290,27 @@ static void mark_recent_complete_commits
 	}
 }
 
-static int everything_local(struct ref *refs)
+static void filter_refs(struct ref **refs, int nr_match, char **match)
+{
+	struct ref *prev, *current, *next;
+
+	if (!nr_match)
+		return;
+
+	for (prev = NULL, current = *refs; current; current = next) {
+		next = current->next;
+		if (!path_match(current->name, nr_match, match)) {
+			if (prev == NULL)
+				*refs = next;
+			else
+				prev->next = next;
+			free(current);
+		} else
+			prev = current;
+	}
+}
+
+static int everything_local(struct ref **refs, int nr_match, char **match)
 {
 	struct ref *ref;
 	int retval;
@@ -283,7 +319,7 @@ static int everything_local(struct ref *
 	track_object_refs = 0;
 	save_commit_buffer = 0;
 
-	for (ref = refs; ref; ref = ref->next) {
+	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
 		o = parse_object(ref->old_sha1);
@@ -305,8 +341,10 @@ static int everything_local(struct ref *
 	if (cutoff)
 		mark_recent_complete_commits(cutoff);
 
-	for (retval = 1; refs ; refs = refs->next) {
-		const unsigned char *remote = refs->old_sha1;
+	filter_refs(refs, nr_match, match);
+
+	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
+		const unsigned char *remote = ref->old_sha1;
 		unsigned char local[20];
 		struct object *o;
 
@@ -317,16 +355,16 @@ static int everything_local(struct ref *
 				continue;
 			fprintf(stderr,
 				"want %s (%s)\n", sha1_to_hex(remote),
-				refs->name);
+				ref->name);
 			continue;
 		}
 
-		memcpy(refs->new_sha1, local, 20);
+		memcpy(ref->new_sha1, local, 20);
 		if (!verbose)
 			continue;
 		fprintf(stderr,
 			"already have %s (%s)\n", sha1_to_hex(remote),
-			refs->name);
+			ref->name);
 	}
 	return retval;
 }
@@ -338,12 +376,12 @@ static int fetch_pack(int fd[2], int nr_
 	int status;
 	pid_t pid;
 
-	get_remote_heads(fd[0], &ref, nr_match, match, 1);
+	get_remote_heads(fd[0], &ref, 0, NULL, 1);
 	if (!ref) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	if (everything_local(ref)) {
+	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
