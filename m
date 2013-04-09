From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository
 boundaries
Date: Tue, 09 Apr 2013 10:41:50 -0700
Message-ID: <7vr4ijsish.fsf@alter.siamese.dyndns.org>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
 <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org>
 <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:42:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcYQ-0002BM-8F
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211Ab3DIRly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:41:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40729 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab3DIRlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:41:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFC0D11FCF;
	Tue,  9 Apr 2013 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5XdC+3HFS9Np4nJ0mbsYj82PtGg=; b=I5Clyt
	eNCjyOHaznluFJHdQd0bxUuzg7vJojFZzieE7q0QVYOy3UZD/oZw4WC24it1zhAA
	XKFUGC3tBB3PsvRCUYXjwALassA81xc9n74kHhxFECUi5ZhWWDdw518sFz4quvYc
	5s2VRNEUUdT292TfEHK03P7c02Z00gMVdeGx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e312Vp9bzqtGnDYVeRSwnJbDUktLdd1o
	U0CGxxz0jwut2vMi9jJ2vlNqtS5GCvgi8BfRGnFCoWusoPA58d01dBsItchbk1NG
	OXBnWEPod7jZ9gzenjd6/GooQOOCHPUR3YTpuoXGTAK6nJ2XQlEigamp4o/0ZSiI
	9CQybG1KkQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6CB111FCC;
	Tue,  9 Apr 2013 17:41:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D070B11FC6; Tue,  9 Apr
 2013 17:41:51 +0000 (UTC)
In-Reply-To: <7vvc7vsj4p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 09 Apr 2013 10:34:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C330C6A6-A13C-11E2-9619-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220597>

Junio C Hamano <gitster@pobox.com> writes:

>> I looked at the output from "grep has_symlink_leading_path" and also
>> for "die_if_path_beyond"; all of these places are checking "I have
>> this multi-level path; I want to know if the path does not (should
>> not) be part of the current project", I think.  Certainly the one in
>> the "update-index" is about the same operation as "git add" you are
>> patching.
>>
>> Isn't it a better approach to _rename_ the existing function not to
>> single out "symlink"-ness of the path first ?  A symlink in the
>> middle of such a multi-level path that leads to a place outside the
>> project is _not_ the only way to step out of our project boundary.  A
>> directory in the middle of a multi-level path that is the top-level
>> of the working tree of a foreign project is another way to step out
>> of our project boundary.  Perhaps
>>
>> 	die_if_path_outside_our_project()
>>         path_outside_our_project()
>>
>> And then update the implementation of path_outside_our_project(),
>> which only took "symlink in the middle" into account so far, and
>> teach it that such a "top-level of the working tree of a foreign
>> project" is also stepping out of our project?
>>
>> That way, you do not have to settle on fixing the bug only in "git
>> add" and keep the bug in "git update-index", I think.
>>
>> I think the hit in builtin/apply.c deals with the same "beyond
>> symlink is outside our project" check and can be updated like so.  I
>> didn't look at the ones in diff-lib.c and dir.c so you may want to
>> double check on what they use it for.
>
> The first step (renaming and adjusting comments) would look like
> this.

Actually, there is another function "check_leading_path()" you may
want also adjust.

        /*
         * Return zero if path 'name' has a leading symlink component or
         * if some leading path component does not exists.
         *
         * Return -1 if leading path exists and is a directory.
         *
         * Return path length if leading path exists and is neither a
         * directory nor a symlink.
         */
        int check_leading_path(const char *name, int len)
        {
            return threaded_check_leading_path(&default_cache, name, len);
        }

I think what the callers of this function care about is if the name
is a path that should not be added to our index (i.e. points
"outside the repository").  If you had a symlink d that points at e
when our project does have a subdirectory e with file f,

	check_leading_path("d/f")

wants to say "bad", even though the real file pointed at, i.e. "e/f"
is inside our working tree, so "outside our working tree" is not
quite correct in the strict sense (this applies equally to
has_symlink_leading_path), but I think we should treat the case
where "d" (and "d/f") belongs to the working tree of a repository
for a separate project, that is embedded in our working tree the
same way.
