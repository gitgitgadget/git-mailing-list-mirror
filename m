From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 3/3] builtin/blame.c: large-scale rewrite
Date: Mon, 27 Jan 2014 22:21:16 +0100
Organization: Organization?!?
Message-ID: <87sis96rzn.fsf@fencepost.gnu.org>
References: <877g9ocjsk.fsf@fencepost.gnu.org>
	<1390674221-25767-1-git-send-email-dak@gnu.org>
	<1390674221-25767-4-git-send-email-dak@gnu.org>
	<xmqq8uu1pdqq.fsf@gitster.dls.corp.google.com>
	<87a9eh8b0d.fsf@fencepost.gnu.org>
	<xmqqtxcpno6i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 27 22:21:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7tci-000275-9e
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 22:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbaA0VVg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jan 2014 16:21:36 -0500
Received: from plane.gmane.org ([80.91.229.3]:42605 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354AbaA0VVf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 16:21:35 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W7tcc-00023y-71
	for git@vger.kernel.org; Mon, 27 Jan 2014 22:21:34 +0100
Received: from x2f3d3f3.dyn.telefonica.de ([2.243.211.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 22:21:34 +0100
Received: from dak by x2f3d3f3.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 22:21:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f3d3f3.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:KVZzY5GqzM/NKYVT8rx37Glj6UU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241159>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> David Kastrup <dak@gnu.org> writes:
>>>
>>>> The previous implementation uses a sorted linear list of struct
>>>> blame_entry in a struct scoreboard for organizing all partial or
>>>> completed work.  Every task that is done requires going through th=
e
>>>> whole list where most entries are not relevant to the task at hand=
=2E
>>>>
>>>> This commit reorganizes the data structures in order to have each
>>>> remaining subtask work with its own sorted linear list it can work=
 off
>>>> front to back.  Subtasks are organized into "struct origin" chains
>>>> hanging off particular commits.  Commits are organized into a prio=
rity
>>>> queue, processing them in commit date order in order to keep most =
of
>>>> the work affecting a particular blob collated even in the presence=
 of
>>>> an extensive merge history.  In that manner, linear searches can b=
e
>>>> basically avoided anywhere.  They still are done for identifying o=
ne
>>>> of multiple analyzed files in a given commit, but the degenerate c=
ase
>>>> of a single large file being assembled from a multitude of smaller
>>>> files in the past is not likely to occur often enough to warrant
>>>> special treatment.
>>>> ---
>>>
>>> Sign-off?
>>
>> Not while this is not fit for merging because of #if 0 etc and missi=
ng
>> functionality.  This is just for review.
>
> That is not what Signing off a patch means, though ;-)

=46rom Documentation/SubmittingPatches:

    The sign-off is a simple line at the end of the explanation for
    the patch, which certifies that you wrote it or otherwise have
    the right to pass it on as a open-source patch.  The rules are
    pretty simple: if you can certify the below:

            Developer's Certificate of Origin 1.1

            By making a contribution to this project, I certify that:

Well, and the patch is not in a state where I want to contribute it to
this project.  Basically I first want to bring it into a state where
I=A0am not embarrassed by having my name attached to it.

Yes, that's probably not quite the idea of signing off...

> OK.  As we do not want to break the build in the middle of the
> series, but we still want to keep the individual steps reviewable
> incrementally, I would think the best structure would be have the
> series that consists of multiple steps "the basic infrastructure is
> there, but no rename following, and neither -M or -C works", "now
> renames are followed", "now -M works", etc., with tests that are not
> yet working (in the beginning, most of "git blame" test may no
> longer work until the series is finished) marked with
>
>     s/test_expect_success/test_expect_failure/
>
> and turn expect_failure into expect_success as the series advances.
> That way, we may get a better picture of what each step achieves.  I
> dunno.

Seems a bit pointless as the various functionalities are implemented in
separate code passages.  Basically the only "common" code is

static void pass_blame(struct scoreboard *sb, struct origin *origin, in=
t opt)
{
	struct rev_info *revs =3D sb->revs;
	int i, pass, num_sg;
	struct commit *commit =3D origin->commit;
[...]

#if 0
	/*
	 * Optionally find moves in parents' files.
	 */
	if (opt & PICKAXE_BLAME_MOVE)
		for (i =3D 0, sg =3D first_scapegoat(revs, commit);
		     i < num_sg && sg;
		     sg =3D sg->next, i++) {
			struct origin *porigin =3D sg_origin[i];
			if (!porigin)
				continue;
			if (find_move_in_parent(sb, origin, porigin))
				goto finish;
		}

	/*
	 * Optionally find copies from parents' files.
	 */
	if (opt & PICKAXE_BLAME_COPY)
		for (i =3D 0, sg =3D first_scapegoat(revs, commit);
		     i < num_sg && sg;
		     sg =3D sg->next, i++) {
			struct origin *porigin =3D sg_origin[i];
			if (find_copy_in_parent(sb, origin, sg->item,
						porigin, opt))
				goto finish;
		}
#endif

 finish:
	for (i =3D 0; i < num_sg; i++) {
		if (sg_origin[i]) {
			drop_origin_blob(sg_origin[i]);
			origin_decref(sg_origin[i]);
		}
	}
	drop_origin_blob(origin);
	if (sg_buf !=3D sg_origin)
		free(sg_origin);
}


So what will happen here is that the #if 0 will get removed again, and
there will be somewhat different code for

        /*
	 * Optionally find moves in parents' files.
	 */

and then somewhat different code for

	/*
	 * Optionally find copies from parents' files.
	 */

and some section elsewhere with the functions being called here.  It's
not like there will be significant intersection between the
"same-file-and-rename" code and the "move-in-file or
copy-from-some-other-file" code.  It's just a separate piece of code,
marked with a separate comment.  Not an "evolution" of code, but rather
a simple addition.  Basically each of those additions does "try blaming
some more entries to some source different from the currently considere=
d
target" and whatever remains at the end is blamed on the current target=
=2E
And every such addition has its own algorithm and functions.

At any rate: I'll just propose the thing as one piece first and then we
can still discuss what kind of subdivision and/or
commenting/restructuring might be warranted and would simplify
reviewing.

--=20
David Kastrup
