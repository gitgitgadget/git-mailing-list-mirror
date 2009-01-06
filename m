From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/4] Use 'lstat_cache()' instead of
 'has_symlink_leading_path()'
Date: Tue, 06 Jan 2009 00:19:33 -0800
Message-ID: <7vk598j17u.fsf@gitster.siamese.dyndns.org>
References: <1231161001-32599-1-git-send-email-barvik@broadpark.no>
 <1231161001-32599-3-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:21:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7BO-0007yr-6R
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbZAFITk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZAFITk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:19:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbZAFITj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:19:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B79388DEAE;
	Tue,  6 Jan 2009 03:19:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B7DD78DEAB; Tue,
  6 Jan 2009 03:19:34 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2B383EE-DBCA-11DD-A254-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104660>

Kjetil Barvik <barvik@broadpark.no> writes:

> Start using the optimised, faster and more effective symlink/directory
> cache.  The previously used call:
>
>    has_symlink_leading_path(len, name);
>
> should be identically with the following call to lstat_cache():
>
>    lstat_cache(len, name,
>                LSTAT_SYMLINK|LSTAT_DIR,
>                LSTAT_SYMLINK);
> ...

Care to enlighten why some of callers use the above, but not others?
Namely, check_removed() in diff-lib.c and callers in unpack-trees.c care
about NOTDIR unlike others, even though the original code checked for
exactly the same condition.

Does this mean that some callers of has_symlink_leading_path() checked
only for leading symlinks when they should also have checked for a leading
non-directory, and this patch is also a bugfix?
