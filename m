From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] docs: add a basic description of the config API
Date: Wed, 8 Feb 2012 10:59:50 -0500
Message-ID: <20120208155950.GD8773@sigill.intra.peff.net>
References: <20120206095306.GA2404@sigill.intra.peff.net>
 <20120206095346.GA4300@sigill.intra.peff.net>
 <7vbopb61cd.fsf@alter.siamese.dyndns.org>
 <20120207180625.GA27189@sigill.intra.peff.net>
 <7vlioe1o1g.fsf@alter.siamese.dyndns.org>
 <CACsJy8AU3ZA1=Q3vahhP6Nr=FZNKd7oRJ04mtKVs+uvNqJeVaw@mail.gmail.com>
 <7vmx8tzv3l.fsf@alter.siamese.dyndns.org>
 <CACsJy8B1cMBbrUznOp95u8YmfLf5bbzox8g9cuQUwgf-vY1XrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 17:00:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv9w5-0002XT-Md
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 16:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254Ab2BHP7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 10:59:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59631
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755Ab2BHP7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 10:59:52 -0500
Received: (qmail 16946 invoked by uid 107); 8 Feb 2012 16:07:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Feb 2012 11:07:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2012 10:59:50 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8B1cMBbrUznOp95u8YmfLf5bbzox8g9cuQUwgf-vY1XrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190242>

On Wed, Feb 08, 2012 at 01:55:30PM +0700, Nguyen Thai Ngoc Duy wrote:

> Or allow multiple callbacks from git_config(). The problem with is it
> adds another common set of config vars. Now it's common to chain var
> sets by doing
> 
> int config_callback(...)
> {
>     ....
>     return yet_another_callback(...);
> }
> 
> int main()
> {
>    git_config(config_callback, ...)
>    ...
> 
> where yet_another_callback() hard codes another callback (usually
> git_default_config). This is inflexible. If we allow multiple
> callbacks, git_column_config() could be changed to return just 0 or -1
> (i.e. 1 remains unsuccessful error code).

I don't think we need multiple callbacks. You could convert any such
call of:

  git_config_multiple(cb1, cb2, cb3, NULL, NULL);

into:

  int combining_callback(const char *var, const char *value, void *data)
  {
          if (cb1(var, value, data) < 0)
                  return -1;
          if (cb2(var, value, data) < 0)
                  return -1;
          if (cb3(var, value, data) < 0)
                  return -1;
          return 0;
  }

But note that you get the same "data" pointer in each case. If you
wanted different data pointers, you would need more support from the
config machinery. However, I'd rather that be spelled:

  git_config(cb1, data1);
  git_config(cb2, data2);
  git_config(cb3, data3);

and if the efficiency isn't acceptable, then looking into caching the
key/value pairs.

> On second thought, I think calling git_config() multiple times, each
> time with one callback, may work too. We may want to cache config
> content to avoid accessing files too many times though.

Exactly. I would do that first, and then worry about efficiency later if
it comes up. The first time I saw that we cached config multiple times
in a program run (several years ago), I had the same thought. But I
don't think the performance impact for reading the config 2 or 3 times
instead of 1 was even measurable, so I stopped looking into it.

If were to adopt something like the "automatically run this program to
get the config value" proposal that has been floating around (and I am
not saying we should), _then_ I think it might make sense to cache the
values, because the sub-program might be expensive to run.

-Peff
