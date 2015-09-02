From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Wed, 02 Sep 2015 18:11:13 +0200
Message-ID: <vpq7fo8ol7i.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-8-git-send-email-Karthik.188@gmail.com>
	<vpq8u8ptcjq.fsf@anie.imag.fr>
	<CAOLa=ZTB_uMvKjU=f9UgmvOmeZD4YtFL_Gv1+VvZAgDV-6WYDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 18:11:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXAdE-0006Kw-DT
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 18:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbbIBQLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 12:11:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54049 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755481AbbIBQLV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 12:11:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t82GBBbF004887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 2 Sep 2015 18:11:11 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t82GBDTX029591;
	Wed, 2 Sep 2015 18:11:13 +0200
In-Reply-To: <CAOLa=ZTB_uMvKjU=f9UgmvOmeZD4YtFL_Gv1+VvZAgDV-6WYDA@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 2 Sep 2015 19:46:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Sep 2015 18:11:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t82GBBbF004887
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441815074.81308@6q6V1en9XtJVA7hqfO56vQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277104>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Sep 2, 2015 at 2:37 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> --- a/builtin/tag.c
>>> +++ b/builtin/tag.c
>>> @@ -185,6 +185,10 @@ static enum contains_result contains(struct commit *candidate,
>>>       return contains_test(candidate, want);
>>>  }
>>>
>>> +/*
>>> + * Currently modified and used in ref-filter as append_lines(), will
>>> + * eventually be removed as we port tag.c to use ref-filter APIs.
>>> + */
>>>  static void show_tag_lines(const struct object_id *oid, int lines)
>>
>> I would rather have one "cut and paste" patch followed by a "modify and
>> use" patch for review.
>>
>> As-is, reading the patch doesn't tell me what change you did.
>>
>> That said, I did get this information in the interdiff, so I won't
>> insist on that.
>
> Its only borrowed slightly, so I don't really see the need for this.
> But if you insist, we could do that .

As you prefer.

Perhaps just adapt the comment to say "Currently redundant with
ref-filter'.c's append_line ...", but that's not important.

>>> +static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
>>> +{
>>> +     int i;
>>> +     const char *sp, *eol;
>>> +     size_t len;
>>> +
>>> +     if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
>>> +             size += 2;
>>
>> Why is this "size += 2" needed?
>>
>
> We pass size as "sublen + bodylen - siglen" if there exists a "\n\n"
> between sublen and bodylen this is not accounted for. hence we
> add 2 here.

That's too much magic for uncommented code. If this is really needed,
then thes explanations should go in a comment, and I think this logic
should be moved out of append_lines (if you read the comment above, the
function, it is actually lying about what the function does).

I think you can simplify this: you know where the buffer ends (bodypos +
bodylen) and where it starts (subpos), so you know the size: bodypos +
bodylen - subpos.

IOW, I think you can apply this:

--- a/ref-filter.c
+++ b/ref-filter.c
@@ -645,9 +645,6 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 	const char *sp, *eol;
 	size_t len;
 
-	if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
-		size += 2;
-
 	sp = buf;
 
 	for (i = 0; i < lines && sp < buf + size; i++) {
@@ -707,7 +704,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			struct strbuf s = STRBUF_INIT;
 			if (strtoul_ui(valp, 10, &v->u.contents.lines))
 				die(_("positive width expected contents:lines=%s"), valp);
-			append_lines(&s, subpos, sublen + bodylen - siglen, v->u.contents.lines);
+			append_lines(&s, subpos, bodypos + bodylen - subpos, v->u.contents.lines);
 			v->s = strbuf_detach(&s, NULL);
 		}
 	}

(half-tested only)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
