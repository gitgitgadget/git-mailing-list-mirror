From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin
	commands.
Date: Thu, 08 Nov 2007 11:01:48 -0500
Message-ID: <1194537708.27305.6.camel@hinata.boston.redhat.com>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
	 <1194017589-4669-2-git-send-email-krh@redhat.com>
	 <1194017589-4669-3-git-send-email-krh@redhat.com>
	 <1194017589-4669-4-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0711031328500.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 17:04:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq9rT-0000pr-B7
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 17:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761555AbXKHQDE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 11:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758744AbXKHQDD
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 11:03:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48523 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761218AbXKHQDB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 11:03:01 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA8G22ca003639;
	Thu, 8 Nov 2007 11:02:02 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA8G1ujK030424;
	Thu, 8 Nov 2007 11:01:56 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA8G1slP030889;
	Thu, 8 Nov 2007 11:01:55 -0500
In-Reply-To: <Pine.LNX.4.64.0711031328500.4362@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64050>

On Sat, 2007-11-03 at 13:56 +0000, Johannes Schindelin wrote:=20
> Hi,

Hi, wanted to send this out earlier, but I punted it and a couple of
days went by...

> On Fri, 2 Nov 2007, Kristian H=C3=B8gsberg wrote:
>=20
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
> > +		add_files_to_cache(verbose, NULL, files);
> > +		if (write_cache(fd, active_cache, active_nr) || close(fd))
> > +			die("unable to write new_index file");
> > +		return lock_file.filename;
> > +	} else if (also) {
> > +		add_files_to_cache(verbose, prefix, files);
> > +		if (write_cache(fd, active_cache, active_nr) || close(fd))
> > +			die("unable to write new_index file");
> > +		return lock_file.filename;
> > +	}
>=20
> Unless something slips by my mind, this could be written as
>=20
> 	if (all || also) {
> 		add_files_to_cache(verbose, also ? prefix : NULL, files);
> 		...
> 	}

Yup, that looks right.

> > +
> > +	if (interactive)
> > +		interactive_add();
> > +
> > +	if (*files =3D=3D NULL) {
> > +		/* Commit index as-is. */
> > +		rollback_lock_file(&lock_file);
> > +		return get_index_file();
> > +	}
>=20
> Would an interactive add not conflict with this rollback?  And indeed=
 with=20
> the locked index to begin with?

Yes, I've moved the interactive case up to the beginning of
prepare_index() and made it return get_index_file() after running
interactive_add().

> > +	/* update the user index file */
> > +	add_files_to_cache(verbose, prefix, files);
> > +	if (write_cache(fd, active_cache, active_nr) || close(fd))
> > +		die("unable to write new_index file");
>=20
> Does that mean that the index is _always_ written?  Even when not=20
> specifying and paths on the command line?

Do you mean "not specifying any options and paths..."?  In that case we
add the files to the index and create a temporary index from HEAD and
add the files there too, which we then commit.  So we have to write the
index in that case.  If there are no files on the command line, we roll
back the lock and bail out just above the part you quoted.

> > +	/* Uh oh, abusing lock_file to create a garbage collected file */
>=20
> It's not that bad.  But I would mention that it is a temporary index =
which=20
> you are building.

Heh, yeah, I toned it down a bit :)

> > +static const char sign_off_header[] =3D "Signed-off-by: ";
>=20
> Funny, I thought it was a footer ;-)
>=20
> > +	} else if (!stat(template_file, &statbuf)) {
>=20
> Should this not test "if (template_file && " first?

Yup, added.

> > +/* Find out if the message starting at position 'start' in the str=
buf
> > + * contains only whitespace and Signed-off-by lines. */
> > +static int message_is_empty(struct strbuf *sb, int start)
> > +{
> > +	struct strbuf tmpl;
> > +	const char *nl;
> > +	int eol, i;
> > +
> > +	/* See if the template is just a prefix of the message. */
> > +	strbuf_init(&tmpl, 0);
> > +	if (template_file && strbuf_read_file(&tmpl, template_file, 0) > =
0) {
> > +		stripspace(&tmpl, 1);
> > +		if (start + tmpl.len <=3D sb->len &&
> > +		    memcmp(tmpl.buf, sb->buf + start, tmpl.len) =3D=3D 0)
> > +			start +=3D tmpl.len;
> > +	}
> > +	strbuf_release(&tmpl);
>=20
> The release could go inside the if block, no?

Sure, not a big deal, though.

> > +static int run_hook(const char *index_file, const char *name, cons=
t char *arg)
>=20
> Would this function not prefer to live in run-command.c?

Yeah, we can move it later, though.

> > +{
> > +	struct child_process hook;
> > +	const char *argv[3], *env[2];
> > +	char index[PATH_MAX];
> > +
> > +	argv[0] =3D git_path("hooks/%s", name);
> > +	argv[1] =3D arg;
> > +	argv[2] =3D NULL;
> > +	snprintf(index, sizeof(index), "GIT_INDEX_FILE=3D%s", index_file)=
;
> > +	env[0] =3D index;
> > +	env[1] =3D NULL;
> > +
> > +	if (access(argv[0], X_OK) < 0)
> > +		return 0;
>=20
> That check logically belongs 6 lines higher...

You mean you want to do it right after the argv[0] assignment?  I'd lik=
e
to keep the block of assignments together so it's easy to see how the
array is set up.  Don't tell me you worry about performance here... ;)

> > +	rev.abbrev =3D 0;
> > +	rev.diff =3D 1;
> > +	rev.diffopt.output_format =3D
> > +		DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_SUMMARY;
> > +
> > +	rev.verbose_header =3D 1;
> > +	rev.show_root_diff =3D 1;
> > +	rev.commit_format =3D get_commit_format("format:%h: %s");
>=20
> That's interesting.  Wouldn't have thought of that.  Reusing the log_=
tree=20
> machinery to output the summary.  Cute.

Heh, I just did what the shell script did.  It uses git diff-tree for
this, and the above is just the relevant bits from builtin-diff-tree.c.

cheers,
Kristian
