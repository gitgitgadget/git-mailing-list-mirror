From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: slow git-cherry-pick.
Date: Wed, 4 Dec 2013 08:07:23 +0700
Message-ID: <CACsJy8Be2USmGA--FLT3LERTde327Ue65CCjoLHi5SzNzUX1dw@mail.gmail.com>
References: <2142926.gg3W3MsbJZ@localhost.localdomain> <87fvq9n154.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pawel.sikora@agmk.net, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Dec 04 02:08:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo0wZ-0003Qv-HH
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 02:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469Ab3LDBHz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 20:07:55 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:51691 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab3LDBHy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Dec 2013 20:07:54 -0500
Received: by mail-qa0-f45.google.com with SMTP id o15so6160194qap.18
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 17:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=K4t8GIS4sTzOW+63ZVT42lJfdw2wFOws2FL6XdPLGiw=;
        b=P4+KaSOH01NLRl2HEePQeVev1GFWBysP1yLxosVUW1+egjhmUgCJLaadaVqzPjRT+s
         HhxFIyzvy9kyYWro4NcxE5swMWRbF66ZO+sWoutRuZseZUw2atZhfi59XEoAonmFGZJo
         cF6gygtJq+HddqjYkB/VPLrbTIhQxzfkwnYuWewD3LSfvFTnFzuVkYOVASVmON4Pohxl
         RQ6PKjsK06AZmPEihlBCLFEaDkRUGmVgydXXXel7mhm+FB+2l6+M59LFRy/lA/b9xhUL
         5hkKcBVz3iyDjqAwFnCi9h/K0dGVn3wWJgAMMgtQRx1kYNd2A5k5j1wOsxlGCxYWpGk1
         jWdg==
X-Received: by 10.49.1.106 with SMTP id 10mr131593577qel.55.1386119273954;
 Tue, 03 Dec 2013 17:07:53 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Tue, 3 Dec 2013 17:07:23 -0800 (PST)
In-Reply-To: <87fvq9n154.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238748>

On Wed, Dec 4, 2013 at 3:13 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> Pawe=C5=82 Sikora <pawel.sikora@agmk.net> writes:
>>
>
> Umm, there's a gem here that the thread missed so far:
>
>> my git repo isn't very big[1] but it's checked out on the linear lvm
>> where random i/o generally hurts and strace shows that current git v=
ersion
>> performs 2x{lstat}+1x{open,read,close} [2] on whole checkout before
>            ^^^^^^^^^
>
> There's no reason why it should do the lstat() *twice* for every file=
=2E
> But Pawe=C5=82 is right; the code path roughly goes like this:
>
> int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
> {
> [...]
>         res =3D sequencer_pick_revisions(&opts);
>
> int sequencer_pick_revisions(struct replay_opts *opts)
> {
> [...]
>         read_and_refresh_cache(opts);
> [...]
>         return pick_commits(todo_list, opts);
> }
>
> static int pick_commits(struct commit_list *todo_list, struct replay_=
opts *opts)
> {
> [...]
>         read_and_refresh_cache(opts);
>
>
> I'm too tired to dig further, but AFAICT it's just a rather obvious c=
ase
> of duplication of effort.

That's something to optimize, but it's single commit picking,
sequencer_pick_revisions() should call single_pick() instead of
pick_commits().

The read+close on the whole checkout looks like there's problem with
refresh operation and git decides to read up and verify sha-1 by
content. Pawel, if you run "strace git update-index --refresh" twice,
does it still show 1 stat + 1 read for every entry on the second try?
--=20
Duy
