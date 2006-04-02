From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Solaris cloning woes partly diagnosed
Date: Sun, 2 Apr 2006 12:18:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021159110.3050@g5.osdl.org>
References: <7vy7yol0nk.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021118210.3050@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 21:18:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ85y-0003LW-6l
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 21:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWDBTSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 15:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWDBTSf
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 15:18:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751266AbWDBTSe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 15:18:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k32JIUEX015561
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 12:18:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k32JIT1o019391;
	Sun, 2 Apr 2006 12:18:29 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604021118210.3050@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18278>



On Sun, 2 Apr 2006, Linus Torvalds wrote:
> 
> Suddenly, some system calls will either return -1/EINTR, or they'll return 
> partial reads or writes. 

Hmm. If I read the IRC logs right, the bad pack is still a _valid_ pack, 
and passes git-verify-pack with flying colors.

That certainly implies that we had no problems with write-out: not only 
must the SHA1 of the resulting file match itself, but it must match the 
index too, and the number of objects there must match the index.

So the only way I see the pack being bad (if it does indeed pass 
git-verify-pack) is if the object list we generated was bad.

However, "-q" only affects git-pack-file itself, not the generation of the 
list. Which would imply that we have trouble _reading_ the list as it 
comes in through a pipe. Which is just insane, because we use just a 
bog-standard "fgets(... stdin)" for that. And no _way_ can stdio have 
problems with a few SIGALRM's, that would break a lot of other problems.

But Oeje1 seems to be saying (in http://pastebin.com/635566):

	git rev-list --objects --all | git pack-objects pack
	Generating pack...
	Done counting 15 objects.
	Deltifying 15 objects.
	 100% (15/15) done
	Writing 15 objects.
	 100% (15/15) done
	806439fdfa5e9990b03f9301bd68e243795fff50

where the result _should_ be 16385 objects, not 15.

And the thing is, the _only_ thing we do there is that

	while (fgets(line, sizeof(line), stdin) != NULL) {
		...
		add_object_entry(sha1, name_hash(NULL, line+41), 0);

so it really really looks like fgets() would have problems with a SIGALRM 
coming in and doesn't just re-try on EINTR. Can Solaris stdio _really_ be 
that broken? (Yeah, yeah, it may be "conforming". It's also so incredibly 
programmer-unfriendly that it's not even funny)

That would be truly insane. Can somebody with Solaris check what the 
following patch results in...

		Linus

----
diff --git a/pack-objects.c b/pack-objects.c
index ccfaa5f..daba5de 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1099,8 +1099,18 @@ int main(int argc, char **argv)
 		fprintf(stderr, "Generating pack...\n");
 	}
 
-	while (fgets(line, sizeof(line), stdin) != NULL) {
+	for (;;) {
 		unsigned char sha1[20];
+
+		if (!fgets(line, sizeof(line), stdin)) {
+			if (feof(stdin))
+				break;
+			if (!ferror(stdin))
+				die("fgets returned NULL, not EOF, not error!");
+			if (errno == EINTR)
+				continue;
+			die("fgets: %s", strerror(errno));
+		}
 
 		if (line[0] == '-') {
 			if (get_sha1_hex(line+1, sha1))
