From: Andreas Ericsson <ae@op5.se>
Subject: Re: git binary directory?
Date: Wed, 09 Nov 2005 14:32:36 +0100
Message-ID: <4371FA74.5070504@op5.se>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org> <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511052013550.3316@g5.osdl.org> <7vy84249re.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511060816390.3316@g5.osdl.org> <7v7jbly1lh.fsf@assigned-by-dhcp.cox.net> <20051106221952.GP1431@pasky.or.cz> <7virv5wc86.fsf@assigned-by-dhcp.cox.net> <20051107004346.GR1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020606080001040403060606"
X-From: git-owner@vger.kernel.org Wed Nov 09 14:34:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZq4T-0006jJ-A3
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 14:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVKINck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 08:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVKINcj
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 08:32:39 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:52616 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750751AbVKINci
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 08:32:38 -0500
Received: from [82.182.116.45] (1-2-9-7b.gkp.gbg.bostream.se [82.182.116.45])
	by smtp-gw1.op5.se (Postfix) with ESMTP id C77046BD1B
	for <git@vger.kernel.org>; Wed,  9 Nov 2005 14:32:36 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051107004346.GR1431@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11399>

This is a multi-part message in MIME format.
--------------020606080001040403060606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Petr Baudis wrote:
> 
> I want to avoid extra fork()s and exec()s. They seem to routinely matter
> in orders of magnitude of speed in tight loops.
> 

Give this a whirl. It's still slower than using the git-<something> 
form, but it's quite an improvement anyways.

#############

$ time for i in `seq 1 10000`; do git send-pack --help >/dev/null 2>&1; done

real    0m28.921s
user    0m12.626s
sys     0m14.219s
$ time for i in `seq 1 10000`; do ./git send-pack --help >/dev/null 
2>&1; done

real    0m12.129s
user    0m4.444s
sys     0m7.615s
$ time for i in `seq 1 10000`; do git-send-pack --help >/dev/null 2>&1; done

real    0m9.069s
user    0m3.481s
sys     0m5.558s

##############

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

--------------020606080001040403060606
Content-Type: text/x-csrc;
 name="git.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git.c"

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <limits.h>
#include <stdarg.h>
#include <glob.h>

#ifndef PATH_MAX
# define PATH_MAX 4096
#endif

static const char git_usage[] =
	"Usage: git [ --version ] [ --lib=<GIT_LIB> ] COMMAND [ OPTIONS ] [ TARGET ]";

struct string_list {
	size_t len;
	char *str;
	struct string_list *next;
};

/* most gui terms set COLUMNS (although some don't export it) */
static int columns(void)
{
	char *col_string = getenv("COLUMNS");
	int n_cols = 0;

	if (col_string && (n_cols = atoi(col_string)) > 0)
		return n_cols;

	return 80;
}

static inline void mput_char(char c, unsigned int num)
{
	unsigned int i;

	for(i = 0; i < num; i++)
		putchar(c);
}

static void fmt_print_string_list(struct string_list *list, int longest)
{
	int cols;
	int space = longest + 1; /* space between start of string1 and string2 */
	int max_cols = columns() - 1;

	cols = max_cols / space;

	if(cols < 1) {
		cols = 1;
		space = 0;
	}

	while (list) {
		int c = cols;
		printf("  ");

		for(c = cols; c; c--) {
			if (!list)
				break;

			printf("%s", list->str);

			if (space && c != 1)
				mput_char(' ', space - list->len);

			list = list->next;
		}

		putchar('\n');
	}
}

static void usage(char *path, const char *fmt, ...)
	__attribute__((__format__(__printf__, 2, 3)));

static void usage(char *path, const char *fmt, ...)
{
	struct string_list *list, *tail;
	unsigned int longest = 0, i;
	glob_t gl;

	list = tail = NULL;

	if (!fmt)
		puts(git_usage);
	else {
		printf("git: ");
		va_list ap;
		va_start(ap, fmt);
		vprintf(fmt, ap);
		va_end(ap);
	}

	putchar('\n');

	if (!path)
		exit(1);

	if (chdir(path) < 0) {
		printf("git: '%s': %s\n", path, strerror(errno));
		exit(1);
	}

	printf("\ngit commands available in '%s'\n", path);
	printf("----------------------------");
	mput_char('-', strlen(path));
	putchar('\n');

	glob("git-*", 0, NULL, &gl);
	for (i = 0; i < gl.gl_pathc; i++) {
		int len = strlen(gl.gl_pathv[i] + 4);

		if(access(gl.gl_pathv[i], X_OK))
			continue;

		if (longest < len)
			longest = len;

		if (!tail)
			tail = list = malloc(sizeof(struct string_list));
		else {
			tail->next = malloc(sizeof(struct string_list));
			tail = tail->next;
		}
		tail->len = len;
		tail->str = gl.gl_pathv[i] + 4;
		tail->next = NULL;
	}

	fmt_print_string_list(list, longest);

	puts("\nman-pages can be reached through 'man git-<COMMAND>'\n");

	exit(1);
}

#define DEFAULT_GIT_LIB "/usr/bin"
#define GIT_VERSION "0.99.9.GIT"

int main(int argc, char **argv, char **envp)
{
	char git_command[PATH_MAX + 1];
	char *git_lib = getenv("GIT_LIB");
	char wd[PATH_MAX + 1], libdir[PATH_MAX + 1];

	getcwd(wd, PATH_MAX);

	if(argc == 1) {
		if (git_lib)
			usage(git_lib, NULL);

		usage(DEFAULT_GIT_LIB, NULL);
	}

	argv++;
	/* always *argv since we inc it if we hit an option */
	while (argc-- && !strncmp(*argv, "--", 2)) {
		char *arg = (*argv++) + 2;

		if (!strncmp(arg, "lib=", 3))
			git_lib = arg + 4;
		else if (!strncmp(arg, "version", 7)) {
			printf("git version %s\n", GIT_VERSION);
			exit(0);
		}
		else
			usage (NULL, NULL);
	}

	if (!git_lib)
		git_lib = DEFAULT_GIT_LIB;

	/* allow relative paths, but run with exact */
	if (chdir(git_lib)) {
		printf("git: '%s': %s\n", git_lib, strerror(errno));
		exit (1);
	}

	getcwd(libdir, sizeof(libdir));
	chdir(wd);

	snprintf(git_command, sizeof(git_command), "%s/git-%s", libdir, *argv);

	if (access(git_command, X_OK))
		usage(git_lib, "'%s' is not a git-command", *argv);

	if (execve(git_command, argv, envp)) {
		printf("Failed to run command '%s': %s\n", git_command, strerror(errno));
		return 1;
	}

	/* not reached */

	return 0;
}

--------------020606080001040403060606--
