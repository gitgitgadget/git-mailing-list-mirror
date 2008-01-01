From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: input validation in receive-pack
Date: Tue, 1 Jan 2008 22:34:51 +0100
Message-ID: <20080101213451.GA26772@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 22:35:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9olc-0000uf-Qx
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 22:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbYAAVey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2008 16:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbYAAVey
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 16:34:54 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:44682 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbYAAVex (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 16:34:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 59468680BED6;
	Tue,  1 Jan 2008 22:34:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 88z7oFsYR8cJ; Tue,  1 Jan 2008 22:34:51 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 3BCE5680BEA4; Tue,  1 Jan 2008 22:34:51 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69446>

In the function "static const char *update(struct command *cmd)" in
receive-pack.c:

|        if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
|            !is_null_sha1(old_sha1) &&
|            !prefixcmp(name, "refs/heads/")) {
|                struct commit *old_commit, *new_commit;
|                struct commit_list *bases, *ent;
|
|                old_commit =3D (struct commit *)parse_object(old_sha1)=
;
|                new_commit =3D (struct commit *)parse_object(new_sha1)=
;
|                bases =3D get_merge_bases(old_commit, new_commit, 1);
|                for (ent =3D bases; ent; ent =3D ent->next)
|                        if (!hashcmp(old_sha1, ent->item->object.sha1)=
)
|                                break;
|                free_commit_list(bases);
|                if (!ent) {
|                        error("denying non-fast forward %s"
|                              " (you should pull first)", name);
|                        return "non-fast forward";
|                }
|        }

As far as I understand the code, it assumes, that sha1 values provided
by the client really point to a commit. Shouldn't there be a check for
the object type?

Some lines above:
|        if (!prefixcmp(name, "refs/") && check_ref_format(name + 5)) {
|                error("refusing to create funny ref '%s' remotely", na=
me);
|                return "funny refname";
|        }

Is this code really correct? All refnames starting with "refs/" may
only contain allowed characters, while all other may contain any
characters (except \0 and \n)?

=46or the updating code path, lock_any_ref_for_update calls
check_ref_format, so the error will happen latter. For the delete code
path, the refname seems not to be checked.

In the update code path, the check is done in refs.c:
| struct ref_lock *lock_any_ref_for_update(const char *ref, const unsig=
ned char *old_sha1, int flags)
| {
|         if (check_ref_format(ref) =3D=3D -1)
|                 return NULL;
|         return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
| }

check_ref_format may also return -2 (less than two name levels) and -3
(* at the end), which are ignored. Is it really intended, that
receive-pack can create such refs.

mfg Martin K=F6gler
