From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: slow git-cherry-pick.
Date: Tue, 03 Dec 2013 21:13:43 +0100
Message-ID: <87fvq9n154.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <2142926.gg3W3MsbJZ@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: pawel.sikora@agmk.net
X-From: git-owner@vger.kernel.org Tue Dec 03 21:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnwLz-0000pr-Mb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 21:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab3LCUNv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 15:13:51 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:43828 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125Ab3LCUNv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Dec 2013 15:13:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id D187C4D6563;
	Tue,  3 Dec 2013 21:13:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gEhPgMtQck9k; Tue,  3 Dec 2013 21:13:44 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 1E2544D64C4;
	Tue,  3 Dec 2013 21:13:44 +0100 (CET)
In-Reply-To: <2142926.gg3W3MsbJZ@localhost.localdomain> (=?utf-8?Q?=22Pawe?=
 =?utf-8?Q?=C5=82?= Sikora"'s
	message of "Sun, 24 Nov 2013 11:45:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238730>

Pawe=C5=82 Sikora <pawel.sikora@agmk.net> writes:
>

Umm, there's a gem here that the thread missed so far:

> my git repo isn't very big[1] but it's checked out on the linear lvm
> where random i/o generally hurts and strace shows that current git ve=
rsion
> performs 2x{lstat}+1x{open,read,close} [2] on whole checkout before
           ^^^^^^^^^

There's no reason why it should do the lstat() *twice* for every file.
But Pawe=C5=82 is right; the code path roughly goes like this:

int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
{
[...]
	res =3D sequencer_pick_revisions(&opts);

int sequencer_pick_revisions(struct replay_opts *opts)
{
[...]
	read_and_refresh_cache(opts);
[...]
	return pick_commits(todo_list, opts);
}

static int pick_commits(struct commit_list *todo_list, struct replay_op=
ts *opts)
{
[...]
	read_and_refresh_cache(opts);


I'm too tired to dig further, but AFAICT it's just a rather obvious cas=
e
of duplication of effort.

--=20
Thomas Rast
tr@thomasrast.ch
