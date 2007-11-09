From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/11] Allow pooled nodes to be recycled back onto a free list
Date: Fri, 09 Nov 2007 14:27:39 -0800
Message-ID: <7v1wazrr50.fsf@gitster.siamese.dyndns.org>
References: <20071109110619.GD19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 23:28:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqcKX-0001H7-1o
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 23:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbXKIW1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 17:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbXKIW1q
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 17:27:46 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54944 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbXKIW1p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 17:27:45 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C81A02FB;
	Fri,  9 Nov 2007 17:28:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 430C393C9B;
	Fri,  9 Nov 2007 17:28:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64266>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> In some cases and for some node types a caller may have used one of
> our allocated nodes for some temporary usage and then wants to return
> it back to the available free list.  We now define a function that
> will thread the object onto the front of a free list, which will be
> used only after the current block has been exhausted.
>
> We hold off on looking at the free list until we are sure the current
> block is empty.  This saves about 1000 tests of the (usually empty)
> free list per block.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

> +void free_##name##_node(void *n)				\
> +{								\
> +	*((void**)n) = name##_pool.free_list;			\
> +	name##_pool.free_list = n;				\
> +}								\
>  static void report_##name(void)					\
>  {								\
>  	report(#name, &name##_pool, sizeof(t));			\

I wonder how well this will interact with object scrubbing.  A
freed node is still in the array in the block bucket and the
scrubber walks the array without skipping any freed node, but
the threading pointer already scribbled on the first
sizeof(void**) bytes on the object memory.  Worse, the caller
may say "Hey, I am freeing this node, so I'll bzero() it before
returning it to the pool", without realizing that the scrubber
may still act on that freed node buffer.

The rules for a "class designer" on freeing a temporary node
with this implementation as I understand it is:

 - do assume free_all will call scrubber on freed nodes;

 - do not have anything your scrubber needs to access near the
   beginning of the nodes managed by alloc.c API;

 - do not clobber anything scrubber needs to access when freeing
   a node.

For struct object and its descendant classes, I think this is a
non issue -- the first bytes in the structure are the flags and
sha1[] and the current implementation of the scrubbers would not
look at these fields.

But it does look like a risk in the future.
