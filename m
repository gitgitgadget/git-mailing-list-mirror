From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 7/9] sparse: Fix errors due to missing target-specific
 variables
Date: Mon, 11 Apr 2011 19:04:31 +0100
Message-ID: <4DA342AF.7080109@ramsay1.demon.co.uk>
References: <4D9E06EE.9090803@ramsay1.demon.co.uk> <7vfwpt6474.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 20:25:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Lnn-0001TV-Md
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 20:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab1DKSZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 14:25:26 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:63290 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754879Ab1DKSZZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 14:25:25 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Q9Lnf-0004Hn-a9; Mon, 11 Apr 2011 18:25:24 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vfwpt6474.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171346>

[Sorry for the late reply, I'm having ISP problems and real-life is
insanely busy right now...]

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> In particular, sparse issues the following errors:
>>
>>     attr.c:472:43: error: undefined identifier 'ETC_GITATTRIBUTES'
>>     config.c:821:43: error: undefined identifier 'ETC_GITCONFIG'
>>     exec_cmd.c:14:37: error: undefined identifier 'PREFIX'
>>     exec_cmd.c:83:28: error: undefined identifier 'GIT_EXEC_PATH'
>>     builtin/help.c:328:46: error: undefined identifier 'GIT_MAN_PATH'
>>     builtin/help.c:374:40: error: undefined identifier 'GIT_INFO_PATH'
>>     builtin/help.c:382:45: error: undefined identifier 'GIT_HTML_PATH'
>>     git.c:96:42: error: undefined identifier 'GIT_HTML_PATH'
>>     git.c:241:35: error: invalid initializer
>>     http.c:293:43: error: undefined identifier 'GIT_HTTP_USER_AGENT'
>>
>> which is caused by not passing the target-specific additions to
>> the EXTRA_CPPFLAGS variable to cgcc.
>>
[...]
> 
> Hmm, shouldn't this be part of [1/9]?  I don't think I saw these with
> "make check" before applying that patch.

No, these errors were not introduced by patch #1; below I have added a
transcript of a session on Linux which shows that these errors were
present prior to patch #1. I can't say I'm surprised that you didn't
notice these errors; as you can see below, they are swamped by the
(for me) 4223 warnings and 161 errors.

Patch #1 is really about using "cgcc -no-compile", rather than sparse,
in order to fix the vast majority of warnings and errors; 4209 fewer
warnings and 148 fewer errors is not a bad return!

Patch #2 is about fixing up the target-specific additions in the
Makefile (ie, it's not a general sparse usage issue, but specific to
the git Makefile).

Having said that, I certainly don't mind squashing this in with patch #1
if that's what you would prefer. I have to make some additions to this
patch anyway; I forgot some "common-cmds.h" dependencies, thus:

--- >8 ---
diff --git a/Makefile b/Makefile
index 4b03b8a..4dee43f 100644
--- a/Makefile
+++ b/Makefile
@@ -1684,9 +1684,9 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-help.o: common-cmds.h
+help.sp help.o: common-cmds.h
 
-builtin/help.o: common-cmds.h
+builtin/help.sp builtin/help.o: common-cmds.h
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
@@ -2171,7 +2171,7 @@ SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		$(SPARSE_FLAGS) $<
 
-sparse: $(SP_OBJ)
+sparse: common-cmds.h $(SP_OBJ)
 
 check: common-cmds.h
 	@if sparse; \
--- >8 ---

NOTE: The Makefile has "git.o: common-cmds.h" (line 1679), but I don't
think git.c has depended on that header since commit 70827b15 (21-Apr-2006).

> Also shouldn't you be marking .sp suffix as .PHONY?

Hmmm, I didn't think so ... but I could easily be wrong!
Given that the .sp files never actually exist, and that the pattern rule
has a .PHONY dependency (FORCE), I didn't think marking $(SP_OBJ) as
phony would add anything.
Ah, well I suppose it would help if somebody did (say) "make git.sp 2>git.sp".
OK, I'll add that in the re-roll.

Let me know if you want me to squash this in with patch #1; I'll wait a while
before I re-roll.

Thanks!

ATB,
Ramsay Jones

$ git checkout 52d269da  # Stephen's "Makefile: cover more files" patch.
$ make check >/dev/null 2>sp-out
$ grep warning sp-out | wc -l
4223
$ grep error sp-out | wc -l
161
$ grep error sp-out | grep ETC_
attr.c:472:43: error: undefined identifier 'ETC_GITATTRIBUTES'
config.c:813:43: error: undefined identifier 'ETC_GITCONFIG'
$ grep error sp-out | grep PREFIX
exec_cmd.c:14:37: error: undefined identifier 'PREFIX'
$ grep error sp-out | grep GIT_
exec_cmd.c:83:28: error: undefined identifier 'GIT_EXEC_PATH'
builtin/help.c:328:46: error: undefined identifier 'GIT_MAN_PATH'
builtin/help.c:374:40: error: undefined identifier 'GIT_INFO_PATH'
builtin/help.c:382:45: error: undefined identifier 'GIT_HTML_PATH'
git.c:96:42: error: undefined identifier 'GIT_HTML_PATH'
http.c:293:43: error: undefined identifier 'GIT_HTTP_USER_AGENT'

$ git checkout 0343332f  # patch #1
$ make check >/dev/null 2>sp-out
$ grep warning sp-out | wc -l
14
$ grep error sp-out | wc -l
13
$ grep error sp-out | grep ETC_
attr.c:472:43: error: undefined identifier 'ETC_GITATTRIBUTES'
config.c:821:43: error: undefined identifier 'ETC_GITCONFIG'
$ grep error sp-out | grep PREFIX
exec_cmd.c:14:37: error: undefined identifier 'PREFIX'
$ grep error sp-out | grep GIT_
exec_cmd.c:83:28: error: undefined identifier 'GIT_EXEC_PATH'
builtin/help.c:328:46: error: undefined identifier 'GIT_MAN_PATH'
builtin/help.c:374:40: error: undefined identifier 'GIT_INFO_PATH'
builtin/help.c:382:45: error: undefined identifier 'GIT_HTML_PATH'
git.c:96:42: error: undefined identifier 'GIT_HTML_PATH'
http.c:293:43: error: undefined identifier 'GIT_HTTP_USER_AGENT'

$ git checkout 6f8a9fe3  # Patch #7
$ make check >/dev/null 2>sp-out
$ grep warning sp-out | wc -l
10
$ grep error sp-out | wc -l
3
$ grep error sp-out | grep ETC_
$ grep error sp-out | grep PREFIX
$ grep error sp-out | grep GIT_
