From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] rev-parse: suppress duplicate log limit exceeded
 message.
Date: Sun, 22 Aug 2010 14:20:12 -0700
Message-ID: <7vy6by2vlf.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
 <1282355022-17795-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 22 23:20:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnHxp-0005ME-0X
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 23:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab0HVVUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 17:20:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab0HVVUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 17:20:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7F39CFD7B;
	Sun, 22 Aug 2010 17:20:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=MFhArg8j1G03ozjB/Sgcf6iU7Lk=; b=t3+AUcDKwmfvLtJjYOw3Zgn
	IRL2EtFIQK0azRhpx541GD6wiUbAaH9XY+DmptoUTb5qq9mwy5Kej0FXzBUFyBLp
	jdJ53ivqCZ9AqnZ5FSUtbJKyzai57DsLo4EULJByh0BGP+MnTCPvza9kJziumGhv
	jAq6TDF0XOPkqxzB+Ir0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DQS4TmRnLRuudRotB/qi1DXwBbv0bP2Ubao1uIj1oato8nkwQ
	tqI6HNb/5reor7QM3OawD58DtCuy3gEqtz+N1XMmEhOpGafS6y431Bsqzaml4vxK
	zzPvcOLQGzndIdzIzkmrPh6g2kMKaY6gTAqo6OZz8I2qUlFPGOyUnFGzKc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93EBDCFD78;
	Sun, 22 Aug 2010 17:20:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E24E8CFD71; Sun, 22 Aug
 2010 17:20:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F3038AC-AE33-11DF-9364-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154195>

Jon Seymour <jon.seymour@gmail.com> writes:

> With this change, git rev-parse master@{99999} reports:
>
>   master@{99999}
>   error: Log for 'master' only has 166 entries.
>   fatal: ambiguous argument 'master@{99999}': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions

If we are going to say "fatal:" and die at the end, I think we probably do
not want to say a separate "error" message.  Instead of adding a boolean
parameter "fail silently or warn?", it may be better to make it a pointer
to a strbuf and have it filled with error details (or a machine readable
struct and make it responsibility of the caller to generate a message).

Then die_verify_filename can become, e.g.:

static void NORETURN die_verify_filename(const char *prefix, const char *arg)
{
	unsigned char sha1[20];
	unsigned mode;
        struct strbuf e;

        /* learn in what way is it bad? */
	get_sha1_with_mode_1(arg, sha1, &mode, &e, prefix);

	/* ... or fall back the most general message. */
	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
	    "%s"
            "Use '--' to separate paths from revisions", arg, e.buf);
}

and we can later reuse the same mechanism to cover other kind of errors,
not just "the log does not have that many entries" error.  With your
"gently" approach it may not be easy to do that without adding more
parameters to all the functions in the codepath, no?

I also wonder if this can simply become part of "struct object_context",
which is to pass extra information in addition to the SHA-1 (which the
original API returned) back to the caller.
