From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [RFC] send-email quote issues
Date: Mon, 15 Jun 2015 13:16:54 +0200 (CEST)
Message-ID: <330077615.505681.1434367014434.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <387683965.505610.1434366660032.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 13:15:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4SMo-0005nq-OQ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 13:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbbFOLPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 07:15:47 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:59488 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754221AbbFOLPn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2015 07:15:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 65FA136FA;
	Mon, 15 Jun 2015 13:15:41 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v6R5F2QqWwaw; Mon, 15 Jun 2015 13:15:41 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4B86F36F5;
	Mon, 15 Jun 2015 13:15:41 +0200 (CEST)
In-Reply-To: <387683965.505610.1434366660032.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email quote issues
Thread-Index: QRTWfO20M/evjxQZQpLukZbzW5uJ1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271678>

Hi,

I'm currently working on git send-email to allow passing names
containing commas. I would like to specify that the comma
shouldn't be interpreted as a delimiter when there's quotes
around:

  "Jane, Katarina Doe" <jdoe@example.com>

This changes the behavior of the double quote. For example
when passing:

  --to='"Jane" Doe <jdoe@example.com>'

to git send-email, the line produced was:

  To: "\"Jane\" Doe" <jdoe@example.com>

With this modification, it would be:

  To: Jane Doe <jdoe@example.com>
    or
  To: "Jane Doe" <jdoe@example.com>

And this will not be possible to use quote in a name anymore.
Is this a problem ?

Currently, git send-email contains a function which splits at commas
with respect to quotes (parse_address_line introduced by
5012699d9840fe34fe0838ea0d529c2f32f76b82). It is used to parse user
input when there's no recipient specified. I would like to use this
function to parse --to, --cc and --bcc options, but the execution of
this function depends on whether the user has the Perl library
Mail::Address or not. This introduce a change in the behaviour:

Output1 represents lines produced with the Mail::Address library
Output2 represents lines produced without the Mail::Address library

 1) Simple quote are not interpreted the same way:

   Input : 'Doe, "Jane' <jdoe@example.com>
      Output1 : 'Doe,
                "\" Jane'" <jdoe@example.com>
      Output2 : "'Doe, \"Jane'" <jdoe@example.com>

   Input : 'Jane 'Doe' <jdoe@example.com>
      Output1 : 'Jane 'Doe' <jdoe@example.com>
      Output2 : ERROR

 2) Mail::Address adds a space when using a quote or a backslash in a name

   Input : "Jane Do"e <jdoe@example.com>
      Output1 : "\"Jane Do\" e" <jdoe@example.com>
      Output2 : "\"Jane Do\"e" <jdoe@example.com>

   Input : \Jane Doe <jdoe@example.com>
      Output1 : "\ Jane Doe" <jdoe@example.com>
      Output2 : "\Jane Doe" <jdoe@example.com>

 3) Mail::Address works when quote is not closed

   Input : "Jane Doe <jdoe@example.com>
      Output1 : "\" Jane Doe" <jdoe@example.com>
      Output2 : ERROR

 4) Mail::Address splits the string when there's no comma

   Input : Jane "Doe <jdoe@example.com>"
      Output1 : Jane,
   	"\"Doe" <jdoe@example.com>
      Output2 : "Jane \"Doe" <jdoe@example.com>

The following doesn't work for both:

   Input : "Jane Doe <jdoe@example.com>" <jdoe@example.com>
      Output1 : ERROR
      Output2 : ERROR
