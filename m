From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git log - crash and core dump
Date: Tue, 16 Apr 2013 20:09:08 +0200
Message-ID: <516D93C4.1000100@lsrfire.ath.cx>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Ivan Lyapunov <dront78@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 20:09:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USAJl-00063V-8W
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab3DPSJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:09:15 -0400
Received: from india601.server4you.de ([85.25.151.105]:48074 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab3DPSJO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:09:14 -0400
Received: from [192.168.2.105] (p579BE374.dip.t-dialin.net [87.155.227.116])
	by india601.server4you.de (Postfix) with ESMTPSA id CC1721E3;
	Tue, 16 Apr 2013 20:09:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221441>

Am 16.04.2013 18:55, schrieb Ivan Lyapunov:
> git version 1.8.2.1 crashes on my ArchLinux x86_64 on git log command
> gdb bt is attached
> 
> git log | less
> does not crash in same repo
> 
> I cannot share a repo for a debug purposes since it's private repo of
> my employer
> but I can perform any suitable tests on repo to help this bug to be fixed
> 
> #0  0x00007ffff722b3e6 in ____strtoull_l_internal () from /usr/lib/libc.so.6
> #1  0x00000000004b31d4 in pp_user_info (pp=pp@entry=0x7fffffffd310,
> what=what@entry=0x521379 "Author", sb=sb@entry=0x7fffffffd290,
>      line=line@entry=0x7b3a45 "Ivan Lyapunov <ilyapunov@trueconf.ru>-
> <> 1354083115 +0400\ncommitter Ivan Lyapunov <ilyapunov@trueconf.ru>

So this is the author information, correct?

	Ivan Lyapunov <ilyapunov@trueconf.ru>-<> 1354083115 +0400
        |author name|  |---author email----| ^^^ |--time--| |tz-|

How did you manage to add the "-<>" after the email address?

What does git log in version 1.8.1 or earlier show for this commit?

> 1354083115 +0400\n\n- small merge fixes",
> encoding=encoding@entry=0x505400 "UTF-8") at pretty.c:441
> #2  0x00000000004b533a in pp_header (sb=0x7fffffffd290,
> msg_p=0x7fffffffd228, commit=0x7c1e10, encoding=0x505400 "UTF-8",
> pp=0x7fffffffd310) at pretty.c:1415
> #3  pretty_print_commit (pp=pp@entry=0x7fffffffd310,
> commit=commit@entry=0x7c1e10, sb=sb@entry=0x7fffffffd290) at
> pretty.c:1545
> #4  0x00000000004a0b45 in show_log (opt=opt@entry=0x7fffffffd4d0) at
> log-tree.c:683
> #5  0x00000000004a1616 in log_tree_commit
> (opt=opt@entry=0x7fffffffd4d0, commit=commit@entry=0x7c1e10) at
> log-tree.c:859
> #6  0x0000000000438b03 in cmd_log_walk (rev=rev@entry=0x7fffffffd4d0)
> at builtin/log.c:310
> #7  0x00000000004395dd in cmd_log (argc=1, argv=0x7fffffffdd30,
> prefix=0x0) at builtin/log.c:582
> #8  0x000000000040562d in run_builtin (argv=0x7fffffffdd30, argc=1,
> p=0x754d18 <commands.21404+1080>) at git.c:282
> #9  handle_internal_command (argc=1, argv=0x7fffffffdd30) at git.c:444
> #10 0x0000000000404a6f in run_argv (argv=0x7fffffffdbd0,
> argcp=0x7fffffffdbdc) at git.c:490
> #11 main (argc=1, argv=0x7fffffffdd30) at git.c:565

Does this patch help?

 pretty.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index d3a82d2..713eefc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -405,8 +405,8 @@ void pp_user_info(const struct pretty_print_context *pp,
 	const char *mailbuf, *namebuf;
 	size_t namelen, maillen;
 	int max_length = 78; /* per rfc2822 */
-	unsigned long time;
-	int tz;
+	unsigned long time = 0;
+	int tz = 0;
 
 	if (pp->fmt == CMIT_FMT_ONELINE)
 		return;
@@ -438,8 +438,10 @@ void pp_user_info(const struct pretty_print_context *pp,
 	strbuf_add(&name, namebuf, namelen);
 
 	namelen = name.len + mail.len + 3; /* ' ' + '<' + '>' */
-	time = strtoul(ident.date_begin, &date, 10);
-	tz = strtol(date, NULL, 10);
+	if (ident.date_begin) {
+		time = strtoul(ident.date_begin, &date, 10);
+		tz = strtol(date, NULL, 10);
+	}
 
 	if (pp->fmt == CMIT_FMT_EMAIL) {
 		strbuf_addstr(sb, "From: ");
