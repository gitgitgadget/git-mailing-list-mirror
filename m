From: Paul Ebermann <Paul-Ebermann@gmx.de>
Subject: Re: [PATCH/WIP] completion: complete git diff with only changed files.
Date: Wed, 18 May 2011 15:22:28 +0200
Message-ID: <4DD3C814.8000100@gmx.de>
References: <4DD30F87.2000807@gmx.de> <7v8vu4efvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 15:22:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMghy-0006R7-04
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 15:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757032Ab1ERNWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 09:22:33 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:60197 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756956Ab1ERNWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 09:22:32 -0400
Received: (qmail invoked by alias); 18 May 2011 13:22:30 -0000
Received: from stilgar.mathematik.hu-berlin.de (EHLO [141.20.50.149]) [141.20.50.149]
  by mail.gmx.net (mp010) with SMTP; 18 May 2011 15:22:30 +0200
X-Authenticated: #2289940
X-Provags-ID: V01U2FsdGVkX19uC3ASbcdu58gaVXWnPd+JTx0PB0Z8SbBUgLSiu4
	9i8Kb+fw0wzmyI
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.19) Gecko/20110420 SUSE/2.0.14-0.2.1 SeaMonkey/2.0.14
In-Reply-To: <7v8vu4efvj.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173878>

Junio C Hamano skribis:
> Paul Ebermann <Paul-Ebermann@gmx.de> writes:
>=20
>> I ported this idea to git. Now
>>    git diff -- <tab>
>> will complete any changed files. It also works for the other ways
>> of calling git diff, except the .. and ... notations (as I'm
>> not sure how to do this).
>=20
> Very interesting.
>=20
> I would be a bit dissapointed if this change makes
>=20
> 	git diff maint master -- builtin/lo<TAB>
>=20
> not complete for me when builtin/log.c did not change between these t=
wo
> branches, as running between different maintenance tracks and the mas=
ter
> branch to see how far things have diverged is my first quick sanity c=
heck
> before deciding where in the history a new patch should be queued.

In fact, it does complete. (Even if there is no maint branch like in my
clone.) There seems to be a fallback to filename completion if the comp=
letion
list is empty.  It takes quite longer than before, though.
And it does not give a list of all files if there are changed files sta=
rting
with the prefix typed.

> Spending cycles to keep me waiting while running "diff" before giving=
 me
> the control back, and implicitly telling me by not telling me that lo=
=2E..
> is a completion candidate, would surely make me go "Huh? Is it being =
slow?
> Hello? <TAB> <TAAAB> <TAAAAAAAB> ... hmm, did I mistype the directory
> name?  B-U-I-L-T-I-N ... that's correct.... what's going on?  ah wait=
 a
> minute, we recently applied that stupid change that tells me what I r=
eally
> want to know by not telling me, which is backwards."
>
> That's already 12 seconds wasted, and worse yet, even after I learn t=
he
> quirk of the new behaviour that tells what I want to know by not tell=
ing
> me, the need to make sure that I didn't mistype the directory name wo=
uld
> not disappear.
>
> I would rather not to be retrained to wire my brain backwards in the =
first
> place.

Okay, this seems to depend on the usage pattern.

I'm normally using (for differences to head) git status  first, and the=
n
have a look at the files I really want to see. Then completion of only =
the
changed files seems useful.=20

I must confess that I seldomly use
    git diff <commit> <commit> -- <path>
at all, while it seems to be an important tool for maintainers of proje=
cts
with lots of contributors (like you).

What about having this completion only apply for the no-commit-given ca=
se
(i.e. `git diff -- <path>`), and using the normal file-based completion
in the case of a given <commit>?
(But shouldn't we complete for files existent in one of the comparison =
ends
 instead of in the working tree?)

I also thought about somehow caching the results to make it faster, but=
 the
problem with this is that this will change after each commit, and also
between the commits with every edit to a file.

>> +    local -a args=3D()
>> +    local finish=3Dfalse
>> +
>> +    for (( i=3D1 ; i < cword ; i++)) do
>> +    local current_arg=3D${words[$i]}
>> +    #  echo checking $current_arg >&2
>> +       case $current_arg in
>> +           --cached)
>=20
> case arms align with case and esac in our codebase, i.e.
>=20
>         case $current_arg in
>         --cached)
>         	...
>                 ;;
>                 ...
>         esac

Okay. (I simply used what my Emacs auto-indented.)
I will change this if I submit another patch.

>> +           *)
>> +               if git cat-file -e $current_arg 2> /dev/null
>> +               then
>> +                   case $( git cat-file -t $current_arg ) in
>=20
> I do not see the need for the outer if/then/fi here. Wouldn't this
> sufficient?
>=20
> 		case "$(git cat-file -t $current_arg 2>/dev/null)" in
> 		commit|tag)
>                 	...

Seems like it.
Looks like I was reading the documentation of -e, which said
"Suppress all output; instead exit with zero status if <object>
exists and is a valid object.", and thus I thought I could avoid
using the redirection at all - I then added it when it showed
that the redirect still was necessary.

Yes, your version works, too.

> If you are interested in dealing with ../... notation, you could inst=
ead
> use "git rev-parse --revs-only --no-flags", e.g.
>=20
> 	$ git rev-parse --revs-only --no-flags maint..master
>         b602ed7dea968d72c5b3f61ca016de7f285d80ef
> 	^ea1ab4b280ed3b041da53e161e32e38930569f3e
>=20
>         $ git rev-parse --revs-only --no-flags jch...pu
>         11b715c624d3766546a52cc333bc2ea2e426f631
>         14f92e20522bae26faa841374bbbe6c0d08770de
>         ^14f92e20522bae26faa841374bbbe6c0d08770de

The reason for using cat-file instead of rev-parse was the ability
to distinguish between commits and blobs (for example).=20

	$ git rev-parse --revs-only --no-flags c4d58da4e
	c4d58da4e9050c6330ff145914cc379f0600f703

(This is zlib.c in the current master, and the exit code is still 0.
Using the git 1.7.1 binaries on OpenSUSE, I did not compile the current
master code.)

I'm not sure this is really necessary, as I wrote before:

>> I'm checking the non-option arguments on being commits (or tags), an=
d pass
>> only the matching ones to the nested `git diff` call.
>> It might be easier to ommit this check and pass everything that does=
 not
>> start with a `-`. Then it would also easily work for the .. and ... =
syntax,
>> I think.
>> Opinions?

Thus I could simply write here

	case $current_arg in
	...
	*)
		args+=3D( $current_arg )
	esac

instead. If someone supplies something non-commitish, I don't have to c=
are
about it. It would also catch any non-option arguments, but it looks li=
ke
there are none of these (apart from the commits).

> But I tend to think this change itself is not such a great idea to be=
gin
> with, so....

Yeah, I understood this.

If this is not accepted, I'll publish it separately for the ones who li=
ke it
(not as a patch, but as a separate bash file which you could source aft=
er the
main comments.)
Still thanks for your comments.


Pa=C5=ADlo
