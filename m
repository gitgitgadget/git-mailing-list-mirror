From: David Kastrup <dak@gnu.org>
Subject: Re: How to substructure rewrites?
Date: Mon, 27 Jan 2014 17:27:38 +0100
Organization: Organization?!?
Message-ID: <87eh3t8k5h.fsf@fencepost.gnu.org>
References: <877g9ocjsk.fsf@fencepost.gnu.org>
	<xmqqppndpgbg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 27 17:27:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7p2R-0002hb-IO
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 17:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbaA0Q1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jan 2014 11:27:51 -0500
Received: from plane.gmane.org ([80.91.229.3]:53720 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545AbaA0Q1u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 11:27:50 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W7p2L-0002em-MR
	for git@vger.kernel.org; Mon, 27 Jan 2014 17:27:49 +0100
Received: from x2f3d3f3.dyn.telefonica.de ([2.243.211.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 17:27:49 +0100
Received: from dak by x2f3d3f3.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 17:27:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f3d3f3.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:y1lethChXCW7ixGNUJJzktieKG0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241145>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> As it can easily be guessed, the "add xxx function" commits are
>> basically adding not-yet-used code (and so will not disrupt
>> compilation), but everything starting with "Reorganize blame data
>> structures" up until the final commit will not work or compile since=
 the
>> code does not match the data structures.
>>
>> So there is little point in substructing all that, right?  Even
>> something seemingly isolated like
>>
>> commit f64b41c472442ae9971321fe8f62c3885ba4d8b7
>> Author: David Kastrup <dak@gnu.org>
>> Date:   Sun Jan 19 02:16:21 2014 +0100
>>
>>     blame.c: Let output determine MORE_THAN_ONE_PATH more efficientl=
y
>>
>> is not really useful as a separate commit since while it does implem=
ent
>> a particular task, this is done starting with non-working code relyi=
ng
>> on no-longer existent data structures.
>
> Small pieces that are incrementally added with their own
> documentation would certainly be a lot easier to read than one big
> ball of wax.

Sure.  The problem is that my rewrite is characterized by doing as
little as possible in order to achieve identical results (with the
conceivable exception of picking a different, equally scored variant in
those parts of the algorithm choosing a maximum).  That also means that
the basic logic and layout of the program stays the same while the data
flow and parts of the data structures are replaced.

> I am wondering if it would make it easier for everybody to tentativel=
y
> do "git-blame vs git-blame2" dance here, just like we did "git-blame
> vs git-annotate" dance some years ago.  That is, to add a completely
> new command and have them in parallel while cooking in 'next' (or we
> could even keep them in a few releases if we are not absolutely
> certain about the correctness of the result of the new code), aiming
> to eventually retire the current implementation and replace it with
> the new one.  We have already have test infrastructure to allow us to
> run variants of blames, too, to help that kind of transition.

Well, the point is that the implementation is supposed to
a) deliver identical results
b) reuse as much code as possible
so there is no real point in working with a separate source file.

=46or the "if we are not absolutely certain about the correctness of th=
e
result of the new code" angle, this should be covered with the usual
stable/unstable/proposed division most projects have in some way or
another for quality assurance.  I=A0have absolutely no clue how Git
organizes that, but it would usually mean that the new code is not
placed in a different _file_ (or a differently named command) but rathe=
r
in a different _branch_ as compared with the current implementation.

>> In general, the rule is likely "any commit should not create a
>> non-working state" right?
>
> Yes.

My current aim is to complete the code to the point where it is
a) fully operative and delivering equivalent results to the current
implementation
b) in every aspect at least as efficient as the current implementation
and in a state that is not basically less comprehensible than what I
started with

Since the change of the data structures and data flow requires changing
all affected program parts to get to a working state, and since I=A0don=
't
have ambitions to do more than that which is required to get there,
I=A0don't see how the bulk of the work can sensibly avoid coming as one
"omnibus" patch.  Most changes, however, will be understandable quite
well locally.

=46or example, currently the code has a number of loops traversing one
global linked list, ignoring all entries not relevant to a particular
target, and doing something with the rest.  Those loops generally are
replaced with a simpler loop just running through a single _completely_
relevant linked list.  Even while those replacements are scattered
throughout the patch, they make sense without having to look at the res=
t
of the patch.

--=20
David Kastrup
