From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make "git request-pull" use the configured
 remote.REMOTE.uploadpack
Date: Tue, 28 Jul 2009 22:05:47 -0700
Message-ID: <7vws5syt78.fsf@alter.siamese.dyndns.org>
References: <1248728563-23906-1-git-send-email-tgrennan@redback.com>
 <adf1fd3d0907281713t378440eamb39baae3be6d41c4@mail.gmail.com>
 <20090729013002.GM4850@redback.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Tom Grennan <tgrennan@redback.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 07:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW1Mm-0007gk-N7
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 07:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbZG2FGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 01:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbZG2FGI
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 01:06:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZG2FGH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 01:06:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D02715A85;
	Wed, 29 Jul 2009 01:06:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9115F15A83; Wed, 29 Jul 2009
 01:05:56 -0400 (EDT)
In-Reply-To: <20090729013002.GM4850@redback.com> (Tom Grennan's message of
 "Tue\, 28 Jul 2009 18\:30\:02 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 855E3772-7BFD-11DE-8BB6-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124304>

Tom Grennan <tgrennan@redback.com> writes:

> On Tue, Jul 28, 2009 at 05:13:30PM -0700, Santi B=C3=A9jar wrote:
>>2009/7/27 Tom Grennan <tgrennan@redback.com>:
>>> git-request-pull.sh should use git-parse-remote:get_uploadpack() to
>>> load a configured remote.REMOTE.uploadpack like "git remote show" a=
nd
>>> "git fetch". This allows one to specify the path of git-upload-pack=
 on
>>> the remote side.
>>
>>Sorry, but I removed all unused functions from git-parse-remote in 62=
d955f
>>(parse-remote: remove unused functions, 2009-06-12), and it is in
>>v1.6.4-rc1. I don't think there is much problem reverting part of tha=
t commit,
>>but I wonder if the problem is that "git ls-remote" does not read the
>>remote.<remote>.uploadpack by itself as it reads the remote.<remote>.=
url.
>>
>>Santi
>
> Thanks for the hint.
>
> Yes, "git ls-remote" is retrieving remote.<remote>.uploadpack when
> dest is a configured remote.  However, git-request-pull runs ls-remot=
e
> after converting its URL argument from remote.<remote>.url

Thanks, both.

-- >8 --
=46rom: Tom Grennan <tgrennan@redback.com>
Date: Tue, 28 Jul 2009 18:30:02 -0700
Subject: request-pull: allow ls-remote to notice remote.$nickname.uploa=
dpack

The location to pull from should be converted from the configured nickn=
ame
to URL in the message, but ls-remote should be fed the nickname so that
the command uses remote.$nickname.* variables, most notably "uploadpack=
".

Signed-off-by: Tom Grennan <tgrennan@redback.com>
---

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 5917773..fd95bea 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -28,13 +28,13 @@ headrev=3D`git rev-parse --verify "$head"^0` || exi=
t
 merge_base=3D`git merge-base $baserev $headrev` ||
 die "fatal: No commits in common between $base and $head"
=20
-url=3D$(get_remote_url "$url")
 branch=3D$(git ls-remote "$url" \
 	| sed -n -e "/^$headrev	refs.heads./{
 		s/^.*	refs.heads.//
 		p
 		q
 	}")
+url=3D$(get_remote_url "$url")
 if [ -z "$branch" ]; then
 	echo "warn: No branch of $url is at:" >&2
 	git log --max-count=3D1 --pretty=3D'tformat:warn:   %h: %s' $headrev =
>&2
