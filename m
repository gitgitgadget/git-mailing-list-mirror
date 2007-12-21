From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't dereference NULL upon lookup_tree failure.
Date: Fri, 21 Dec 2007 14:48:32 -0800
Message-ID: <7v4peb4qbj.fsf@gitster.siamese.dyndns.org>
References: <873atvwueq.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Matthew Farrellee <mfarrellee@redhat.com>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Dec 21 23:49:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5qfy-0001Bh-5w
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 23:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbXLUWsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 17:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbXLUWsl
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 17:48:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbXLUWsk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 17:48:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A3115C9B;
	Fri, 21 Dec 2007 17:48:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E6D6F5C9A;
	Fri, 21 Dec 2007 17:48:33 -0500 (EST)
In-Reply-To: <873atvwueq.fsf@rho.meyering.net> (Jim Meyering's message of
	"Fri, 21 Dec 2007 23:32:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69103>

Jim Meyering <jim@meyering.net> writes:

> When running on an x86_64 system (either debian unstable or rawhide)
> I see only this:
>
>   0 blocks
>   error: Object 0d57588da39d10795486bd5451bc2660832228e6 is a commit, not a tree
>   fatal: The remote end hung up unexpectedly
>...
> diff --git a/object.c b/object.c
> index 16793d9..eb59550 100644
> --- a/object.c
> +++ b/object.c
> @@ -142,10 +142,14 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
>  		obj = &blob->object;
>  	} else if (type == OBJ_TREE) {
>  		struct tree *tree = lookup_tree(sha1);
> -		obj = &tree->object;
> -		if (!tree->object.parsed) {
> -			parse_tree_buffer(tree, buffer, size);
> -			eaten = 1;
> +		if (!tree)
> +		    obj = NULL;
> +		else {
> +		    obj = &tree->object;
> +		    if (!tree->object.parsed) {
> +			    parse_tree_buffer(tree, buffer, size);
> +			    eaten = 1;
> +		    }
>  		}
>  	} else if (type == OBJ_COMMIT) {
>  		struct commit *commit = lookup_commit(sha1);

While this change may be a prudent safeguard, there is something
else going on.  Can you provide the callchain that led to the
parse_object_buffer() that gave SHA1 of a commit object with
type set to OBJ_TREE?  Which caller does that bogus combination?
