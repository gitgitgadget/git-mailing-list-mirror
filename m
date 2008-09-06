From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v4] for-each-ref: `:short` format for `refname`
Date: Sat, 6 Sep 2008 20:16:05 +0200
Message-ID: <36ca99e90809061116q7b9559f8w2b939f22e5f94fb7@mail.gmail.com>
References: <7vtzcxaxgr.fsf@gitster.siamese.dyndns.org>
	 <1220649383-17916-1-git-send-email-bert.wesarg@googlemail.com>
	 <7vej3yutes.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 20:17:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc2Ld-00055r-EF
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 20:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbYIFSQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 14:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbYIFSQJ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 14:16:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:50887 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYIFSQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 14:16:07 -0400
Received: by wr-out-0506.google.com with SMTP id 69so934700wri.5
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qr/koynXHygHqshkckDY6e2BBIvzq8zz3SMTDy4XYSk=;
        b=el8bfExHzB5Nvh62tVKfL/7A3Bs5ynJKmOJfc4JXssofGKOErevUCjGyYvsig4uUQ2
         23aghgBupAdgOOjZtQShwnd4ocFwQ/FZ2eXWkJvoiDSmxfDaBMxnF0TFDwnmKDoEYuSV
         0XTkUDCEglUZiuw/orzhoyCvjI9+1BGmE95Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Caep/13Yt5tce+PJWm91JsNV0D+7Soa/3jnNtfKjrzEtyC1bHmmdEUfPnohrF+DteE
         hA8hpn+MPnsPaVVWZbsT9nD6+ve6ibJsMZyYXJtEtENLeUDvln0btVXJ9XXBnEpVy51t
         64Cmz3ZrPV5gIFL8iPg/YJWCpmiiUPFJjycv0=
Received: by 10.70.66.9 with SMTP id o9mr16289078wxa.1.1220724966079;
        Sat, 06 Sep 2008 11:16:06 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Sat, 6 Sep 2008 11:16:05 -0700 (PDT)
In-Reply-To: <7vej3yutes.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95087>

On Sat, Sep 6, 2008 at 00:20, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> ...
>> To integrate this new format into the bash completion to get
>> only non-ambiguous refs is beyond the scope of this patch.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
>> Cc: git@vger.kernel.org
>> Cc: szeder@ira.uka.de
>> Cc: Shawn O. Pearce <spearce@spearce.org>
>
> Nice writeup of the history of this patch, if on tad-too-verbose side.
>
>> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
>> index 21e92bb..9b44092 100644
>> --- a/builtin-for-each-ref.c
>> +++ b/builtin-for-each-ref.c
>> @@ -546,6 +546,107 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
>> +/*
>> + * Shorten the refname to an non-ambiguous form
>> + */
>> +static char *get_short_ref(struct refinfo *ref)
>> +{
>> ...
>> +     /* skip first rule, it will always match */
>> +     for (i = nr_rules - 1; i > 0 ; --i) {
>> +             int j;
>> +             int short_name_len;
>> +
>> +             if (1 != sscanf(ref->refname, scanf_fmts[i], short_name))
>> +                     continue;
>> +
>> +             short_name_len = strlen(short_name);
>> +
>> +             /*
>> +              * check if the short name resolves to a valid ref,
>> +              * but use only rules prior to the matched one
>> +              */
>> +             for (j = 0; j < i; j++) {
>> ...
>> +             }
>> +             /*
>> +              * short name is non-ambiguous if all previous rules
>> +              * haven't resolved to a valid ref
>> +              */
>> +             if (j == i)
>> +                     return short_name;
>
> Is this inner loop essentially the same as calling dwim_ref(), while
> temporarily turning warn_ambiguous_refs on, and checking for return value
> of one?
Not exactly.

Short version:

To follow my above example, with dwim_ref() we would get this:

heads/xyzzy
tags/xyzzy

Long version:

Currently we consider only rules prior to the matched rule (the rule
which gives us the short name). That is, if any of these rules will
also resolve to a valid ref, the short name is  ambiguous, else its
unambiguous. If we would consider subsequent rules past the matched
one, we may find more valid refs for this short name. Because the
current rule would match first if we try to resolve the short name, we
don't have to check these rules. We get only a "ambiguous refs"
warning.

I have no opinion if we want this 'strict unambiguousness'.

>
>> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
>> index 8ced593..4f247dd 100755
>> --- a/t/t6300-for-each-ref.sh
>> +++ b/t/t6300-for-each-ref.sh
>> @@ -262,6 +262,50 @@ for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
>>       "
>>  done
>>
>> +cat >expected <<\EOF
>> +master
>> +testtag
>> +EOF
>> +
>> +test_expect_success 'Check short refname format' '
>> +     (git for-each-ref --format="%(refname:short)" refs/heads &&
>> +     git for-each-ref --format="%(refname:short)" refs/tags) >actual &&
>> +     test_cmp expected actual
>> +'
>
> Not a complaint nor objection but mere curiosity.  Why does this run two
> for-each-ref, not just one with two patterns?
Its more a leftover from the :strip version, where the pattern was the point of
interest.

>
>> +test_expect_success 'Check for invalid refname format' '
>> +     test_must_fail git for-each-ref --format="%(refname:INVALID)"
>> +'
>
> Good.
>
>> +cat >expected <<\EOF
>> +heads/master
>> +master
>> +EOF
>> +
>> +test_expect_success 'Check ambiguous head and tag refs' '
>> +     git checkout -b newtag &&
>> +     echo "Using $datestamp" > one &&
>> +     git add one &&
>> +     git commit -m "Branch" &&
>> +     setdate_and_increment &&
>> +     git tag -m "Tagging at $datestamp" master &&
>> +     git for-each-ref --format "%(refname:short)" refs/heads/master refs/tags/master >actual &&
>> +     test_cmp expected actual
>> +'
>> +
>> +cat >expected <<\EOF
>> +heads/ambiguous
>> +ambiguous
>> +EOF
>> +
>> +test_expect_success 'Check ambiguous head and tag refs II' '
>> +     git checkout master &&
>> +     git tag ambiguous testtag^0 &&
>> +     git branch ambiguous testtag^0 &&
>> +     git for-each-ref --format "%(refname:short)" refs/heads/ambiguous refs/tags/ambiguous >actual &&
>> +     test_cmp expected actual
>> +'
>> +
>
> Can we also try first creating a clone of some repo and run:
>
>        for-each-ref --format="%(refname:short)" refs/remotes
>
> I am unsure how "remotes/origin" when "refs/remotes/origin/HEAD" points at
> their 'master' branch behaves with your code, and/or how it should behave.
I will look at this.


>
> Other than that, nicely done.
>
>

Bert
