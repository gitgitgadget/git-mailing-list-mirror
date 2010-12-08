From: Anders Kaseorg <andersk@ksplice.com>
Subject: Re: [PATCH v2 4/4] describe: Delay looking up commits until searching
 for an inexact match
Date: Wed, 8 Dec 2010 18:47:36 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012081800540.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino> <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <7vfwu9qvew.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1012072204371.23348@dr-wily.mit.edu> <alpine.DEB.2.02.1012072341570.23348@dr-wily.mit.edu> <alpine.DEB.2.02.1012072344000.23348@dr-wily.mit.edu> <7v7hfjkhfm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 01:12:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQU78-0005rV-Tg
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 01:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab0LIAL6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 19:11:58 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35372 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab0LIAL5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 19:11:57 -0500
Received: by qwa26 with SMTP id 26so1917486qwa.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 16:11:56 -0800 (PST)
Received: by 10.229.75.10 with SMTP id w10mr7482329qcj.209.1291852059134;
        Wed, 08 Dec 2010 15:47:39 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id x9sm716273qco.10.2010.12.08.15.47.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 15:47:38 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <7v7hfjkhfm.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163247>

On Wed, 8 Dec 2010, Junio C Hamano wrote:
> You seem to have gone in a slightly different direction with this rer=
oll.
> I am not sure if use of hash_table in this code would actually improv=
e
> anything (aside from the general readability and "reusing code from a=
 good
> infrastructure is a good thing" principle), though, no matter how man=
y
> tags you have in your repository.  In the code from the earlier round=
,
> lookup_commit_reference_gently call in the fallback codepath to popul=
ate
> commit->util used the *obj_hash[] to quickly look up the commits with=
 the
> same object name already.

Yes; the problem now is that, in order to avoid calling replace_name()=20
excessively, I need to resolve all multiply-tagged commits in one pass,=
=20
before I have those commits in the obj_hash.  This could have been done=
=20
with the linked list by deleting any commit_name from the linked list t=
he=20
first time replace_name() decides it should be superseded by a differen=
t=20
commit_name, but the hash table approach seems less fragile to me.  The=
=20
hash table also has the advantage of avoiding the O(#tags * #arguments)=
=20
complexity when describe is given many arguments.

Let me know if you=E2=80=99d like me to try it the other way.

> I don't know how the above would work in the face of hash collisions.

Oh right.  I=E2=80=99ll fix that.

static int set_util(void *chain)
{
	struct commit_name *n;
	for (n =3D chain; n; n =3D n->next) {
		struct commit *c =3D lookup_commit_reference_gently(n->peeled, 1);
		if (c)
			c->util =3D n;
	}
	return 0;
}

> Do we know that all the archs we will be compiled on will be happy wi=
th
> this potentially unaligned access?  hash_filespec() in diffcore-renam=
e.c
> is written in a way to avoid such an issue, and I would feel safer to=
=20
> see this do the same.

I=E2=80=99ll fix that too.

static inline unsigned int hash_sha1(const unsigned char *sha1)
{
	unsigned int hash;
	memcpy(&hash, sha1, sizeof(hash));
	return hash;
}

Anders
