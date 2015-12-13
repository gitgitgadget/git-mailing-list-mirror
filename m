From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 09/10] ref-filter: introduce contents_atom_parser()
Date: Sat, 12 Dec 2015 23:41:18 -0500
Message-ID: <CAPig+cTVqTc1S8gduLq3qiyuzJNb=LNQiXijEHwqPPzi1YU8UQ@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-10-git-send-email-Karthik.188@gmail.com>
	<CAPig+cTbT60cWk+=6EARte68mmQ2xkS5xFgsgh0FbpoueFcBbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 05:42:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7yTw-0003jX-5F
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 05:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbbLMElU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 23:41:20 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35705 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbbLMElT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 23:41:19 -0500
Received: by vkha189 with SMTP id a189so137132565vkh.2
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 20:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ivh4thEhmy/mwxf/YHijZNYx+r7PNFbBiPYbLGnquFw=;
        b=JjKh7Yqo5C/K4/w8I3vsI31wS0Tu63gTCN4RVkekDcerBE+TxfhGCMmXYjtnuu/sUe
         Q3rk33xhh986BeYmGIPxVM1UomBTkQ3HXPzB3kz1TkoyPusVs21237YHXbF5S+iQhs54
         yOtGnXR2Vdae0n0h9VWS028Po9rPyRw4Nk1+iFiD43dOCP2xRhixkEHSLtwimYIQDiR2
         MGmBpfZJUtHi11FsjClrwZFG/y1R0XeIVrPqOdkJcDrd8SsJUoSKpqcdt6FDRDjsEPNu
         q8/9uNKJGKxKC0s+XQGHbpyWS5RKdfwzDUUTLPIDZ8zakjVGrtGsTr0DbC8j0huFYDX1
         oLWQ==
X-Received: by 10.31.58.142 with SMTP id h136mr20208918vka.115.1449981678989;
 Sat, 12 Dec 2015 20:41:18 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 12 Dec 2015 20:41:18 -0800 (PST)
In-Reply-To: <CAPig+cTbT60cWk+=6EARte68mmQ2xkS5xFgsgh0FbpoueFcBbg@mail.gmail.com>
X-Google-Sender-Auth: naYoMcj1XCHEK288wCQuaIy637Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282318>

On Sat, Dec 12, 2015 at 10:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> +void contents_atom_parser(struct used_atom *atom)
>> +{
>> +       const char * buf;
>> +
>> +       if (match_atom_name(atom->str, "contents", &buf))
>> +               atom->u.contents.all = 1;
>> +
>> +       if (!buf)
>> +               return;

Also, isn't this logic somewhat bogus? u.contents.all is set to 1 for
both bare %(contents) and decorated %(contents:whatever). Then, below,
you also set one of .body, .signature, .subject, or .lines if a
decoration is specified. So, now you have both .all and one of the
other attributes set to 1, which is rather nonsensical (if I
understand correctly).

If you change this to an enum as suggested in my previous email, then
the problem goes away.

>> +       if (!strcmp(buf, "body"))
>> +               atom->u.contents.body = 1;
>> +       else if (!strcmp(buf, "signature"))
>> +               atom->u.contents.signature = 1;
>> +       else if (!strcmp(buf, "subject"))
>> +               atom->u.contents.subject = 1;
>> +       else if (skip_prefix(buf, "lines=", &buf)) {
>> +               atom->u.contents.lines = 1;
>> +               if (strtoul_ui(buf, 10, &atom->u.contents.no_lines))
>> +                       die(_("positive value expected contents:lines=%s"), buf);
>> +       } else
>> +               die(_("improper format entered contents:%s"), buf);
>> +}
