From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 13/22] documentation: add documentation of the index-v5
 file format
Date: Thu, 11 Jul 2013 17:39:33 +0700
Message-ID: <CACsJy8ALSBPq1+TP_YxJ=ecUwpKRY-i2O=+q8qMjtXbjShg3mA@mail.gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-14-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 12:40:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxEIG-0005I2-9W
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 12:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603Ab3GKKkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 06:40:05 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48928 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590Ab3GKKkE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 06:40:04 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so11006742oag.5
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 03:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=G0Su6KHMENOimmuMY8D6B2CDR7AahSxdGfI2/KJzs60=;
        b=eNWwBoMMZD8iuK5L6U+zQMOZrtH1zGx3yjZWi5JXYrV15nI4+zaPBYzPyXk2FXqBz7
         DR1vAZM748KaQP3suskKT+rNPBocLNDbk1vVDbq6S/l39rfyo8ZUDxSbKBnbOTwwl1JN
         qquwIPIE8p5AF45wE37EZhlW09ShIgEt9hJSQ7tqdcoH8EdyLlOuN8mJnaM53ODL8BuF
         wmEgV9F4Q2KueKtwyA0WQh0F7q1Pv6EK6FKZB7SQwPhRBAnvaKSwDQl+4y0s/rw2L0DT
         +8VLEfiafZGjMH8ZuBYNxz7cTXEhl2BXgdkiMhWXD+kG0MEhTNQRoum/H3uLVpS/qqNn
         hbrg==
X-Received: by 10.60.136.161 with SMTP id qb1mr31215310oeb.32.1373539203803;
 Thu, 11 Jul 2013 03:40:03 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Thu, 11 Jul 2013 03:39:33 -0700 (PDT)
In-Reply-To: <1373184720-29767-14-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230081>

On Sun, Jul 7, 2013 at 3:11 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +== File entry (fileentries)
> +
> +  File entries are sorted in ascending order on the name field, after the
> +  respective offset given by the directory entries. All file names are
> +  prefix compressed, meaning the file name is relative to the directory.
> +
> +  filename (variable length, nul terminated). The exact encoding is
> +    undefined, but the filename cannot contain a NUL byte (iow, the same
> +    encoding as a UNIX pathname).
> +
> +  flags (16-bits): 'flags' field split into (high to low bits)
> +
> +    assumevalid (1-bit): assume-valid flag
> +
> +    intenttoadd (1-bit): intent-to-add flag, used by "git add -N".
> +      Extended flag in index v3.
> +
> +    stage (2-bit): stage of the file during merge
> +
> +    skipworktree (1-bit): skip-worktree flag, used by sparse checkout.
> +      Extended flag in index v3.
> +
> +    smudged (1-bit): indicates if the file is racily smudged.
> +
> +    10-bit unused, must be zero [6]
> +
> +  mode (16-bits): file mode, split into (high to low bits)
> +
> +    objtype (4-bits): object type
> +      valid values in binary are 1000 (regular file), 1010 (symbolic
> +      link) and 1110 (gitlink)
> +
> +    3-bit unused
> +
> +    permission (9-bits): unix permission. Only 0755 and 0644 are valid
> +      for regular files. Symbolic links and gitlinks have value 0 in
> +      this field.
> +
> +  mtimes (32-bits): mtime seconds, the last time a file's data changed
> +    this is stat(2) data
> +
> +  mtimens (32-bits): mtime nanosecond fractions
> +    this is stat(2) data
> +
> +  file size (32-bits): The on-disk size, trucated to 32-bit.
> +    this is stat(2) data
> +
> +  statcrc (32-bits): crc32 checksum over ctime seconds, ctime
> +    nanoseconds, ino, dev, uid, gid (All stat(2) data
> +    except mtime and file size). If the statcrc is 0 it will
> +    be ignored. [7]
> +
> +  objhash (160-bits): SHA-1 for the represented object
> +
> +  entrycrc (32-bits): crc32 checksum for the file entry. The crc code
> +    includes the offset to the offset to the file, relative to the
> +    beginning of the file.

Question about the possibility of updating index file directly. If git
updates a few fields of an entry (but not entrycrc yet) and crashes,
the entry would become corrupt because its entrycrc does not match the
content. What do we do? Do we need to save a copy of the entry
somewhere in the index file (maybe in the conflict data section), so
that the reader can recover the index? Losing the index because of
bugs is big deal in my opinion. pre-v5 never faces this because we
keep the original copy til the end.

Maybe entrycrc should not cover stat fields and statcrc. It would make
refreshing safer. If the above happens during refresh, only statcrc is
corrupt and we can just refresh the entry. entrycrc still says the
other fields are good (and they are).
--
Duy
