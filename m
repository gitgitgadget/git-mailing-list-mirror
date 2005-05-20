From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: checkout-cache -f: a better way?
Date: Fri, 20 May 2005 19:55:12 -0400
Message-ID: <428E78E0.4010503@pobox.com>
References: <428E5102.60003@pobox.com> <Pine.LNX.4.58.0505201626560.2206@ppc970.osdl.org> <Pine.LNX.4.58.0505201641160.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040708040708070304060700"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 01:55:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZHKo-0006CX-Nn
	for gcvg-git@gmane.org; Sat, 21 May 2005 01:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVETX4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 19:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVETX4G
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 19:56:06 -0400
Received: from mail.dvmed.net ([216.237.124.58]:38586 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261609AbVETXzQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 19:55:16 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DZHKl-0000Lk-75; Fri, 20 May 2005 23:55:15 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505201641160.2206@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708040708070304060700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Fri, 20 May 2005, Linus Torvalds wrote:
> 
>>In other words, those lines in your script should look like this:
>>
>>	git-read-tree -m HEAD && git-checkout-cache -q -f -u -a
>>
>>and you'll be a lot happier.
> 
> 
> Btw, I do realize that I'm a total wiener, and that my inability to use 
> "getopt_long()" is shameful and stupid. 

info libc argp :)  argp is a lot more flexible, but with the same basic 
structure as getopt_long().

If you pick a random git program, I would be willing to convert it as an 
example.  I attached my implementation of ipcrm[1] as an example.

	Jeff


[1] from 'posixutils', my project to implement all the POSIX command 
line utilities.  Yes, I'm crazy too.

--------------040708040708070304060700
Content-Type: text/x-csrc;
 name="ipcrm.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipcrm.c"

/*
 * Copyright 2004-2005 Jeff Garzik <jgarzik@pobox.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */


#ifndef HAVE_CONFIG_H
#error missing autoconf-generated config.h.
#endif
#include "posixutils-config.h"

#include <sys/types.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include <argp.h>
#include <libpu.h>


static const char doc[] =
N_("ipcrm - remove a message queue, semaphore set or shared memory id");

static struct argp_option options[] = {
	{ NULL, 'q', "msgid", 0,
	  N_("Remove message queue identifier msgid from system") },
	{ NULL, 'm', "shmid", 0,
	  N_("Remove shared memory identifier shmid from system") },
	{ NULL, 's', "semid", 0,
	  N_("Remove semaphore identifier semid from system") },
	{ NULL, 'Q', "msgkey", 0,
	  N_("Remove message queue identifier, created with key msgkey, from system") },
	{ NULL, 'M', "shmkey", 0,
	  N_("Remove shared memory identifier, created with key shmkey, from system") },
	{ NULL, 'S', "semkey", 0,
	  N_("Remove semaphore identifier, created with key semkey, from system") },
	{ }
};

static error_t parse_opt (int key, char *arg, struct argp_state *state);
static const struct argp argp = { options, parse_opt, NULL, doc };

enum parse_options_bits {
	OPT_MSG			= (1 << 0),
	OPT_SHM			= (1 << 1),
	OPT_SEM			= (1 << 2),
	OPT_KEY			= (1 << 3),
};

struct arglist {
	struct arglist		*next;
	int			mask;
	unsigned long		arg;
};

#ifdef _SEM_SEMUN_UNDEFINED
   union semun
   {
     int val;
     struct semid_ds *buf;
     unsigned short int *array;
     struct seminfo *__buf;
   };
#endif

static int exit_status = EXIT_SUCCESS;
static struct arglist *arglist;


static const char *arg_name(int mask)
{
	if (mask & OPT_MSG) return "msg";
	if (mask & OPT_SHM) return "shm";
	if (mask & OPT_SEM) return "sem";
	return NULL;
}

static void push_opt(int mask, unsigned long arg)
{
	struct arglist *tmp, *node = xcalloc(1, sizeof(struct arglist));

	node->mask = mask;
	node->arg = arg;

	tmp = arglist;
	if (!tmp) {
		arglist = node;
	} else {
		while (tmp->next)
			tmp = tmp->next;
		tmp->next = node;
	}
}

static void push_arg_opt(int mask, const char *arg)
{
	int base = (mask & OPT_KEY) ? 0 : 10;
	char *end = NULL;
	unsigned long l;

	l = strtoul(arg, &end, base);

	if ((*end != 0) ||	/* entire string is -not- valid */
	    ((mask & OPT_KEY) && (l == IPC_PRIVATE))) {
		fprintf(stderr, "%s%s '%s' invalid\n",
			arg_name(mask),
			mask & OPT_KEY ? "key" : "id",
			arg);
		exit_status = EXIT_FAILURE;
		return;
	}

	push_opt(mask, l);
}

static error_t parse_opt (int key, char *arg, struct argp_state *state)
{
	switch (key) {
	case 'q': push_arg_opt(OPT_MSG, arg); break;
	case 'm': push_arg_opt(OPT_SHM, arg); break;
	case 's': push_arg_opt(OPT_SEM, arg); break;
	case 'Q': push_arg_opt(OPT_MSG | OPT_KEY, arg); break;
	case 'M': push_arg_opt(OPT_SHM | OPT_KEY, arg); break;
	case 'S': push_arg_opt(OPT_SEM | OPT_KEY, arg); break;

	default:
		return ARGP_ERR_UNKNOWN;
	}

	return 0;
}

static void pinterr(const char *msg, long l)
{
	fprintf(stderr, msg, l, strerror(errno));
	exit_status = 1;
}

static void remove_one(int mask, unsigned long arg)
{
	int rc;
	int id = (int) arg;
	const char *errmsg = NULL;

	if (mask & OPT_KEY) {
		if (mask & OPT_MSG)
			id = msgget(arg, 0);
		else if (mask & OPT_SHM)
			id = shmget(arg, 0, 0);
		else if (mask & OPT_SEM)
			id = semget(arg, 0, 0);
		else
			abort();	/* should never happen */
	}

	if (id < 0) {
		pinterr("key 0x%lx lookup failed: %s\n", arg);
		return;
	}

	if (mask & OPT_MSG) {
		rc = msgctl(id, IPC_RMID, NULL);
		errmsg = "msgctl(0x%x): %s\n";
	}
	else if (mask & OPT_SHM) {
		rc = shmctl(id, IPC_RMID, NULL);
		errmsg = "shmctl(0x%x): %s\n";
	}
	else if (mask & OPT_SEM) {
		union semun dummy;
		dummy.val = 0;

		rc = semctl(id, 0, IPC_RMID, dummy);
		errmsg = "semctl(0x%x): %s\n";
	}

	else
		abort();	/* should never happen */

	if (rc < 0) {
		fprintf(stderr, errmsg, id, strerror(errno));
		exit_status = 1;
	}
}

static void remove_stuff(void)
{
	struct arglist *tmp = arglist;

	while (tmp) {
		remove_one(tmp->mask, tmp->arg);
		tmp = tmp->next;
	}
}

int main (int argc, char *argv[])
{
	error_t rc;

	pu_init();

	rc = argp_parse(&argp, argc, argv, 0, NULL, NULL);
	if (rc) {
		fprintf(stderr, "argp_parse failed: %s\n", strerror(rc));
		return 1;
	}

	remove_stuff();

	return exit_status;
}


--------------040708040708070304060700--
