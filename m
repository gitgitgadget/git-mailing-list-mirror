From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: avoid generation of empty patches
Date: Sat, 10 Jan 2009 12:41:33 -0800
Message-ID: <7vy6xivqpu.fsf@gitster.siamese.dyndns.org>
References: <1231536787-20685-1-git-send-email-nathan.panike@gmail.com>
 <7vmye0yohu.fsf@gitster.siamese.dyndns.org> <20090110113642.GA25723@myhost>
 <20090110113903.GB25723@myhost>
 <d77df1110901100801s463bb43bt701a95df14f167d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alexander Potashev" <aspotashev@gmail.com>, git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 21:43:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLkfi-0002Df-Rc
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 21:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbZAJUln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 15:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZAJUll
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 15:41:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbZAJUll (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 15:41:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 81B5B1C32F;
	Sat, 10 Jan 2009 15:41:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B50101C32E; Sat,
 10 Jan 2009 15:41:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1566CDFA-DF57-11DD-B2AA-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105145>

"Nathan W. Panike" <nathan.panike@gmail.com> writes:

> On Sat, Jan 10, 2009 at 5:39 AM, Alexander Potashev
> <aspotashev@gmail.com> wrote:
> ...
>>
>> +               if (!commit->parents && !rev.show_root_diff)
>> +                       break;
>
> Do you really want to stop getting commits?  It seems like the break
> statement here should be a continue.

You can give a commit range that has two independent roots.  The above
"break" is wrong.

The variable is called show_root_DIFF, not show_root_COMMIT; even if you
have "log.showroot = false", "git log -p" output would still give you the
initial commit, but without the patch text, no?

But that is not Alexander's fault; it is mine.

I think "log -p" and "format-patch" can and should behave differently in
this case.  "log -p" is for people who already _have_ the history and
would want to inspect how it evolved, and it is reasonable if some people
want to say "the very initial huge import is not interesting to me while
reviewing the history", and turning it off makes sense for them (in fact,
the default was initially that way).

On the other hand, "format-patch" is about exporting a part of your
history so that you can mechanincally replay it elsewhere, and I do not
think of a reasonable justification not to export a root commit fully if
the range user asked for happens to contain one.

I agree with Alexander that we should not output just the message without
the patch text, but I think the right solution is to show both. not to
skip root.

-- >8 --
format-patch: show patch text for the root commit

Even without --root specified, if the range given on the command line
happens to include a root commit, we should include its patch text in the
output.

This fix deliberately ignores log.showroot configuration variable because
"format-patch" and "log -p" can and should behave differently in this
case, as the former is about exporting a part of your history in a form
that is replayable elsewhere and just giving the commit log message
without the patch text does not make any sense for that purpose.

Noticed and fix originally attempted by Nathan W. Panike; credit goes to
Alexander Potashev for injecting sanity to my initial (broken) fix that
used the value from log.showroot configuration, which was misguided.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-log.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git c/builtin-log.c w/builtin-log.c
index 4a02ee9..91e5412 100644
--- c/builtin-log.c
+++ w/builtin-log.c
@@ -935,6 +935,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		 * get_revision() to do the usual traversal.
 		 */
 	}
+
+	/*
+	 * We cannot move this anywhere earlier because we do want to
+	 * know if --root was given explicitly from the comand line.
+	 */
+	rev.show_root_diff = 1;
+
 	if (cover_letter) {
 		/* remember the range */
 		int i;
