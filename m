From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Plans for the vcs-svn-pu branch
Date: Fri, 11 Feb 2011 21:19:15 +0530
Message-ID: <20110211154910.GB7335@kytes>
References: <20101107112129.GA30042@burratino>
 <20101121063149.GA15449@burratino>
 <20101205113717.GH4332@burratino>
 <20110105233915.GB22975@burratino>
 <20110211090931.GA27410@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 16:48:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnvEP-0002Ou-3j
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 16:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379Ab1BKPsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 10:48:19 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56446 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757234Ab1BKPsS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 10:48:18 -0500
Received: by gxk9 with SMTP id 9so1123147gxk.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 07:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=blLUkvB6AMVNUvnpT4y0cWIs46YkgeuFv2Ss+Ul77YE=;
        b=PlarkD9BMUn/bsUORRp3N7SU7Nxo6h3FXZScLnYkcN0DRmwCMHIoljKnPiUDASYzSg
         OClgzfU5V89eFlmwcHARxt3A1uLKM+OaFETqRwCqDET16Wjz8LP8djNdeub9m1FIiX2s
         61FEzZZ8mMBxa+IP1rJdkzN0+ITxKXxHZ3VGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hHMQ64VGVJ31CI8tON8Vkx3OYBTq2oT5q8/v4LnE4e1lNp856ugC7fFGxFl2MFyMWy
         sadm1TG+XTNp4hZAOXJY9YZ5rHP9QRoHRVFPMtJmj+m0OyPuKiOxo9uFVRKIizbyqpBT
         eW11s14+gb3aOXg+1oR8NA+zP/DwcXy+dO4WM=
Received: by 10.90.54.14 with SMTP id c14mr739213aga.14.1297439297428;
        Fri, 11 Feb 2011 07:48:17 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id g28sm575871yhd.42.2011.02.11.07.48.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 07:48:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110211090931.GA27410@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166562>

Hi,

Jonathan Nieder writes:
> Jonathan Nieder wrote:
> 
> > Here are the topics that are cooking in vcs-svn-pu.

Thanks for the elaborate email. Some updates from my side:
- I've rewritten most of the svnload parser to resemble fast-import,
  and I'd like some preliminary feedback on the design.
- Although most of the dependent infrastructure is in place now, the
  remote-helper branch is still lagging. I'll shortly look into this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
--8<--
/*
 * Produce a dumpfile v3 from a fast-import stream.
 * Load the dump into the SVN repository with:
 * svnrdump load <URL> <dumpfile
 *
 * Licensed under a two-clause BSD-style license.
 * See LICENSE for details.
 */

#include "cache.h"
#include "quote.h"
#include "git-compat-util.h"
#include "dump_export.h"
#include "dir_cache.h"

#define SVN_DATE_FORMAT "%Y-%m-%dT%H:%M:%S.000000Z"
#define SVN_DATE_LEN 27

struct ident
{
	struct strbuf name, email;
	char date[SVN_DATE_LEN + 1];
};

static FILE *infile;
static struct strbuf command_buf = STRBUF_INIT;
static struct strbuf log_buf = STRBUF_INIT;
static struct strbuf path_s = STRBUF_INIT;
static struct strbuf path_d = STRBUF_INIT;
static struct strbuf svn_author = STRBUF_INIT;
static struct ident author = {STRBUF_INIT, STRBUF_INIT, ""};
static struct ident committer = {STRBUF_INIT, STRBUF_INIT, ""};

static int read_next_command(void)
{
	return strbuf_getline(&command_buf, infile, '\n');
}

static void populate_revprops(struct strbuf *props, size_t author_len,
			const char *author, size_t log_len, const char *log,
			size_t date_len, const char *date)
{
	strbuf_reset(props);
	strbuf_addf(props, "K 10\nsvn:author\nV %lu\n%s\n", author_len, author);
	strbuf_addf(props, "K 7\nsvn:log\nV %lu\n%s\n", log_len, log);
	if (date_len)
		/* SVN doesn't like an empty svn:date value */
		strbuf_addf(props, "K 8\nsvn:date\nV %lu\n%s\n", date_len, date);
	strbuf_add(props, "PROPS-END\n", 10);
}

static void parse_ident(const char *buf, struct ident *identp)
{
	char *t, *tz_off;
	int tz_off_buf;
	const struct tm *tm_time;

	/* John Doe <johndoe@email.com> 1170199019 +0530 */
	strbuf_reset(&(identp->name));
	strbuf_reset(&(identp->email));

	if (!buf)
		goto error;
	if (!(tz_off = strrchr(buf, ' ')))
		goto error;
	*tz_off++ = '\0';
	if (!(t = strrchr(buf, ' ')))
		goto error;
	*(t - 1) = '\0'; /* Ignore '>' from email */
	t++;
	tz_off_buf = atoi(tz_off);
	if (tz_off_buf > 1200 || tz_off_buf  < -1200)
		goto error;
	tm_time = time_to_tm(strtoul(t, NULL, 10), tz_off_buf);
	strftime(identp->date, SVN_DATE_LEN + 1, SVN_DATE_FORMAT, tm_time);
	if (!(t = strchr(buf, '<')))
		goto error;
	*(t - 1) = '\0'; /* Ignore ' <' from email */
	t++;

	strbuf_add(&(identp->email), t, strlen(t));
	strbuf_add(&(identp->name), buf, strlen(buf));
	return;
error:
	die("Malformed ident line: %s", buf);
}

static void skip_optional_lf(void)
{
	int term_char = fgetc(stdin);
	if (term_char != '\n' && term_char != EOF)
		ungetc(term_char, stdin);
}

static void parse_data(struct strbuf *dst)
{
	if (prefixcmp(command_buf.buf, "data "))
		die("Expected 'data n' command, found: %s", command_buf.buf);

	if (!prefixcmp(command_buf.buf + 5, "<<")) {
		char *term = xstrdup(command_buf.buf + 5 + 2);
		size_t term_len = command_buf.len - 5 - 2;

		strbuf_reset(&command_buf);
		for (;;) {
			if (read_next_command() == EOF)
				die("EOF in data (terminator '%s' not found)", term);
			if (term_len == command_buf.len
			    && !memcmp(term, command_buf.buf, term_len))
				break;
			if (dst) {
				strbuf_addbuf(dst, &command_buf);
				strbuf_addch(dst, '\n');
			} else
				printf("%s\n", command_buf.buf);
		}
		free(term);
	} else {
		uintmax_t length;

		length = strtoumax(command_buf.buf + 5, NULL, 10);
		if ((size_t)length < length)
			die("Data is too large to use in this context");
		if (!dst) {
			strbuf_reset(&command_buf);
			/* buffer_copy_bytes(&command_buf, (size_t)length); */
		} else
			strbuf_fread(dst, (size_t)length, stdin);
	}

	skip_optional_lf();
}

static const char *get_mode(const char *str, uint16_t *modep)
{
	unsigned char c;
	uint16_t mode = 0;

	while ((c = *str++) != ' ') {
		if (c < '0' || c > '7')
			return NULL;
		mode = (mode << 3) + (c - '0');
	}
	*modep = mode;
	return str;
}

static void file_change_m(void)
{
	const char *p;
	const char *endp;
	uint16_t mode;
	enum node_kind kind;

	p = get_mode(command_buf.buf + 2, &mode);
	if (!p)
		die("Corrupt mode: %s", command_buf.buf);
	switch (mode) {
	case 0644:
	case 0755:
		mode |= S_IFREG;
	case S_IFREG | 0644:
		kind = NODE_KIND_NORMAL;
		break;
	case S_IFREG | 0755:
		kind = NODE_KIND_EXECUTABLE;
		break;
	case S_IFLNK:
		kind = NODE_KIND_SYMLINK;
		break;
	case S_IFGITLINK:
		die("Gitlinks unsupported"); /* TODO */
	case S_IFDIR:
		die("Subdirectories unsupported"); /* TODO */
	default:
		die("Corrupt mode: %s", command_buf.buf);
	}

	if (!prefixcmp(p, "inline"))
		p += 6;
	else
		die ("Non-inlined data unsupported");
	if (*p++ != ' ')
		die("Missing space after dataref: %s", command_buf.buf);

	/* parse out path into path_d */
	strbuf_reset(&path_d);
	if (!unquote_c_style(&path_d, p, &endp)) {
		if (*endp)
			die("Garbage after path in: %s", command_buf.buf);
	} else
		strbuf_addstr(&path_d, p);

	dump_export_m(path_d.buf, kind);
	read_next_command();
	parse_data(NULL); /* parse data and write it to stdout */
}

static void file_change_d(void)
{
	const char *p;
	const char *endp;
	
	p = command_buf.buf + 2;
	/* parse out path into path_d */
	strbuf_reset(&path_d);
	if (!unquote_c_style(&path_d, p, &endp)) {
		if (*endp)
			die("Garbage after path in: %s", command_buf.buf);
	} else
		strbuf_addstr(&path_d, p);
	dump_export_d(path_d.buf);
}

static void file_change_cr(int rename)
{
	const char *p;
	const char *endp;

	p = command_buf.buf + 2;
	strbuf_reset(&path_s);
	if (!unquote_c_style(&path_s, p, &endp)) {
		if (*endp != ' ')
			die("Missing space after source: %s", command_buf.buf);
	} else {
		endp = strchr(p, ' ');
		if (!endp)
			die("Missing space after source: %s", command_buf.buf);
		strbuf_add(&path_s, p, endp - p);
	}

	endp++;
	if (!*endp)
		die("Missing destination: %s", command_buf.buf);

	p = endp;
	strbuf_reset(&path_d);
	if (!unquote_c_style(&path_d, p, &endp)) {
		if (*endp)
			die("Garbage after destination in: %s", command_buf.buf);
	} else
		strbuf_addstr(&path_d, p);

	/* TODO: Check C "path/to/subdir" "" */
	if (rename)
		dump_export_d(path_s.buf);
	dump_export_c(path_d.buf, path_s.buf, 0);
}

static void parse_new_commit()
{
	char *branch;

	/* parse and ignore branch name */
	branch = strchr(command_buf.buf, ' ') + 1;
	read_next_command();
	if (!prefixcmp(command_buf.buf, "mark :"))
		/* parse and ignore mark line */
		read_next_command();
	if (!prefixcmp(command_buf.buf, "author ")) {
		parse_ident(command_buf.buf + 7, &author);
		read_next_command();
	}
	if (!prefixcmp(command_buf.buf, "committer ")) {
		parse_ident(command_buf.buf + 10, &committer);
		read_next_command();
	}
	if (!committer.name.len)
		die("Missing committer line in stream");
	parse_data(&log_buf);
	read_next_command();
	if (!prefixcmp(command_buf.buf, "from "))
		/* TODO: Support copyfrom */
		read_next_command();
	while (!prefixcmp(command_buf.buf, "merge "))
		/* TODO: Support merges */
		read_next_command();

	/* file_change_* */
	while (command_buf.len > 0) {
		if (!prefixcmp(command_buf.buf, "M "))
			file_change_m();
		else if (!prefixcmp(command_buf.buf, "D "))
			file_change_d();
		else if (!prefixcmp(command_buf.buf, "R "))
			file_change_cr(1);
		else if (!prefixcmp(command_buf.buf, "C "))
			file_change_cr(0);
		else if (!prefixcmp(command_buf.buf, "N "))
			; /* ignored */
		else if (!prefixcmp(command_buf.buf, "ls "))
			goto error; /* TODO */
		else if (!strcmp("deleteall", command_buf.buf))
			goto error; /* TODO */
		else
			break;
		if (read_next_command() == EOF)
			break;
	}
	return;
error:
	die("Unsupported command: %s", command_buf.buf);
}

void parse_new_tag()
{
	/* TODO: Support tags */
	return;
}

void parse_reset_branch()
{
	/* TODO */
	return;
}

void build_svn_author(struct ident *author, struct ident *committer)
{
	char *t, *email;

	strbuf_reset(&svn_author);
	email = author->email.len ? author->email.buf : committer->email.buf;
	if ((t = strchr(email, '@')))
		strbuf_add(&svn_author, email, t - email);
	else
		strbuf_addstr(&svn_author, t);
}

void svnload_read(void)
{
	char *val;
	while (read_next_command() != EOF) {
		if ((val = strchr(command_buf.buf, ' ')))
			*val++ = '\0';

		if (!strcmp("blob", command_buf.buf))
			die("Non-inlined blobs unsupported");
		else if (!prefixcmp(command_buf.buf, "ls "))
			goto error; /* TODO */
		else if (!prefixcmp(command_buf.buf, "cat-blob "))
			goto error; /* TODO */
		else if (!prefixcmp(command_buf.buf, "commit "))
			parse_new_commit(val);
		else if (!prefixcmp(command_buf.buf, "tag "))
			parse_new_tag(val);
		else if (!prefixcmp(command_buf.buf, "reset "))
			parse_reset_branch(val);
		else if (!strcmp(command_buf.buf, "checkpoint")
			|| !prefixcmp(command_buf.buf, "progress ")
			|| !prefixcmp(command_buf.buf, "feature ")
			|| !prefixcmp(command_buf.buf, "option "))
			; /* ignored */
		else
			goto error;
	}
error:
	die("Unsupported command: %s", command_buf.buf);
}

int svnload_init(const char *filename)
{
	if (!(infile = filename ? fopen(filename, "r") : stdin))
		die("Cannot open %s: %s", filename, strerror(errno));
	dump_export_init();
	return 0;
}
