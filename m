From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 5/5] Split out the actual commit creation from the
	option parsing etc.
Date: Tue, 31 Jul 2007 10:11:49 -0400
Message-ID: <1185891109.11086.28.camel@hinata.boston.redhat.com>
References: <11858309261111-git-send-email-krh@redhat.com>
	 <11858309311728-git-send-email-krh@redhat.com>
	 <11858309322006-git-send-email-krh@redhat.com>
	 <11858309322915-git-send-email-krh@redhat.com>
	 <11858309332705-git-send-email-krh@redhat.com>
	 <7v8x8xgp3s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 16:12:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFsST-0006Id-Ky
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 16:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759743AbXGaOMS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 10:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759775AbXGaOMS
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 10:12:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55771 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759743AbXGaOMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 10:12:17 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6VEC16x021371;
	Tue, 31 Jul 2007 10:12:01 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VEBwF3005564;
	Tue, 31 Jul 2007 10:11:58 -0400
Received: from [192.168.1.102] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VEBtWS028842;
	Tue, 31 Jul 2007 10:11:55 -0400
In-Reply-To: <7v8x8xgp3s.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.11.4 (2.11.4-1.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54352>

On Mon, 2007-07-30 at 21:43 -0700, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > @@ -85,40 +129,20 @@ int cmd_commit_tree(int argc, const char **arg=
v, const char *prefix)
> >  			parents++;
> >  	}
> > =20
> > -	/* Not having i18n.commitencoding is the same as having utf-8 */
> > -	encoding_is_utf8 =3D is_encoding_utf8(git_commit_encoding);
> > +	buffer =3D NULL;
> > +	if (read_fd(0, &buffer, &len))
> > +		die("Could not read commit message from standard input");
> > =20
> > -	strbuf_init(&sb);
> > -	strbuf_printf(&sb, "tree %s\n", sha1_to_hex(tree_sha1));
> > +	commit_sha1 =3D create_commit(tree_sha1,
> > +				    parent_sha1, parents,
> > +				    xstrdup(git_author_info(1)),
> > +				    xstrdup(git_committer_info(1)),
> > +				    buffer, len);
>=20
> Hmph, the series was so nice so far, but here we have a few new
> leak, presumably so small per process invocation that we do not
> care about?

There's number of buffers that don't get freed: the strbuf, the commit
message buffer, and the strdup'ed author and committer info.  All the
leaks are not critical since the process exits immediately.  As for the
strbuf leak, I was thinking about renaming strbuf_begin to strbuf_reset
and making it public[1], which will then be used for freeing up strbuf
memory.  The message buffer leak should be fixed by adding a
strbuf_read_fd() that just reads it straight into the strbuf.  The
xstrdup's are necessary because fmt_ident uses a static buffer (thanks,
test case :).  We could add rotating static buffers for fmt_ident like
git_path and avoid the strdups, but again, the leaks are not critical.

Kristian

[1] strbuf_begin() is a good name the way it's used in strbuf.c where
it's balanced by strbuf_end(), but as a general purpose reset function
it's better name strbuf_reset(), I think
