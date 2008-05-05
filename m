From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Sun, 04 May 2008 22:00:13 -0700
Message-ID: <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-5-git-send-email-pkufranky@gmail.com>
 <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
 <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
 <alpine.DEB.1.00.0805041040560.30431@racer>
 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
 <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
 <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 07:01:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsspE-0005qx-17
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 07:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbYEEFAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 01:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbYEEFAb
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 01:00:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbYEEFAb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 01:00:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B21DD15B0;
	Mon,  5 May 2008 01:00:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 368C415AD; Mon,  5 May 2008 01:00:24 -0400 (EDT)
In-Reply-To: <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
 (Ping Yin's message of "Mon, 5 May 2008 09:40:47 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2EE8D014-1A60-11DD-97D5-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81230>

"Ping Yin" <pkufranky@gmail.com> writes:

> For this example,both "/if/while/ (i />/>=/ /1/0/)" and  "/if/while/
> (i >//=/ /1/0/)" are fine to me.

For the particular example, both are Ok, but for this other example:

	-if (i > 1...
        +if ((i > 1...

it probably is better to treat each non-word character as a separate
token, that is, it would be easier to read if we said "( stayed intact,
and another ( was added", instead of saying "( is changed to ((".

So "a run of punct chars" rule only sometimes produces better output but
otherwise worse output, and to make it produce better output consistently,
we would need to know the syntax of the target language for tokenization,
i.e. ">=" and ">" are comparison operators, while "(" is a token and "(("
is better split into two open-paren tokens.

So as a very longer term subproject, we may want to teach the mechanism
language specific tokenization rules, just like we can specify the hunk
header pattern via gitattributes(5) to the diff output layer.

Of course, I do not expect you to do that during this round --- and if we
choose to keep the rule simple, I think it is probably better to use
one-char-one-token rule for now.

> And when designing, i think it's better to take multi-byte characters
> into account. For multi-byte characters (especially CJK), every
> character should be considered as a token.

If we take an idealistic view for the longer term, we should be tokenizing
even CJK sensibly, but unlike Occidental scripts, we cannot even use
inter-word spacing for tokenizing hint, so unless we are willing to learn
morphological analysis (which we are not for now), the best we can do is
to use one-char-one-token rule.

	Side Note.  For Japanese we could cheat and often do a slightly
	better job than simple one-char-one-token without having full
	morphological analysis by splicing between Kanji and Kana
	boundaries, but I'd prefer not to go there and keep the rules we
	would use to the minimum.

I should stress that I said "character" in the above "punct" and "CJK"
discussions, not "byte".
