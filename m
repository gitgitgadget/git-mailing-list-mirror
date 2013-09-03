From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] peel_onion(): add support for <rev>^{tag}
Date: Tue, 3 Sep 2013 03:05:46 -0400
Message-ID: <20130903070546.GC3608@sigill.intra.peff.net>
References: <1378100551-892-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:05:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGkgT-0001tw-0E
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759472Ab3ICHFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:05:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:52796 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759453Ab3ICHFs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:05:48 -0400
Received: (qmail 19801 invoked by uid 102); 3 Sep 2013 07:05:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 02:05:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 03:05:46 -0400
Content-Disposition: inline
In-Reply-To: <1378100551-892-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233686>

On Mon, Sep 02, 2013 at 01:42:31AM -0400, Richard Hansen wrote:

> Complete the <rev>^{<type>} family of object specifiers by having
> <rev>^{tag} dereference <rev> until a tag object is found (or fail if
> unable).
> 
> At first glance this may not seem very useful, as commits, trees, and
> blobs cannot be peeled to a tag, and a tag would just peel to itself.
> However, this can be used to ensure that <rev> names a tag object:
> 
>     $ git rev-parse --verify v1.8.4^{tag}
>     04f013dc38d7512eadb915eba22efc414f18b869
>     $ git rev-parse --verify master^{tag}
>     error: master^{tag}: expected tag type, but the object dereferences to tree type
>     fatal: Needed a single revision
> 
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---

FWIW, this makes sense to me. You can already accomplish the same thing
by checking the output of $(git cat-file -t $name), but this is a
natural extension of the other ^{} rules, and I can see making some
callers more natural.

>  Documentation/revisions.txt | 3 +++
>  sha1_name.c                 | 2 ++

Can you please add a test (probably in t1511) that checks the behavior,
similar to what you wrote in the commit message?

> diff --git a/sha1_name.c b/sha1_name.c
> index 65ad066..6dc496d 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -679,6 +679,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>  	sp++; /* beginning of type name, or closing brace for empty */
>  	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
>  		expected_type = OBJ_COMMIT;
> +	else if (!strncmp(tag_type, sp, 3) && sp[3] == '}')
> +		expected_type = OBJ_TAG;

This is not a problem you are introducing to this code, but the use of
opaque constants like commit_type along with the magic number "6"
assuming that it contains "commit" seems like a maintenance nightmare
(the only thing saving us is that it will almost certainly never change
from "commit"; but then why do we have the opaque type in the first
place?).

I wonder if we could do better with:

  #define COMMIT_TYPE "commit"
  ...
  if (!strncmp(COMMIT_TYPE, sp, strlen(COMMIT_TYPE))
      && sp[strlen(COMMIT_TYPE)] == '}')

Any compiler worth its salt will optimize the strlen on a string
constant into a constant itself. The length makes it a bit less
readable, though.

I wonder if we could do even better with:

  const char *x;
  ...
  if ((x = skip_prefix(sp, commit_type)) && *x == '}')

which avoids the magic lengths altogether (though the compiler cannot
optimize out the strlen call inside skip_prefix, because we declare
commit_type and friends as an extern. It probably doesn't matter in
peel_onion, though, which should not generally be performance critical
anyway).

-Peff
