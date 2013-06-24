From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: give early feedback
Date: Mon, 24 Jun 2013 14:28:09 -0400
Message-ID: <20130624182809.GA15296@sigill.intra.peff.net>
References: <1372095662-24527-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBUu-00038o-8b
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab3FXS2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:28:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:40509 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132Ab3FXS2L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:28:11 -0400
Received: (qmail 1656 invoked by uid 102); 24 Jun 2013 18:29:14 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Jun 2013 13:29:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jun 2013 14:28:09 -0400
Content-Disposition: inline
In-Reply-To: <1372095662-24527-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228894>

On Mon, Jun 24, 2013 at 11:11:02PM +0530, Ramkumar Ramachandra wrote:

> There are many configuration variables that determine exactly what a
> push does.  Give the user early feedback so that she has a chance to
> abort if she doesn't mean to push those refspecs to that destination
> like:
> 
>   $ git push
>   # pushing refspecs 'master next' to ram (^C to abort)

If your intent is to let people stop disastrous pushes before they
complete, I think there are two failings:

  1. It does not tell very much about how the refspecs are expanded or
     what is going to happen. "git push --dry-run" gives a much more
     complete view of what will be pushed.

  2. You are creating a race with the user to hit ^C. It will probably
     work if there are a lot of objects to be pushed. But not if the
     push is small, or even has no pack at all (e.g., only deletions, or
     moving refs to existing history). As an added bonus, since push
     prints its output after receiving commitment from the server, it is
     possible for the server to commit a change, have the user hit ^C,
     thinking they beat the race, only to find out that the server did
     indeed accept the change.

I think you could deal with both of them by doing something like:

  git push --dry-run "$@" || exit 1
  echo >&2 "OK to push?"
  read response
  case "$response" in
  [Yy]) ;;
  *) exit 1
  esac
  exec git push "$@"

That is subject to a race condition in a busy repo (you do not know that
the refs are in the same state on either end between the two pushes).
You could solve that by having a "pre-push" hook on the local side that
gets the list of proposed updates.

In fact, I think this came up before but no hook code ever materialized:

  http://thread.gmane.org/gmane.comp.version-control.git/128273

  http://thread.gmane.org/gmane.comp.version-control.git/128426

As discussed in the top thread, this could also be used for "interactive
push" where you could examine and confirm the changes for each proposed
ref change.

-Peff
