From: Johan Herland <johan@herland.net>
Subject: [PATCH] builtin-notes: Minor (mostly parse_options-related) fixes
Date: Thu, 25 Feb 2010 01:48:11 +0100
Message-ID: <201002250148.11487.johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
 <4B792347.8070208@gmail.com> <201002160247.49719.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 01:48:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkRtt-0008Qd-U9
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 01:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758664Ab0BYAsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 19:48:17 -0500
Received: from smtp.getmail.no ([84.208.15.66]:33173 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758557Ab0BYAsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 19:48:16 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYD0019VGWEUE90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 25 Feb 2010 01:48:14 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYD00412GWC8K10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 25 Feb 2010 01:48:14 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.25.3337
User-Agent: KMail/1.13.0 (Linux/2.6.32-ARCH; KDE/4.4.0; x86_64; ; )
In-reply-to: <201002160247.49719.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141017>

Use PARSE_OPT_NONEG to disallow --no-<option> for --message, --file,
--reedit-message and --reuse-message. --no-<option> does not make sense
for these options, and specifying PARSE_OPT_NONEG simplifies the code in
the option-handling callbacks.

Also, use strbuf_addch(... '\n') instead of strbuf_addstr(... "\n") in
couple of places.

Finally, improve the short-help by dividing the options into two OPT_GROUPs.

Suggested-by: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---

On Tuesday 16 February 2010, Johan Herland wrote:
> On Monday 15 February 2010, Stephen Boyd wrote:
> > On 02/13/2010 01:28 PM, Johan Herland wrote:
> > > @@ -199,6 +203,40 @@ static int parse_file_arg(const struct option

[...]

> > > +	if (!arg)
> > > +		return -1;
> > 
> > This is impossible unless you're using the PARSE_OPT_OPTARG flag or
> > allowing negation (i.e. --no-reuse-mesage). You should probably make
> > the two callback options PARSE_OPT_NONEG and then drop this if
> > statement. Same applies to some of the other callbacks not introduced
> > in this patch.
> 
> Thanks. Fixed locally. Will be part of the next iteration.
> 
> > > +
> > > +	if (msg->buf.len)
> > > +		strbuf_addstr(&(msg->buf), "\n");
> > > +
> > 
> > Use strbuf_addch()? I saw this in a couple other patches too.
> 
> Of course. Thanks for noticing. Fixed locally. Will be part of the next
> iteration.

I never got around to submitting the next jh/notes iteration before it was
merged to 'next', so here are Stephen's suggestions as a separate patch on
top of 'next'. AFAICS it does not conflict with tr/notes-display in 'pu'.


Have fun! :)

...Johan


 builtin-notes.c |   38 +++++++++++++++++---------------------
 1 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/builtin-notes.c b/builtin-notes.c
index 123ecad..feb710a 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -171,12 +171,9 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct msg_arg *msg = opt->value;
 
-	if (!arg)
-		return -1;
-
 	strbuf_grow(&(msg->buf), strlen(arg) + 2);
 	if (msg->buf.len)
-		strbuf_addstr(&(msg->buf), "\n");
+		strbuf_addch(&(msg->buf), '\n');
 	strbuf_addstr(&(msg->buf), arg);
 	stripspace(&(msg->buf), 0);
 
@@ -188,11 +185,8 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct msg_arg *msg = opt->value;
 
-	if (!arg)
-		return -1;
-
 	if (msg->buf.len)
-		strbuf_addstr(&(msg->buf), "\n");
+		strbuf_addch(&(msg->buf), '\n');
 	if (!strcmp(arg, "-")) {
 		if (strbuf_read(&(msg->buf), 0, 1024) < 0)
 			die_errno("cannot read '%s'", arg);
@@ -212,11 +206,8 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	enum object_type type;
 	unsigned long len;
 
-	if (!arg)
-		return -1;
-
 	if (msg->buf.len)
-		strbuf_addstr(&(msg->buf), "\n");
+		strbuf_addch(&(msg->buf), '\n');
 
 	if (get_sha1(arg, object))
 		die("Failed to resolve '%s' as a valid ref.", arg);
@@ -291,15 +282,20 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	int given_object = 0, i = 1, retval = 0;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
 	struct option options[] = {
-		OPT_GROUP("Notes options"),
-		OPT_CALLBACK('m', "message", &msg, "MSG",
-			     "note contents as a string", parse_msg_arg),
-		OPT_CALLBACK('F', "file", &msg, "FILE",
-			     "note contents in a file", parse_file_arg),
-		OPT_CALLBACK('c', "reedit-message", &msg, "OBJECT",
-			   "reuse and edit specified note object", parse_reedit_arg),
-		OPT_CALLBACK('C', "reuse-message", &msg, "OBJECT",
-			   "reuse specified note object", parse_reuse_arg),
+		OPT_GROUP("Notes contents options"),
+		{ OPTION_CALLBACK, 'm', "message", &msg, "MSG",
+			"note contents as a string", PARSE_OPT_NONEG,
+			parse_msg_arg},
+		{ OPTION_CALLBACK, 'F', "file", &msg, "FILE",
+			"note contents in a file", PARSE_OPT_NONEG,
+			parse_file_arg},
+		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, "OBJECT",
+			"reuse and edit specified note object", PARSE_OPT_NONEG,
+			parse_reedit_arg},
+		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, "OBJECT",
+			"reuse specified note object", PARSE_OPT_NONEG,
+			parse_reuse_arg},
+		OPT_GROUP("Other options"),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
 		OPT_END()
 	};
-- 
1.7.0.rc1.141.gd3fd

-- 
Johan Herland, <johan@herland.net>
www.herland.net
