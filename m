From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] dir: remove PATH_MAX limitation
Date: Wed, 9 Jul 2014 01:42:16 -0400
Message-ID: <20140709054215.GE2318@sigill.intra.peff.net>
References: <53B72DAA.5050007@gmail.com>
 <53B72DD5.6020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 07:42:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4ke6-0008IC-M9
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 07:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbaGIFmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 01:42:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:58498 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751351AbaGIFmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 01:42:18 -0400
Received: (qmail 24311 invoked by uid 102); 9 Jul 2014 05:42:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 00:42:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 01:42:16 -0400
Content-Disposition: inline
In-Reply-To: <53B72DD5.6020603@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253065>

On Sat, Jul 05, 2014 at 12:42:29AM +0200, Karsten Blees wrote:

> Note: this fix just 'abuses' strbuf as string allocator, len is always 0.
> prep_exclude() can probably be simplified using more strbuf APIs.

Hrm. It looks like you grow it and add some data, but really don't want
the length to expand (because the caller depends on it).

In other directory-traversal code we follow a pattern like:

  size_t prefix_len = dir->base.len;

  strbuf_add(&dir->base, cp, stk->baselen - current);
  /* use full path in dir->base, then "pop" */
  strbuf_setlen(&dir->base, stk->baselen);

That makes it a little more obvious that the memcpy matches the
strbuf_grow (because it all happens inside strbuf_add).

Is it possible to do something like that here?

-Peff
