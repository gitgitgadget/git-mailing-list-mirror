From: Junio C Hamano <gitster@pobox.com>
Subject: Re: patches in context format ?
Date: Mon, 12 Jan 2009 01:28:57 -0800
Message-ID: <7vy6xgj2jq.fsf@gitster.siamese.dyndns.org>
References: <46d6db660901120100g7f62a0c2k68c96cbfc23dab5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "Christian MICHON" <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMJ7s-00057I-0E
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbZALJ3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbZALJ3G
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:29:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbZALJ3F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:29:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 178D71C4DC;
	Mon, 12 Jan 2009 04:29:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F234A1C4DB; Mon,
 12 Jan 2009 04:28:59 -0500 (EST)
In-Reply-To: <46d6db660901120100g7f62a0c2k68c96cbfc23dab5@mail.gmail.com>
 (Christian MICHON's message of "Mon, 12 Jan 2009 10:00:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 73526476-E08B-11DD-BC8A-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105312>

"Christian MICHON" <christian.michon@gmail.com> writes:

> I'm maintaining a git tree of the vim project: this work can be seen
> at http://github.com/cmichon/vim
>
> vim patches do not come as unified format, but only as context format
> instead (from a "diff -c").
> ...
> I guess the answer is no, but has anyone on the list been working on
> this ? is there another way to translate from "context" to "unified"
> format ?

Not that I know of.

If you want to add support for the copied context format patches to your
workflow, I think the first step (and easiest one) would be to find an
external program that lets you convert from the copied context format to
the unified context format.  Perhaps "interdiff /dev/null copied >unified"
would suffice (but I haven't tested this).

Then find the place that feeds "git apply" with a patch, and add an option
to "git am" to instead do something like this:

-	git apply --index "$dotest/patch"
+	case "$input_is_in_the_copied_context_format"
+	yes)
+		interdiff /dev/null "$dotest/patch" | git apply --index
+		;;
+	*)
+		# unified context as before...
+		git apply --index "$dotest/patch"
+		;;
+	esac

In the longer term, if we were to update "git-apply" to support the copied
context format, I think we should take the same approach.  

Inside read_patch_file(), you detect that the patch is in the copied
context format, and convert it to the unified context format and return
the result.  All the rest of the program can then be left alone and you
will have little chance of regression.
