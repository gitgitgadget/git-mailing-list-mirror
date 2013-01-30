From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/6] introduce pack metadata cache files
Date: Wed, 30 Jan 2013 08:30:57 +0700
Message-ID: <CACsJy8Af9g9Tdqr0dXyucq-M2aP5U2HvX3ANSsabqtuX=w4Q0w@mail.gmail.com>
References: <20130129091434.GA6975@sigill.intra.peff.net> <20130129091555.GC9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 02:31:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0MWk-0007Ec-9I
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 02:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab3A3Bb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 20:31:29 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:38863 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab3A3Bb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 20:31:27 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so1124824obq.21
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 17:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WPkE/qQwki2TI2h5VPXQE2Aex6RaAxQdtU92QpazDe4=;
        b=mPEukO/LrBp/5SEjlYP5sZ0hINTq/+5eatncCaSfvh46tLjsmOQyYYrC42tJgGqsCR
         ZcPG/Z6p7zs/KyA2btg0NpsioWPO1kecXavo6wriWHmvHVoVkBrkkPHrWZS07Bi3CaT0
         IDDtZfKGdMNxWz+U6ObaNPTgZK+oq/v1TEbF11A+vJs0d7I1zSXhLUjYE9NBfrcEzRgz
         6QGbr7aMmYyIyQ/6JL3klrar92Us99jBLikE0kgPHKeUc6pXdT/y8rBdAHBJKa7bMRon
         LM9+13NlH/fyn3yZSMQ1KkaminQE8BHaBlSvS/bHwrvTl7EIy5CtPiCXeF8lA0dhsXxz
         JJZg==
X-Received: by 10.60.8.131 with SMTP id r3mr2416481oea.14.1359509487390; Tue,
 29 Jan 2013 17:31:27 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Tue, 29 Jan 2013 17:30:57 -0800 (PST)
In-Reply-To: <20130129091555.GC9999@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214986>

On Tue, Jan 29, 2013 at 4:15 PM, Jeff King <peff@peff.net> wrote:
> +static void write_meta_header(struct metapack_writer *mw, const char *id,
> +                             uint32_t version)
> +{
> +       version = htonl(version);
> +
> +       sha1write(mw->out, "META", 4);
> +       sha1write(mw->out, "\0\0\0\1", 4);
> +       sha1write(mw->out, mw->pack->sha1, 20);
> +       sha1write(mw->out, id, 4);
> +       sha1write(mw->out, &version, 4);
> +}

Because you go with all-commit-info-in-one-file, perhaps we should
have an uint32_t bitmap to describe what info this cache contains? So
far we need 4 bits for date, tree, 1st and 2nd parents (yes, I still
want to check if storing 1-parent commits only gains us anything on
some other repos). When commit count comes, it can take the fifth bit.
Reachability bitmap offsets can take the sixth bit, if we just append
the bitmaps at the end of the same file.
-- 
Duy
