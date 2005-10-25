From: Andreas Ericsson <ae@op5.se>
Subject: Re: User-relative paths
Date: Tue, 25 Oct 2005 09:47:21 +0200
Message-ID: <435DE309.9090509@op5.se>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se> <20051023183757.GS30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 25 09:48:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUJWo-0005pM-MX
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 09:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVJYHrY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 03:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVJYHrX
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 03:47:23 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:25565 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932070AbVJYHrX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 03:47:23 -0400
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 0B5496BD09
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 09:47:22 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051023183757.GS30889@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10570>

Petr Baudis wrote:
> Dear diary, on Sun, Oct 23, 2005 at 11:41:52AM CEST, I got a letter
> where Andreas Ericsson <ae@op5.se> told me that...
> 
>>Anyways, the attached patch does this. I've tested all the various 
>>syntaxes and they work as expected. rsync, http and local files take the 
>>same syntax as before. I haven't added support for user-relative paths 
>>to the git-daemon (can't see the point, really) although that can be 
>>done easily enough.
> 
> 
> It would be useful to add a [PATCH] tag to subject when you submit a
> patch, so that we notice it better. ;-)
> 

Will do in the future. I thought it was auto-imported for buildtest if 
it was.

> You don't update the documentation even though there seem to be some
> syntactic changes. You should at least update
> 
> 	Documentation/pull-fetch-param.txt
> 

True. I'll need to re-work the patch a bit to take Junio's RFC on paths 
into account. I'll do this then.

> Also before Junio asks you, in the followup patches, you might want to
> sign off the patch if you want it integrated.
> 
> 
>>diff --git a/Makefile b/Makefile
>>index 903c57c..87188ea 100644
>>--- a/Makefile
>>+++ b/Makefile
>>@@ -359,6 +362,9 @@ git-cherry-pick: git-revert
>> %.o: %.S
>> 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
>> 
>>+$(SERVERSIDE_PROGRAMS) : git-%$X : %.o srvside-ssh.o $(LIB_FILE)
>>+	$(CC) $(ALL_CFLAGS) -o $@ $(filter %o,$^) $(LIBS)
>>+
>> git-%$X: %.o $(LIB_FILE)
>> 	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
>> 
> 
> 
> Why are you adding own compilation command, and why is it inconsistent
> with the git-%$X's one?
> 

Mainly because I'm really no good at Makefiles and just noticed that 
this seems to do what I want. My own projects rarely stretch over 15 
files and it's usually just one or two binaries, so I haven't gotten 
round to learning the finer points of make.

> 
>>diff --git a/connect.c b/connect.c
>>index b171c5d..0d78b3e 100644
>>--- a/connect.c
>>+++ b/connect.c
>>@@ -436,33 +436,44 @@ static int git_tcp_connect(int fd[2], co
>>+	/* leading colon marks relative path for ssh.
>>+	 * Check for host == url and default to PROTO_SSH to allow
>>+	 *   $ git fetch kernel.org:git
>>+	 */
>>+	if(ptr && (!path || ptr < path)) {
>>+		if(host == url)
>>+			protocol = PROTO_SSH;
>>+
>>+		if(protocol == PROTO_SSH) {
>>+			*ptr = '\0';
>>+			path = ptr + 1;
>> 		}
>> 	}
> 
> 
> If I understand this right,
> 
> 	ssh://foo.bar:baz/quux
> 
> will make foo.bar the host and baz/quux the path. Please, do NOT do
> this! It is supposed to be a URL, dammit! And you know, URLs have
> defined _syntax_, and that's important at least every time the URL gets
> out of GIT's context. Or stop it calling URL altogether, to prevent any
> confusion. But in URLs, the space between : and / is a port definition.
> See also RFC3986 (aka STD066) and RFC2718.
> 
> Thanks.
> 

Right you are. I was thinking scp like syntax rather than url.

> 
>>diff --git a/receive-pack.c b/receive-pack.c
>>index 8f157bc..9a040ff 100644
>>--- a/receive-pack.c
>>+++ b/receive-pack.c
>>@@ -265,18 +267,9 @@ int main(int argc, char **argv)
>> 	if (!dir)
>> 		usage(receive_pack_usage);
>> 
>>-	/* chdir to the directory. If that fails, try appending ".git" */
>>-	if (chdir(dir) < 0) {
>>-		if (chdir(mkpath("%s.git", dir)) < 0)
>>-			die("unable to cd to %s", dir);
>>-	}
>>-
>>-	/* If we have a ".git" directory, chdir to it */
>>-	chdir(".git");
>>-	putenv("GIT_DIR=.");
>>+	/* Find the right directory */
>>+	srvside_chdir(dir, 0);
>> 
>>-	if (access("objects", X_OK) < 0 || access("refs/heads", X_OK) < 0)
>>-		die("%s doesn't appear to be a git directory", dir);
>> 	write_head_info();
>> 
>> 	/* EOF */
> 
> 
> No srvside_chdir() declaration?
> 
> 
>>diff --git a/srvside-ssh.c b/srvside-ssh.c
>>new file mode 100644
>>index 0000000..0ed5d30
>>--- /dev/null
>>+++ b/srvside-ssh.c
>>@@ -0,0 +1,63 @@
>>+#include "cache.h"
>>+#include <unistd.h>
>>+#include <pwd.h>
>>+
>>+extern const char *__progname;
> 
> 
> How portable is this? It appears that no standard really defines this,
> and Google faintly hints at least some Cygwin-related problems...
> 

Somewhat, but not very. It was more of a quick hack since the old code 
had hardcoded program names. If this gets supported in git-daemon as 
well it should say "git-daemon" in the error message, so I think either 
pass it as a parameter or invent some git_progname variable and use some 
small init-code for all programs.

> 
>>diff --git a/upload-pack.c b/upload-pack.c
>>index accdba6..356c9b1 100644
>>--- a/upload-pack.c
>>+++ b/upload-pack.c
>>@@ -5,6 +5,7 @@
>> #include "object.h"
>> 
>> static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
>>+extern void srvside_chdir(const char *path, int strict);
>> 
>> #define MAX_HAS 256
>> #define MAX_NEEDS 256
> 
> 
> What about a .h file?
> 

Prototype patch, sort of, and since it's only one function I thought 
it'd be better to keep it as unobtrusive as possible.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
