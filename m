From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] prune.c: only print informational message in
 show_only or verbose mode
Date: Mon, 06 Aug 2012 22:28:42 -0700
Message-ID: <7vtxwfw9rp.fsf@alter.siamese.dyndns.org>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
 <1344315709-15897-1-git-send-email-drafnel@gmail.com>
 <1344315709-15897-2-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 07:28:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SycLb-0000YO-6m
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 07:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab2HGF2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 01:28:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38744 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab2HGF2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 01:28:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2A7897BE;
	Tue,  7 Aug 2012 01:28:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nNRDvLKMEHfBLx/YetST6Svgjmo=; b=teht6d
	XsDgYpx48Eg472+F2jpHGmNHDWdYy4lEFdA7JMv9TKmC1lDNs9XznPmiFLjuERGd
	TyjFl8gKzF9KZshiE4Jw8Ltd0Q6K+wjS63h2oFQNyS5ll4LJebg+LcT0KfPHlabk
	i6idfV8ODDvj1dIYEubCD7TBLYunbDaPToi6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dh73hmn4I9RR9qtzN+DHsXCkqCQaplkQ
	FCwhgo4+OixxZXDe9rKvcYOapxL0lvLi7Raow3zeek20oiU1C3l1c5l/1P8mYQxi
	XeQI48DK4Ql0zAj+RcPF1v0f97L1XR5zIkYns/TBtOykg2zAlMj5lBus7O9bXGeI
	ZdLz0RLnFT8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F63997BD;
	Tue,  7 Aug 2012 01:28:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA21997BC; Tue,  7 Aug 2012
 01:28:43 -0400 (EDT)
In-Reply-To: <1344315709-15897-2-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Mon, 6 Aug 2012 22:01:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C11BF406-E050-11E1-AB75-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203014>

Thanks.

This patch may fix the immediate symptom, but I think the right fix
is to correct the way "gc" is invoked by receive-pack, so that
nothing "gc" writes to its standard output can leak to the standard
output of the receive-pack.  After all, receive-pack is the one that
knows that its output is a structured protocol communication channel
and should not be contaminated by random crufts.  Receive-pack is
the one that is responsible to avoid this kind of problem in the
first place.

Once that fix is done, any future changes to "gc" or its subprograms
won't be able to cause the same breakage again.  Which automatically
makes your patch unnecessary.

Something along this line, perhaps.

Note that this chooses to expose what comes out of the standard
output of the subprocess to the standard error to be shown to the
user sitting on the other end.  This is in line with what we do to
all of our hooks (Cf. cd83c74 (Redirect update hook stdout to
stderr., 2006-12-30)).

If we instead want to discard the standard output, we would need to
either extend run_command_v_opt(), or set up our own child_process
and spawn the subprocess using the underlying run_command() API
ourselves.

 builtin/receive-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ee7751a..19bdc66 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -979,7 +979,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			const char *argv_gc_auto[] = {
 				"gc", "--auto", "--quiet", NULL,
 			};
-			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+			int opt = RUN_GIT_CMD | RUN_COMMAND_STDOUT_TO_STDERR;
+			run_command_v_opt(argv_gc_auto, opt);
 		}
 		if (auto_update_server_info)
 			update_server_info(0);
 
