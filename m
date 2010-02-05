From: Johan Herland <johan@herland.net>
Subject: Re: notes TODOs (was: Re: [PATCH 1/4] gitweb: notes feature)
Date: Fri, 5 Feb 2010 15:46:19 +0100
Message-ID: <201002051546.19406.johan@herland.net>
References: <cb7bb73a1002050444y55f57696gb1b3bd06ab9261ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 15:46:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdPST-0005la-Ht
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 15:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856Ab0BEOqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 09:46:51 -0500
Received: from smtp.opera.com ([213.236.208.81]:57261 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932672Ab0BEOqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 09:46:50 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5) with ESMTP id o15EgZ0j020959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 5 Feb 2010 14:42:41 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <cb7bb73a1002050444y55f57696gb1b3bd06ab9261ac@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139047>

On Friday 05 February 2010, Giuseppe Bilotta wrote:
> On Fri, Feb 5, 2010 at 11:36 AM, Johan Herland wrote:
> > - Better integration with rebase/amend/cherry-pick. Optionally
> > bring notes across a commit rewrite. Controlled by command-line
> > options and/or config variables. Add "git notes move" and "git
> > notes copy" to suit. Junio says:
> > =A0 =A0I used to fix minor issues (styles, decl-after-stmt, etc.) u=
sing
> > =A0 =A0rebase-i long after running "am" in bulk, but these days I f=
ind
> > =A0 =A0myself going back to my "inbox" and fix them in MUA; this is
> > =A0 =A0only because I know these notes do not propagate across reba=
ses
> > =A0 =A0and amends -- adjusting the workflow to the tool's limitatio=
n is
> > =A0 =A0not very good.
>
> It might be useful to this purpose to have a notes.<refname>.* config
> space, like for branches. This would allows us to define
> per-namespace attribute for notes, such as whether or not they get
> across rebases, whether or not (and how) they are output in
> format-patch, in logs, etc

Yes, that is a possibility, but first we need the infrastructure itself=
=20
for doing this.

> > - Junio says:
> > =A0The interface to tell tools to use which notes ref to use should
> > be able to say "these refs", not just "this ref" i.e.
> > GIT_NOTES_REF=3Da:b just like PATH=3Da:b:c...); I am fairly certain
> > that we would want to store different kind of information in
> > separate notes trees and aggregate them, as we gain experience with
> > notes.
>
> I would say that this only makes sense when reading notes, since when
> you are writing a note you probably want to add it to a single
> specific namespace.

Of course.

> > - Junio says:
> > =A0There should be an interface to tell tools to use which notes re=
fs
> > via command line options; "!alias" does not TAB-complete, and "git
> > lgm" above doesn't, either. "git log --notes=3Dnotes/amlog
> > --notes=3Dnotes/other" would probably be the way to go.
>
> As mentioned elsewhere in this thread, this might be better as a git
> option rather than a subcommand option: git --notes-ref=3Damlog:other
> log or git --notes-ref=3D{amlog,other} log.

Maybe. Making it a git option makes it (GIT_NOTES_REF/--notes-ref)=20
consistent with things like GIT_WORK_TREE/--work-tree and=20
GIT_DIR/--git-dir, but then I'm not sure whether notes will affect the=20
behaviour of enough commands to warrant it becoming a git option.

Consider for example the -m/--message subcommand option which can be=20
applied to several subcommands (commit, tag, notes, etc.), but that=20
does not make it a candidate for "promotion" to a git option (i.e.=20
git -m "foo" commit).

> If I may be allowed to add a suggestion to put in the list, I would
> like to see notes attachable to named refs (branch heads in
> particular). From a cursory reading of your patches currently in pu
> it would seem that you explicitly prohibit this case currently.
> However, this has many possible uses, ranging from longer branch
> descriptions to tracking information to improve survival in case of
> remote rebases.

Nope. There is no explicit prohibition on anything. On a fundamental=20
level, Git-notes simply maps a given SHA1 (the annotated object) to=20
another SHA1 (the object holding the annotation itself). In principle=20
you can annotate _any_ SHA1, it doesn't even have to exist as a git=20
object!

In fact, something like the following abomination should solve=20
your "problem" quite easily:

  git notes add $(echo "refs/heads/master" | git hash-object --stdin)

(...washing my hands...)

> And one last comment: how do notes behave wrt to cloning and remote
> handling? Am I correct in my understanding that notes are (presently)
> local only? Would it make sense to have them cloned to something like
> the refs/notes/remotes/* namespace?

They are no more local than any other ref, except that they are outside=
=20
the refspecs that are "usually" pushed/fetched (refs/heads/ and=20
refs/tags/).

	git push <remote> refs/notes/<foo>
	git fetch <remote> refs/notes/<foo>[:refs/notes/<foo>]
	etc.

should all work as expected.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
