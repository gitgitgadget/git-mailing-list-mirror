From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Fri, 14 Mar 2008 09:20:09 -0700
Message-ID: <7v4pb9qnuu.fsf@gitster.siamese.dyndns.org>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net>
 <20080313170016.GA3439@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 17:21:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaCeW-0007LW-5b
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 17:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbYCNQUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 12:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbYCNQUY
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 12:20:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbYCNQUX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 12:20:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 74EED187B;
	Fri, 14 Mar 2008 12:20:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 60D481878; Fri, 14 Mar 2008 12:20:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77250>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 13, 2008 at 05:40:19PM +0100, Samuel Tardieu wrote:
>
>> Add MIME-Version/Content-Type/Content-Transfer-Encoding headers in
>> messages generated with git-format-patch. Without it, messages gener=
ated
>> without using --attach or --inline didn't have any content type info=
rmation.
>>=20
>> I got hit with this problem yesterday when sending a patch to linux-=
kernel
>> with a commit message containing the name "P=C3=A1draig" in it. More=
over,
>> the mailing-list software added an incorrect ISO-8859-1 encoding inf=
ormation
>> which mangled P=C3=A1draig's name.
>
> It's supposed to handle this automatically if the commit message
> contains non-ascii characters. What version of git were you using?

You are right.  The call-chain looks like this:

    log_tree_diff_flush()
     show_log()
      log_write_email_headers()     writes mbox From
      pretty_print_commit()
                                    check commit log if it is pure asci=
i
       pp_header()
        pp_user_info()              writes RFC2822 From:
       pp_title_line()              writes RFC2822 Subject:
                                    writes MIME-Version: and friends if=
 needed
       pp_remainder()               writes the remainder of the log mes=
sage
      append_signoff()
     printf("---\n")
     diff_flush()                   writes the patch

At the beginning of pretty_print_commit() we look at the log and if it =
is
not ascii we pass that information down to pp_title_line() which is
responsible for writing MIME header at the appropriate place.

If your patch itself has some non-ASCII material, and if your commit lo=
g
message is pure ASCII, the above would end up not writing MIME at all. =
 If
your commit log message is non ASCII, then we will mark it as if the
entire message is in the encoding of the log in pp_title_line().  This
might look like a problem, but it is not something non multipart output=
 of
format-patch should even try to cater to.  The payload (i.e. the patch)
out of git has always been uninterpreted sequence of bytes (and it is n=
ot
going to change).

A patch to i18n po/ files for example could contain patches to differen=
t
files encoded in KOI-8, BIG5, EUC-JP and UTF-8 at the same time.  There=
 is
no way to say "text/plain; charset=3DX" for such a payload (because the=
re is
no single charset used in such a patch), and git simply does not know n=
or
care about what encoding each file is in.  The output from git marks on=
ly
the part git knows the encoding about (i.e. the commit log message).

Having said all that, I notice that addition of format.headers variable
(which I think is a later invention) was done not quite correctly.  In =
the
callchain above, pretty_print_commit() function checks the commit log b=
ut
it is meant to do so only when we haven't emitted MIME Content-Type:
(because the user told us to do multipart), and "after_subject" paramet=
er
was getting passed around for it (and its callees) to detect exactly th=
at.
But format.headers misused that variable to carry its contents along --=
-
there needs a way to pass "have we said MIME-Version crap already"
separately.
