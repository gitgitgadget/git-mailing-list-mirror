From: Benjamin Meyer <ben@meyerhome.net>
Subject: Re: [PATCH 2/4] pull: use --quiet rather than 2>/dev/null
Date: Sat, 20 Mar 2010 14:59:25 -0400
Message-ID: <818FE4EC-5AE9-4F05-B9AD-E1753F7ED9E6@meyerhome.net>
References: <1269051518-25099-1-git-send-email-bmeyer@rim.com> <1269051518-25099-2-git-send-email-bmeyer@rim.com> <20100320123520.GA29041@progeny.tock>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Mar 20 20:06:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt3zK-00032D-Ob
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 20:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab0CTTFN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 15:05:13 -0400
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:33436
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751154Ab0CTTFM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 15:05:12 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Mar 2010 15:05:11 EDT
Received: from omta20.westchester.pa.mail.comcast.net ([76.96.62.71])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id vWy81d0071YDfWL5DWzTY2; Sat, 20 Mar 2010 18:59:27 +0000
Received: from [192.168.3.101] ([71.192.50.29])
	by omta20.westchester.pa.mail.comcast.net with comcast
	id vX1k1d00C0dnthT3gX1ltM; Sat, 20 Mar 2010 19:01:45 +0000
In-Reply-To: <20100320123520.GA29041@progeny.tock>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142740>

On Mar 20, 2010, at 8:35 AM, Jonathan Nieder wrote:

> Benjamin C Meyer wrote:
>=20
>> -	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
>> +	for reflog in $(git rev-list --quiet -g $remoteref)
>=20
> Are you sure?  My local copy of git-rev-list.1 says
>=20
>   --quiet
>        Don=92t print anything to standard output. This form is primar=
ily meant
>        to allow the caller to test the exit status to see if a range =
of
>        objects is fully connected (or not). It is faster than redirec=
ting
>        stdout to /dev/null as the output does not have to be formatte=
d.
>=20
> A similar question applies to the other patches in this series: are
> you sure they suppress the right output?  (I haven=92t checked, just
> asking.)

Thanks for reviewing the change

Yah looks like I made a mistake there, rev-list --quiet suppresses ever=
ything and not just stderr.  When going through this janitor task I not=
iced that the --quiet is very inconsistent among git commands.  Some su=
ppress error messages, some suppress all messages.  This might be somet=
hing to improve in the future as even though I kept referring to the do=
cumentation this error slipped in.

re-checking the other patches I think they are correct in their usage. =
 I ran the matching tests, the rebase ones passed, 3903-stash.sh is alr=
eady failing before my patch and t3904-stash-patch.sh continues passing=
 with the patch.  Other then running the tests in t/ is there anything =
I should do to verify patches?

> Aside: that for loop looks like it could be improved.  Maybe it is wo=
rth
> factoring this into a separate function, something like:
>=20
> old_upstream() {
> 	remoteref=3D$1 &&
> 	curr_branch=3D$2 &&
>=20
> 	oldremoteref=3D"$(git rev-parse -q --verify "$remoteref")" &&
> 	{ git rev-list -g "$remoteref" 2>/dev/null || return $?; } |
> 	while read reflog
> 	do
> 		if test -z "$(git rev-list "$curr_branch".."$reflog" | head -n 1)"
> 		then
> 			printf "%s\n" "$reflog"
> 			return 0
> 		fi
> 	done &&
> 	printf "%s\n" "$oldremoteref"
> }
>=20
> In other words, we can avoid walking the whole reflog before starting
> to look for an ancestor for the current branch.

That looks like it would speed up that bit of code, but I am still figu=
ring out the internals of git so I can't really comment on if this is t=
he best solution etc.

-Benjamin Meyer
