From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Sun, 21 Apr 2013 17:56:23 +0200
Message-ID: <8738ujubbs.fsf@hexa.v.cablecom.net>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
	<20130420140051.GB29454@ruderich.org>
	<7vd2towdiq.fsf@alter.siamese.dyndns.org>
	<CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
	<20130421102150.GJ10429@elie.Belkin>
	<CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	"Tay Ray Chuan" <rctay89@gmail.com>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 17:56:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTwd8-0001Ew-OD
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 17:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab3DUP41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 11:56:27 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:18159 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab3DUP41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 11:56:27 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 21 Apr
 2013 17:56:10 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 21 Apr
 2013 17:56:24 +0200
In-Reply-To: <CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
	(John Tapsell's message of "Sun, 21 Apr 2013 14:46:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221955>

John Tapsell <johnflux@gmail.com> writes:

> On 21 April 2013 11:21, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>> A merge can completely
>> undo important changes made in a side branch and "-c" and "--cc" will
>> not show it.
>
> Wait, what?  This is getting even worse then!  Can you expand on this please?
>
> And then how do I show all of these important changes with a git log -p ?
> Or is it impossible to get a sane output?

It pretty much by definition does not show changes if the merge picks
one side unchanged:

 -c
     [...] lists only files which were modified from all parents.

 --cc
     This flag implies the -c option and further compresses the patch
     output [...]

On top of that, the default history simplification when you specify a
pathspec will only walk the (or any one) unchanged side of such a merge,
so if you filter for a file you wouldn't even find the offending commit
further back in history.

I don't think this can be improved easily with the current one-pass[1]
history/diff generation.  To know what the merge *should* have done,
you'd need to somehow get an idea what parts of the resulting files
should be affected, which AFAICS boils down to redoing the merge.  And
to do that, you need to scan history so far that you can compute the
merge-bases.  Not to mention that redoing all merges while walking
history is somewhat expensive.

You could hack up a script that does the verification manually, by
actually running a merge and comparing the result with what the merge
gave you.  But it's not something that you would want to run by default.


[1]  some things like --simplify-merges are actually another pass, but
the default is to generate everything -- including diffs -- as we go.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
