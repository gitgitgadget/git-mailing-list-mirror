From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Wed, 21 Mar 2012 21:02:13 +0100
Message-ID: <4F6A33C5.2080909@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 21:02:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SARjg-0003Ge-SS
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 21:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108Ab2CUUCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 16:02:10 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:49482 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757250Ab2CUUCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 16:02:08 -0400
Received: (qmail invoked by alias); 21 Mar 2012 20:02:06 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.163.209]
  by mail.gmx.net (mp032) with SMTP; 21 Mar 2012 21:02:06 +0100
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX1/gHg9vNUXgDn6ptXlzUBwRfStthkycOhDIyXyQ44
	2LmIbbNEE/5C89
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120321171423.GA13140@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193608>

On 21.03.2012 18:14, Jeff King wrote:
> On Wed, Mar 21, 2012 at 07:28:24AM -0700, Shawn O. Pearce wrote:
> 
>>> Would it be OK for fetch-pack.c to use the packetized format (pkt-line.h)
>>> for reading the list of refs from stdin?
>> This is probably the easiest way to implement the sneak-into-stdin
>> patch. Use a pkt-line for each argument that should have been in the
>> argv array from the command line, and a flush pkt to terminate the
>> list.
> 
> Something in me feels slightly uncomfortable with that, just because
> simple newline-delimited formats make it easy for people to hack on the
> tool and feed input from unexpected sources.

I understand what you mean. How about this:

If both --stdin and --stateless-rpc are specified to fetch-pack, it will 
use pkt-line to read the refs from stdin before handing off stdin to 
get_remote_heads().

However, if only --stdin is specified, it will read refs from stdin in a 
script-friendly newline delimited format, one ref per line. This is okay 
because when --stateless-rpc is not specified get_remote_heads() reads 
from an fd different from stdin so there is no issue with residual 
buffers in this case.

This way you preserve scriptability for any other callers who don't use 
--stateless-rpc.

How does this sound?
