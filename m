From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] git_progname (was: Re: User-relative paths)
Date: Tue, 25 Oct 2005 11:11:54 +0200
Message-ID: <435DF6DA.6010205@op5.se>
References: <435ABB99.5020908@op5.se>	<7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se> <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020600090706070709030509"
X-From: git-owner@vger.kernel.org Tue Oct 25 11:15:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUKqd-0001tF-Hd
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 11:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVJYJL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 05:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVJYJL4
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 05:11:56 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:9440 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932103AbVJYJL4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 05:11:56 -0400
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id D0B106BD12
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 11:11:54 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10576>

This is a multi-part message in MIME format.
--------------020600090706070709030509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Junio C Hamano wrote:
>>
>>>Andreas Ericsson <ae@op5.se> writes:
>>>...
>>>At one point, Linus posted an outline of "restricted login shell
>>>for use with git over ssh".  I think you could start from there,
>>>perhaps extend it so that it checks the binaries *and* pathnames
>>>the user can specify (e.g. only under your own $HOME is allowed,
>>>and no /../ in them, or something silly like that).
>>>
>>
>>I found this in the archives:
>>http://article.gmane.org/gmane.comp.version-control.git/5784/match=restricted+login
>>
>>Is that what you're referring to?
> 
> 
> No, it is this one:
> 
>     http://marc.theaimsgroup.com/?l=git&m=112681457828137&w=2
> 
> But it is orthogonal to what you are doing in this patch.
> 
> 
>>Let me know if you want things done differently.
> 
> 
> I think srvside_chdir() should not do the userdir expansion
> under --strict (otherwise you would need a matching change in
> daemon.c as well, but I would rather not).
> 

True. I'll rework it.

> The --strict flag in upload-pack is to make sure git-daemon can
> see what is being accessed and make its policy decision even
> before it calls upload-pack.  In a pathological case, somebody
> can create a directory "/~foo/bar/.git", where the "/~foo"
> directory is different from "/home/foo", and have git-daemon
> check that the former is OK and call your upload-pack.  Your
> upload-pack uses srvside_chdir() and exposes /home/foo/bar/.git;


It shouldn't, because srvside_chdir() will only user-expand paths that 
start with a tilde.


> this circumvents git-daemon's policy decision, doesn't it?
> 
> I also agree with everything Pasky already said.
> 
>  * In a URL, a colon after hostname means "port number
>    follows".  So it was a good intention to make these
>    consistent:
> 
>         git fetch ssh://kernel.org:git
>         git fetch kernel.org:git
> 
>    it should not be done.  IOW, if I wanted to use the former
>    form (which I do not think I'd use myself), I should say either one
>    of:
> 
>         git fetch ssh://kernel.org:~/git
>         git fetch ssh://kernel.org:~junio/git
> 
>    Oh, I just noticed you do not handle the former, because you
>    did not have to, but now you need to.
> 
>  * Use of "extern const char *__progname" is questionable.  I
>    could be easily talked into:
> 
>     - have "extern const char *git_program_name" in cache.h or
>       somewhere;
> 
>     - convert programs (gradually) to set that at the beginning
>       of main();
> 

See the attached patch, which adds git_progname as a global variable to 
daemon.c with a minimum of fuzz. The one-liner below will add it to the 
rest of the programs. GNU sed >= 4.0.9 required.

grep -l "int main" *.c | xargs -- sed -i '/^#include/i#include "main.h"'

>     - update die() and error() to use that variable when
>       reporting (both callers and implementation) -- this is
>       optional.
> 
> 

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

--------------020600090706070709030509
Content-Type: text/plain;
 name="git_progname.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git_progname.diff"

diff --git a/Makefile b/Makefile
index 5b0306d..f8e4511 100644
--- a/Makefile
+++ b/Makefile
@@ -147,7 +147,7 @@ LIB_FILE=libgit.a
 LIB_H = \
 	blob.h cache.h commit.h count-delta.h csum-file.h delta.h \
 	diff.h epoch.h object.h pack.h pkt-line.h quote.h refs.h \
-	run-command.h strbuf.h tag.h tree.h
+	run-command.h strbuf.h tag.h tree.h main.h
 
 DIFF_OBJS = \
 	diff.o diffcore-break.o diffcore-order.o diffcore-pathspec.o \
diff --git a/cache.h b/cache.h
index d776016..db5d667 100644
--- a/cache.h
+++ b/cache.h
@@ -45,6 +45,13 @@
 #endif
 #endif
 
+#if defined(__GLIBC__)
+extern const char *__progname;
+#define git_progname __progname
+#else
+extern const char *git_progname;
+#endif
+
 /*
  * Intensive research over the course of many years has shown that
  * port 9418 is totally unused by anything else. Or
diff --git a/daemon.c b/daemon.c
index 0c6182f..c197ee5 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,3 +1,4 @@
+#include "main.h"
 #include "cache.h"
 #include "pkt-line.h"
 #include <signal.h>
diff --git a/main.h b/main.h
new file mode 100644
index 0000000..472f134
--- /dev/null
+++ b/main.h
@@ -0,0 +1,22 @@
+/* unistd.h must be available and the glibc version includes features.h
+ * from it which #defines __GLIBC__ and friends */
+#include <unistd.h>
+#ifndef __GLIBC__
+const char *git_progname;
+static int git_main(int, char **);
+
+int main(int argc, char **argv)
+{
+	char *p;
+	git_progname = p = *argv;
+
+	/* don't use any library functions. We won't have the headers */
+	while(*p)
+		if(*p++ == '/')
+			git_progname = p;
+
+	return git_main(argc, argv);
+}
+
+#define main(argc, argv) git_main(argc, argv)
+#endif /* __GLIBC__ */

--------------020600090706070709030509--
