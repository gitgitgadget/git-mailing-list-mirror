From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] revert: simplify insn parsing logic
Date: Mon, 02 Apr 2012 13:33:55 -0700
Message-ID: <7vr4w5euvg.fsf@alter.siamese.dyndns.org>
References: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
 <1333029495-10034-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 22:34:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEnwz-0007jq-KN
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 22:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab2DBUeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 16:34:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab2DBUd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 16:33:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8909E6F55;
	Mon,  2 Apr 2012 16:33:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MVe246Mv5mzcMLOe+BXPeFRyaPY=; b=PEmYeg
	B9KA9OEDlAlJlPyyUC2tF3foRsp2InB5k6RGemeQTFoWaZLYXdciQ4in+BSzLP7m
	IkEbP0rfRb5xyUk/Hsgs3DvLDXbNmt0I2jQAFVXTS4YlbM1cw1tfCOOpHmhlTOtV
	Qs6ouaC53mKeq5/VXPD7Q1qyx1R7s0fgL01mY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Otg8bAnAy5h+JLFmv+RJ6/TT3cQQ/p1G
	gySy3DcgULgmxhSdU7n7HHtjdy4ikhr4u72/FKy7HxCLJeakGA/QN/gD6nDU5V+i
	7c7mH24kmUthoG0s5CcPJ97WCMiF11s6nud4M/B+KzHU9kshkn/A3ryqgXbKr9z4
	zB4K4+7wlcE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 809116F53;
	Mon,  2 Apr 2012 16:33:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E967F6F52; Mon,  2 Apr 2012
 16:33:56 -0400 (EDT)
In-Reply-To: <1333029495-10034-4-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 29 Mar 2012 19:28:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BB7E5D8-7D03-11E1-B43E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194555>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Our instruction sheet parser first looks for a valid action by
> checking that the buffer starts with either "pick" or "revert".  Then,
> it looks for either spaces or tabs before looking for the object name,
> erroring out if it doesn't find any.  Simplify this logic without
> making any functional changes by looking for ("pick " or "pick\t") or
> ("revert " or "revert\t") in the first place.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Hrm.

In the longer term, I think the right approach is to cut the first token
on the line, and then switch the action based on what the token is.

The reason why the original complains against "pickle <commit> <msg>" is
not because the headword "pickle" is an unknown verb, but because the
recognised token "pick" is followed by 'l' which is not a whitespace, and
the updated code may slightly be closer to the ideal, but not that much.

Perhaps something like this?

I suspect that this may be a bit over-engineered, but on the other hand,
if we do not foresee that we would be adding many other verbs, I do not
think there is much point in your patch to clean up the verb parsing part,
either, so...

-- >8 --

static struct {
	const char *name;
	int len;
	enum replay_action action;
} replay_action[] = {
	{ "pick", 4, REPLAY_PICK },
	{ "revert", 6, REPLAY_REVERT },
};

static enum replay_action parse_action(char **cp_, int *namelen_)
{
	char *cp = *cp_;
        int namelen = strcspn(cp, "\t ");
	int i, padlen;

	for (i = 0; i < ARRAY_SIZE(replay_action); i++)
        	if (namelen == replay_action[i].len &&
                    !memcmp(cp, replay_action[i].name, namelen)) {
			if (namelen_)
				*namelen_ = namelen;
			padlen = strspn(cp + namelen, "\t ");
                        *cp_ = cp + namelen + padlen;
			return replay_action[i].action;
		}
	return -1;
}

static struct commit *parse_insn_line(char *bol, ...)
{
	...

	action = parse_action(&bol, NULL);
	/*
         * Verify that the action matches ...
