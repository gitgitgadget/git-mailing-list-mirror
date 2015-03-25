From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC] init-db: introduce new -c/--config option
Date: Wed, 25 Mar 2015 14:39:59 -0400
Message-ID: <20150325183959.GA16989@peff.net>
References: <1427307759-18679-1-git-send-email-kuleshovmail@gmail.com>
 <CANCZXo56RY18xKJbQoU=VRYApnKfy6e9ieu8munNsF6WB6YWYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:40:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaqDo-0003C4-A8
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 19:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbbCYSkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 14:40:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:38426 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753116AbbCYSkC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 14:40:02 -0400
Received: (qmail 21342 invoked by uid 102); 25 Mar 2015 18:40:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 13:40:01 -0500
Received: (qmail 16735 invoked by uid 107); 25 Mar 2015 18:40:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 14:40:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2015 14:39:59 -0400
Content-Disposition: inline
In-Reply-To: <CANCZXo56RY18xKJbQoU=VRYApnKfy6e9ieu8munNsF6WB6YWYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266291>

On Thu, Mar 26, 2015 at 12:30:13AM +0600, Alexander Kuleshov wrote:

> I'm not sure about two things:
> 
> 1. Is there any way to do this with the current git? At least i didn't
> find how to do it, so decided to write this patch.
> If there is already ability to do the same without this patch, please
> let me know.

The reason we originally added "-c" to clone and not init is that clone
performs several other follow-on actions after the repository is
initialized. For example, you might want to run:

  git clone -c core.autocrlf=true ...

to have that option in place before clone checks out files to the
working tree. There is no direct way to have "git init" set the config
for you, but there is no harm in doing:

  git init
  git config core.autocrlf=true

because init returns control to you immediatel.

> 2. Now current patch overwrite the value of the configuration option
> from config,
> if there is given option with the same key. For example, when we do git init,
> .git/config contains core.filemode = true. If we will pass
> core.filemode = false with this patch to git init,
> there will be core.filemode = false in the .git/config. So, I'm not
> sure about it.
> I looked on git clone -c/--config, it just adds the same option to the
> .git/config, but it looks strange to me....

Most options, when there are multiple present, will use the last-seen
value (core.filemode is one of these, so having it there twice means the
second one takes precedence). Some options form a list (e.g., fetch
refspecs). So if you run:

  git clone -c remote.origin.fetch=refs/notes/*:refs/notes/* ...

you add a new refspec, but do not replace the default one to fetch the
actual branches. The knowledge of which config keys are which is known
only to the config callbacks, so it is generally safer for generic
config-munging code to add a potentially overriding key (the downside is
that you cannot use "-c" to "clear" a list-like key, but the inability
to do that is a failing of the config code in general).

-Peff
