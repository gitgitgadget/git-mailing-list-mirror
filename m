From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 09/19] ls-files.c: use index api
Date: Sun, 14 Jul 2013 10:39:46 +0700
Message-ID: <CACsJy8DA=AD8=_kVYLNMS53fb8QwqKG4=8fA1cYAQBTn1gcj0Q@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-10-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 05:40:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyDAr-0006CQ-B6
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 05:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326Ab3GNDkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 23:40:19 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:44653 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab3GNDkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 23:40:18 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so14658803oag.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 20:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M1IoAi9JSBPBAe62FB7pQC4f6qs1vMUPyey8xsCn6Ic=;
        b=XhEG+FnTFeNCKObODgeHzUF8gGVTJRmNE3JsKwIQire5237HYR0i2DSsq3jsxUzB2X
         fnAtqgE7sgfLgNJwZufkNFRGbfpFHFrIdBHr13o76XVA7a8G3TxS2t5PmVNI0JrEtR3e
         mrhBMPxAYUymfBM9McwaENFB08BXpr8BpebcjiKuPm5RgIKLx1AXyvYD8/fMABeGf8iE
         aXo7vKLUOIsQLFXdOIiMXk/fmfzQLGuQcCzf3ErcfR9b0zxjTUrYNPAm+udB8HmScxIu
         S3X4az0ip1HiV48K867gIHUVZ2uq4NE1n8fbMfaaoBWBrfTbS0ESjs+rLW2E9zoShVts
         bsfg==
X-Received: by 10.60.83.116 with SMTP id p20mr39555227oey.83.1373773217660;
 Sat, 13 Jul 2013 20:40:17 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sat, 13 Jul 2013 20:39:46 -0700 (PDT)
In-Reply-To: <1373650024-3001-10-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230306>

On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +       if (!with_tree) {
> +               memset(opts, 0, sizeof(*opts));
> +               opts->pathspec = &pathspec_struct;
> +               opts->read_staged = 1;
> +               if (show_resolve_undo)
> +                       opts->read_resolve_undo = 1;
> +               read_cache_filtered(opts);

So you load partial index here.

> +       } else {
> +               read_cache();
> +       }
> +       /* be nice with submodule paths ending in a slash */
> +       if (pathspec)
> +               strip_trailing_slash_from_submodules();

Then strip_trailing_slash_from_submodules will attempt to convert
pathspec "foo/" to "foo" if "foo" exists in the index and is a
gitlink. But becaues "foo/" is used to load the partial index, "foo"
is not loaded (is it?) and this could become incorrect no-op. I
suggest you go through the pathspec once checking for ones ending with
'/'. If so strip_trailing_... may potentially update pathspec, just
load full index. If no pathspec ends with '/', strip_trail... is no-op
and we can do partial loading safely.
-- 
Duy
