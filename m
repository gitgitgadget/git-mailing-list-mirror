From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Thu, 08 Oct 2015 11:35:45 -0700
Message-ID: <xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3l5zgst.fsf@grenoble-inp.fr>
	<CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
	<vpq8u7dp9qr.fsf@grenoble-inp.fr>
	<CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 20:35:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkG2i-0004N7-5G
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 20:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbbJHSfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 14:35:48 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35692 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbbJHSfr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 14:35:47 -0400
Received: by pabve7 with SMTP id ve7so3221576pab.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tkvTZev/cofM2q2LXZ+UQjlx02H2VJu91ljPl79wVJI=;
        b=hMKhyHY05Fyl1c/dIyKBksi7v5zxyJe2l5/6e/UizOdZ/ExWJm7XxdI5l5ke+0Mv+T
         WmEVPfD5JECKDibfBFsIV65R7kA19dAeOgBrsabV+mk0hQf3M2NaELixOC6LgsDwldsn
         KJVdlrA9y9irsKWdCiRON1Xa8SOWaiSfdlibTMYoyHkjgj89rk4nUl5C74iZOqLiRza6
         8mI+yRhnNqhD7eM0bGEFMldyd/zgw+Hgfannm4+Ox7Xsm/4/HOTAkmBfY4p9EBb12JxK
         9P5m5iBz8+pEWuZfAoiE2xoh+Lu0BMRwj8PCoL7MPziNiyHBe9PoP6sBvpOSh8oRf1Ke
         nhaw==
X-Received: by 10.68.102.225 with SMTP id fr1mr9730210pbb.65.1444329346929;
        Thu, 08 Oct 2015 11:35:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id st5sm45043415pab.42.2015.10.08.11.35.45
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 08 Oct 2015 11:35:46 -0700 (PDT)
In-Reply-To: <CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 8 Oct 2015 22:58:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279254>

Karthik Nayak <karthik.188@gmail.com> writes:

> No i mean I could follow up with the way we use it in align, but I don't see
> how I can make a function out of this.

At least you should be able to pre-parse the %(<atom>:<modifier>)
construct, instead of doing strcmp() every time populate_value() is
called, no?  Then your parser would not be doing

>>>> +                             if (!strcmp(valp, ",nobracket"))
>>>> +                                     nobracket = 1;

with 'valp' that scans over 'name' (which is an element of
used_atom[], i.e. a name from valid_atom[] followed by ":<modifier>"
for each customization).  Instead your used_atom[] would be an array
of a data structure that is richer than just a string.

The <modifier> would be split at comma boundary and made into an
array of two field structure, as the most general form of it is

    <modifier> ::= <attrval> | <attrval> ',' <modifier>
    <attrval> ::= <attr> '=' <value> | <attr> | <value>

if we recall the discussion we had while designing %(align), i.e.

 * The most general form is "%(align:position=left,width=32)"

 * The value domain of attributes may be distinct, in which case the
   value itself could imply what attr it is talking about,
   e.g. "%(align:32,left)" is sufficiently clear as '32' cannot be
   position and 'left' cannot be width.

And clearly there can be an attr whose presense alone can imply its
value (iow, a boolean), even though your %(align) does not yet have
such a modifier.  It is easy to imagine that you would later want to
add %(align:position=left,width=32,truncate) that truncates the value
when its display width exceeds '32'.  The 'nobracket' above would be
an another example of a boolean (whose name is negative, which is
not a very good design in general, though).

Then used_atom[] could become something like

    struct {
    	const char *str; /* e.g. "align:position=left,32" */
	struct {
        	const char *part0; /* everything before '=' */
                const char *part1; /* optional */
	} *modifier;
        int modifier_nr;
    } *used_atom;

and "align:position=left,32" would be parsed into

	.str = "align:position=left,32";
        .modifier = { { "position", "left" }, { "32", NULL } };
        .modifier_nr = 2;

when the format string is read, which is done only once.

The looping over all the refs done in populate_value() could just
use the pre-parsed representation.

Hmm?
