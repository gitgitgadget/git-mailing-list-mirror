From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] Add "rcs format diff" support
Date: Sun, 14 May 2006 01:12:14 +0100
Message-ID: <20060514001214.GB27946@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0605131405590.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sun May 14 02:12:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff4Df-0004B0-57
	for gcvg-git@gmane.org; Sun, 14 May 2006 02:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWENAMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 20:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWENAMU
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 20:12:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:15764 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964800AbWENAMT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 20:12:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1Ff4DW-0002kB-Ly; Sun, 14 May 2006 01:12:14 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605131405590.3866@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19952>

On Sat, May 13, 2006 at 02:14:15PM -0700, Linus Torvalds wrote:
> 
> Al was asking for the "diff -n" format, which is the old RCS format, and 
> which is really easy to parse.

Heh... And I've just managed to get around that stuff on plain git.  Have fun:

Use:
	git-remap-data [git-diff arguments] > map
	git-remap map <old-log >remapped-old
	git-remap /dev/null <new-log >remapped-new
	diff -u remapped-old remapped-new
with old-log and new-log being build/sparse/whatever logs produced on
trees in question (for values of "whatever logs" including e.g. grep -n
results, etc.)

git-remap-data builds the description of how lines of old tree are mapped
to the new one; git-remap is a filter using that data to massage log
from the old tree to new one; lines of form
<file>:<line>:<text>
are turned into
N:<new-file>:<new-line>:<text>
if they survive in new tree and
O:<file>:<line>:<text>
otherwise.

Here they are; enjoy.  BTW, that puppy can be used on unified diffs with
zero context; won't catch renames, obviously...

git-remap-data.sh:
#!/bin/sh
GIT_DIFF_OPTS="-u 0" git-diff -M "$@" | git-remap

git-remap.c:

/*
 * Copyright (c) 2006, Al Viro.  All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

char *prefix1 = "a/", *prefix2 = "b/";
size_t len1, len2;

char *line;
size_t size;

void die(char *s)
{
	fprintf(stderr, "remap: %s\n", s);
	exit(1);
}

void Enomem(void)
{
	die("out of memory");
}

void Eio(void)
{
	die("IO error");
}

int getline(FILE *f)
{
	char *s;
	if (!fgets(line, size, f)) {
		if (!feof(f))
			Eio();
		return 0;
	}
	for (s = line + strlen(line); s[-1] != '\n'; s = s + strlen(s)) {
		if (s == line + size - 1) {
			line = realloc(line, 2 * size);
			if (!line)
				Enomem();
			s = line + size - 1;
			size *= 2;
		}
		if (!fgets(s, size - (s - line), f)) {
			if (!feof(f))
				Eio();
			return 1;
		}
	}
	s[-1] = '\0';
	return 1;
}

/* to == 0 -> deletion */
struct range_map {
	int from, to;
};

struct file_map {
	char *name;
	struct file_map *next;
	char *new_name;
	int count;
	int allocated;
	int last;
	struct range_map ranges[];
};

struct file_map *alloc_map(char *name)
{
	struct file_map *map;

	map = malloc(sizeof(struct file_map) + 16 * sizeof(struct range_map));
	if (!map)
		Enomem();
	map->name = map->new_name = strdup(name);
	if (!map->name)
		Enomem();
	map->count = 0;
	map->allocated = 16;
	map->next = NULL;
	map->last = 0;
	return map;
}

/* this is 32bit FNV1 */
uint32_t FNV_hash(char *name)
{
	uint32_t n = 0x811c9dc5;
	while (*name) {
		unsigned char c = *name++;
		n *= 0x01000193;
		n ^= c;
	}
	return n;
}

struct file_map *hash[1024];

int hash_map(struct file_map *map)
{
	int n = FNV_hash(map->name) % 1024;
	struct file_map **p = &hash[n];

	while (*p) {
		if (!strcmp((*p)->name, map->name))
			return 0;
		p = &(*p)->next;
	}
	*p = map;
	if (map->new_name && !map->count)
		return 0;
	if (map->new_name && map->ranges[0].from != 1)
		return 0;
	return 1;
}

struct file_map *find_map(char *name)
{
	static struct file_map *last = NULL;
	int n = FNV_hash(name) % 1024;
	struct file_map *p;

	if (last && !strcmp(last->name, name))
		return last;

	for (p = hash[n]; p && strcmp(p->name, name); p = p->next)
		;
	if (p)
		last = p;
	return p;
}

void parse_map(char *name)
{
	struct file_map *map = NULL;
	struct range_map *range;
	char *s;
	FILE *f;

	f = fopen(name, "r");
	if (!f)
		die("can't open map");
	while (getline(f)) {
		if (line[0] == 'D') {
			if (map && !hash_map(map))
				goto Ebadmap;
			if (line[1] != ' ')
				goto Ebadmap;
			if (strchr(line + 2, ' '))
				goto Ebadmap;
			map = alloc_map(line + 2);
			map->new_name = NULL;
			continue;
		}
		if (line[0] == 'M') {
			if (map && !hash_map(map))
				goto Ebadmap;
			if (line[1] != ' ')
				goto Ebadmap;
			s = strchr(line + 2, ' ');
			if (!s)
				goto Ebadmap;
			*s++ = '\0';
			if (strchr(s, ' '))
				goto Ebadmap;
			map = alloc_map(line + 2);
			if (strcmp(line + 2, s)) {
				map->new_name = strdup(s);
				if (!map->new_name)
					Enomem();
			}
			continue;
		}
		if (!map || !map->new_name)
			goto Ebadmap;
		if (map->count == map->allocated) {
			int n = 2 * map->allocated;
			map = realloc(map, sizeof(struct file_map) +
					   n * sizeof(struct range_map));
			if (!map)
				Enomem();
			map->allocated = n;
		}
		range = &map->ranges[map->count++];
		if (sscanf(line, "%d %d%*c", &range->from, &range->to) != 2)
			goto Ebadmap;
		if (range > map->ranges && range->from <= range[-1].from)
			goto Ebadmap;
	}
	if (map && !hash_map(map))
		goto Ebadmap;
	fclose(f);
	return;
Ebadmap:
	die("bad map");
}

struct range_map *find_range(struct file_map *map, int l)
{
	struct range_map *range = &map->ranges[map->last];
	struct range_map *p;

	if (range->from <= l) {
		p = &map->ranges[map->count - 1];
		if (p->from > l) {
			for (p = range; p->from <= l; p++)
				;
			p--;
		}
	} else {
		for (p = map->ranges; p->from <= l; p++)
			;
		p--;
	}
	map->last = p - map->ranges;
	return p;
}

void mapline(void)
{
	struct file_map *map;
	struct range_map *range;
	unsigned long l;
	char *s1, *s2;
	char *name;

	s1 = strchr(line, ':');
	if (!s1)
		goto noise;
	s2 = strchr(line, ' ');
	if (s2 && s2 < s1)
		goto noise;
	l = strtoul(s1 + 1, &s2, 10);
	if (s2 == s1 + 1 || *s2 != ':' || !l || l > INT_MAX)
		goto noise;
	*s1++ = *s2++ = '\0';
	name = line;
	map = find_map(line);
	if (!map)
		goto new;
	if (!map->new_name)
		goto old;
	name = map->new_name;
	range = find_range(map, l);
	if (!range->to)
		goto old;
	l += range->to - range->from;
new:
	printf("N:%s:%lu:%s\n", name, l, s2);
	return;
old:
	s1[-1] = s2[-1] = ':';
	printf("O:%s\n", line);
	return;
noise:
	printf("%s\n", line);
}

int parse_hunk(int *l1, int *l2, int *n1, int *n2)
{
	unsigned long n;
	char *s, *p;
	if (line[3] != '-')
		return 0;
	n = strtoul(line + 4, &s, 10);
	if (s == line + 4 || n > INT_MAX)
		return 0;
	*l1 = n;
	if (*s == ',') {
		n = strtoul(s + 1, &p, 10);
		if (p == s + 1 || n > INT_MAX)
			return 0;
		*n1 = n;
		if (!n)
			(*l1)++;
	} else {
		p = s;
		*n1 = 1;
	}
	if (*p != ' ' || p[1] != '+')
		return 0;
	n = strtoul(p + 2, &s, 10);
	if (s == p + 2 || n > INT_MAX)
		return 0;
	*l2 = n;
	if (*s == ',') {
		n = strtoul(s + 1, &p, 10);
		if (p == s + 1 || n > INT_MAX)
			return 0;
		*n2 = n;
		if (!n)
			(*l2)++;
	} else {
		p = s;
		*n2 = 1;
	}
	return 1;
}

void parse_diff(void)
{
	int skipping = -1, suppress = 1;
	char *name1 = NULL, *name2 = NULL;
	int from = 1, to = 1;
	int l1, l2, n1, n2;
	enum cmd {
		Diff, Hunk, New, Del, Copy, Rename, Junk
	} cmd;
	static struct { const char *s; size_t len; } pref[] = {
		[Hunk] = {"@@ ", 3},
		[Diff] = {"diff ", 5},
		[New] = {"new file ", 9},
		[Del] = {"deleted file ", 12},
		[Copy] = {"copy from ", 10},
		[Rename] = {"rename from ", 11},
		[Junk] = {"", 0},
	};
	size_t len1 = strlen(prefix1), len2 = strlen(prefix2);

	while (getline(stdin)) {
		if (skipping > 0) {
			switch (line[0]) {
			case '+':
			case '-':
			case '\\':
				continue;
			}
		}
		for (cmd = 0; strncmp(line, pref[cmd].s, pref[cmd].len); cmd++)
			;
		switch (cmd) {
		case Hunk:
			if (skipping < 0)
				goto Ediff;
			if (!suppress) {
				if (!skipping)
					printf("M %s %s\n", name1, name2);
				if (!parse_hunk(&l1, &l2, &n1, &n2))
					goto Ediff;
				if (l1 > from)
					printf("%d %d\n", from, to);
				if (n1)
					printf("%d 0\n", l1);
				from = l1 + n1;
				to = l2 + n2;
			}
			skipping = 1;
			break;
		case Diff:
			if (!suppress) {
				if (!skipping)
					printf("M %s %s\n", name1, name2);
				printf("%d %d\n", from, to);
			}
			free(name1);
			free(name2);
			name2 = strrchr(line, ' ');
			if (!name2)
				goto Ediff;
			*name2 = '\0';
			name1 = strrchr(line, ' ');
			if (!name1)
				goto Ediff;
			if (strncmp(name1 + 1, prefix1, len1))
				goto Ediff;
			if (strncmp(name2 + 1, prefix2, len2))
				goto Ediff;
			name1 = strdup(name1 + len1 + 1);
			name2 = strdup(name2 + len2 + 1);
			if (!name1 || !name2)
				goto Ediff;
			skipping = 0;
			suppress = 0;
			from = to = 1;
			break;
		case New:
			if (skipping)
				goto Ediff;
			suppress = 1;
			break;
		case Del:
		case Copy:
			if (skipping)
				goto Ediff;
			printf("D %s\n", name2);
			suppress = 1;
			break;
		case Rename:
			if (skipping)
				goto Ediff;
			printf("D %s\n", name2);
			break;
		default:
			break;
		}
	}
	return;
Ediff:
	die("odd diff");
}

int main(int argc, char **argv)
{
	int skipping = 0;
	size = 256;
	line = malloc(size);
	if (!line)
		Enomem();
	if (argc < 2) {
		parse_diff();
	} else {
		parse_map(argv[1]);
		while (getline(stdin))
			mapline();
	}
	return 0;
}
