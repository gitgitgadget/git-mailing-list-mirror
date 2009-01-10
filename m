From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Get format-patch to show first commit after root commit
Date: Fri, 09 Jan 2009 16:49:01 -0800
Message-ID: <7vmye0yohu.fsf@gitster.siamese.dyndns.org>
References: <1231536787-20685-1-git-send-email-nathan.panike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 01:50:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLS3g-0004dB-Ud
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 01:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945AbZAJAtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 19:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754623AbZAJAtO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 19:49:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbZAJAtN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 19:49:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 966901C260;
	Fri,  9 Jan 2009 19:49:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E19131C25B; Fri, 
 9 Jan 2009 19:49:03 -0500 (EST)
In-Reply-To: <1231536787-20685-1-git-send-email-nathan.panike@gmail.com>
 (Nathan W. Panike's message of "Fri, 9 Jan 2009 15:33:07 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7DBB8E92-DEB0-11DD-A8F6-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105050>

"Nathan W. Panike" <nathan.panike@gmail.com> writes:

> Rework this patch to try to handle the case where one does
>
> git format-patch -n ...
>
> and n is a number larger than 1.

It is unclear what "this patch" is in the context of this proposed commit
message.

> git format-patch -1 e83c5163316f89bfbde
> ...

I do not think the current backward compatibile behaviour to avoid
surprising the end user by creating a huge initial import diff is
particularly a good idea.

I do not see anything special you do for "one commit" case in your patch,
yet the proposed commit message keeps stressing "-1", which puzzles me.

Wouldn't it suffice to simply say something like:

    You need to explicitly ask for --root to obtain a patch for the root
    commit.  This may have been a good way to make sure that the user
    realizes that a patch from the root commit won't be applicable to a
    history with existing data, but we should assume the user knows what
    he is doing when the user explicitly specifies a range of commits that
    includes the root commit.

Perhaps there are some other downsides I may not remember why --root is
not the default, though.

> Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
> ---
>  builtin-log.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-log.c b/builtin-log.c
> index 4a02ee9..0eca15f 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -975,6 +975,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		nr++;
>  		list = xrealloc(list, nr * sizeof(list[0]));
>  		list[nr - 1] = commit;
> +		if(!commit->parents){
> +			rev.show_root_diff=1;
> +		}

Three issues.

 - The "if(){" violates style by not having one SP before "(" and after ")",
   and surrounds a single statement with needless { } pair.  You need one SP
   on each side of the = (assignment) as well.

 - Because rev.show_root_diff is a no-op for non-root commit anyway, I do not
   think you even want a conditional there.

 - It is a bad style to muck with rev.* while it is actively used for
   iteration (note that the above part is in a while loop that iterates over
   &rev).

I think the attached would be a better patch.  We already have a
configuration to control if we show the patch for a root commit by
default, and we can use reuse it here.  The configuration defaults to true
these days.

Because the code before the hunk must check if the user said "--root
commit" or just "commit" from the command line and behave quite
differently by looking at rev.show_root_diff, we cannot do this assignment
before the command line parsing like other commands in the log family.

 builtin-log.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git c/builtin-log.c w/builtin-log.c
index 4a02ee9..2d2c111 100644
--- c/builtin-log.c
+++ w/builtin-log.c
@@ -935,6 +935,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		 * get_revision() to do the usual traversal.
 		 */
 	}
+
+	/*
+	 * We cannot move this anywhere earlier because we do want to
+	 * know if --root was given explicitly from the comand line.
+	 */
+	if (default_show_root)
+		rev.show_root_diff = 1;
+
 	if (cover_letter) {
 		/* remember the range */
 		int i;
