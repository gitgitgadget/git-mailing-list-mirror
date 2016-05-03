From: Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH] commit-tree: do not pay attention to commit.gpgsign
Date: Tue, 3 May 2016 14:58:02 -0400
Message-ID: <20160503185802.GB30530@sigill.intra.peff.net>
References: <xmqqlh3sqfze.fsf@gitster.mtv.corp.google.com>
 <20160503041256.GA30529@sigill.intra.peff.net>
 <xmqqfutznhqw.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 20:58:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axfWO-00067C-8L
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 20:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933731AbcECS6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 14:58:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:33282 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933291AbcECS6G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 14:58:06 -0400
Received: (qmail 21476 invoked by uid 102); 3 May 2016 18:58:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 14:58:05 -0400
Received: (qmail 32754 invoked by uid 107); 3 May 2016 18:58:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 14:58:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 14:58:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfutznhqw.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293436>

On Tue, May 03, 2016 at 11:01:11AM -0700, Junio C Hamano wrote:

> Ignoring commit.gpgsign option _obviously_ breaks the backward
> compatibility, but it is easy to follow the standard pattern in
> scripts to honor whatever configuration variable they choose to
> follow.  E.g.
> 
> 	case $(git config --bool commit.gpgsign) in
> 	true) sign=-S ;;
> 	*) sign= ;;
> 	esac &&
> 	git commit-tree $sign ...whatever other args...
> 
> Do so to make sure that "git rebase" keeps paying attention to the
> configuration variable, which unfortunately is a documented mistake.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-commit-tree.txt |  4 ++--
>  builtin/commit-tree.c             |  4 ----
>  git-rebase.sh                     |  5 ++++-
>  t/t7510-signed-commit.sh          | 13 ++++++++++---
>  4 files changed, 16 insertions(+), 10 deletions(-)

Thanks, this looks good to me[1]. Especially thinking about the rebase
case you handle here makes me more convinced than ever that an option
like "--respect-commit-gpgsign-config" is the wrong path. Because the
ultimate fate for rebase may be something like:

  case $(git config --bool rebase.gpgsign) in
  true) sign=-S ;;
  false) sign= ;;
  *)
	case $(git config --bool commit.gpgsign) in
	true) sign=-S ;;
	*) sign= ;;
	esac
	;;
  esac

You _can_ implement that by falling back to --respect... in the "*"
case, but at that point it is not saving much code, and merely making
things unnecessarily confusing.

-Peff

[1] I will say that I am happy with rebase respecting commit.gpgsign
    myself. The config I want is really "sign all commits I create", so
    I'd end up setting rebase.gpgsign, too, if it existed. But maybe
    other people have different workflows.
