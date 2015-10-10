From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 04/10] ref-filter: modify "%(objectname:short)" to take length
Date: Sat, 10 Oct 2015 23:45:46 +0530
Message-ID: <CAOLa=ZT8YydU-4HH2migNewtiAvB=wOCWx2TGV+Y+8YVHCdaNQ@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <1444295885-1657-5-git-send-email-Karthik.188@gmail.com> <vpqh9m1mbln.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 10 20:16:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zkygx-00039G-11
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 20:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbbJJSQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2015 14:16:18 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34370 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbbJJSQR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2015 14:16:17 -0400
Received: by vkat63 with SMTP id t63so68244887vka.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2015 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PkUluA/go+Frx2yggHOCU+m7jmHiYsZKjKaYirzF4vo=;
        b=fquKlNxeJ+uWne/8ui4gOtk0BMITlFnTCyqO+qgy8kNAZ5NOeJXOhPsNqi5diP49MW
         mMdowWVHKxsOee9timMqA3UNdewZMckM3mlrFek2GMNt6pwrE+M3twSe3rtzp7wegdvF
         WY3CIJ9BWMhhTFdACh1HspU76UIuGUngj1LXHEuDYs3ufTaAkhN2U68He7sLsUdwQt2r
         TkkBzJMmsTlcjcUR294GrWZvtYyE49IKgMjdfAbrd5Aag20LDlnQ0IOD8PPCE4R3SSwc
         ueIlrl62ClKtJ9RT+Qigk1jkWcPuXRZe6qE9IDZaPR1JhwXukSaAJbDE4zN7zt7hIgIo
         9MnQ==
X-Received: by 10.31.173.136 with SMTP id w130mr12988011vke.72.1444500976240;
 Sat, 10 Oct 2015 11:16:16 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sat, 10 Oct 2015 11:15:46 -0700 (PDT)
In-Reply-To: <vpqh9m1mbln.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279328>

On Fri, Oct 9, 2015 at 12:28 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -464,14 +464,28 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
>>  static int grab_objectname(const char *name, const unsigned char *sha1,
>>                           struct atom_value *v)
>>  {
>> -     if (!strcmp(name, "objectname")) {
>> -             char *s = xmalloc(41);
>> -             strcpy(s, sha1_to_hex(sha1));
>> -             v->s = s;
>> -             return 1;
>> -     }
>> -     if (!strcmp(name, "objectname:short")) {
>> -             v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
>> +     const char *p;
>> +
>> +     if (match_atom_name(name, "objectname", &p)) {
>> +             /*  No arguments given, copy the entire objectname */
>> +             if (!p) {
>> +                     char *s = xmalloc(41);
>
> While you're there, you may want to get rid of this hardcoded 41 and
> write GIT_SHA1_HEXSZ + 1 instead.
>

Sure, will change that.

>> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
>> index 7c9bec7..6fc569e 100755
>> --- a/t/t6300-for-each-ref.sh
>> +++ b/t/t6300-for-each-ref.sh
>> @@ -385,6 +385,28 @@ test_expect_success 'Check short objectname format' '
>>       test_cmp expected actual
>>  '
>>
>> +cat >expected <<EOF
>> +$(git rev-parse --short=1 HEAD)
>> +EOF
>
> Please write all code within test_expect_success including this
> (t/README:
>
>  - Put all code inside test_expect_success and other assertions.
>
>    Even code that isn't a test per se, but merely some setup code
>    should be inside a test assertion.
> ).
>

Was just following the previous syntax, should have read that. fixed it

>> +test_expect_success 'Check objectname:short format when size is less than MINIMUM_ABBREV' '
>> +     git for-each-ref --format="%(objectname:short=1)" refs/heads >actual &&
>> +     test_cmp expected actual
>> +'
>> +
>> +cat >expected <<EOF
>> +$(git rev-parse --short=10 HEAD)
>> +EOF
>
> Likewise.
>

fixed it here too. Thanks

-- 
Regards,
Karthik Nayak
