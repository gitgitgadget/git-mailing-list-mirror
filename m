From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty.c: add %z specifier.
Date: Thu, 20 Mar 2008 23:19:15 -0700
Message-ID: <7v8x0csios.fsf@gitster.siamese.dyndns.org>
References: <5d46db230803201745mb736e98w4925e14b5d92d71d@mail.gmail.com>
 <7veja4u1gv.fsf@gitster.siamese.dyndns.org>
 <20080321045137.GA5563@coredump.intra.peff.net>
 <7vtzj0slx4.fsf@gitster.siamese.dyndns.org>
 <5d46db230803202242j60b0e9f6q798afd6c5f468207@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 07:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcacD-00006P-0j
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 07:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbYCUGTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 02:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755892AbYCUGTg
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 02:19:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868AbYCUGTf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 02:19:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B85A22485;
	Fri, 21 Mar 2008 02:19:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 94EB32484; Fri, 21 Mar 2008 02:19:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77720>

"Govind Salinas" <govind@sophiasuchtig.com> writes:

> On Fri, Mar 21, 2008 at 12:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jeff King <peff@peff.net> writes:
>>
>>  > On Thu, Mar 20, 2008 at 09:48:16PM -0700, Junio C Hamano wrote:
>>  >
>>  >> > +  case 'z':               /* null */
>>  >> > +          strbuf_addch(sb, '\0');
>>  >> > +          return 1;
>>  >> >    }
>>  >> >
>>  >> >    /* these depend on the commit */
>>  >>
>>  >> I do not like this at all.  Why aren't we doing %XX (2 hexadecimal digits
>>  >> for an octet)?
>>  >
>>  > Because %ad is already taken? :)
>>  >
>>  > %x* is still available, though, so maybe %x00?
>>
>>  Perhaps, but before I forget.
>> ...
>
> Sorry, I'm a bit confused.  Should I alter the patch to use a different code
> for null, that would be fine by me?  The above seems to be an unrelated issue.

Sorry for confusing you.  The above is an unrelated issue.  But at least
to me it is much more important one.  I would not be unhappy at all if we
did not have either %z nor %x00, but the above bugs me moderately.  Also I
suspect the proper fix for that issue would involve the part in log-tree
you touched.

By the way, I think Jeff's suggestion of %x00 makes more sense than %z.

 pretty.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index 16bfb86..308bfad 100644
--- a/pretty.c
+++ b/pretty.c
@@ -457,6 +457,7 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	const struct commit *commit = c->commit;
 	const char *msg = commit->buffer;
 	struct commit_list *p;
+	int h1, h2;
 
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
@@ -478,6 +479,18 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
 		return 1;
+	case 'x':
+		/* %x00 == NUL, %x0a == LF, etc. */
+		if (0 <= (h1 = hexval_table[0xff & placeholder[1]]) &&
+		    h1 <= 16 &&
+		    0 <= (h2 = hexval_table[0xff & placeholder[2]]) &&
+		    h2 <= 16) {
+			strbuf_addch(sb, (h1<<4)|h2);
+			return 2;
+		} else {
+			return 0;
+		}
+		
 	}
 
 	/* these depend on the commit */
