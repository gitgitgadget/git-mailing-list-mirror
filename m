From: Luciano Rocha <luciano@eurotux.com>
Subject: backups with git and inotify
Date: Mon, 10 Dec 2007 20:29:11 +0000
Message-ID: <20071210202911.GA14738@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 21:29:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1pG1-0003te-TN
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 21:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbXLJU3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 15:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbXLJU3U
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 15:29:20 -0500
Received: from os.eurotux.com ([216.75.63.6]:50785 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbXLJU3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 15:29:19 -0500
Received: (qmail 9767 invoked from network); 10 Dec 2007 20:29:16 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 10 Dec 2007 20:29:16 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67754>


--DBIVS5p969aUjpLe
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

The following is a work in progress. There are some problems in how I'm
using git and recording the history:

1. I use an opened fd for each monitored directory (and subdirectories),
   (inotify_add_watch_at would be nice).
   I fchdir(fd) when a change happens to register and commit it.

2. git-rm dir/file also removes <dir> if file was the only entry of
   <dir>. So, when committing the removal, git complains that it can't
   find cwd. So I record the parent directory, do the git command, check
   if getcwd() works, and if not do the commit in the parent directory.

3. git-rm (empty) directory fails

4. Changes aren't atomic, but I can live with that and I doubt I would
   be able to make it atomic without implementing a filesystem (FUSE or
   not).

I can work around most of the problems, and rewrite to use recorded path
names instead of directories fd, but before I do that, and while I'm
at the beginning, I'd like to probe for opinions and suggestions.

So, please, suggest.

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ino.c"
Content-Transfer-Encoding: quoted-printable

/*
    monitor with inotify, record with git

    Copyright (C) 2007, Luciano Rocha <luciano@nsk.pt>
    Released under the GPL v2 or later. See LICENSE.GPL.
=20
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
*/

#define _ATFILE_SOURCE 1
#define _GNU_SOURCE 1
#include <sys/inotify.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ilist {
	int fd;
	uint32_t wd;
	struct ilist *prev, *next;
};

typedef struct ilist *ilist;

/* inotify_add_watch macro, with desired mask */
#define INOTIFY_ADD(ifd, dir) (inotify_add_watch((ifd), (dir), \
			IN_CLOSE_WRITE | IN_CREATE \
			| IN_DELETE | IN_DELETE_SELF \
			| IN_MOVED_FROM | IN_MOVED_TO))

/* add directory to inotify watch list
 * inotify_add_watchat would be nice, but it doesn't exist, so
 * read symlink in /proc/self/fd/<dirfd> instead
 */
int add_inotify(int fd, int ifd)
{
	char p[32];
	char *dir;
	int l;
	int wd;
	ssize_t ll;

	snprintf(p, sizeof p, "/proc/self/fd/%d", fd);
	dir =3D NULL;
	l =3D 0;
	do {
		l +=3D 256;
		if (dir)
			free(dir);
		dir =3D malloc(l);
		ll =3D readlink(p, dir, l);
		if (ll < 0) {
			perror(p);
			free(dir);
			return -1;
		}
	} while (ll >=3D l);
	dir[strlen(dir) - 1] =3D '\0';
	wd =3D INOTIFY_ADD(ifd, dir);
	if (wd < 0)
		perror(dir);
	free(dir);
	return wd;
}

/* add watch for directory and each sub-directory, unless
 * there's a .git inside
 */
void add_watch(int root, const char *name, ilist *head, int ifd,
		const char **except, const char **skip)
{
	ilist new;
	DIR *dir;
	struct dirent *d;
	int dirfd, DIRfd;
	int wd;
	int i;

	new =3D malloc(sizeof *new);
	if (!new) {
		perror(name);
		return;
	}

	dirfd =3D openat(root, name, O_RDONLY | O_DIRECTORY | O_NOATIME
			| O_NOFOLLOW);

	if (dirfd < 0) {
		perror(name);
		free(new);
		return;
	}

	if (except) {
		for (i =3D 0; except[i] && faccessat(dirfd, except[i],
					R_OK | X_OK,
					AT_EACCESS | AT_SYMLINK_NOFOLLOW); i++);
		if (except[i]) {
			printf("skipping %s (%s exists)\n", name, except[i]);
			free(new);
			close(dirfd);
			return;
		}
	}

	wd =3D add_inotify(dirfd, ifd);
	if (wd < 0) {
		free(new);
		close(dirfd);
		return;
	}

	DIRfd =3D dup(dirfd);
	dir =3D fdopendir(DIRfd);
	if (!dir) {
		perror(name);
		free(new);
		close(dirfd);
		close(DIRfd);
		inotify_rm_watch(ifd, wd);
		return;
	}

	while ((d =3D readdir(dir))) {
		if (!S_ISDIR(d->d_type << 12))
			continue;
		if (d->d_name[0] =3D=3D '.' && (d->d_name[1] =3D=3D '\0'
					|| (d->d_name[1] =3D=3D '.'
						&& d->d_name[2] =3D=3D '\0')))
			continue;

		if (skip) {
			for (i =3D 0; skip[i] && strcmp(skip[i], d->d_name); i++);
			if (skip[i])
				continue;
		}

		add_watch(dirfd, d->d_name, head, ifd, except, skip);
	}
	closedir(dir);

	/* add to list */
	new->fd =3D dirfd;
	new->wd =3D wd;
	new->next =3D *head;
	if (*head) (*head)->prev =3D new;
	new->prev =3D NULL;
	*head =3D new;
}

static const char *default_except[] =3D {
	".git",
	NULL,
};

/* add watch to a directory and its sub-directories, complain and do
 * nothing if no .git exists
 */
void git_watch(const char *name, ilist *head, int ifd, const char **skip)
{
	ilist new;
	DIR *dir;
	struct dirent *d;
	int dirfd, DIRfd;
	int wd;
	int i;

	new =3D malloc(sizeof *new);
	if (!new) {
		perror(name);
		return;
	}

	dirfd =3D open(name, O_RDONLY | O_DIRECTORY | O_NOATIME | O_NOFOLLOW);

	if (dirfd < 0) {
		perror(name);
		free(new);
		return;
	}

	if (faccessat(dirfd, ".git", R_OK | X_OK,
				AT_EACCESS | AT_SYMLINK_NOFOLLOW)) {
		fprintf(stderr, "couldn't access .git subdir of %s: %s\n",
				name, strerror(errno));
		free(new);
		close(dirfd);
		return;
	}

	wd =3D INOTIFY_ADD(ifd, name);
	if (wd < 0) {
		perror(name);
		free(new);
		close(dirfd);
		return;
	}

	DIRfd =3D dup(dirfd);
	dir =3D fdopendir(DIRfd);
	if (!dir) {
		perror(name);
		free(new);
		close(dirfd);
		close(DIRfd);
		inotify_rm_watch(ifd, wd);
		return;
	}

	while ((d =3D readdir(dir))) {
		if (!S_ISDIR(d->d_type << 12))
			continue;
		if (d->d_name[0] =3D=3D '.' && (d->d_name[1] =3D=3D '\0'
					|| (d->d_name[1] =3D=3D '.'
						&& d->d_name[2] =3D=3D '\0')))
			continue;
		if (!strcmp(".git", d->d_name))
			continue;
		if (skip) {
			for (i =3D 0; skip[i] && strcmp(skip[i], d->d_name); i++);
			if (skip[i])
				continue;
		}

		add_watch(dirfd, d->d_name, head, ifd, default_except, skip);
	}
	closedir(dir);

	/* add to list */
	new->fd =3D dirfd;
	new->wd =3D wd;
	new->next =3D *head;
	if (*head) (*head)->prev =3D new;
	new->prev =3D NULL;
	*head =3D new;
}

/* run a shell command, abort on error
 */
void run_command(char *argv[])
{
	pid_t pid;
	int status;

	pid =3D fork();
	if (pid < 0) {
		perror("fork(2)");
		exit(1);
	}

	if (pid =3D=3D 0) {
		execvp(argv[0], argv);
		perror(argv[0]);
		exit(1);
	}

	if (waitpid(pid, &status, 0) < 0) {
		perror("couldn't wait for child");
		exit(1);
	}

	if (WIFEXITED(status) && WEXITSTATUS(status) =3D=3D 0)
		return;

	fprintf(stderr, "sub-command %s returned invalid exit code: %d\n",
			argv[0], status);
	exit(1);
}

/* run git command, and follow it with git-commit
 */
void run_git(int fd, char *cmd, char *what)
{
	int parent;
	int cl =3D strlen(cmd);
	int wl =3D strlen(what);
	char commit[cl + wl + 5];
	char *argv[] =3D {
		"git",
		cmd,
		what,
		NULL,
	};

	if (fchdir(fd))
		return;

	/* save parent:
	 * git-rm of last file in subdir removes the directory, so the
	 * following git-commit fails
	 */
	parent =3D open("..", O_RDONLY | O_DIRECTORY | O_NOATIME | O_NOFOLLOW);

	/* run git sub-command */
	run_command(argv);

	if (getcwd(commit, cl + wl) =3D=3D NULL && errno !=3D ERANGE && parent >=
=3D 0) {
		printf("errno: %d, %s\n", errno, strerror(errno));
		fchdir(parent);
	}

	/* create commit message */
	commit[0] =3D '-';
	commit[1] =3D 'm';
	memcpy(commit + 2, cmd, cl);
	commit[cl + 2] =3D ':';
	commit[cl + 3] =3D ' ';
	memcpy(commit + cl + 4, what, wl + 1);

	/* commit change(s) */
	argv[1] =3D "commit";
	argv[2] =3D commit;
	run_command(argv);
}

/* get inotify events, run git as appropriate
 */
void check_event(void *buffer, int len, ilist *head, int ifd)
{
	while (len >=3D sizeof(struct inotify_event)) {
		struct inotify_event *p =3D buffer;
		ilist l;

		/* advance buffer position */
		len -=3D sizeof(struct inotify_event) + p->len;
		buffer +=3D sizeof(struct inotify_event) + p->len;

		for (l =3D *head; l && l->wd !=3D p->wd; l =3D l->next);

		if (!l) {
			/* not found in list? */
			continue;
		}

		if (p->mask & (IN_IGNORED | IN_UNMOUNT | IN_DELETE_SELF)) {
			/* remove it */
			inotify_rm_watch(ifd, p->wd);
			close(l->fd);

			if (l->prev)
				l->prev->next =3D l->next;
			else
				*head =3D l->next;

			if (l->next)
				l->next->prev =3D l->prev;
		}

		/* the following events require a file name specification,
		 * changes to the directory itself aren't of our interest
		 */
		if (p->len =3D=3D 0)
			continue;

		if (p->mask & IN_CREATE) {
			/* add new watch if directory, otherwise ignore,
			 * IN_CLOSE_WRITE should follow
			 */
			struct stat st;
			if (!fstatat(l->fd, p->name, &st, AT_SYMLINK_NOFOLLOW)
					&& S_ISDIR(st.st_mode))
				add_watch(l->fd, p->name, head, ifd,
						default_except, NULL);
		}

		if (p->mask & (IN_CLOSE_WRITE | IN_MOVED_TO)) {
			/* add/commit */
			run_git(l->fd, "add", p->name);
		}


		if (p->mask & (IN_DELETE | IN_MOVED_FROM)) {
			/* rm/commit */
			run_git(l->fd, "rm", p->name);
		}
	}
}

int main(int argc, char *argv[])
{
	int fd;
	int i;
	ilist head;
	void *buffer;

	fd =3D inotify_init();
	if (fd < 0) {
		perror("init inotify");
		return 1;
	}


	buffer =3D malloc(1<<20);
	if (!buffer) {
		perror("buffer allocation");
		return 1;
	}

	head =3D NULL;

	while (*++argv) {
		git_watch(*argv, &head, fd, NULL);
	}

	if (!head) {
		printf("nothing to do\n");
		return 0;
	}

	/* loop until there's an error or all watched elements are
	 * removed or made inaccessible
	 */
	while (head) {
		i =3D read(fd, buffer, 1<<20);
		if (i =3D=3D 0 || (i < 0 && errno !=3D EINTR && errno !=3D EAGAIN))
			break;
		if (i < 0)
			continue;
		check_event(buffer, i, &head, fd);
	}

	if (i < 0) {
		perror("reading event");
		return 1;
	}

	return 0;
}

--uAKRQypu60I7Lcqm--

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHXaGXinSul6a7oB8RAs5tAKCZonft55kqVTlHKyC16ZmzIq+LqACeNhpv
ZlfYYGN8bTG/m7kmF3MATf8=
=TEP0
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
