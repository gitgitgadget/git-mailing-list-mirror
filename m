From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH] reset: trivial refactoring
Date: Thu, 13 Jun 2013 14:13:17 -0700
Message-ID: <CANiSa6i5xL-V+W46zWXGzLc+dSO6a+V0BLPt7hFgGZGXpp03BQ@mail.gmail.com>
References: <1371147305-20771-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 23:13:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnEpf-00060j-JJ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 23:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758889Ab3FMVNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 17:13:19 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:50585 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757642Ab3FMVNS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 17:13:18 -0400
Received: by mail-wi0-f175.google.com with SMTP id m6so1996964wiv.2
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wi1uVSdErg7l0yIYHzpzRbIOCo4u/pDme3w5InAMrfU=;
        b=fEKVLO58rA7T4Lit9qgRlqNC2t3bH2IQkc/JZWqJp/ta6dJ5GCeUoyMVTkzLQ/Pt4G
         525zWN9q8PkbyfOviuyU/tLDweMHLNTjHXYfmwKHPjCbaIGQW2lTfp0v/Z4NSqPIX2Oz
         NBVMA1My8T94Fe/JCXfJ8OeguJ6gMfdZU+jGBojNzD1tvdJhnyE9pN6F+StvPktcWUxd
         +rsx0EZqgi5mFmKHEi+o3mJQ1C4+MWsAfgDMO/YW1lKDKRD9x+0gACVz7MTgSGNSU+tH
         uuXvTLDIJkF5LNqrSUUUEDdiUUZ+rtbtYTk9qkCZ24j+gQrXULRfV32/P8B3WqjC7EiG
         CPhA==
X-Received: by 10.194.237.38 with SMTP id uz6mr1705765wjc.73.1371157997206;
 Thu, 13 Jun 2013 14:13:17 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Thu, 13 Jun 2013 14:13:17 -0700 (PDT)
In-Reply-To: <1371147305-20771-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227778>

On Thu, Jun 13, 2013 at 11:15 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> @@ -82,7 +82,7 @@ static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
>         if (unpack_trees(nr, desc, &opts))
>                 return -1;
>
> -       if (reset_type == MIXED || reset_type == HARD) {
> +       if (reset_type == HARD) {

Are you sure that this can not be reached given that...

> @@ -323,8 +323,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>                 struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
>                 int newfd = hold_locked_index(lock, 1);
>                 if (reset_type == MIXED) {
> +                       int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
>                         if (read_from_tree(pathspec, sha1))
>                                 return 1;
> +                       refresh_index(&the_index, flags, NULL, NULL,
> +                                     _("Unstaged changes after reset:"));
>                 } else {
>                         int err = reset_index(sha1, reset_type, quiet);
>                         if (reset_type == KEEP && !err)

...the line after this one reads

   err = reset_index(sha1, MIXED, quiet);

? I don't know what the consequence of not calling prime_cache_tree()
would be, though.

The merging of the two if blocks looks good. Thanks.
