From: Andreas Ericsson <ae@op5.se>
Subject: Re: User-relative paths (was: Server side programs)
Date: Sun, 23 Oct 2005 11:41:52 +0200
Message-ID: <435B5AE0.1060400@op5.se>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020108090701040804070308"
X-From: git-owner@vger.kernel.org Sun Oct 23 11:43:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETcMq-0007H9-Aq
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 11:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVJWJlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 05:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVJWJly
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 05:41:54 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:44235 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751436AbVJWJly
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 05:41:54 -0400
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id BA54E6BD0A
	for <git@vger.kernel.org>; Sun, 23 Oct 2005 11:41:52 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10489>

This is a multi-part message in MIME format.
--------------020108090701040804070308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Are git-receive-pack and git-upload-pack the only two binaries that get 
>>called directly over a SSH-tunnel?
> 
> 
> There are git-ssh-fetch and git-ssh-upload which call each other
> (and the older name pairs git-ssh-push and git-sh-pull do so as
> well).  However, you do not have to use these commit walkers
> over ssh; fetch-pack/upload-pack pair work quite well.
> 
> I think your question is "what is the absolute minimum set of
> binaries you need to allow", so I think the two listed are
> enough.  If you want to let your users coming over SSH *create*
> a new repository on your machine, you would need a bit more,
> though (namely, shell access to run mkdir and git-init-db).
> 

That's good to know.

> 
>>The reason I'm asking is that I'm adding support for userrelative paths 
>>(git pull ssh://host:~user/somedir) and removing the possibilities to 
>>use a compromised but limited account for finding out what other 
>>useraccounts are available.
> 
> 
> Sorry, it is not clear to me what you are adding.  I do this
> regularly:
> 
> 	$ git push kernel.org:git/
> 	$ git fetch kernel.org:git/
> 
> to push into and fetch from $HOME/git/ repository on the other
> end.
> 

Looking at the old code I see that that should work. I'll re-work the 
patch to take this into account. The help-text was a bit fuzzy however, 
and if you tried

	$ git fetch ssh://kernel.org:git

it wouldn't work. Here's how I decided it was somehow broken, or at 
least non-intuitive:

	$ git clone ssh://git.op5.se:git foo
	defaulting to local storage area
	ssh: ssh: Name or service not known
	fatal: unexpected EOF


> Also I can do this already (assuming the other end hangs all
> users under the same directory, presumably /home/$user):
> 
> 	$ git fetch kernel.org:../torvalds/git/
> 
> Are you in addition trying to let me do this:
> 
> 	$ git fetch kernel.org:~torvalds/git/
> 
> which would work even when ~torvalds == /home/torvalds and
> ~junio == /home2/junio, without having to tell people where
> the user home directories are?
> 

Yes. Our servers' home-directories have varying paths and it'd be nice 
to be able to pull other team-members code without having to remember 
how that particular server is configured.

> At one point, Linus posted an outline of "restricted login shell
> for use with git over ssh".  I think you could start from there,
> perhaps extend it so that it checks the binaries *and* pathnames
> the user can specify (e.g. only under your own $HOME is allowed,
> and no /../ in them, or something silly like that).
> 

I found this in the archives:
http://article.gmane.org/gmane.comp.version-control.git/5784/match=restricted+login

Is that what you're referring to?

There's no reason why git-upload-pack and git-receive-pack couldn't be 
used safely with a perfectly ordinary shell provided we're careful about 
giving the same error message for when a directory is missing and when 
it isn't a git archive.

Anyways, the attached patch does this. I've tested all the various 
syntaxes and they work as expected. rsync, http and local files take the 
same syntax as before. I haven't added support for user-relative paths 
to the git-daemon (can't see the point, really) although that can be 
done easily enough.

This patch works without conflicts alongside Johannes Schindelin's 
recent contribution.

Let me know if you want things done differently.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

--------------020108090701040804070308
Content-Type: text/plain;
 name="git-userrelative-paths.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-userrelative-paths.diff"

diff --git a/Makefile b/Makefile
index 903c57c..87188ea 100644
--- a/Makefile
+++ b/Makefile
@@ -115,15 +115,18 @@ PROGRAMS = \
 	git-local-fetch$X git-ls-files$X git-ls-tree$X git-merge-base$X \
 	git-merge-index$X git-mktag$X git-pack-objects$X git-patch-id$X \
 	git-peek-remote$X git-prune-packed$X git-read-tree$X \
-	git-receive-pack$X git-rev-list$X git-rev-parse$X \
+	git-rev-list$X git-rev-parse$X \
 	git-send-pack$X git-show-branch$X \
 	git-show-index$X git-ssh-fetch$X \
 	git-ssh-upload$X git-tar-tree$X git-unpack-file$X \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
-	git-upload-pack$X git-verify-pack$X git-write-tree$X \
+	git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
 	$(SIMPLE_PROGRAMS)
 
+# server side programs called (possibly) over an ssh-tunnel
+SERVERSIDE_PROGRAMS = git-receive-pack$X git-upload-pack$X
+
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS += git-ssh-pull$X git-ssh-push$X
 
@@ -315,7 +318,7 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
 
-all: $(PROGRAMS) $(SCRIPTS)
+all: $(PROGRAMS) $(SCRIPTS) $(SERVERSIDE_PROGRAMS)
 
 all:
 	$(MAKE) -C templates
@@ -359,6 +362,9 @@ git-cherry-pick: git-revert
 %.o: %.S
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
+$(SERVERSIDE_PROGRAMS) : git-%$X : %.o srvside-ssh.o $(LIB_FILE)
+	$(CC) $(ALL_CFLAGS) -o $@ $(filter %o,$^) $(LIBS)
+
 git-%$X: %.o $(LIB_FILE)
 	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
 
@@ -383,6 +389,7 @@ init-db.o: init-db.c
 
 $(LIB_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H)
+$(patsubst git-%$X,%.o,$(SERVERSIDE_PROGRAMS)): $(LIB_H) srvside-ssh.o
 $(DIFF_OBJS): diffcore.h
 
 $(LIB_FILE): $(LIB_OBJS)
@@ -410,9 +417,10 @@ check:
 
 ### Installation rules
 
-install: $(PROGRAMS) $(SCRIPTS)
+install: $(PROGRAMS) $(SCRIPTS) $(SERVERSIDE_PROGRAMS)
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
-	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) $(PROGRAMS) $(SERVERSIDE_PROGRAMS) $(SCRIPTS) \
+		$(call shellquote,$(DESTDIR)$(bindir))
 	sh ./cmd-rename.sh $(call shellquote,$(DESTDIR)$(bindir))
 	$(MAKE) -C templates install
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
diff --git a/connect.c b/connect.c
index b171c5d..0d78b3e 100644
--- a/connect.c
+++ b/connect.c
@@ -436,33 +436,44 @@ static int git_tcp_connect(int fd[2], co
 int git_connect(int fd[2], char *url, const char *prog)
 {
 	char command[1024];
-	char *host, *path;
-	char *colon;
+	char *host, *path, *ptr = NULL;
 	int pipefd[2][2];
 	pid_t pid;
 	enum protocol protocol;
 
+	protocol = PROTO_LOCAL;
 	host = NULL;
 	path = url;
-	colon = strchr(url, ':');
-	protocol = PROTO_LOCAL;
-	if (colon) {
-		*colon = 0;
-		host = url;
-		path = colon+1;
-		protocol = PROTO_SSH;
-		if (!memcmp(path, "//", 2)) {
-			char *slash = strchr(path + 2, '/');
-			if (slash) {
-				int nr = slash - path - 2;
-				memmove(path, path+2, nr);
-				path[nr] = 0;
-				protocol = get_protocol(url);
-				host = path;
-				path = slash;
-			}
+	host = strstr(url, "://");
+	if (host) {
+		*host = '\0';
+		host += 3;
+		protocol = get_protocol(url);
+	}
+	else host = url;
+
+	ptr = strchr(host, ':');
+	path = strchr(host, '/');
+
+	/* leading colon marks relative path for ssh.
+	 * Check for host == url and default to PROTO_SSH to allow
+	 *   $ git fetch kernel.org:git
+	 */
+	if(ptr && (!path || ptr < path)) {
+		if(host == url)
+			protocol = PROTO_SSH;
+
+		if(protocol == PROTO_SSH) {
+			*ptr = '\0';
+			path = ptr + 1;
 		}
 	}
+	else if(path != url) {
+		/* null-terminate host and copy path if it isn't relative */
+		ptr = strdup(path);
+		*path = '\0';
+		path = ptr;
+	}
 
 	if (protocol == PROTO_GIT)
 		return git_tcp_connect(fd, prog, host, path);
diff --git a/receive-pack.c b/receive-pack.c
index 8f157bc..9a040ff 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -8,6 +8,8 @@ static const char receive_pack_usage[] =
 
 static const char unpacker[] = "git-unpack-objects";
 
+extern void srvside_chdir(const char *path, int strict);
+
 static int show_ref(const char *path, const unsigned char *sha1)
 {
 	packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
@@ -265,18 +267,9 @@ int main(int argc, char **argv)
 	if (!dir)
 		usage(receive_pack_usage);
 
-	/* chdir to the directory. If that fails, try appending ".git" */
-	if (chdir(dir) < 0) {
-		if (chdir(mkpath("%s.git", dir)) < 0)
-			die("unable to cd to %s", dir);
-	}
-
-	/* If we have a ".git" directory, chdir to it */
-	chdir(".git");
-	putenv("GIT_DIR=.");
+	/* Find the right directory */
+	srvside_chdir(dir, 0);
 
-	if (access("objects", X_OK) < 0 || access("refs/heads", X_OK) < 0)
-		die("%s doesn't appear to be a git directory", dir);
 	write_head_info();
 
 	/* EOF */
diff --git a/srvside-ssh.c b/srvside-ssh.c
new file mode 100644
index 0000000..0ed5d30
--- /dev/null
+++ b/srvside-ssh.c
@@ -0,0 +1,63 @@
+#include "cache.h"
+#include <unistd.h>
+#include <pwd.h>
+
+extern const char *__progname;
+
+
+/*
+ * Provide support for user-relative paths, but carefully.
+ *
+ * If someone has compromised an account with access limited to a few
+ * commands (git-receive-pack, git-upload-pack) we don't want to let
+ * them find out about other users through git.  We prevent that by the
+ * simple expedient of maintaining the 'path' variable as is and always
+ * supplying the same (not entirely) helpful error message.
+ */
+#define DIR_OOPS \
+	die("%s: '%s': unable to chdir or not a git-archive", __progname, path)
+void srvside_chdir(char *path, int strict)
+{
+	char *dir = path;
+	struct passwd *pw;
+
+	if(chdir(path) < 0 && *path == '~') {
+		char *slash;
+		char *user = (char *)path + 1;
+
+		if((slash = strchr(dir, '/')))
+			*slash = '\0';
+
+		if(!(pw = getpwnam(user))) {
+			if(slash)
+				*slash = '/';
+			DIR_OOPS;
+		}
+		if(chdir(pw->pw_dir) < 0) {
+			DIR_OOPS;
+		}
+
+		/* We're in someones homedir so re-insert the slash (for the
+		 * error message) and set dir just beyond it. If there was no
+		 * spoon we supply the local one */
+		if(slash) {
+			*slash = '/';
+			dir = slash + 1;
+		}
+		else
+			dir = "./";
+	}
+
+	/* chdir to the directory. If that fails, try appending ".git" */
+	if (chdir(dir) < 0) {
+		if (strict || chdir(mkpath("%s.git", dir)) < 0)
+			DIR_OOPS;
+	}
+	if (!strict)
+		chdir(".git");
+
+	if (access("objects", X_OK) || access("refs", X_OK))
+		DIR_OOPS;
+
+	putenv("GIT_DIR=.");
+}
diff --git a/upload-pack.c b/upload-pack.c
index accdba6..356c9b1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -5,6 +5,7 @@
 #include "object.h"
 
 static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
+extern void srvside_chdir(const char *path, int strict);
 
 #define MAX_HAS 256
 #define MAX_NEEDS 256
@@ -202,7 +203,6 @@ static int upload_pack(void)
 
 int main(int argc, char **argv)
 {
-	const char *dir;
 	int i;
 	int strict = 0;
 
@@ -227,20 +227,10 @@ int main(int argc, char **argv)
 	
 	if (i != argc-1)
 		usage(upload_pack_usage);
-	dir = argv[i];
 
-	/* chdir to the directory. If that fails, try appending ".git" */
-	if (chdir(dir) < 0) {
-		if (strict || chdir(mkpath("%s.git", dir)) < 0)
-			die("git-upload-pack unable to chdir to %s", dir);
-	}
-	if (!strict)
-		chdir(".git");
-
-	if (access("objects", X_OK) || access("refs", X_OK))
-		die("git-upload-pack: %s doesn't seem to be a git archive", dir);
+	/* Find the right directory */
+	srvside_chdir(argv[i], strict);
 
-	putenv("GIT_DIR=.");
 	upload_pack();
 	return 0;
 }

--------------020108090701040804070308--
