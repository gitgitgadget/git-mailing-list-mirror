From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] describe: rewrite name_rev() iteratively
Date: Tue, 8 Apr 2014 14:50:47 -0400
Message-ID: <20140408185047.GA7073@sigill.intra.peff.net>
References: <1396824434-31672-1-git-send-email-dragos.foianu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 20:50:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXb6j-00085i-Qf
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 20:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285AbaDHSuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 14:50:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:56259 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756164AbaDHSut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 14:50:49 -0400
Received: (qmail 17374 invoked by uid 102); 8 Apr 2014 18:50:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Apr 2014 13:50:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Apr 2014 14:50:47 -0400
Content-Disposition: inline
In-Reply-To: <1396824434-31672-1-git-send-email-dragos.foianu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245948>

On Mon, Apr 07, 2014 at 01:47:14AM +0300, Dragos Foianu wrote:

> The "git describe --contains" command uses the name_rev() function which
> is currently a recursive function. This causes a Stack Overflow when the
> history is large enough.
> 
> Rewrite name_rev iteratively using a stack on the heap. This slightly
> reduces performance due to the extra operations on the heap, but the
> function no longer overflows the stack.

You can avoid the heap overhead by using an array for your stack, and
only resizing it when necessary. Like this:

    struct rev_stack {
            int nr, alloc;
            struct rev_data *data;
    };

    static struct rev_data *rev_stack_push(struct rev_stack *stack)
    {
            ALLOC_GROW(stack->data, stack->nr + 1, stack->alloc);
            return &stack->data[stack->nr++];
    }

    static void rev_stack_pop(struct rev_stack *stack)
    {
            stack->nr--;
    }

    static void rev_stack_init(struct rev_stack *stack)
    {
            stack->nr = stack->alloc = 0;
            stack->data = NULL;
    }

    static void rev_stack_release(struct rev_stack *stack)
    {
            free(stack->data);
            rev_stack_init(stack);
    }

Usage would be something like:

    struct rev_data *data = rev_stack_push(&stack);
    data->commit = commit;
    data->tip_name = tip_name;
    ...

IOW, you push first to allocate the space, and then do your
make_rev_data, rather than the other way around.

The downside is that your allocation is always as big as the deepest
recursion so far, so you hold on to the memory a little longer than
necessary. I think that's a good tradeoff versus an extra malloc() for
every commit.

-Peff
