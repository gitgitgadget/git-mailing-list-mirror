From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] rev-parse: be more careful with munging arguments
Date: Mon, 9 Dec 2013 16:33:42 -0500
Message-ID: <CAPig+cSSherOy0HXC-E0bRcW=+M370ZoDP7CbW8bKvwSs5imYA@mail.gmail.com>
References: <20131206220520.GA30652@sigill.intra.peff.net>
	<20131206220751.GB25620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:33:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq8Sb-0008T3-Es
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761472Ab3LIVdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:33:44 -0500
Received: from mail-la0-f47.google.com ([209.85.215.47]:48219 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3LIVdo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:33:44 -0500
Received: by mail-la0-f47.google.com with SMTP id ep20so2046496lab.34
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 13:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nHr2/6jKEHKm/y1biedGbCml/25clvZVCuJIKun5ZOY=;
        b=Q3v/OLLuDd/XvNeRZUaLdMzGxNlYkF+LGYAz49nFOiDtdVwH6wm2mK+KDApVkz2yIU
         ph6t5KULy2OMU/yQHwlAbXEPjiGM18CRDMm9P3LvjKVlUC0LlasiP9iNTSRuQtRz+jMr
         /Xtmo3M2fAZW+20u1qb+nE4IUaA27VarNzEKpcCJ17CSizWdxp0tRMYurbMvTD4fSr9l
         KEL69c547Df4bsclYRRHO/6/NT73aMcoLgIJ74JB79diIAH28JIuGnfFDxAJlrFhad6q
         HDdTXXgdXie/+W7VmVzDreZtLmehgW2Xb9oG7PusBe+uAAakLKYyxifB8TWCWA5ZDd6V
         2D5g==
X-Received: by 10.152.19.131 with SMTP id f3mr99449lae.87.1386624822905; Mon,
 09 Dec 2013 13:33:42 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Mon, 9 Dec 2013 13:33:42 -0800 (PST)
In-Reply-To: <20131206220751.GB25620@sigill.intra.peff.net>
X-Google-Sender-Auth: r3dtAQO73CG7O9q1cuNiwFe-MBA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239109>

On Fri, Dec 6, 2013 at 5:07 PM, Jeff King <peff@peff.net> wrote:
> When rev-parse looks at whether an argument like "foo..bar"
> or "foobar^@" is a difference or parent-shorthand, it
> internally munges the arguments so that it can pass the
> individual rev arguments to get_sha1. However, we do not
> consistently un-munge the result.
>
> For cases where we do not match (e.g., "doesnotexist..HEAD"),
> we wouuld then want to try to treat the argument as a

s/wouuld/would/

> filename. try_difference gets this right, and always
> unmunges in this case. However, try_parent_shorthand never
> unmunges, leading to incorrect error messages, or even
> incorrect results:
>
>   $ git rev-parse foobar^@
>   foobar
>   fatal: ambiguous argument 'foobar': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>
>   $ >foobar
>   $ git rev-parse foobar^@
>   foobar
>
> For cases where we do match, neither function unmunges. This
> does not currently matter, since we are done with the
> argument. However, a future patch will do further
> processing, and this prepares for it. In addition, it's
> simply a confusing interface for some cases to modify the
> const argument, and others not to.
>
> Signed-off-by: Jeff King <peff@peff.net>
