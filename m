From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 11:48:14 -0800
Message-ID: <xmqq61bocao1.fsf@gitster.dls.corp.google.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
	<xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
	<xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
	<20150130181153.GA25513@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 20:48:30 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHHYI-0007Yd-5d
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 20:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763073AbbA3TsT (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 14:48:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763007AbbA3TsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 14:48:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3BEE3171F;
	Fri, 30 Jan 2015 14:48:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z1qMdtTjqvcp6LDmNEr0zbylFP4=; b=UNgbHK
	gu70V0cQe1cD/DsFT/oBinoQcxbU/fMdGzHdA2yG3lf1YdwbMJ+YGlTEejMH5XVB
	YGOMc2dYS+Cv7kpkyuzb1UlhFDp2En2rR6sv9uy2j3Rx5D1rbcodPYp+YSQDIvfc
	YsoXSsirM9wpVr+2QofZ338cCWRmocUiNXFSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=snrvxTCIL3mZzbMeUg1zqM5yLhCnUDSP
	J2wXyi4x/haWwWQCmeLXCYGMvTnLpkoGTSVu+wpXd3uTVHstd/3V0hLiUt4q5uU1
	JtOoDbLXC5W6l11HsydYPCiMAv556S8UL5hX5QO9FKvZvCsoU5VmvF1be1zG4VXS
	xvDCpLNMDhk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9EC03171E;
	Fri, 30 Jan 2015 14:48:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F7673171B;
	Fri, 30 Jan 2015 14:48:16 -0500 (EST)
In-Reply-To: <20150130181153.GA25513@peff.net> (Jeff King's message of "Fri,
	30 Jan 2015 13:11:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EEDA81CC-A8B8-11E4-B76F-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263191>

Jeff King <peff@peff.net> writes:

>> +	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
>> +		return error(_("affected file '%s' is beyond a symbolic link"),
>> +			     patch->new_name);
>
> Why does this not kick in when deleting a file? If it is not OK to
> add across a symlink, why is it OK to delete?

Hmph, adding

	if (patch->is_delete &&	path_is_beyond_symlink(patch->old_name))
		return error(_("deleted file '%s' is beyond a symlink"),
				patch->old_name);

seems to break t4114.11, which wants to apply this patch to a tree
that does not have a symbolic link but a directory at 'foo/'.

diff --git a/foo b/foo
new file mode 120000
index 0000000..ba0e162
--- /dev/null
+++ b/foo
@@ -0,0 +1 @@
+bar
\ No newline at end of file
diff --git a/foo/baz b/foo/baz
deleted file mode 100644
index 682c76b..0000000
--- a/foo/baz
+++ /dev/null
@@ -1 +0,0 @@
-if only I knew
