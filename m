From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git cannot push to repository with too many tags/heads
Date: Tue, 21 Feb 2006 18:56:32 -0800
Message-ID: <7virr8t82n.fsf@assigned-by-dhcp.cox.net>
References: <1140547568.5509.21.camel@orbit.scot.redhat.com>
	<7vwtfotaq3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 03:57:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBkBC-00052m-NJ
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 03:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWBVC4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 21:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWBVC4g
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 21:56:36 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39090 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751156AbWBVC4f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 21:56:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222025310.VVMB17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Feb 2006 21:53:10 -0500
To: "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <7vwtfotaq3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 21 Feb 2006 17:59:16 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16586>

Junio C Hamano <junkio@cox.net> writes:

> "Stephen C. Tweedie" <sct@redhat.com> writes:
>
>> send_pack()
>> then skips all other refs by doing a
>>
>> 		if (!ref->peer_ref)
>> 			continue;
>>
>> Unfortunately, exec_rev_list() is missing this, and it tries to ask
>> git-rev-list for the commit objects of *every* ref on the remote_refs
>> list, even if they have been explicitly excluded by match_refs() and
>> have no peer_ref.  So with this huge repository, I can't even push a
>> single refspec without bumping into the limit of 900 refs.
>
> IIRC, the distinction was deliberate.  send_pack() excludes
> what did not match because it does not want to send them.
> rev_list() adds what we know they have to "do not bother to
> send" list to make the resulting pack smaller.  The time where
> it matters most is when you are pushing a new branch head (or a
> tag).
>
> I think the exec_rev_list logic should be taught to first
> include all the positive refs (i.e. the ones we are going to
> send), and then as many the negative refs (i.e. the ones we know
> they have), from newer to older, as they fit without triggering
> "argument list too long".

That is, something like this.
-- >8 --
Do not give up running rev-list when remote has insanely large number of refs.

---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
git diff
diff --git a/send-pack.c b/send-pack.c
index 990be3f..cfd0eeb 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -37,24 +37,27 @@ static void exec_pack_objects(void)
 
 static void exec_rev_list(struct ref *refs)
 {
+	struct ref *ref;
 	static char *args[1000];
 	int i = 0;
 
 	args[i++] = "rev-list";	/* 0 */
 	args[i++] = "--objects";	/* 1 */
-	while (refs) {
-		char *buf = malloc(100);
+	for (ref = refs; refs; refs = refs->next) {
+		char *buf = malloc(41);
 		if (i > 900)
 			die("git-rev-list environment overflow");
-		if (!is_zero_sha1(refs->old_sha1) &&
-		    has_sha1_file(refs->old_sha1)) {
+		if (!is_zero_sha1(refs->new_sha1)) {
 			args[i++] = buf;
-			snprintf(buf, 50, "^%s", sha1_to_hex(refs->old_sha1));
-			buf += 50;
+			snprintf(buf, 41, "%s", sha1_to_hex(refs->new_sha1));
 		}
-		if (!is_zero_sha1(refs->new_sha1)) {
+	}
+	for (ref = refs; i < 900 && refs; refs = refs->next) {
+		char *buf = malloc(42);
+		if (!is_zero_sha1(refs->old_sha1) &&
+		    has_sha1_file(refs->old_sha1)) {
 			args[i++] = buf;
-			snprintf(buf, 50, "%s", sha1_to_hex(refs->new_sha1));
+			snprintf(buf, 42, "^%s", sha1_to_hex(refs->old_sha1));
 		}
 		refs = refs->next;
 	}

Compilation finished at Tue Feb 21 18:52:49
