From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 4/4] grep: obey --textconv for the case rev:path
Date: Wed, 6 Feb 2013 17:36:56 -0500
Message-ID: <20130206223656.GF27507@sigill.intra.peff.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
 <a2808975f00bac5de0902e6830f254e4b064e8a5.1360162813.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:37:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3DcJ-0005HB-LU
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758116Ab3BFWhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:37:00 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37174 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758005Ab3BFWg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 17:36:59 -0500
Received: (qmail 11589 invoked by uid 107); 6 Feb 2013 22:38:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 17:38:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 17:36:56 -0500
Content-Disposition: inline
In-Reply-To: <a2808975f00bac5de0902e6830f254e4b064e8a5.1360162813.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215656>

On Wed, Feb 06, 2013 at 04:08:53PM +0100, Michael J Gruber wrote:

> -			add_object_array(object, arg, &list);
> +			add_object_array_with_context(object, arg, &list, xmemdupz(&oc, sizeof(struct object_context)));

If we go this route, this new _with_context variant should be used in
patch 1, too.

> @@ -265,9 +260,28 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
>  	objects[nr].item = obj;
>  	objects[nr].name = name;
>  	objects[nr].mode = mode;
> +	objects[nr].context = context;
>  	array->nr = ++nr;
>  }

This seems a little gross. Who is responsible for allocating the
context? Who frees it? It looks like we duplicate it in cmd_grep. Which
I think is OK, but it means all of this context infrastructure in
object.[ch] is just bolted-on junk waiting for somebody to use it wrong
or get confused.  It does not get set, for example, by the regular
setup_revisions code path.

It would be nice if we could just always have the context available,
then setup_revisions could set it up by default (and replace the "mode"
parameter entirely). But we'd need to do something to avoid the
PATH_MAX-sized buffer for each entry, as some code paths may have a
large number of pending objects.

-Peff
