From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/3] format-patch: create patch filename in one
 function
Date: Sat, 21 Mar 2009 22:31:47 -0700
Message-ID: <7vwsai86nw.fsf@gitster.siamese.dyndns.org>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <1237696363-6819-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 06:33:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlGJP-0005Rf-1K
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 06:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbZCVFb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 01:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbZCVFbz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 01:31:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbZCVFbz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 01:31:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F55E83AC;
	Sun, 22 Mar 2009 01:31:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9507483AB; Sun,
 22 Mar 2009 01:31:48 -0400 (EDT)
In-Reply-To: <1237696363-6819-2-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Sat, 21 Mar 2009 21:32:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C024C72E-16A2-11DE-9AB4-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114118>

Stephen Boyd <bebarino@gmail.com> writes:

> reopen_stdout() usually takes the oneline description of a commit,
> appends the patch suffix, prepends the output directory (if any) and
> then reopens stdout as the resulting file. Now the patch filename (the
> oneline description and the patch suffix) is created in
> get_patch_filename() and passed to reopen_stdout() which prepends the
> output directory and reopens stdout as that file.

The renaming is a good idea even without any change in the feature.
Naming functions after what their result is used _for_ is never a good
idea, and we should name them after what they do.

Does it still make sense to pass "keep_subject" to the function?  After
all what it does is to retain "[PATCH.." prefix that is useless for the
purpose of making each patch easily identifiable.  Because people almost
always use patch acceptance tools in non-keep mode to strip the
"[PATCH..]"  prefix when creating the commits these days anyway, it may
make more sense to lose the parameter altogether and simplify the
processing.

> -static const char *get_oneline_for_filename(struct commit *commit,
> -					    int keep_subject)
> +static const char *get_patch_filename(char* sol, int keep_subject, int nr)

Asterisk sticks to the variable name, not type name.

I also wonder if it makes sense to move what this function does into a
user format; especially the logic that sanitizes the oneline string into
filename friendly one may be something Porcelains may want an access to
from outside.

IOW, you can introduce a new format specifier (say, "%f") to
format_commit_message() and the implemention of get_patch_filename() would
just prepare a strbuf and call format_commit_message() on it, no?
