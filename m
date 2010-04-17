From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Sat, 17 Apr 2010 10:00:53 -0400
Message-ID: <20100417140053.GA10997@coredump.intra.peff.net>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
 <201004151107.33892.jnareb@gmail.com>
 <20100417095259.GA23110@coredump.intra.peff.net>
 <201004171502.42044.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 16:01:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O38af-0005pH-Vm
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 16:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593Ab0DQOB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 10:01:28 -0400
Received: from peff.net ([208.65.91.99]:50747 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003Ab0DQOB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 10:01:27 -0400
Received: (qmail 19157 invoked by uid 107); 17 Apr 2010 14:01:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Apr 2010 10:01:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Apr 2010 10:00:53 -0400
Content-Disposition: inline
In-Reply-To: <201004171502.42044.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145147>

On Sat, Apr 17, 2010 at 03:02:39PM +0200, Jakub Narebski wrote:

> Something like that (please remember that it is still in vague beginnings
> of an idea stage:
> 
>   OUT_OBJECT(
>      OUT_FIELD("mode",   OUT_MODE, tree.mode), SP,
>      OUT_FIELD("type",   "%s", tree.object.type), SP,
>      OUT_FIELD("object", OUT_SHA1, tree.object.sha1), TAB,
>      OUT_FIELD("file", OUT_FILE(sep), tree.filename), 
>      sep
>   );

Doing that would require variadic macros, which are a C99-ism. So you
would have to do:

  OUT_OBJECT_START();
    OUT_FIELD("mode", OUT_MODE, tree.mode); OUT_SP;
    ...
  OUT_OBJECT_END();

which is not all that different from what Julian has now. I do think
some type-specific conversions might be handy. They don't even need to
be macros. E.g.,:

  void output_mode(struct output_context *oc, int mode)
  {
    output_strf(oc, "mode", "%06o", mode);
  }

OTOH, looking over Julian's last patch series, there really aren't that
many that would be generally applicable, and as you can see they only
save a few characters, not even a line. A few bigger objects could be
factored out, but he has already done that (e.g., see
wt_porcelain_unmerged in his v2 3/4).

-Peff
