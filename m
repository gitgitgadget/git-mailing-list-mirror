From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin-commit: Include the diff in the commit message when verbose.
Date: Thu, 22 Nov 2007 11:14:29 -0800
Message-ID: <7vzlx63xey.fsf@gitster.siamese.dyndns.org>
References: <1195700089-8326-1-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0711221049350.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvHVq-0001hP-T7
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 20:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbXKVTOj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 14:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbXKVTOj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 14:14:39 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39080 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbXKVTOi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 14:14:38 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DF1B72F9;
	Thu, 22 Nov 2007 14:14:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C2C498908;
	Thu, 22 Nov 2007 14:14:54 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711221049350.27959@racer.site> (Johannes
	Schindelin's message of "Thu, 22 Nov 2007 10:52:04 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65835>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 21 Nov 2007, Kristian H=C3=B8gsberg wrote:
>
>> +
>> +	/* Truncate the message just before the diff, if any. */
>> +	p =3D strstr(sb.buf, "\ndiff --git a/");
>> +	if (p !=3D NULL)
>> +		strbuf_setlen(&sb, p - sb.buf);
>> +
>
> Is this related to the change in wt_status?  If so, wouldn't we want =
to=20
> suppress the diff, instead of generating it, and then killing it late=
r?

This corresponds to the sed script near l.545 in git-commit.sh.

I've been wondering if it would be better not to have this logic
but instead "git commit -v" to show the diff text prefixed with
'# ' to make it a proper comment, by the way.

> Besides, you'd want to leave the \n there: strbuf_setlen(&sb, p + 1 -=
=20
> sb.buf);

Yup.

>> +	/* Sigh, the entire diff machinery is hardcoded to output to
>> +	 * stdout.  Do the dup-dance...*/
>
> I wonder how much effort it would be to change that.  Not that it wou=
ld=20
> help too much, since we want the output in a strbuf anyway.

The codepath is preparing COMMIT_EDITMSG file for the user to
edit (or to the standard output, if this is "git status -v").

I do not know about "strbuf" part; resulting patch text could be
large and in most cases the callers would rather flush it to
outside (either pipe or file) as soon as possible than having to
keep it all in core.

I was trying to do the stdout -> FILE *fp conversion of diff.c
last night but dropped it halfway, after finding one puts()
misconversion and fixing it.  The changes should mostly be
straightforward but the result felt ugly.
