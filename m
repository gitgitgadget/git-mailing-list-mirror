Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428FD18651
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296313; cv=none; b=g1NdsK3EauTIKrb/KroC5kt6BZvIkVodQ85z6CvWVuSTB1iRCuoNbKsdpBJRsJl3PBDa1LtVgt2af5HakQJ+TnsJbxKyc6+8LOHRHh4w+m1B3k5wBgUb2Q/WlAOcSZeXjn5srudRT6uOYTZg+BSwFJMy2rqVS8pLwc/4DvVWmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296313; c=relaxed/simple;
	bh=X2azCSaI20HkVNGi0cJuutyKoqKx7y/AtbgSFJm1Cgs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rF/vP/GPnd8mLgaTYAFnFo6G5PNr3SIZ4Rw1AXCjeyw+fEEz2VU8Q01bAaMb2x/hMLA/RaeHNNIPj+Sfo/m84hHExBxTzfj0HIIOKoYnEm8OMf8BWynO3IJ6bpXM62aVuj/lpWH7uZXiPHiMcgGiZzZf5AHOO+hFK4PP1VzZfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 42OG4lia027333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Mar 2024 16:04:47 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Christian Couder'" <christian.couder@gmail.com>,
        "'Stefan Haller'" <lists@haller-berlin.de>
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Olliver Schinagl'" <oliver@schinagl.nl>, <git@vger.kernel.org>
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl> <xmqqwmptzyny.fsf@gitster.g> <01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de> <xmqqle68x008.fsf@gitster.g> <e896da79-c87b-4475-9890-10051d8ddf76@haller-berlin.de> <CAP8UFD2DhkmVias+RfMESJz9Z-rKKHWHB+MFHcDb9QLO16TOhg@mail.gmail.com>
In-Reply-To: <CAP8UFD2DhkmVias+RfMESJz9Z-rKKHWHB+MFHcDb9QLO16TOhg@mail.gmail.com>
Subject: RE: Allow git bisect to auto-skip
Date: Sun, 24 Mar 2024 12:04:41 -0400
Organization: Nexbridge Inc.
Message-ID: <066501da7e04$fecabf40$fc603dc0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQNLgi3b+fMjDR3yv7fp/bqT8+4c/gE2keweARG/cUwBu8we7AI/93BRARCVG0+uKlyG4A==

On Sunday, March 24, 2024 10:29 AM, Christian Couder wrote:
>On Sun, Mar 24, 2024 at 11:16=E2=80=AFAM Stefan Haller =
<lists@haller-berlin.de> wrote:
>>
>> On 23.03.24 19:43, Junio C Hamano wrote:
>> > Stefan Haller <lists@haller-berlin.de> writes:
>> >
>> >> On 22.03.24 23:31, Junio C Hamano wrote:
>> >>> It often is discovered that a commit breaks bisection after the
>> >>> fact and it is not feasible to rebase all the history after the
>> >>> commit.
>> >>
>> >> This reminds me of a similar problem with git blame, for which we
>> >> have the blame.ignoreRevsFile config to work around it. Couldn't
>> >> there be a similar mechanism for bisect, e.g. bisect.skipRevsFile?
>> >
>> > A Very good point.  If a breakage of a commit is "this does not =
even
>> > build" kind of breakage, such a mechanism would be an excellent =
fit.
>> >
>> > But if a breakage is "only this particular test fails and we know
>> > the reason why it fails has nothing to do with the bug we are
>> > chasing", then compiling such a fixed list of commits, or pointing
>> > at such a list with a configuration variable, would not work very
>> > well, I am afraid.
>>
>> That's true, but the same can be said about blame.ignoreRevsFile.
>> There may be commits that contain both uninteresting whitespace
>> changes and real changes (not in a well-maintained project of course
>> :-), so it wouldn't be a good idea to add those to
>> blame.ignoreRevsFile. But that's not a reason not to offer the =
feature at all.
>
>I am not against the feature, but I think it would be especially useful =
if the file(s)
>containing the revs that should be skipped
>is(are) tracked in Git. In this case though, any such file wouldn't be =
used
>automatically after cloning the repo as the bisect.skipRevsFile option =
would still
>need to be configured.
>
>Also, how much better would this be compared to tracking  "git bisect =
run" scripts in
>the repo, even if they have to be copied somewhere else before they are =
launched?
>I wonder about this because writing the conditions that decide whether =
the current
>commit is good or bad might not be so easy either. So if the goal is to =
simplify things
>for users, then simplifying all the way by providing example scripts =
with comments
>about how they could be customized might be even better.

In some situations, git bisect is used for compile issues, while others =
in debugging. In development branches, bisect is sufficient. However, if =
one has multiple production deploy branches, where feature merge squash =
happens multiple times into multiple branches, this makes finding the =
offending commit using bisect rather difficult as the defect may come in =
and out depending on the order in which feature branches are squashed =
(some may have the bug, while others don't). I can see the point of =
teaching bisect to knowingly skipping specific versions in this setting, =
although it is arguable that the investigation probably should not =
happen on the destination branches where functional stability cannot be =
guaranteed.

But this brought up a thought. What if bisect had the notion of parallel =
context: Meaning running two (or more) bisects in parallel on the same =
repo in search of two semi-independent defects, then analysing =
convergence between the two analyses - something like

 bisect 1: A(good) B(good) C(bad) D(bad);
 bisect 2: A(good) B(good) C(good) D(bad);
 bisect 3: A(good) B(bad) C(good) D(bad),   <- a production-like branch

with an interpretation that C and D may have interrelated defects but =
started showing in B in one situation. This is not a well-baked thought, =
but I can see this having some relevance when sub-modules are involved =
and bugs exist in more than one sub-module with bisects happening in the =
main repo. [note: I am not certain where I am going with this idea as of =
yet].

--Randall

