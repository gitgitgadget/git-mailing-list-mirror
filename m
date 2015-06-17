From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v4 07/10] send-email: reduce dependancies impact on
 parse_address_line
Date: Thu, 18 Jun 2015 01:48:34 +0200 (CEST)
Message-ID: <989982277.592587.1434584914349.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1434550720-24130-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <xmqqioam58kz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 01:47:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5N35-00041B-EC
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 01:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbbFQXrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 19:47:11 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:52047 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752080AbbFQXrJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 19:47:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 79E6A292A;
	Thu, 18 Jun 2015 01:47:07 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jacgl+y-WxRL; Thu, 18 Jun 2015 01:47:07 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 65B4F2928;
	Thu, 18 Jun 2015 01:47:07 +0200 (CEST)
In-Reply-To: <xmqqioam58kz.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: reduce dependancies impact on parse_address_line
Thread-Index: sluhZO36/kqxmsS0NMejmEJH3TakNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271930>

> Junio C Hamano <gitster@pobox.com> writes
> Suffix "rgx" that means "regular expression" is a bit unusual, and
> also hard to read when squashed to another word.  Elsewhere in the
> same script, we seem to use $re_whatever to store precompiled
> regular expressions, so perhaps $re_comment, $re_quote, etc.?

Yes it's indeed a better name. I had not seen it, thanks!


> > +                if ($str_address ne "" && $str_phrase ne "") {
> > +                    $str_address = qq[<$str_address>];
> > +                }
> 
> We see both "git@vger.kernel.org" and "<git@vger.kernel.org>" around
> here for an address without comment or phrase; this chooses to turn
> them both into "<git@vger.kernel.org>" form?  Not a complaint but am
> thinking aloud to see if I am reading it correctly.

If there's no phrase, this will choose the "git@vger.kernel.org" form,
in both cases, because it'll be recognize as an address, $str_address
will be "git@vger.kernel.org" and $str_phrase will be empty before the
if ($str_address ne "" ...)
Here are some tests:

Input: <jdoe@example.com>
Split: jdoe@example.com
M::A : jdoe@example.com
----------
Input: jdoe@example.com
Split: jdoe@example.com
M::A : jdoe@example.com
----------
Input: Jane <jdoe@example.com>
Split: Jane <jdoe@example.com>
M::A : Jane <jdoe@example.com>
----------
Input: Jane Doe <jdoe@example.com>
Split: Jane Doe <jdoe@example.com>
M::A : Jane Doe <jdoe@example.com>
----------
Input: "Jane" <jdoe@example.com>
Split: "Jane" <jdoe@example.com>
M::A : "Jane" <jdoe@example.com>
----------
Input: "Doe, Jane" <jdoe@example.com>
Split: "Doe, Jane" <jdoe@example.com>
M::A : "Doe, Jane" <jdoe@example.com>

I've some more tests, maybe I should put them all in this post ?
