From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] Use explicit pointers for execl...() sentinels.
Date: Sun, 12 Mar 2006 13:59:42 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne18aae.fr9.mdw@metalzone.distorted.org.uk>
References: <20060311192954.GQ16135@artsapartment.org> <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <7v7j6zgaxx.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 12 14:59:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIR6s-0005lU-64
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 14:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWCLN7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 08:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWCLN7r
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 08:59:47 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:30151 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751492AbWCLN7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 08:59:46 -0500
Received: (qmail 25191 invoked by uid 110); 12 Mar 2006 13:59:42 -0000
To: git@vger.kernel.org
Received: (qmail 25178 invoked by uid 9); 12 Mar 2006 13:59:42 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1142171982 25176 172.29.199.2 (12 Mar 2006 13:59:42 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sun, 12 Mar 2006 13:59:42 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17512>

A terminator of `0' (or `NULL', which might well expand to `0') gets
passed as type `int' in the absence of argument type declarations (which
is the case for execl...(), since it uses varargs).  Argument passing
conventions may differ between `int' and `char *' if, say, `int' is 32
bits and pointers a 64; and there's no particular guarantee that a null
pointer has all-bits-zero anyway.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>

---

Junio C Hamano <junkio@cox.net> wrote:

> Patches welcome.  We have about 15 or so such instances.

So we do! ;-)  

---

 cat-file.c    |    2 +-
 connect.c     |    6 +++---
 daemon.c      |    2 +-
 fetch-clone.c |    4 ++--
 git.c         |    2 +-
 imap-send.c   |    2 +-
 merge-index.c |    2 +-
 pager.c       |    2 +-
 rsh.c         |    2 +-
 upload-pack.c |    2 +-
 10 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/cat-file.c b/cat-file.c
index 1a613f3..6310787 100644
--- a/cat-file.c
+++ b/cat-file.c
@@ -136,7 +136,7 @@ int main(int argc, char **argv)
 
 		/* custom pretty-print here */
 		if (!strcmp(type, "tree"))
-			return execl_git_cmd("ls-tree", argv[2], NULL);
+			return execl_git_cmd("ls-tree", argv[2], (char*)0);
 
 		buf = read_sha1_file(sha1, type, &size);
 		if (!buf)
diff --git a/connect.c b/connect.c
index 3f2d65c..a86a111 100644
--- a/connect.c
+++ b/connect.c
@@ -544,7 +544,7 @@ static int git_proxy_connect(int fd[2], 
 		close(pipefd[0][1]);
 		close(pipefd[1][0]);
 		close(pipefd[1][1]);
-		execlp(git_proxy_command, git_proxy_command, host, port, NULL);
+		execlp(git_proxy_command, git_proxy_command, host, port, (char *)0);
 		die("exec failed");
 	}
 	fd[0] = pipefd[0][0];
@@ -643,7 +643,7 @@ int git_connect(int fd[2], char *url, co
 				ssh_basename = ssh;
 			else
 				ssh_basename++;
-			execlp(ssh, ssh_basename, host, command, NULL);
+			execlp(ssh, ssh_basename, host, command, (char *)0);
 		}
 		else {
 			unsetenv(ALTERNATE_DB_ENVIRONMENT);
@@ -651,7 +651,7 @@ int git_connect(int fd[2], char *url, co
 			unsetenv(GIT_DIR_ENVIRONMENT);
 			unsetenv(GRAFT_ENVIRONMENT);
 			unsetenv(INDEX_ENVIRONMENT);
-			execlp("sh", "sh", "-c", command, NULL);
+			execlp("sh", "sh", "-c", command, (char *)0);
 		}
 		die("exec failed");
 	}
diff --git a/daemon.c b/daemon.c
index a1ccda3..13d3974 100644
--- a/daemon.c
+++ b/daemon.c
@@ -260,7 +260,7 @@ static int upload(char *dir)
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
 
 	/* git-upload-pack only ever reads stuff, so this is safe */
-	execl_git_cmd("upload-pack", "--strict", timeout_buf, ".", NULL);
+	execl_git_cmd("upload-pack", "--strict", timeout_buf, ".", (char *)0);
 	return -1;
 }
 
diff --git a/fetch-clone.c b/fetch-clone.c
index da1b3ff..14a1cdf 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -29,7 +29,7 @@ static int finish_pack(const char *pack_
 		dup2(pipe_fd[1], 1);
 		close(pipe_fd[0]);
 		close(pipe_fd[1]);
-		execl_git_cmd("index-pack", "-o", idx, pack_tmp_name, NULL);
+		execl_git_cmd("index-pack", "-o", idx, pack_tmp_name, (char *)0);
 		error("cannot exec git-index-pack <%s> <%s>",
 		      idx, pack_tmp_name);
 		exit(1);
@@ -106,7 +106,7 @@ int receive_unpack_pack(int fd[2], const
 		dup2(fd[0], 0);
 		close(fd[0]);
 		close(fd[1]);
-		execl_git_cmd("unpack-objects", quiet ? "-q" : NULL, NULL);
+		execl_git_cmd("unpack-objects", quiet ? "-q" : (char *)0, (char *)0);
 		die("git-unpack-objects exec failed");
 	}
 	close(fd[0]);
diff --git a/git.c b/git.c
index 0b40e30..8dd7933 100644
--- a/git.c
+++ b/git.c
@@ -253,7 +253,7 @@ static void show_man_page(const char *gi
 		page = p;
 	}
 
-	execlp("man", "man", page, NULL);
+	execlp("man", "man", page, (char *)0);
 }
 
 static int cmd_version(int argc, const char **argv, char **envp)
diff --git a/imap-send.c b/imap-send.c
index 1b38b3a..825a5cf 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -946,7 +946,7 @@ imap_open_store( imap_server_conf_t *srv
 				_exit( 127 );
 			close( a[0] );
 			close( a[1] );
-			execl( "/bin/sh", "sh", "-c", srvc->tunnel, NULL );
+			execl( "/bin/sh", "sh", "-c", srvc->tunnel, (char *)0);
 			_exit( 127 );
 		}
 
diff --git a/merge-index.c b/merge-index.c
index 024196e..24d4b62 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -23,7 +23,7 @@ static void run_program(void)
 			    arguments[5],
 			    arguments[6],
 			    arguments[7],
-			    NULL);
+			    (char *)0);
 		die("unable to execute '%s'", pgm);
 	}
 	if (waitpid(pid, &status, 0) < 0 || !WIFEXITED(status) || WEXITSTATUS(status)) {
diff --git a/pager.c b/pager.c
index 1364e15..9da76ac 100644
--- a/pager.c
+++ b/pager.c
@@ -11,7 +11,7 @@ static void run_pager(void)
 	if (!prog)
 		prog = "less";
 	setenv("LESS", "-S", 0);
-	execlp(prog, prog, NULL);
+	execlp(prog, prog, (char *)0);
 }
 
 void setup_pager(void)
diff --git a/rsh.c b/rsh.c
index d665269..92ace2f 100644
--- a/rsh.c
+++ b/rsh.c
@@ -103,7 +103,7 @@ int setup_connection(int *fd_in, int *fd
 		close(sv[1]);
 		dup2(sv[0], 0);
 		dup2(sv[0], 1);
-		execlp(ssh, ssh_basename, host, command, NULL);
+		execlp(ssh, ssh_basename, host, command, (char *)0);
 	}
 	close(sv[0]);
 	*fd_in = sv[1];
diff --git a/upload-pack.c b/upload-pack.c
index 47560c9..fbfdbcd 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -89,7 +89,7 @@ static void create_pack_file(void)
 	dup2(fd[0], 0);
 	close(fd[0]);
 	close(fd[1]);
-	execl_git_cmd("pack-objects", "--stdout", NULL);
+	execl_git_cmd("pack-objects", "--stdout", (char *)0);
 	die("git-upload-pack: unable to exec git-pack-objects");
 }
 

-- [mdw]
