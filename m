From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 02/17] revert: Inline add_message_to_msg function
Date: Wed, 13 Jul 2011 11:30:40 +0530
Message-ID: <CALkWK0kHutr41aH7OrmW3REV+YBUeHSryA9n62yxyF0qRd1FEw@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-3-git-send-email-artagnon@gmail.com> <20110712165302.GA13578@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 08:02:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgsWK-0002aK-3o
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 08:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab1GMGBC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 02:01:02 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:39759 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab1GMGBB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 02:01:01 -0400
Received: by wwg11 with SMTP id 11so172273wwg.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 23:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Pp6Tm8QGDb2PJON3D7m28GCUixr7ewmQGJKNUpHCfL4=;
        b=nw1t1gyd4Yo3zTb4JRrOOEBRxVaN4d/Cr7+j+jp+Hoz4aTv8BQcD000ZQGVBZHq8XO
         4RiuYQpAtdVUnH/B/V8ZYNY9WUjGGtHQMog5wvgENdSIyE0CWFROHHq4bW7lYm+x05nZ
         QG7lvywGVlqXj5s+lhAAtCYNBZpkwYvy03zog=
Received: by 10.216.8.204 with SMTP id 54mr566873wer.92.1310536860127; Tue, 12
 Jul 2011 23:01:00 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Tue, 12 Jul 2011 23:00:40 -0700 (PDT)
In-Reply-To: <20110712165302.GA13578@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176992>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>
>> The add_message_to_msg function is poorly implemented, has an unclea=
r
>> API, and only one callsite. =C2=A0Replace the callsite with a cleane=
r
>> implementation. =C2=A0Additionally, fix a bug introduced in 9509af6 =
(Make
>> git-revert & git-cherry-pick a builtin, 2007-03-01) -- a NULL pointe=
r
>> was being incremented when "\n\n" was not found in "message".
>
> Rather than being an optimization, the main impact of this change is
> to avoid a NULL pointer dereference in some cases, right?
>
> If so, the subject line should say so. =C2=A0Is it possible to reprod=
uce
> this? =C2=A0Could we add a test to avoid regressing in the future?
>
> Less importantly:
>
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
> [...]
>> @@ -462,11 +449,16 @@ static int do_pick_commit(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addstr(&msgb=
uf, ".\n");
>> =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *p =3D strstr=
(msg.message, "\n\n");
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base =3D parent;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base_label =3D msg.=
parent_label;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next =3D commit;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next_label =3D msg.=
label;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_message_to_msg(&msgb=
uf, msg.message);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D p ? p + 2 : sha1_t=
o_hex(commit->object.sha1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addstr(&msgbuf, p=
);
>
> I think this would be clearer like so:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *p;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D strstr(.=
=2E.);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0p +=3D 2;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0p =3D sha1_to_hex...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addstr(=
&msgbuf, p);
>
> i.e., putting all the code that manipulates p together. =C2=A0Besides=
,
> pre-C99 compilers don't like "p" to be initialized to a non-constant.
> :)
>
> At [1], I also see a suggestion of a comment that could clarify the
> code a little.

=46ixed all issues.  The commit message now reads

revert: Inline add_message_to_msg function

The add_message_to_msg function is poorly implemented, has an unclear
API, and only one callsite.  Replace the callsite with a cleaner
implementation.  Additionally, fix a bug introduced in 9509af6 (Make
git-revert & git-cherry-pick a builtin, 2007-03-01) -- a NULL pointer
was being dereferenced when "\n\n" was not found in "message".

Thanks.

-- Ram
