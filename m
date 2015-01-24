From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 6/6] refs.c: enable large transactions
Date: Fri, 23 Jan 2015 16:38:38 -0800
Message-ID: <xmqqtwzhnhbl.fsf@gitster.dls.corp.google.com>
References: <54C0E76D.5070104@alum.mit.edu>
	<1422043442-30676-1-git-send-email-sbeller@google.com>
	<1422043442-30676-7-git-send-email-sbeller@google.com>
	<xmqqy4otnigf.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYbCBHVhL+FvKu-yKMinxGCMwGfqG96rSp+0-7frgO2wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Loic Dachary <loic@dachary.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 01:38:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEokQ-00081o-L6
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 01:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbbAXAim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 19:38:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751877AbbAXAil (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 19:38:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6439532A2D;
	Fri, 23 Jan 2015 19:38:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IkImP9KhMR7fHKyFBWI0hBGfuxE=; b=az+bPB
	wOepG/6TD1mAdpbW9XLUpPvFdRkaR7iYV9N+4N1zyjxFYbdKCks4mFtx0Z247uVC
	QctR3b/rEtLz+B2BO90Foy5y8njkcWaNiVhny2qBvcY4Q406qICc8RKJvIw1hxuu
	ViyTfJBM5nN4aEPkm7giam0N3NLWPrnwnRWW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iyDWAmX+d0NmqRtU5xPbbRpwgV2tUPzp
	NK7uFPVBQk2lb8Dpq6Taz2j0TZtBp+E4VyJeoL29jFsk9MlDMTwcMTAER0WyZ88V
	KV38XCLhkf7Dw4g9YNj6dKAYYGVCfCW/sVDy2Si7HKHr1/vec+qNsyFSeNjRXmfe
	X+2pMU3hhU0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A88C32A2C;
	Fri, 23 Jan 2015 19:38:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C159232A2B;
	Fri, 23 Jan 2015 19:38:39 -0500 (EST)
In-Reply-To: <CAGZ79kYbCBHVhL+FvKu-yKMinxGCMwGfqG96rSp+0-7frgO2wQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 23 Jan 2015 16:24:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 573C7D18-A361-11E4-9F8D-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262980>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jan 23, 2015 at 4:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> yeah that's the goal. Though as we're in one transaction, as soon
> as we have an early exit, the transaction will abort.

An early exit I am talking about is this:

static int write_ref_sha1(struct ref_lock *lock,
	const unsigned char *sha1, const char *logmsg)
{
	static char term = '\n';
	struct object *o;

	if (!lock) {
		errno = EINVAL;
		return -1;
	}
	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
		return 0;

It returns 0 and then the transaction side has this call in a loop:

		if (!is_null_sha1(update->new_sha1)) {
			if (write_ref_sha1(update->lock, update->new_sha1,
					   update->msg)) {
				strbuf_addf(err, "Cannot write to the ref lock '%s'.",
					    update->refname);
				ret = TRANSACTION_GENERIC_ERROR;
				goto cleanup;
			}
		}

>> If so, shouldn't the write function at least close the file
>> descriptor even when it knows that the $ref.lock already has the
>> correct object name?  The call to close_ref() is never made when the
>> early-return codepath is taken as far as I can see.
>
> The  goto cleanup; will take care of unlocking (and closing fds of) all refs

Yes, if write_ref_sha1() returns with non-zero signaling an error,
then the goto will trigger.

But if it short-cuts and returns zero, that goto will not be
reached.
