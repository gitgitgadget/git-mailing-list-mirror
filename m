From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] tree.c: add support for traversal of submodules
Date: Sun, 11 Jan 2009 19:15:15 -0800
Message-ID: <7vr639kyf0.fsf@gitster.siamese.dyndns.org>
References: <1231717555-10559-1-git-send-email-hjemli@gmail.com>
 <1231717555-10559-2-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 04:16:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMDIF-0000eR-OC
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 04:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbZALDPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 22:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbZALDPW
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 22:15:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbZALDPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 22:15:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C68BF8F402;
	Sun, 11 Jan 2009 22:15:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D877D8F3FE; Sun,
 11 Jan 2009 22:15:17 -0500 (EST)
In-Reply-To: <1231717555-10559-2-git-send-email-hjemli@gmail.com> (Lars
 Hjemli's message of "Mon, 12 Jan 2009 00:45:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3E98F85A-E057-11DD-BD63-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105284>

Lars Hjemli <hjemli@gmail.com> writes:

> If the commit referenced by a gitlink is available in the (possibly
> alternate) object database, read_tree_recursive() is now able to descend
> into the tree of the linked commit if the flag 'traverse_gitlinks' is
> turned on.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>  tree.c |   20 +++++++++++++++++---
>  tree.h |    1 +
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/tree.c b/tree.c
> index 03e782a..1468e10 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -7,6 +7,7 @@
>  #include "tree-walk.h"
>  
>  const char *tree_type = "tree";
> +int traverse_gitlinks = 0;

I think we tend to put these global settings that will affect everybody in
environment.c.  You do not have to initialize variable to zero; BSS will
take care of it.

When the user explicitly asks you to traverse into submodules and the
necessary commit is not available in a submodule, the code goes on without
complaining.  I am not saying it is bad, but I wonder if we would want to
distinguish these three cases:

 (1) the submodule is initialized and the necessary commit is there.

 (2) the submodule is initialized, but the necessary commit is missing.

 (3) the submodule is not even initialized (aka "the user is not
     interested in it"); there is only an empty directory.

I think it is perfectly fine not to say anything for (3) but I am unsure
about the second case.
