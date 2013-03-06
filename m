From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/4] push --follow-tags
Date: Wed, 6 Mar 2013 03:41:05 -0500
Message-ID: <20130306084105.GB2018@sigill.intra.peff.net>
References: <1362523639-30566-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 09:41:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD9uo-0003ZQ-Tk
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 09:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab3CFIlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 03:41:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37889 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab3CFIlI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 03:41:08 -0500
Received: (qmail 23539 invoked by uid 107); 6 Mar 2013 08:42:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 03:42:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 03:41:05 -0500
Content-Disposition: inline
In-Reply-To: <1362523639-30566-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217507>

On Tue, Mar 05, 2013 at 02:47:15PM -0800, Junio C Hamano wrote:

> The primary change since the last round is that it pushes out only
> annotated tags that are missing from the other side.

Like you, I have mixed feelings on treating annotated tags separately. I
don't feel like the previous discussion actually came to a conclusion.

I kind of lean towards the "if we are pushing A..B to a ref, no matter
if the remote had the objects already, consider any tag that peels to
any commit in A..B". That seems intuitive to me, and reduces the chances
of accidentally pushing crufty tags. But I admit it's just a gut
feeling.

I think the implementation would just be something like:

  for each ref we are pushing
          mark ref->old_sha1 as UNINTERESTING
          add ref->new_sha1 to pending
  traverse pending commits, marking SEEN

  for each local tag
          if tag does not exist on remote &&
             commit = lookup_commit_reference_gently(tag) &&
             commit->object.flags & SEEN
                    push tag

-Peff
