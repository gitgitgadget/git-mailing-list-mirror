From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Set hard limit on delta chain depth
Date: Tue, 6 Dec 2011 10:12:54 -0800
Message-ID: <CAJo=hJuy27Uagmubbv=RqAOMx03e6JBgZxObkjFLg9oG2x_UqA@mail.gmail.com>
References: <1323068688-31481-1-git-send-email-pclouds@gmail.com>
 <CABPQNSaE=TWGbBRMnthEuT181=XbOafPfgx88_JQnnQ6TiYyqw@mail.gmail.com>
 <4EDE2C95.5040804@alum.mit.edu> <CACsJy8Btwn0=PGS+PJV-6DqYBmzOp7LTB2=R_kCx4SJHA2YDRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, kusmabite@gmail.com,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 19:13:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXzW9-0001c5-6V
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 19:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab1LFSNR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 13:13:17 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45584 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab1LFSNP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 13:13:15 -0500
Received: by iakc1 with SMTP id c1so4027059iak.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 10:13:15 -0800 (PST)
Received: by 10.42.163.200 with SMTP id d8mr15147365icy.41.1323195195204; Tue,
 06 Dec 2011 10:13:15 -0800 (PST)
Received: by 10.50.171.39 with HTTP; Tue, 6 Dec 2011 10:12:54 -0800 (PST)
In-Reply-To: <CACsJy8Btwn0=PGS+PJV-6DqYBmzOp7LTB2=R_kCx4SJHA2YDRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186364>

On Tue, Dec 6, 2011 at 07:30, Nguyen Thai Ngoc Duy <pclouds@gmail.com> =
wrote:
> index-pack is called at server side as part of a push. So in theory
> the sending side can generate very long delta chains and bring down
> the server side.

It is also called at client side during fetch. So in theory the server
can produce very long delta chains and take down a client.

>> =A0Because if not, then the "creator" had better never be configured
>> to use a chain depth that the "reader" cannot handle.
>
> Normal creators (i.e. C Git) use default depth 50 so we should be saf=
e.

JGit is also a "normal creator", and it sometimes produces chains
deeper than 50. Junio identified a 255 deep chain a week or two ago.
Some people have repacked their repositories very aggressively with
deeper chains when they are trying to optimize for space and don't
access historical revisions very often. I doubt anyone has packed
deeper than 120ish intentionally... but we shouldn't assume that in
the code.

>> =A0This in turn
>> imply that there should be a common limit that is supported by all g=
it
>> clients and is a documented part of the protocol. =A0(Or the code ha=
s to
>> be rewritten to use an explicit stack instead of recursion.)
>
> It's the implementation limitation, not the protocol. If the server
> propagates error messages from index-pack back to client (I'm not
> sure), then users can adjust --depth to be accepted by server. We
> could negotiate the limit over the protocol but not sure we would wan=
t
> to go that route.

What about clients fetching from a server? The client can't change the
depth the server sends it.

> The troubled code could be rewritten to avoid recursion. However long
> delta chains may degrade performance, I'd rather have support to spli=
t
> long chains (which can be done with --depth at client already) instea=
d
> of just recursion elimination. This patch is simpler, so it would be
> easier to back port it if someone wants to do so.

JGit long ago changed its IndexPack routine to use a manually managed
heap based stack instead of recursion, making it immune from
overrunning the stack due to a long delta chain. That is probably the
cleaner route. But you also have to fix sha1_file.c and its recursion
based unpacking of a delta chain... again which JGit fixed a long time
ago.
