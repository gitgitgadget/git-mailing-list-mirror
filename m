From: Johan Herland <johan@herland.net>
Subject: Re: [WIP/RFC 04/13] notes.h/c: Propagate combine_notes_fn return value
 to add_note() and beyond
Date: Sat, 24 Jul 2010 00:39:24 +0200
Message-ID: <201007240039.25005.johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
 <1279880104-29796-5-git-send-email-johan@herland.net>
 <20100723152344.GA1709@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 00:39:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcQtw-000394-Nw
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 00:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757338Ab0GWWj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 18:39:28 -0400
Received: from smtp.getmail.no ([84.208.15.66]:51333 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756206Ab0GWWj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 18:39:27 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L61002YR89P7K50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 24 Jul 2010 00:39:25 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A2C0E1EA53AF_C4A1A1DB	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 22:39:25 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 5D6C81EA2DEE_C4A1A1DF	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 22:39:25 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6100BR789P8710@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 24 Jul 2010 00:39:25 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <20100723152344.GA1709@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151581>

On Friday 23 July 2010, Jonathan Nieder wrote:
> Johan Herland wrote:
> > +		/* No return value checking; c_n_overwrite always returns 0 */
> >  		add_note(t, object, new_note, combine_notes_overwrite);
> 
> I suspect something like
> 
> 	if (add_note(t, object, ...))
> 		die("confused: combine_notes_overwrite failed");
> 
> would be less likely to fall out of date. ;-)

Good call, I'll squash the following into the next iteration:

Thanks!

...Johan


diff --git a/builtin/notes.c b/builtin/notes.c
index 516401c..5aaae03 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -576,9 +576,8 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	if (is_null_sha1(new_note))
 		remove_note(t, object);
-	else
-		/* No return value checking; c_n_overwrite always returns 0 */
-		add_note(t, object, new_note, combine_notes_overwrite);
+	else if (add_note(t, object, new_note, combine_notes_overwrite))
+		die("confused: combine_notes_overwrite failed");
 
 	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
 		 is_null_sha1(new_note) ? "removed" : "added", "add");
@@ -657,8 +656,8 @@ static int copy(int argc, const char **argv, const char *prefix)
 		goto out;
 	}
 
-	/* No return value checking; c_n_overwrite always returns 0 */
-	add_note(t, object, from_note, combine_notes_overwrite);
+	if (add_note(t, object, from_note, combine_notes_overwrite))
+		die("confused: combine_notes_overwrite failed");
 	commit_notes(t, "Notes added by 'git notes copy'");
 out:
 	free_notes(t);
@@ -717,9 +716,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 
 	if (is_null_sha1(new_note))
 		remove_note(t, object);
-	else
-		/* No return value checking; c_n_overwrite always returns 0 */
-		add_note(t, object, new_note, combine_notes_overwrite);
+	else if (add_note(t, object, new_note, combine_notes_overwrite))
+		die("confused: combine_notes_overwrite failed");
 
 	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
 		 is_null_sha1(new_note) ? "removed" : "added", argv[0]);
diff --git a/notes-merge.c b/notes-merge.c
index 122d6b9..47cd32a 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -442,12 +442,14 @@ static int merge_one_change(struct notes_merge_options *o,
 		return 0;
 	case NOTES_MERGE_RESOLVE_THEIRS:
 		OUTPUT(o, 2, "Using remote notes for %s", sha1_to_hex(p->obj));
-		add_note(t, p->obj, p->remote, combine_notes_overwrite);
+		if (add_note(t, p->obj, p->remote, combine_notes_overwrite))
+			die("confused: combine_notes_overwrite failed");
 		return 0;
 	case NOTES_MERGE_RESOLVE_UNION:
 		OUTPUT(o, 2, "Concatenating local and remote notes for %s",
 		       sha1_to_hex(p->obj));
-		add_note(t, p->obj, p->remote, combine_notes_concatenate);
+		if (add_note(t, p->obj, p->remote, combine_notes_concatenate))
+			die("confused: combine_notes_concatenate failed");
 		return 0;
 	}
 	die("Unknown resolve method (%i).", o->resolve);
@@ -489,7 +491,9 @@ static int merge_changes(struct notes_merge_options *o,
 			   !hashcmp(p->local, p->base)) {
 			/* no local change; adopt remote change */
 			OUTPUT(o, 5, "\t\t\tno local change, adopting remote");
-			add_note(t, p->obj, p->remote, combine_notes_overwrite);
+			if (add_note(t, p->obj, p->remote,
+				     combine_notes_overwrite))
+				die("confused: combine_notes_overwrite failed");
 		} else {
 			/* need file-level merge between local and remote */
 			OUTPUT(o, 5, "\t\t\tneed content-level merge");


-- 
Johan Herland, <johan@herland.net>
www.herland.net
