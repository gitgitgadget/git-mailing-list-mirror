From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/8] add packet tracing debug code
Date: Thu, 24 Feb 2011 15:44:12 -0600
Message-ID: <20110224214412.GG17412@elie>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224143019.GG15477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 22:44:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psiz3-0004Up-Ac
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 22:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab1BXVoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 16:44:20 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36824 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab1BXVoT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 16:44:19 -0500
Received: by vxi39 with SMTP id 39so857458vxi.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 13:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=x+DEUkvDK7b5mKI1etcZhvU+kYB1hJT4KyFpZNQvND8=;
        b=SkEOu9bgnMJFL7yvHboUJgIWBfdZZMbaoNrWSU+TmTo+Cd0g85uyccJ1Svta5dqzLb
         lqMVpXtUTUCHjIUuuLHFGe6I6J6fuIqd+6995Tb23KnQt5/eEyvZJeqy2t249t9tbU0y
         F5JlXOJTCRd9ZfJByE6gPfuW2mLVHNqFN6QRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kBrFuZZP8hch5FFMtz1rNENp7oqO+h/Vwv/RwmgWlM3ahFp4uQwjoSDW4toAXIV+f/
         xiXXWh9gUwYq7/DDgCjAuL3SIG+0SXFeFKTSSPpZQc/FVYjo/SqEMo+2ORZyIizB+IyP
         JQq/tCUImyJrhvff33dpLuVZ2ktKZ/q5oZtNg=
Received: by 10.52.160.3 with SMTP id xg3mr2516020vdb.215.1298583858539;
        Thu, 24 Feb 2011 13:44:18 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id q5sm4470199vcr.39.2011.02.24.13.44.16
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 13:44:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110224143019.GG15477@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167865>

Jeff King wrote:

> This shows a trace of all packets coming in or out of a given
> program. This can help with debugging object negotiation or
> other protocol issues.

Sounds handy.

> Packet tracing can be enabled with GIT_TRACE_PACKET=<foo>,
> where <foo> takes the same arguments as GIT_TRACE.
[...]
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -383,6 +383,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	junk_pid = getpid();
>  
> +	packet_trace_identity("clone");

My first thought on reading this was "identity operation" (= pass-through),
which left me a little confused.

Maybe "packet_trace_set_identity" (or ...set_prefix) would be a little
clearer?

> +++ b/pkt-line.c
> @@ -1,6 +1,51 @@
[...]
> +	if ((len >= 4 && !prefixcmp(buf, "PACK")) ||
> +	    (len >= 5 && !prefixcmp(buf+1, "PACK"))) {
> +		strbuf_addstr(&out, "PACK ...");
> +		unsetenv(trace_key);
> +	}
> +	else {

Style: should be cuddled, I think.

> +		/* XXX we should really handle printable utf8 */
> +		for (i = 0; i < len; i++) {

Maybe using is_utf8, extended to take a length argument?
(Assuming it's okay if non-ASCII is escaped in packets containing
non-utf8 parts.)

[...]
> @@ -39,11 +84,13 @@ ssize_t safe_write(int fd, const void *buf, ssize_t n)
>   */
>  void packet_flush(int fd)
>  {
> +	packet_trace("0000", 4, 1);
>  	safe_write(fd, "0000", 4);

... I wonder if it would make sense to do

 static void packet_writebuf(int fd, const char *buf, size_t buflen)
 {
	packet_trace(buf, buflen, 1);
	safe_write(fd, buf, buflen);
 }

Nah, that would include the size noise for even nonempty packets,
which your implementation conveniently omits.

Thanks, looks useful.
