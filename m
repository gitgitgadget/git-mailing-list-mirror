From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 08/10] ref-filter: add support for %(upstream:track,nobracket)
Date: Tue, 13 Oct 2015 20:54:05 +0200
Message-ID: <vpqeggy61ma.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<1444295885-1657-9-git-send-email-Karthik.188@gmail.com>
	<CAOLa=ZRZszOqHqJfOHhFqa-XDZbrcPCuSdvM_zMEYHURv8kW_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:54:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm4iN-0005XG-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 20:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbbJMSyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 14:54:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56890 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbbJMSyT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 14:54:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9DIs3l6016589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 13 Oct 2015 20:54:03 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9DIs5n7009977;
	Tue, 13 Oct 2015 20:54:05 +0200
In-Reply-To: <CAOLa=ZRZszOqHqJfOHhFqa-XDZbrcPCuSdvM_zMEYHURv8kW_A@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 13 Oct 2015 23:43:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 13 Oct 2015 20:54:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9DIs3l6016589
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445367245.13787@+y/fjiQ3DK/qL6gidRf9Sg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279513>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Thu, Oct 8, 2015 at 2:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add support for %(upstream:track,nobracket) which will print the
>> tracking information without the brackets (i.e. "ahead N, behind M").
>>
>> Add test and documentation for the same.
>> ---
>>  Documentation/git-for-each-ref.txt |  6 ++++--
>>  ref-filter.c                       | 28 +++++++++++++++++++++++-----
>>  t/t6300-for-each-ref.sh            |  9 +++++++++
>>  3 files changed, 36 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index c713ec0..a38cbf6 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -114,8 +114,10 @@ upstream::
>>         `refname` above.  Additionally respects `:track` to show
>>         "[ahead N, behind M]" and `:trackshort` to show the terse
>>         version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
>> -       or "=" (in sync).  Has no effect if the ref does not have
>> -       tracking information associated with it.
>> +       or "=" (in sync).  Append `:track,nobracket` to show tracking
>> +       information without brackets (i.e "ahead N, behind M").  Has
>> +       no effect if the ref does not have tracking information
>> +       associated with it.
>>
>>  push::
>>         The name of a local ref which represents the `@{push}` location
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 6a38089..6044eb0 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1112,27 +1112,45 @@ static void populate_value(struct ref_array_item *ref)
>>                         if (!strcmp(formatp, "short"))
>>                                 refname = shorten_unambiguous_ref(refname,
>>                                                       warn_ambiguous_refs);
>> -                       else if (!strcmp(formatp, "track") &&
>> +                       else if (skip_prefix(formatp, "track", &valp) &&
>> +                                strcmp(formatp, "trackshort") &&
>>                                  (starts_with(name, "upstream") ||
>>                                   starts_with(name, "push"))) {
>
> If you see here, we detect "track" first for
> %(upstream:track,nobracket)

Yes, but I still think that this was a bad idea. If you want nobracket
to apply to "track", then the syntax should be
%(upstream:track=nobracket). I think the "nobracket" should apply to
"upstream" (i.e. be global to the atom), hence
%(upstream:nobracket,track) and %(upstream:track,nobracket) should both
be accepted. Possibly %(upstream:<not track>,nobracket) could complain,
but just ignoring "nobracket" in this case would make sense to me.

Special-casing the implementation of "nobracket" also means you're
special-casing its user-visible behavior. And as a user, I hate it when
the behavior is subtely different for things that look like each other
(in this case, %(align:...) and %(upstream:...) ).

> %(upstream:nobracket,track) to be supported then, I think we'll have
> to change this whole layout and have the detection done up where we
> locat "upstream" / "push", what would be a nice way to go around this?

You mean, below

		else if (starts_with(name, "upstream")) {

within populate_value()?

I think it would, yes.

> What I could think of:
> 1. Do the cleanup that Junio and Matthieu suggested, where we
> basically parse the
> atoms and store them into a used_atom struct. I could either work on
> those patches
> before this and then rebase this on top.
> 2. Let this be and come back on it when implementing the above series.
> After reading Matthieu's and Junio's discussion, I lean towards the latter.

Leaving it as-is does not fit in my arguments to do the refactoring
later. It's not introducing "another instance of an existing pattern",
but actually a new pattern.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
