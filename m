From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] commit: add --cleanup=scissors
Date: Mon, 24 Feb 2014 16:18:40 -0800
Message-ID: <xmqqios46o4f.fsf@gitster.dls.corp.google.com>
References: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
	<1392639332-7703-1-git-send-email-pclouds@gmail.com>
	<1392639332-7703-4-git-send-email-pclouds@gmail.com>
	<20140222005856.GA9231@lanh>
	<xmqqd2icbf75.fsf@gitster.dls.corp.google.com>
	<CACsJy8AkxJqXvR3H36+m_GJ0Z3z8XLw+Our0Eu7X5B6ZZ1C-nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 01:18:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI5jT-0006pV-Mr
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 01:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbaBYASn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 19:18:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbaBYASm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 19:18:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 577646FDFE;
	Mon, 24 Feb 2014 19:18:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IRB0Nq7vv42jjg33mY25eBMQoLg=; b=jFA/+0
	Afr7zpQPahNG0KYIiCiQ1Hmig9pP8mLey9xzpjisBrlG94nDDe6uboBs/f/cOQI/
	aGyyO3DGR8tAYESegN4F3Nl97VuxCr3kEhBPS566pZTf/BKGy1XZNCnRPc+2o/RJ
	NqXfaqt6vY8NHaR/2G03nCOMrZMy7wN0ScPOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gEelBYeVy7H+izf46NR7oUhO6gYnuGTH
	QVkxX3D+ybg5VoSjBHMEQYI6x5eujMeolQihPpya5X583GL0B2WJBEejkBfUzAnw
	njhgKK1i2mjS3aARZho802PPrN2G7hJCjs6rwN15miFTRD0lN70dHqF49BJrJwDk
	EPJlgzOCA/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46D7E6FDFD;
	Mon, 24 Feb 2014 19:18:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9411E6FDFC;
	Mon, 24 Feb 2014 19:18:41 -0500 (EST)
In-Reply-To: <CACsJy8AkxJqXvR3H36+m_GJ0Z3z8XLw+Our0Eu7X5B6ZZ1C-nQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 25 Feb 2014 06:28:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 61768072-9DB2-11E3-B40D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242657>

Duy Nguyen <pclouds@gmail.com> writes:

> I think I described it incorrectly as "conflict message" while it's
> not. This is the part to be cut out by the patch
>
> # It looks like you may be committing a merge.
> # If this is not correct, please remove the file.
> #     MERGE_HEAD
> # and try again.
>
> (similar message for CHERRY_PICK_HEAD).

Ahh, OK.  That should be removed, of course.

Will squash in (but not tonight).  Thanks.

>
>>
>>> -- 8< --
>>> diff --git a/builtin/commit.c b/builtin/commit.c
>>> index ea2912f..1033c50 100644
>>> --- a/builtin/commit.c
>>> +++ b/builtin/commit.c
>>> @@ -755,7 +755,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>>>       strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRICT));
>>>       if (use_editor && include_status) {
>>>               char *ai_tmp, *ci_tmp;
>>> -             if (whence != FROM_COMMIT)
>>> +             if (whence != FROM_COMMIT) {
>>> +                     if (cleanup_mode == CLEANUP_SCISSORS)
>>> +                             wt_status_add_cut_line(s->fp);
>>>                       status_printf_ln(s, GIT_COLOR_NORMAL,
>>>                           whence == FROM_MERGE
>>>                               ? _("\n"
>>> @@ -771,6 +773,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>>>                               git_path(whence == FROM_MERGE
>>>                                        ? "MERGE_HEAD"
>>>                                        : "CHERRY_PICK_HEAD"));
>>> +             }
>>>
>>>               fprintf(s->fp, "\n");
>>>               if (cleanup_mode == CLEANUP_ALL)
>>> @@ -778,7 +781,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>>>                               _("Please enter the commit message for your changes."
>>>                                 " Lines starting\nwith '%c' will be ignored, and an empty"
>>>                                 " message aborts the commit.\n"), comment_line_char);
>>> -             else if (cleanup_mode == CLEANUP_SCISSORS)
>>> +             else if (cleanup_mode == CLEANUP_SCISSORS && whence == FROM_COMMIT)
>>>                       wt_status_add_cut_line(s->fp);
>>>               else /* CLEANUP_SPACE, that is. */
>>>                       status_printf(s, GIT_COLOR_NORMAL,
>>> -- 8< --
