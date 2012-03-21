From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Wed, 21 Mar 2012 12:05:20 +0100
Message-ID: <4F69B5F0.2060605@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 12:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAJM5-0005f1-8o
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 12:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030843Ab2CULFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 07:05:18 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:49045 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030814Ab2CULFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 07:05:16 -0400
Received: (qmail invoked by alias); 21 Mar 2012 11:05:14 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.161.153]
  by mail.gmx.net (mp028) with SMTP; 21 Mar 2012 12:05:14 +0100
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX1+b6b4mUZ6bQVLTmhMBJ7te4Xc3LNx0FY0/Jkak95
	TAjIgjvcRCEElR
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120319024436.GB10426@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193567>

On 19.03.2012 03:44, Jeff King wrote:
> On Mon, Mar 19, 2012 at 08:30:38AM +0700, Nguyen Thai Ngoc Duy wrote:
> 
>> On Mon, Mar 19, 2012 at 2:07 AM, Jeff King <peff@peff.net> wrote:
>>> I don't think that will work, as stateless-rpc fetch-pack already uses
>>> stdin to receive the list of advertised refs from the remote. Nor would
>>> you want to have multiple invocations of fetch-pack, since that would
>>> mean multiple http requests and multiple pack responses (which could not
>>> delta between themselves).
>> remote-curl functions as middle man between http client and
>> fetch-pack. Can we just send ref list over fetch-pack.stdin first,
>> followed by maybe empty line, then normal stuff that remote-curl feeds
>> fetch-pack?
> 
> Yes, I think that would work. You'd just have to take care to pass the
> residual buffer (i.e., what is left in your input buffer after you
> notice that reading the list of wanted refs is finished) along to
> the git-protocol code.  So it would require a little refactoring of
> get_remote_heads, I think.

Would it be OK for fetch-pack.c to use the packetized format 
(pkt-line.h) for reading the list of refs from stdin?

This way we can read() the exact number of bytes needed for the refs 
from the fd and there would be no need to refactor get_remote_heads() to 
pass a residual buffer, it could just continue reading straight from the 
same fd.
