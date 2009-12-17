From: =?ISO-8859-2?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: potential null dereference
Date: Thu, 17 Dec 2009 13:30:55 +0100
Message-ID: <4B2A247F.4070705@lsrfire.ath.cx>
References: <4B2783DD.5060301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 13:31:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLFVm-0007XJ-P3
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 13:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758917AbZLQMbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2009 07:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756877AbZLQMbM
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 07:31:12 -0500
Received: from india601.server4you.de ([85.25.151.105]:52213 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129AbZLQMbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 07:31:09 -0500
Received: from [10.0.1.101] (p57B7F8B9.dip.t-dialin.net [87.183.248.185])
	by india601.server4you.de (Postfix) with ESMTPSA id 9FD6D2F803F;
	Thu, 17 Dec 2009 13:31:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <4B2783DD.5060301@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135368>

Am 15.12.2009 13:41, schrieb Jiri Slaby:
> Hi,
>=20
> Stanse found the following error in unpack-trees.c:
> dereferencing NULL pointer here.[. * o src_index]
>=20
> int unpack_trees(unsigned len, struct tree_desc *t, struct
> unpack_trees_options *o)
> {
>  int ret;
>  static struct cache_entry *dfc;
> ...
>  if (o->src_index) {                   <-- loc0
>   o->result.timestamp.sec =3D o->src_index->timestamp.sec;
>   o->result.timestamp.nsec =3D o->src_index->timestamp.nsec;
>  }
>  o->merge_size =3D len;
>=20
>  if (!dfc)
>   dfc =3D xcalloc(1, ((1 + (0) + 8) & ~7));
>  o->df_conflict_entry =3D dfc;
>=20
>  if (len) {
> ...
>  }
>=20
>  if (o->merge) {
>   while (o->pos < o->src_index->cache_nr) { <-- here
>=20
> It triggers, because there is a test for o->src_index being NULL at
> loc0, but here, it is dereferenced without a check. Can this happen
> (e.g. does o->merge !=3D NULL imply o->src_index !=3D NULL)?

Running "git grep -w -B70 unpack_trees" and looking for "src_index"
using less' search command showed me that src_index is never NULL when
unpack_trees() is called.

> Further, there is a warning in log-tree.c:
> pointer always points to valid memory here, but checking for not
> NULL.[parents]
>=20
> static int log_tree_diff(struct rev_info *opt, struct commit *commit,
> struct log_info *log)
> {
>  int showed_log;
>  struct commit_list *parents;
>  unsigned const char *sha1 =3D commit->object.sha1;
>=20
>  if (!opt->diff && !((&opt->diffopt)->flags & (1 << 14)))
>   return 0;
>=20
>=20
>  parents =3D commit->parents;
>  if (!parents) {            <-- loc0
>   if (opt->show_root_diff) {
>    diff_root_tree_sha1(sha1, "", &opt->diffopt);
>    log_tree_diff_flush(opt);
>   }
>   return !opt->loginfo;     <-- loc1
>  }
>=20
>  if (parents && parents->next) { <-- here
>=20
> I.e. if parents was NULL at loc0, we escaped at loc1. But we check
> parents against NULL here again.

The check may be duplicate, but I suspect removing it won't change the
resulting object code -- the compiler should be smart enough to come to
the same conclusion.

Thanks,
Ren=E9
