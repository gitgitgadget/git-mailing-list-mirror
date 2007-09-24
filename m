From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 7/7] Implement git commit as a builtin command.
Date: Mon, 24 Sep 2007 16:27:27 -0400
Message-ID: <1190665647.11372.3.camel@hinata.boston.redhat.com>
References: <1190074008617-git-send-email-krh@redhat.com>
	 <1190074014548-git-send-email-krh@redhat.com>
	 <11900740142347-git-send-email-krh@redhat.com>
	 <11900740153845-git-send-email-krh@redhat.com>
	 <11900740154136-git-send-email-krh@redhat.com>
	 <1190074016669-git-send-email-krh@redhat.com>
	 <11900740163661-git-send-email-krh@redhat.com>
	 <7vk5qmm8hq.fsf@gitster.siamese.dyndns.org>
	 <1190395088.31494.55.camel@hinata.boston.redhat.com>
	 <7vwsujizli.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 22:28:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZuX0-0006HN-Lp
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 22:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513AbXIXU1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2007 16:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757435AbXIXU1n
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 16:27:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53384 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785AbXIXU1m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 16:27:42 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8OKRXNA018936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Sep 2007 16:27:33 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8OKRWPg022054;
	Mon, 24 Sep 2007 16:27:32 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8OKRWj7032706;
	Mon, 24 Sep 2007 16:27:32 -0400
In-Reply-To: <7vwsujizli.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59073>

On Fri, 2007-09-21 at 12:32 -0700, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> >> > +
> >> > +	/* update the user index file */
> >> > +	add_files_to_cache(fd, files, prefix);
> >> > +
> >> > +	if (!initial_commit) {
> >> > +		tree =3D parse_tree_indirect(head_sha1);
> >> > +		if (!tree)
> >> > +			die("failed to unpack HEAD tree object");
> >> > +		if (read_tree(tree, 0, NULL))
> >> > +			die("failed to read HEAD tree object");
> >> > +	}
> >>=20
> >> Huh?  Doesn't this read_tree() defeat the add_files_to_cache()
> >> you did earlier?
> >
> > This is the case where we add the files on the command line
> > to .git/index, but commit from a clean index file corresponding to =
HEAD
> > with the files from the command line added (partial commit?).  The =
first
> > add_files_to_cache() updates .git/index, then we do read_tree() to =
build
> > a tmp index from HEAD and then we add the files again.  The tmp ind=
ex is
> > written to a tmp index file.
>=20
> Still, if you are doing read_tree() that reads into the same
> in-core cache you have just prepared in the add_fiels_to_cache()
> above, potentially overwriting whatever you did, doesn't it?
> That was what I was puzzled about...

Ah, I understand the confusion - add_files_to_cache() will write out th=
e
cache to the given fd and close it.  That's not clear, and I've moved
the write+close part back into prepare_index() in the follow-on patches
I sent that shares out add_files_to_cache() with builtin-add.c.

> > ...  As for just using an in-memory
> > index, I wanted to do it that way originally, but you have to write=
 it
> > to disk after all for the pre-commit hook.
>=20
> Ah, I completely forgot about the hook.  Ok, scratch the idea of
> not using a temporary index file.  The is not much potential for
> performance gain anyway.

Ok, cool, I'll keep the current structure of the code then.

Kristian
