From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 18:23:02 -0500
Message-ID: <200505301823.04338.dtor_core@ameritech.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org> <20050530221214.GA29556@redhat.com> <200505301755.15371.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YB6mCaw3pzM1frg"
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 31 01:26:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dctdq-00034g-QE
	for gcvg-git@gmane.org; Tue, 31 May 2005 01:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVE3X1q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 19:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVE3X0d
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 19:26:33 -0400
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:29519 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261834AbVE3XXO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 19:23:14 -0400
Received: from unknown (HELO mail.corenet.homeip.net) (dtor?core@ameritech.net@68.21.93.207 with login)
  by smtp817.mail.sc5.yahoo.com with SMTP; 30 May 2005 23:23:08 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.8
In-Reply-To: <200505301755.15371.dtor_core@ameritech.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_YB6mCaw3pzM1frg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 30 May 2005 17:55, Dmitry Torokhov wrote:
> On Monday 30 May 2005 17:12, Dave Jones wrote:
> > I realise you've got a nifty bunch of tools to apply a whole mbox of
> > patches, but that's not ideal if all of my patches aren't in mboxes
> > (some I create myself and toss in my spool, some I pull from bugzilla etc..)
> 
> I mercilessly hacked Linus's scripts from git-tools repo to work with
> non-mailbox patches, maybe you can make use of them too. Note that
> stripspace.c is not changed in any way whatsoever and mailsplit.c was
> changed to handle my personal preference of having patch description
> in the form of:
> 
> Input: make blah blah change
> ---
>  
> And Linus's script would eat that line.
> 

Oops, make it mailinfo.c, not mailsplit.c

-- 
Dmitry

--Boundary-00=_YB6mCaw3pzM1frg
Content-Type: text/x-csrc;
  charset="utf-8";
  name="mailinfo.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mailinfo.c"

/*
 * Another stupid program, this one parsing the headers of an
 * email to figure out authorship and subject
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

static FILE *cmitmsg, *patchfile, *filelist;

static char line[1000];
static char date[1000];
static char name[1000];
static char email[1000];
static char subject[1000];

static char *sanity_check(char *name, char *email)
{
	int len = strlen(name);
	if (len < 3 || len > 60)
		return email;
	if (strchr(name, '@') || strchr(name, '<') || strchr(name, '>'))
		return email;
	return name;
}

static int handle_from(char *line)
{
	char *at = strchr(line, '@');
	char *dst;

	if (!at)
		return 0;

/*
* If we already have one email, don't take any confusing lines
*/
	if (*email && strchr(at + 1, '@'))
		return 0;

	while (at > line) {
		char c = at[-1];
		if (isspace(c) || c == '<')
			break;
		at--;
	}
	dst = email;
	for (;;) {
		unsigned char c = *at;
		if (!c || c == '>' || isspace(c))
			break;
		*at++ = ' ';
		*dst++ = c;
	}
	*dst++ = 0;

	at = line + strlen(line);
	while (at > line) {
		unsigned char c = *--at;
		if (isalnum(c))
			break;
		*at = 0;
	}

	at = line;
	for (;;) {
		unsigned char c = *at;
		if (!c)
			break;
		if (isalnum(c))
			break;
		at++;
	}

	at = sanity_check(at, email);

	strcpy(name, at);
	return 1;
}

static void handle_date(char *line)
{
	strcpy(date, line);
}

static void handle_subject(char *line)
{
	strcpy(subject, line);
}

static void add_subject_line(char *line)
{
	while (isspace(*line))
		line++;
	*--line = ' ';
	strcat(subject, line);
}

static int check_special_line(char *line, int len)
{
	static int cont = -1;
	if (!memcmp(line, "From:", 5) && isspace(line[5])) {
		handle_from(line + 6);
		cont = 0;
		return 1;
	}
	if (!memcmp(line, "Date:", 5) && isspace(line[5])) {
		handle_date(line + 6);
		cont = 0;
		return 1;
	}
	if (!memcmp(line, "Subject:", 8) && isspace(line[8])) {
		handle_subject(line + 9);
		cont = 1;
		return 1;
	}
	if (isspace(*line)) {
		switch (cont) {
		case 0:
			fprintf(stderr,
				"I don't do 'Date:' or 'From:' line continuations\n");
			break;
		case 1:
			add_subject_line(line);
			return 1;
		default:
			break;
		}
	}
	cont = -1;
	return 0;
}

static char *cleanup_subject(char *subject)
{
	for (;;) {
		char *p;
		int len, remove;
		switch (*subject) {
		case 'r':
		case 'R':
			if (!memcmp("e:", subject + 1, 2)) {
				subject += 3;
				continue;
			}
			break;
		case ' ':
		case '\t':
		case ':':
			subject++;
			continue;

		case '[':
			p = strchr(subject, ']');
			if (!p) {
				subject++;
				continue;
			}
			len = strlen(p);
			remove = p - subject;
			if (remove <= len * 2) {
				subject = p + 1;
				continue;
			}
			break;
		}
		return subject;
	}
}

static void cleanup_space(char *buf)
{
	unsigned char c;
	while ((c = *buf) != 0) {
		buf++;
		if (isspace(c)) {
			buf[-1] = ' ';
			c = *buf;
			while (isspace(c)) {
				int len = strlen(buf);
				memmove(buf, buf + 1, len);
				c = *buf;
			}
		}
	}
}

/*
* Hacky hacky. This depends not only on -p1, but on
* filenames not having some special characters in them,
* like tilde.
*/
static void show_filename(char *line)
{
	int len;
	char *name = strchr(line, '/');

	if (!name || !isspace(*line))
		return;
	name++;
	len = 0;
	for (;;) {
		unsigned char c = name[len];
		switch (c) {
		default:
			len++;
			continue;

		case 0:
		case ' ':
		case '\t':
		case '\n':
			break;

/* patch tends to special-case these things.. */
		case '~':
			break;
		}
		break;
	}
/* remove ".orig" from the end - common patch behaviour */
	if (len > 5 && !memcmp(name + len - 5, ".orig", 5))
		len -= 5;
	if (!len)
		return;
	fprintf(filelist, "%.*s\n", len, name);
}

static void handle_rest(void)
{
	char *sub = cleanup_subject(subject);
	cleanup_space(name);
	cleanup_space(date);
	cleanup_space(email);
	cleanup_space(sub);
	printf("Author: %s\nEmail: %s\nSubject: %s\nDate: %s\n\n", name, email,
	       sub, date);
	FILE *out = cmitmsg;

	do {
/* Track filename information from the patch.. */
		if (!memcmp("---", line, 3)) {
			out = patchfile;
			show_filename(line + 3);
		}

		if (!memcmp("+++", line, 3))
			show_filename(line + 3);

		fputs(line, out);
	} while (fgets(line, sizeof(line), stdin) != NULL);

	if (out == cmitmsg) {
		fprintf(stderr, "No patch found\n");
		exit(1);
	}

	fclose(cmitmsg);
	fclose(patchfile);
}

static int eatspace(char *line)
{
	int len = strlen(line);
	while (len > 0 && isspace(line[len - 1]))
		line[--len] = 0;
	return len;
}

static void handle_body(void)
{
	int has_from = 0;

/* First line of body can be a From: */
	while (fgets(line, sizeof(line), stdin) != NULL) {
		int len = eatspace(line);
		if (!len)
			continue;
		if (!memcmp("From:", line, 5) && isspace(line[5])) {
			if (!has_from && handle_from(line + 6)) {
				has_from = 1;
				continue;
			}
		}
		line[len] = '\n';
		handle_rest();
		break;
	}
}

static void usage(void)
{
	fprintf(stderr, "mailinfo msg-file path-file filelist-file < email\n");
	exit(1);
}

int main(int argc, char **argv)
{
	int mail_patch = 0;

	if (argc != 4)
		usage();
	cmitmsg = fopen(argv[1], "w");
	if (!cmitmsg) {
		perror(argv[1]);
		exit(1);
	}
	patchfile = fopen(argv[2], "w");
	if (!patchfile) {
		perror(argv[2]);
		exit(1);
	}
	filelist = fopen(argv[3], "w");
	if (!filelist) {
		perror(argv[3]);
		exit(1);
	}
	while (fgets(line, sizeof(line), stdin) != NULL) {
		int len = eatspace(line);
		if (!len) {
			if (!mail_patch)
				fputs("\n", cmitmsg);

			handle_body();
			break;
		}
		if (check_special_line(line, len)) {
			mail_patch = 1;
			rewind(cmitmsg);
		}
		if (!mail_patch) {
			line[len] = '\n';
			fputs(line, cmitmsg);
		}
	}
	return 0;
}

--Boundary-00=_YB6mCaw3pzM1frg--
