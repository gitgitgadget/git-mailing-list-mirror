From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Wed, 27 Apr 2005 15:57:53 -0400
Message-ID: <20050427195753.GB7793@thunk.org>
References: <200504261138.46339.mason@suse.com> <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org> <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org> <20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com> <871x8wb6w4.fsf@deneb.enyo.de> <20050427151357.GH1087@cip.informatik.uni-erlangen.de> <426FDFCD.6000309@zytor.com> <20050427190144.GA28848@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 27 21:54:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQsbb-0008I5-EG
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 21:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVD0T7R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 15:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVD0T7R
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 15:59:17 -0400
Received: from thunk.org ([69.25.196.29]:30902 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261986AbVD0T6R (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 15:58:17 -0400
Received: from root (helo=thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 3.35 #1 (Debian))
	id 1DQsfW-0000r8-00; Wed, 27 Apr 2005 15:57:58 -0400
Received: from tytso by thunk.org with local (Exim 4.50)
	id 1DQsfR-00023n-Na; Wed, 27 Apr 2005 15:57:53 -0400
To: "H. Peter Anvin" <hpa@zytor.com>,
	Florian Weimer <fw@DENEB.ENYO.DE>,
	Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, magnus.damm@gmail.com,
	mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"H. Peter Anvin" <hpa@zytor.com>, Florian Weimer <fw@DENEB.ENYO.DE>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	magnus.damm@gmail.com, mason@suse.com, mike.taht@timesys.com,
	mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050427190144.GA28848@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2005 at 09:01:44PM +0200, Thomas Glanzmann wrote:
> Hello,
> 
> > Directory hashing slows down operations that do linear sweeps through 
> > the filesystem reading every single file, simply because without 
> > dir_index, there is likely to be a correlation between inode order and 
> > directory order, whereas with dir_index, readdir() returns entries in 
> > hash order.
> 
> thank you for the awareness training. Than mutt should be slower, too.
> Maybe I should repeat that tests.

If you are using the mutt in Debian unstable, it has the patch applied
which qsorts based on inode number returned from readdir(), which is
why you may not have been seeing the problem.

Or you can LD_PRELOAD the attached quick hack....

						- Ted

/*
 * readdir accelerator
 *
 * (C) Copyright 2003, 2004 by Theodore Ts'o.
 *
 * Compile using the command:
 *
 * gcc -o spd_readdir.so -shared spd_readdir.c -ldl
 *
 * %Begin-Header%
 * This file may be redistributed under the terms of the GNU Public
 * License.
 * %End-Header%
 * 
 */

#define ALLOC_STEPSIZE	100
#define MAX_DIRSIZE	0

#define DEBUG

#ifdef DEBUG
#define DEBUG_DIR(x)	{if (do_debug) { x; }}
#else
#define DEBUG_DIR(x)
#endif

#define _GNU_SOURCE
#define __USE_LARGEFILE64

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <errno.h>
#include <dlfcn.h>

struct dirent_s {
	unsigned long long d_ino;
	long long d_off;
	unsigned short int d_reclen;
	unsigned char d_type;
	char *d_name;
};

struct dir_s {
	DIR	*dir;
	int	num;
	int	max;
	struct dirent_s *dp;
	int	pos;
	int	fd;
	struct dirent ret_dir;
	struct dirent64 ret_dir64;
};

static int (*real_closedir)(DIR *dir) = 0;
static DIR *(*real_opendir)(const char *name) = 0;
static struct dirent *(*real_readdir)(DIR *dir) = 0;
static struct dirent64 *(*real_readdir64)(DIR *dir) = 0;
static off_t (*real_telldir)(DIR *dir) = 0;
static void (*real_seekdir)(DIR *dir, off_t offset) = 0;
static int (*real_dirfd)(DIR *dir) = 0;
static unsigned long max_dirsize = MAX_DIRSIZE;
static num_open = 0;
#ifdef DEBUG
static int do_debug = 0;
#endif

static void setup_ptr()
{
	char *cp;

	real_opendir = dlsym(RTLD_NEXT, "opendir");
	real_closedir = dlsym(RTLD_NEXT, "closedir");
	real_readdir = dlsym(RTLD_NEXT, "readdir");
	real_readdir64 = dlsym(RTLD_NEXT, "readdir64");
	real_telldir = dlsym(RTLD_NEXT, "telldir");
	real_seekdir = dlsym(RTLD_NEXT, "seekdir");
	real_dirfd = dlsym(RTLD_NEXT, "dirfd");
	if ((cp = getenv("SPD_READDIR_MAX_SIZE")) != NULL) {
		max_dirsize = atol(cp);
	}
#ifdef DEBUG
	if (getenv("SPD_READDIR_DEBUG"))
		do_debug++;
#endif
}

static void free_cached_dir(struct dir_s *dirstruct)
{
	int i;

	if (!dirstruct->dp)
		return;

	for (i=0; i < dirstruct->num; i++) {
		free(dirstruct->dp[i].d_name);
	}
	free(dirstruct->dp);
	dirstruct->dp = 0;
}	

static int ino_cmp(const void *a, const void *b)
{
	const struct dirent_s *ds_a = (const struct dirent_s *) a;
	const struct dirent_s *ds_b = (const struct dirent_s *) b;
	ino_t i_a, i_b;
	
	i_a = ds_a->d_ino;
	i_b = ds_b->d_ino;

	if (ds_a->d_name[0] == '.') {
		if (ds_a->d_name[1] == 0)
			i_a = 0;
		else if ((ds_a->d_name[1] == '.') && (ds_a->d_name[2] == 0))
			i_a = 1;
	}
	if (ds_b->d_name[0] == '.') {
		if (ds_b->d_name[1] == 0)
			i_b = 0;
		else if ((ds_b->d_name[1] == '.') && (ds_b->d_name[2] == 0))
			i_b = 1;
	}

	return (i_a - i_b);
}


DIR *opendir(const char *name)
{
	DIR *dir;
	struct dir_s	*dirstruct;
	struct dirent_s *ds, *dnew;
	struct dirent64 *d;
	struct stat st;

	if (!real_opendir)
		setup_ptr();

	DEBUG_DIR(printf("Opendir(%s) (%d open)\n", name, num_open++));
	dir = (*real_opendir)(name);
	if (!dir)
		return NULL;

	dirstruct = malloc(sizeof(struct dir_s));
	if (!dirstruct) {
		(*real_closedir)(dir);
		errno = -ENOMEM;
		return NULL;
	}
	dirstruct->num = 0;
	dirstruct->max = 0;
	dirstruct->dp = 0;
	dirstruct->pos = 0;
	dirstruct->dir = 0;

	if (max_dirsize && (stat(name, &st) == 0) && 
	    (st.st_size > max_dirsize)) {
		DEBUG_DIR(printf("Directory size %ld, using direct readdir\n",
				 st.st_size));
		dirstruct->dir = dir;
		return (DIR *) dirstruct;
	}

	while ((d = (*real_readdir64)(dir)) != NULL) {
		if (dirstruct->num >= dirstruct->max) {
			dirstruct->max += ALLOC_STEPSIZE;
			DEBUG_DIR(printf("Reallocating to size %d\n", 
					 dirstruct->max));
			dnew = realloc(dirstruct->dp, 
				       dirstruct->max * sizeof(struct dir_s));
			if (!dnew)
				goto nomem;
			dirstruct->dp = dnew;
		}
		ds = &dirstruct->dp[dirstruct->num++];
		ds->d_ino = d->d_ino;
		ds->d_off = d->d_off;
		ds->d_reclen = d->d_reclen;
		ds->d_type = d->d_type;
		if ((ds->d_name = malloc(strlen(d->d_name)+1)) == NULL) {
			dirstruct->num--;
			goto nomem;
		}
		strcpy(ds->d_name, d->d_name);
		DEBUG_DIR(printf("readdir: %lu %s\n", 
				 (unsigned long) d->d_ino, d->d_name));
	}
	dirstruct->fd = dup((*real_dirfd)(dir));
	(*real_closedir)(dir);
	qsort(dirstruct->dp, dirstruct->num, sizeof(struct dirent_s), ino_cmp);
	return ((DIR *) dirstruct);
nomem:
	DEBUG_DIR(printf("No memory, backing off to direct readdir\n"));
	free_cached_dir(dirstruct);
	dirstruct->dir = dir;
	return ((DIR *) dirstruct);
}

int closedir(DIR *dir)
{
	struct dir_s	*dirstruct = (struct dir_s *) dir;

	DEBUG_DIR(printf("Closedir (%d open)\n", --num_open));
	if (dirstruct->dir)
		(*real_closedir)(dirstruct->dir);

	if (dirstruct->fd >= 0)
		close(dirstruct->fd);
	free_cached_dir(dirstruct);
	free(dirstruct);
	return 0;
}

struct dirent *readdir(DIR *dir)
{
	struct dir_s	*dirstruct = (struct dir_s *) dir;
	struct dirent_s *ds;

	if (dirstruct->dir)
		return (*real_readdir)(dirstruct->dir);

	if (dirstruct->pos >= dirstruct->num)
		return NULL;

	ds = &dirstruct->dp[dirstruct->pos++];
	dirstruct->ret_dir.d_ino = ds->d_ino;
	dirstruct->ret_dir.d_off = ds->d_off;
	dirstruct->ret_dir.d_reclen = ds->d_reclen;
	dirstruct->ret_dir.d_type = ds->d_type;
	strncpy(dirstruct->ret_dir.d_name, ds->d_name,
		sizeof(dirstruct->ret_dir.d_name));

	return (&dirstruct->ret_dir);
}

struct dirent64 *readdir64(DIR *dir)
{
	struct dir_s	*dirstruct = (struct dir_s *) dir;
	struct dirent_s *ds;

	if (dirstruct->dir)
		return (*real_readdir64)(dirstruct->dir);

	if (dirstruct->pos >= dirstruct->num)
		return NULL;

	ds = &dirstruct->dp[dirstruct->pos++];
	dirstruct->ret_dir64.d_ino = ds->d_ino;
	dirstruct->ret_dir64.d_off = ds->d_off;
	dirstruct->ret_dir64.d_reclen = ds->d_reclen;
	dirstruct->ret_dir64.d_type = ds->d_type;
	strncpy(dirstruct->ret_dir64.d_name, ds->d_name,
		sizeof(dirstruct->ret_dir64.d_name));

	return (&dirstruct->ret_dir64);
}

off_t telldir(DIR *dir)
{
	struct dir_s	*dirstruct = (struct dir_s *) dir;

	if (dirstruct->dir)
		return (*real_telldir)(dirstruct->dir);

	return ((off_t) dirstruct->pos);
}

void seekdir(DIR *dir, off_t offset)
{
	struct dir_s	*dirstruct = (struct dir_s *) dir;

	if (dirstruct->dir) {
		(*real_seekdir)(dirstruct->dir, offset);
		return;
	}

	dirstruct->pos = offset;
}

int dirfd(DIR *dir)
{
	struct dir_s	*dirstruct = (struct dir_s *) dir;

	if (dirstruct->dir)
		return (*real_dirfd)(dirstruct->dir);

	return (dirstruct->fd);
}
