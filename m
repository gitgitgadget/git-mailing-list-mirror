From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: synchronize highlighting in file view for 'f'&'b'
 commands
Date: Mon, 17 Mar 2008 00:42:05 -0700
Message-ID: <7v63vldcfm.fsf@gitster.siamese.dyndns.org>
References: <279b37b20803161950q73853290w864eda69896efb9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 08:42:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb9zj-0006k3-Tu
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 08:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbYCQHmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 03:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbYCQHmP
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 03:42:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbYCQHmO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 03:42:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 352051FF9;
	Mon, 17 Mar 2008 03:42:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CBFDE1FF8; Mon, 17 Mar 2008 03:42:09 -0400 (EDT)
In-Reply-To: <279b37b20803161950q73853290w864eda69896efb9a@mail.gmail.com>
 (Eric Raible's message of "Sun, 16 Mar 2008 19:50:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77415>

"Eric Raible" <raible@gmail.com> writes:

> From 03603a207b2caad8b52dd4a24860e387d418f800 Mon Sep 17 00:00:00 2001
> From: Eric Raible <raible+git@gmail.com>
> Date: Sun, 16 Mar 2008 19:33:52 -0700
> Subject: [PATCH] gitk: synchronize highlighting in file view for
> 'f'&'b' commands

Please do not do this.  The first line is not part of anything but is only
a mail message boundary in mbox format.  Reproducing From: is fine if the
patch author is different from the person who is sending the patch, but I
do not think it is necessary in this case.  Date and Subject should also
go, as taking them from the e-mail header is just as good.

And please do not send gitk patches to me.  It should come through Paul
Mackerras <paulus@samba.org>, so if your patch is obviously correct for
application, then To: him with Cc: list (and I do not mind being on the
Cc:), otherwise if the patch is for review and discussion, please send it
addressed To: the list (and again I do not mind being on the Cc:).

> Previously, 'b', backspace, and delete all did the same thing.
> This changes 'b' to perform the inverse of 'f'.  And both of
> them now highlight the filename of the currently diff.
>
> This makes it easier to review the diffs associated with
> a particular commit using only f,b, and space.

As to the change itself, I think it makes sense to have a binding
available for prevfile (previously there was none), so I'd be supportive
of that keybinding change.

> +proc highlightfile {loc} {
> +    global ctext
> +    $ctext yview $loc
> +
> +    global cmitmode ctext cflist cflist_top
> +    if {$cmitmode eq "tree"} return
> +
> +    $cflist tag remove highlight $cflist_top.0 "$cflist_top.0 lineend"
> +
> +    set file [regsub -- "-* (.*?) -*" [$ctext get $loc "$loc lineend"] "\\1"]
> +    set cline [$cflist search -regexp [subst {^$file$}] 0.0]
> +
> +    $cflist tag add highlight $cline "$cline lineend"
> +    $cflist see $cline
> +    set cflist_top [lindex [split $cline .] 0]
> +}

I however think you also should describe why you had to change "$ctext
yview" in both nextfile and prevfile to a more complex "highlightfile" in
your commit message.  It is not very obvious how it is an improvement, and
typing 'b' in tree view (as opposed to patch view) seems to trigger

	Error: bad text index""

with this patch.
