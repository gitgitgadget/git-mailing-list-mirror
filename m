From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] strbuf_grow(): maintain nul-termination even for new
 buffer
Date: Mon, 29 Aug 2011 18:15:24 -0500
Message-ID: <Zt95k-c1_rj2Kpnuk9FpbHYmWLPBvoSLSqoYn1QCwVcBMyhNOcqhbbTXqG_MPUWLyda3Drs3WPmiEc1u4aNIhFY9vm0Hs0J6fHsKZpVH_9Q@cipher.nrlssc.navy.mil>
References: <c8d8686c1813885a36d8f4cada218686989df236.1314651926.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 30 01:16:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyB3r-0001lS-U0
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 01:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398Ab1H2XQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 19:16:07 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:46155 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755259Ab1H2XQF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 19:16:05 -0400
Received: by mail3.nrlssc.navy.mil id p7TNFP25014993; Mon, 29 Aug 2011 18:15:25 -0500
In-Reply-To: <c8d8686c1813885a36d8f4cada218686989df236.1314651926.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 29 Aug 2011 23:15:25.0440 (UTC) FILETIME=[88990800:01CC66A1]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180375>

On 08/29/2011 04:16 PM, Thomas Rast wrote:
> In the case where sb is initialized to the slopbuf (through
> strbuf_init(sb,0) or STRBUF_INIT), strbuf_grow() loses the terminating
> nul: it grows the buffer, but gives ALLOC_GROW a NULL source to avoid
> it being freed.  So ALLOC_GROW does not copy anything to the new
> memory area.
> 
> This subtly broke the call to strbuf_getline in read_next_command()
> [fast-import.c:1855], which goes
> 
>     strbuf_detach(&command_buf, NULL);  # command_buf is now = STRBUF_INIT
>     stdin_eof = strbuf_getline(&command_buf, stdin, '\n');
>     if (stdin_eof)
>             return EOF;
> 
> In strbuf_getwholeline, this did
> 
>     strbuf_grow(sb, 0);  # loses nul-termination

I'm thinking this call to strbuf_grow() predates the decision to
require that the buf component of a strbuf should always be valid
nul-terminated string.  It was likely made here solely to force
allocation of buf which may have been NULL.

I think this line can safely be removed from strbuf_getwholeline().

>     if (feof(fp))
>             return EOF;
>     strbuf_reset(sb);    # this would have nul-terminated!
> 
> Valgrind found this because fast-import subsequently uses prefixcmp()
> on command_buf.buf, which after the EOF exit contains only
> uninitialized memory.
> 
> Arguably strbuf_getwholeline is also broken, in that it touches the
> buffer before deciding whether to do any work.  However, it seems more
> futureproof to not let the strbuf API lose the nul-termination by its
> own fault.
> 
> So make sure that strbuf_grow() puts in a nul even if it has nowhere
> to copy it from.  This makes strbuf_grow(sb, 0) a semantic no-op as
> far as readers of the buffer are concerned.
> 
> Also remove the nul-termination added by strbuf_init, which is made
> redudant.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Patch looks good.

-Brandon
