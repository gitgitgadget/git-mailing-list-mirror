From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 5/5] cache: Use ce_norm_sha1().
Date: Tue, 20 Apr 2010 12:12:48 -0700
Message-ID: <7v7ho2gcpb.fsf@alter.siamese.dyndns.org>
References: <cover.1271432034.git.grubba@grubba.org>
 <c68d98b384086925da0194e560ae01d83a29f80c.1271432034.git.grubba@grubba.org>
 <7vsk6qio1f.fsf@alter.siamese.dyndns.org>
 <Pine.GSO.4.63.1004201622050.4296@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@roxen.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 21:13:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Isa-0005hQ-On
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 21:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071Ab0DTTM4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 15:12:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab0DTTMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 15:12:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AEEF7ACA09;
	Tue, 20 Apr 2010 15:12:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WhIMD/odFgJ3
	vVG1AGqQnE92Oxs=; b=oaw6DUNNxNEWLRAHgz6m1fbwnqzKhU397FK1MwvPAEML
	IPXmt2KwojzbiJf0seDT1owMbM1zDpi+XS7xDm/ANaQyIA+JMJyPw9c+1qXXZ5U8
	YJDsY5QWT0bjOofojHSDFc2NZACggDHaZ4HTsHi/1tMPeZP3ORI5NWlmwk5mSIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pmivGp
	t2vKFCz1al375IooZOxTlDe4VTNPCnDpRfDkhOlprviSoBSiYy5pdI3dxP28agXP
	0jDxi9bmOyJV1P165LN9kyguv4RGhBZ3sfmOKWxMH58I4geCK/MgW/F5AtkUMQOf
	MeGVfU5eoYCM0b8V/sVH4WVQXWR7+d8a32d1I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B946ACA08;
	Tue, 20 Apr 2010 15:12:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C64BACA07; Tue, 20 Apr
 2010 15:12:49 -0400 (EDT)
In-Reply-To: <Pine.GSO.4.63.1004201622050.4296@shipon.roxen.com> ("Henrik
 =?utf-8?Q?Grubbstr=C3=B6m=22's?= message of "Tue\, 20 Apr 2010 17\:39\:15
 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B7C30F92-4CB0-11DF-A2B4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145392>

Henrik Grubbstr=C3=B6m <grubba@roxen.com> writes:

>> 3. "git update-index --refresh" does not improve the situation, as i=
t
>>    (thinks) it knows the blob and the working tree file are differen=
t.
>
> False. "git update-index --refresh" uses
> read-cache.c:ce_compare_data() to compare the content of the blob wit=
h
> the normalized content of the working tree,...

I don't think you tried it yourself.  Here is what should happen with t=
he
current code.

	# step 0 & 1. a project with LF ending
	$ git init two && cd two
        $ echo a quick brown fox >kuzu
        $ git add kuzu && git commit -m kuzu

        # step 2. you want CRLF in your work area
        $ echo -e "a quick brown fox\015" >kuzu
        $ git config core.autocrlf true
	$ git diff
        diff --git a/kuzu b/kuzu

        # step 3. oops, refresh
        $ git update-index --refresh
        kuzu: needs update

And it is a common thing people wish to do.  Admittedly, this is an one=
-off
event, so it is not _that_ urgent to fix.  You can for example do:

	# step 4. you haven't changed anything really, so you can add
        $ git add kuzu
        $ git diff
        $ git diff --cached ;# empty!

to force re-index.

> Let's take the reverse case instead:
>
>  0. For some reason a file using CRLF line endings has entered the
>     repository.

	# step 0. a blob with CRLF
        $ git init one && cd one
        $ echo -e "a quick brown fox\015" >kuzu
        $ git add kuzu && git commit -m kuzu

>  1. The user notices the mistake, and sets crlf. The index is still
>     clean, but the user wants the file with LF line endings, so the
>     user does a "git checkout -- the_file".

	# step 1. you want CRLF in work area, LF in repository
        $ git config core.autocrlf true
        $ git diff ;# clean!
        $ git checkout -- kuzu
        $ git diff ;# clean!
        $ cat -v kuzu
        a quick brown fox^M

One glitch is that this "checkout" becomes a no-op because the file is
stat-clean.  This is something your "record in the index entry what
normalization was used when we checked it out (or when we read and
hashed)" approach should be able to fix.  It however does not need the
re-indexed object name.

	Side note: if you want to have LF in both work tree and in
        repository, then you wouldn't use core.autocrlf.  Instead you
        would do:

	# step 1 (irrelevant alternative). you want LF in both
        $ dos2unix kuzu
        $ git diff ;# clean!

>  2. The index is now dirty, so the user performs a "git update-index
>     --refresh".

I think you see exactly the same behaviour in the example sequence I ga=
ve
you (blobs with LF with working files with CRLF, core.autocrlf set) and=
 in
your example sequence (blobs with CRLF with working files with LF,
core.autocrlf set) in this case.  What happens to my example are alread=
y
shown above.  Continuing your example, because in reality the index is =
not
dirty, we would need to make it stat-dirty first.

	# step 2. you try to refresh
        $ touch kuzu
        $ git update-index --refresh
        kuzu: needs update
        $ git checkout -- kuzu
        $ cat -v kuzu
        a quick brown fox^M
        $ git diff ;# shows changes!
        diff --git a/kuzu b/kuzu
        index ....

If you are trying to somehow make this last "git diff" silent, then I
think you are solving a _wrong_ problem.  By setting retroactively the
CRLF setting, you are saying that you do not want to have CRLF in the
blobs recorded in the repository, and it is a _good thing_ that there a=
re
differences (tons of them) between what is recorded currently and what =
you
are going to commit to fix the earlier mistake.

>> I was hoping to see a solution where you will add a stronger version=
 of
>> "refresh" without having to do anything else other than recording "h=
ow did
>> I munge the file in the working tree to produce the blob".  The thir=
d step
>> would change to:
>>
>> 3. "git update-index --refresh" notices that the conversion paramete=
rs
>>    are different since the last time the files in the working tree w=
ere
>>    looked at (i.e. immediately after a "clone", working tree files a=
re
>>    what git wrote out using convert_to_working_tree() and you know w=
hat
>>    conversion you used; after the user modified files in the working=
 tree
>>    and said "git add", you know you what conversion parameters you r=
an
>>    convert_to_git() with to produce blobs).  The paths that has diff=
erent
>>    conversion parameters are re-indexed to see if they hash to the s=
ame
>>    sha1 as recorded in the index.  If they have changed, their index
>>    entries are left intact (i.e. you will still show the differences=
);
>>    otherwise you update the cached stat information for their index
>>    entries.
>
> I believe that most people that have edited a file that has changed
> CRLF convention aren't interested in that all lines have changed, but
> in only the lines that have actually been edited.

I think that is not just solving a wrong problem but also is encouragin=
g a
bad workflow at the same time, which is even worse.  If you recorded CR=
LF
blobs in a project that you do not want to have CRLF blob, fixing that
mistake is one logical change that people who later browse the history
would not want to see intermixed with the "lines that actually have bee=
n
edited".

> Storing the normalized sha1 is needed to reduce the amount of double
> work (eg having "git update-index --refresh" reperform
> convert_to_git() for
> the repository blob every time a file is dirty, instead of (as now)
> just comparing the sha1 values).

As I already said, I agree that it would be beneficial to store what
normalization settings were used and comparing that with what settings =
are
in effect to detect the possible phamtom difference caused by the chang=
e
of the settings.  But once we know that the result of a re-normalizatio=
n
is different from what is recorded in the index (or tree), then the
difference should be shown.  The actual difference would change every t=
ime
the work tree file is edited, so I don't see the benefit of contaminate
the object database with intermediate "blobs" that is not "added".
