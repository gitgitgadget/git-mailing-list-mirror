From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v16 00/14] port tag.c to use ref-filter APIs
Date: Mon, 7 Sep 2015 00:46:15 +0530
Message-ID: <CAOLa=ZSw8QSrxpHt+Egm29qTgFTsA2fvC-Cj+Favjn-3k=HEYg@mail.gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com> <vpqa8sz9ydh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 06 21:16:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYfQq-0003gt-9C
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 21:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbbIFTQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 15:16:47 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34922 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbbIFTQp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 15:16:45 -0400
Received: by oiww128 with SMTP id w128so34954792oiw.2
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 12:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EccqJj7T0v9aU4PSylzjLBvnU5Br8xYA4bIP4hRIQ6o=;
        b=NSMpXjdU2h4Zr/PHFZpMbcsKDm1Ecq/tSOYPGL+T7caTXXYB8xyEyImxiGJRFdzXCt
         zbC1Y5cYOua+4tooqvey+dDG3YM+bSfEAfw1livOV7fMKcNQOQITFehR298CkpI1e8DI
         Yacn3GqolcXSr9DZMwCPLOkVZpxoj8lsoVfNyjHX4OpGZqLUO5bxEBXaFeTWhNwukZ05
         lMvZP27I7tYgEYoOHewLZSUa7UDbKp7puWDZeu7qRnCN33+4/oWHqnWei/oXOepAWl4f
         O+72AjtuPOj1ZSrZH50n+mIRtBQq26drxwehyk3dFvg0IZoCfRmitjVoIrbQpJFw1pW2
         ZFJQ==
X-Received: by 10.202.190.87 with SMTP id o84mr11366335oif.111.1441567005101;
 Sun, 06 Sep 2015 12:16:45 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sun, 6 Sep 2015 12:16:15 -0700 (PDT)
In-Reply-To: <vpqa8sz9ydh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277436>

On Mon, Sep 7, 2015 at 12:19 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> @@ -705,9 +719,12 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>>                       v->s = xstrdup(subpos);
>>               else if (skip_prefix(name, "contents:lines=", &valp)) {
>>                       struct strbuf s = STRBUF_INIT;
>> +                     const char *contents_end = bodylen + bodypos - siglen;
>> +
>>                       if (strtoul_ui(valp, 10, &v->u.contents.lines))
>> -                             die(_("positive width expected contents:lines=%s"), valp);
>> -                     append_lines(&s, subpos, sublen + bodylen - siglen, v->u.contents.lines);
>> +                             die(_("positive value expected contents:lines=%s"), valp);
>> +                     /*  Size is the length of the message after removing the signature */
>
> Nit: double-space after /*.
>
>> -test_expect_success 'alignment with format quote' '
>> -     cat >expect <<-EOF &&
>> -     refname is ${sq}           ${sq}\\${sq}${sq}master${sq}\\${sq}${sq}           ${sq}|
>> -     refname is ${sq}            ${sq}\\${sq}${sq}side${sq}\\${sq}${sq}            ${sq}|
>> -     refname is ${sq}          ${sq}\\${sq}${sq}odd/spot${sq}\\${sq}${sq}          ${sq}|
>> -     refname is ${sq}         ${sq}\\${sq}${sq}double-tag${sq}\\${sq}${sq}         ${sq}|
>> -     refname is ${sq}            ${sq}\\${sq}${sq}four${sq}\\${sq}${sq}            ${sq}|
>> -     refname is ${sq}            ${sq}\\${sq}${sq}one${sq}\\${sq}${sq}             ${sq}|
>> -     refname is ${sq}         ${sq}\\${sq}${sq}signed-tag${sq}\\${sq}${sq}         ${sq}|
>> -     refname is ${sq}           ${sq}\\${sq}${sq}three${sq}\\${sq}${sq}            ${sq}|
>> -     refname is ${sq}            ${sq}\\${sq}${sq}two${sq}\\${sq}${sq}             ${sq}|
>> +test_expect_success 'alignment with format quote' "
>> +     cat >expect <<-\EOF &&
>> +     |'       master| A U Thor       '|
>> +     |'        side| A U Thor        '|
>> +     |'      odd/spot| A U Thor      '|
>> +     |'         double-tag|          '|
>> +     |'        four| A U Thor        '|
>> +     |'        one| A U Thor         '|
>> +     |'         signed-tag|          '|
>> +     |'       three| A U Thor        '|
>> +     |'        two| A U Thor         '|
>>       EOF
>> -     git for-each-ref --shell --format="refname is %(align:30,middle)${sq}%(refname:short)${sq}%(end)|" >actual &&
>> +     git for-each-ref --shell --format='|%(align:30,middle)%(refname:short)| %(authorname)%(end)|' >actual &&
>>       test_cmp expect actual
>> -'
>> +"
>
> The new test is indeed easier to read, but you're not testing anymore
> the consequence of a single-quote within the aligned string.
>
> An implementation that just adds single-quotes around the string without
> turning ' into '\'' would be broken but still pass the test.
>

You're right, should squash this in

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index d0c0139..778c33b 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -137,17 +137,17 @@ test_expect_success 'right alignment' '

 test_expect_success 'alignment with format quote' "
        cat >expect <<-\EOF &&
-       |'       master| A U Thor       '|
-       |'        side| A U Thor        '|
-       |'      odd/spot| A U Thor      '|
-       |'         double-tag|          '|
-       |'        four| A U Thor        '|
-       |'        one| A U Thor         '|
-       |'         signed-tag|          '|
-       |'       three| A U Thor        '|
-       |'        two| A U Thor         '|
+       |'      '\''master| A U Thor'\''      '|
+       |'       '\''side| A U Thor'\''       '|
+       |'     '\''odd/spot| A U Thor'\''     '|
+       |'        '\''double-tag| '\''        '|
+       |'       '\''four| A U Thor'\''       '|
+       |'       '\''one| A U Thor'\''        '|
+       |'        '\''signed-tag| '\''        '|
+       |'      '\''three| A U Thor'\''       '|
+       |'       '\''two| A U Thor'\''        '|
        EOF
-       git for-each-ref --shell
--format='|%(align:30,middle)%(refname:short)| %(authorname)%(end)|'
>actual &&
+       git for-each-ref --shell
--format=\"|%(align:30,middle)'%(refname:short)|
%(authorname)'%(end)|\" >actual &&
        test_cmp expect actual
 "

-- 
Regards,
Karthik Nayak
