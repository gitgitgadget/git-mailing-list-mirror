From: Duy Nguyen <pclouds@gmail.com>
Subject: [RFC] The design of new pathspec features
Date: Tue, 29 Jan 2013 11:35:17 +0700
Message-ID: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 05:35:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U02vI-0004OL-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 05:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691Ab3A2Ef1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 23:35:27 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63056 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab3A2EfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 23:35:25 -0500
Received: by mail-pb0-f43.google.com with SMTP id jt11so23136pbb.2
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 20:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=2FAvSLAFdzE8FpF1jtUHGUoDWqMiONY9VcopTW2tedY=;
        b=GYa0mYKL8X57lQptuw74mlJPvwHDcXO4X5OtQPUX9hZJwh69zbgyVetVDJilQLN8SR
         heUGxoZ9kxQzxEh0MT2klM/oGcLG5kOQR+dwPi+2zcCXjc4yNPSYfGZj6QiAe94APFxf
         fKhv4L2GuSOvVbF4jOv20dovwrBDZlhgK+R8JgejWl7s18CZfEDs8MJkyYX9hag4ZHFE
         Xf0KcpHL3XUGKO94bytlz823C6YoqmWShn3wUx0OQkbbL6ZmulK3IZfCg45v5RdKRSV6
         u/sjXEB/l75rybYJRAtBo5s9uAEBVOs4hKHQ1G0wEsMmeF7W76mocWjRw2HNWC7jHMAJ
         wlLA==
X-Received: by 10.68.233.99 with SMTP id tv3mr559968pbc.64.1359434124531;
        Mon, 28 Jan 2013 20:35:24 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id v2sm8083599paz.36.2013.01.28.20.35.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 20:35:23 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 29 Jan 2013 11:35:17 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214899>

For those who haven't followed closely, some coming changes allow us
to extend current pathspec syntax. We should soon be able to do
case-insenstive matching for example, or introduce "**" wildcard that
is currently used by gitignore. I just want to discuss about the new
syntax and behavior.

Many of these are already implemented in [1]. But I don't want you to
bother with buggy code yet. I'll resend it soon after 1.8.2.

--literal-pathspecs
===================

This feature is added by Jeff to disable globbing for all pathspecs. I
want to push it a bit further: disable all pathspec magic. This means
even ":/" is treated literally when --literal-pathspecs is set.
Because the intent behind this, as I understand, is for scripting, it
makes sense to keep it as literal as possible.

:(literal) magic
================

This magic is for people who want simple no-globbing pathspec (*). It
can be used in combination with other magic such as case-insensitive
matching. Incompatible with :(glob) magic below.

Global option --noglob-pathspecs is added to add :(literal) to
all. This is very similar to --literal-pathspecs. It just does not
disable pathspec magic. :(glob) magic overrides this global option.

(*) you can always disable wildcards by quoting them using backslash,
but that's inconvenient

:(glob) magic
=============

This magic is for people who want globbing. However, it does _not_ use
the same matching mechanism the non-magic pathspec does today. It uses
wildmatch(WM_PATHNAME), which basically means '*' does not match
slashes and "**" does.

Global option --glob-pathspecs is added to add :(glob) to all
pathspec. :(literal) magic overrides this global option.

fnmatch without FNM_PATHNAME is deprecated
==========================================

With the two magic above, people can switch between literal and new
globbing. There is no way to regain current matching behavior once
--[no]glob-pathspecs is used. And I think that's a good thing. New
globbing is more powerful than the current one. At some point, I'd
like to switch the matching behavior when neither literal nor magic
pathspec is specified. Either:

 - make it literal by default
 - make it new globbing by default

Which is more often used should be come the default. The question is
which.

Pathspec mnemonic
=================

Are :(literal) and :(glob) used often enough to deserve a short
mnemonic (like :/ is equivalent to :(top))? Which symbols should be
used? We can only use non-alphanumeric here, and '(', ')', ':' and '/'
are taken. It should be friendly to UNIX shell, no quoting is
preferred.

Another magic will come soon: case-insensitive matching. We may want
to reserve a mnemonic symbol for it as well.

We may also want to reserve option shortcuts for --noglob-pathspecs
and --glob-pathspecs. I suspect they'll be used more often.

New way to specify long pathspec magic
======================================

While testing the pathspec magic code, I grow tired of quoting :(glob)
every time because '(' is the start of a new shell. Which is one of
the reasons I introduce --[no]glob-pathspecs. Still I'd like a way to
specify long pathspec magic without quoting.

How about making ":q/xxx/" an equivalence of ":(xxx)"? Any character
(except ',') following 'q' is used as separator (similar to s/// from
sed). This violates the guidelines set in glossary-content.txt (only
use non-alphanumeric).

Another step futher is remove support for ":(xxx)" in favor of
":q(xxx)". We can do it today because I don't think anybody is using
":(top)" (the only supported magic) yet.

[1] https://github.com/pclouds/git/tree/parse-pathspec
