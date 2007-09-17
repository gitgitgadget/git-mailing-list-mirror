From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 9/9] Implement git commit as a builtin command.
Date: Mon, 17 Sep 2007 18:58:01 -0400
Message-ID: <1190069881.10112.10.camel@hinata.boston.redhat.com>
References: <11890382183913-git-send-email-krh@redhat.com>
	 <11890382242333-git-send-email-krh@redhat.com>
	 <11890382243290-git-send-email-krh@redhat.com>
	 <11890382253220-git-send-email-krh@redhat.com>
	 <11890382252522-git-send-email-krh@redhat.com>
	 <1189038225525-git-send-email-krh@redhat.com>
	 <11890382262161-git-send-email-krh@redhat.com>
	 <11890382264046-git-send-email-krh@redhat.com>
	 <11890382271931-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0709061741370.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:58:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPYA-0001yK-La
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 00:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989AbXIQW6P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 18:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757018AbXIQW6O
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 18:58:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42561 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756589AbXIQW6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 18:58:13 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8HMw7LC016484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Sep 2007 18:58:07 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8HMw7HX003770;
	Mon, 17 Sep 2007 18:58:07 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8HMw698008415;
	Mon, 17 Sep 2007 18:58:06 -0400
In-Reply-To: <Pine.LNX.4.64.0709061741370.28586@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58492>

On Thu, 2007-09-06 at 17:59 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 5 Sep 2007, Kristian H=C3=B8gsberg wrote:
>=20
> >  contrib/examples/git-commit.sh |  665 ++++++++++++++++++++++++++++=
+++++++
> >  git-commit.sh                  |  665 ----------------------------=
-------
>=20
> You might want to use "git format-patch -M" next time ;-)
>=20
> > @@ -357,7 +358,6 @@ BUILTIN_OBJS =3D \
> >  	builtin-rev-parse.o \
> >  	builtin-revert.o \
> >  	builtin-rm.o \
> > -	builtin-runstatus.o \
>=20
> Better keep it; some people's scripts could depend on it.

Seriously?  Why don't we remove it and see if somebody yells?  It's mor=
e
of an implementation detail than most other git commands; if you need
status output in your script why wouldn't you just run git status?

> > +struct option {
> > +    enum option_type type;
> > +    const char *long_name;
> > +    char short_name;
> > +    void *value;
> > +};
> > +
> > +static int scan_options(const char ***argv, struct option *options=
)
> > +{
>=20
> I would not (no longer, anyway) be opposed to replacing the option pa=
rsing=20
> in git with getopt(); I hear that it is small enough to keep a copy i=
n=20
> compat/getopt.c.
>=20
> But let's go forward with builtin-commit; getopt() can come later.

I don't know.  I think it's a situation much like the string library
discussion.  It's a small enough dependency (70 lines!) that there's no
gain in depending on an external implementation, and we can tailor it t=
o
gits needs as we extend the use within git.  And we can call it gitopt!

> > +static char *
> > +prepare_index(const char **files, const char *prefix)
> > +{
> > +	int fd;
> > +	struct tree *tree;
> > +	struct lock_file *next_index_lock;
> > +
> > +	fd =3D hold_locked_index(&lock_file, 1);
> > +	if (read_cache() < 0)
> > +		die("index file corrupt");
> > +
> > +	if (all) {
> > +		add_files_to_cache(fd, files, NULL);
> > +		return lock_file.filename;
> > +	} else if (also) {
> > +		add_files_to_cache(fd, files, prefix);
> > +		return lock_file.filename;
> > +	}
> > +
> > +	if (interactive)
> > +		interactive_add();
> > +
> > +	if (*files =3D=3D NULL) {
> > +		/* Commit index as-is. */
> > +		rollback_lock_file(&lock_file);
> > +		return get_index_file();
> > +	}
> > +
> > +	/*
> > +	 * FIXME: Warn on unknown files.  Shell script does
> > +	 *
> > +	 *   commit_only=3D`git-ls-files --error-unmatch -- "$@"`
> > +	 */
> > +
> > +	/*
> > +	 * FIXME: shell script does
> > +	 *
> > +	 *   git-read-tree --index-output=3D"$TMP_INDEX" -i -m HEAD
> > +	 *
> > +	 * which warns about unmerged files in the index.
> > +	 */
> > +
> > +	/* update the user index file */
> > +	add_files_to_cache(fd, files, prefix);
>=20
> I suspect this, or ...
>=20
> > +
> > +	if (!initial_commit) {
> > +		tree =3D parse_tree_indirect(head_sha1);
> > +		if (!tree)
> > +			die("failed to unpack HEAD tree object");
> > +		if (read_tree(tree, 0, NULL))
> > +			die("failed to read HEAD tree object");
> > +	}
> > +
> > +	/* Uh oh, abusing lock_file to create a garbage collected file */
> > +	next_index_lock =3D xmalloc(sizeof(*next_index_lock));
> > +	fd =3D hold_lock_file_for_update(next_index_lock,
> > +				       git_path("next-index-%d", getpid()), 1);
> > +	add_files_to_cache(fd, files, prefix);
>=20
> ... this, but not both.

No, this needs both.  The first add_files_to_cache() call updates the
user index (.git/index) by adding the given files, then we build a
temporary index from a tree and add the files to that index.

>=20
> > +/* Find out if the message starting at position 'start' in the str=
buf
> > + * contains only whitespace and Signed-off-by lines. */
> > +static int message_is_empty(struct strbuf *sb, int start)
> > +{
> > +	static const char signed_off_by[] =3D "Signed-off-by: ";
>=20
> I think you already defined that globally earlier.

Ah, yes, fixed.

> In the function message_is_empty() you write:
>=20
> > +	/* See if the template is just a prefix of the message. */
> > +	strbuf_init(&tmpl);
> > +	if (template_file && strbuf_read_path(&tmpl, template_file) > 0) =
{
> > +		stripspace(&tmpl, 1);
> > +		if (start + tmpl.len <=3D sb->len &&
> > +		    memcmp(tmpl.buf, sb->buf + start, tmpl.len) =3D=3D 0)
> > +			start +=3D tmpl.len;
>=20
> Could we not bail out here, if there is no match?  In that case, the=20
> message is clearly not empty...

The contents could be just sign-off-by's.

> > +	/* Check if the rest is just whitespace and Signed-of-by's. */
> > +	for (i =3D start; i < sb->len; i++) {
> > +		nl =3D memchr(sb->buf + i, '\n', sb->len - i);
> > +		if (nl)
> > +			eol =3D nl - sb->buf;
> > +		else
> > +			eol =3D sb->len;
>=20
> Why not just "if (isspace(sb->buf[i]) || sb->buf[i] =3D=3D '\n') cont=
inue;"?=20
> This would also catch the cases where people indent their S-O-Bs.
>=20
> > +
> > +		if (strlen(signed_off_by) <=3D eol - i &&
> > +		    !prefixcmp(sb->buf + i, signed_off_by)) {
> > +			i =3D eol;
> > +			continue;
> > +		}
> > +		while (i < eol)
> > +			if (!isspace(sb->buf[i++]))
> > +				return 0;
> > +	}
> > +
> > +	return 1;
> > +}
>=20
> I did not review the rest of the code closely yet...

I'm sending an updated version against Pierre's strbuf changes now.
It's a smaller patch set, so hopefully we can get it in soon.

Kristian
