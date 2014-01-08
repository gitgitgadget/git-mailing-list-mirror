From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] refs: teach for_each_ref a flag to avoid recursion
Date: Wed, 8 Jan 2014 05:23:48 -0500
Message-ID: <20140108102348.GA30092@sigill.intra.peff.net>
References: <20140107235631.GA10503@sigill.intra.peff.net>
 <20140107235850.GC10657@sigill.intra.peff.net>
 <20140108034733.GA17198@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 11:23:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0qIl-0004I2-IT
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 11:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbaAHKXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 05:23:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:57120 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754162AbaAHKXu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 05:23:50 -0500
Received: (qmail 32532 invoked by uid 102); 8 Jan 2014 10:23:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 04:23:51 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 05:23:48 -0500
Content-Disposition: inline
In-Reply-To: <20140108034733.GA17198@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240204>

On Tue, Jan 07, 2014 at 10:47:33PM -0500, Jeff King wrote:

> On Tue, Jan 07, 2014 at 06:58:50PM -0500, Jeff King wrote:
> 
> > +			if (flags & DO_FOR_EACH_NO_RECURSE) {
> > +				struct ref_dir *subdir = get_ref_dir(entry);
> > +				sort_ref_dir(subdir);
> > +				retval = do_for_each_entry_in_dir(subdir, 0,
> 
> Obviously this is totally wrong and inverts the point of the flag. And
> causes something like half of the test suite to fail.

And while we're on the subject of my mistakes...

The patch needs the fixup below to ensure that retval is always set,
even when we do not recurse.

I'll hold off on sending a full re-roll of the patch, in the extremely
unlikely event that there are other small errors to be fixed. :)

diff --git a/refs.c b/refs.c
index aafbae9..99c72d0 100644
--- a/refs.c
+++ b/refs.c
@@ -679,7 +679,8 @@ static int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
 				retval = do_for_each_entry_in_dir(subdir, 0,
 								  fn, cb_data,
 								  flags);
-			}
+			} else
+				retval = 0;
 		} else {
 			retval = fn(entry, cb_data);
 		}
@@ -732,7 +733,8 @@ static int do_for_each_entry_in_dirs(struct ref_dir *dir1,
 					retval = do_for_each_entry_in_dirs(
 							subdir1, subdir2,
 							fn, cb_data, flags);
-				}
+				} else
+					retval = 0;
 				i1++;
 				i2++;
 			} else if (!(e1->flag & REF_DIR) && !(e2->flag & REF_DIR)) {
