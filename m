From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Thu, 21 Nov 2013 19:43:03 +0700
Message-ID: <CACsJy8B5xY1FZyhPdct8Nt6Gad2cveRvmOXTXJP=uCaG2_0KuA@mail.gmail.com>
References: <20131120203350.GA31139@kitenet.net> <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net> <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121114837.GB7171@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 21 13:43:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjTbj-0004xO-Fe
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 13:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab3KUMnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 07:43:37 -0500
Received: from mail-qe0-f51.google.com ([209.85.128.51]:35693 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab3KUMng (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 07:43:36 -0500
Received: by mail-qe0-f51.google.com with SMTP id d4so3704014qej.10
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 04:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HgUNmcwbXZCB7Q7kiBzJwIJESGoJ58q6zXHiAvWW/m8=;
        b=ileXIbQxhZJOJD7JE+uCVPuVWSKGF/UqQiQb7ilqlw5/zFEHmigh+2fWH4V5gENPDj
         qDnJVGuuu/wMfoqrQmTQUcixRdCW6ql6FYRrYRuvDVv8qX8AANkyHHFm2/zKMHTwMlF6
         cT12Eywrg/Revu7mu4yDPwc6CSUafFwAK3a5IqKSHc1RSlEYD5X8z+vO3+pZGHHKtrHS
         LYoY4URUyxaIElUqsUJAqrrSOZE4CA8SFqVA3FySKAz7vXRbel4Ox5auy+5LUczcpmOX
         TFLaP7CAj2sZK+hYPMh7okYVkPkfFLxuRToZpuq65vVk/KIxnv9lBRIV0G6M3+zgCYGi
         V6HA==
X-Received: by 10.229.49.8 with SMTP id t8mr10619161qcf.21.1385037813643; Thu,
 21 Nov 2013 04:43:33 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Thu, 21 Nov 2013 04:43:03 -0800 (PST)
In-Reply-To: <20131121114837.GB7171@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238122>

On Thu, Nov 21, 2013 at 6:48 PM, Jeff King <peff@peff.net> wrote:
> @@ -1514,14 +1469,6 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
>
>  int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
>  {
> -       unsigned long size, used;
> -       static const char valid_loose_object_type[8] = {
> -               0, /* OBJ_EXT */
> -               1, 1, 1, 1, /* "commit", "tree", "blob", "tag" */
> -               0, /* "delta" and others are invalid in a loose object */
> -       };
> -       enum object_type type;
> -
>         /* Get the data stream */
>         memset(stream, 0, sizeof(*stream));
>         stream->next_in = map;
> @@ -1529,27 +1476,6 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
>         stream->next_out = buffer;
>         stream->avail_out = bufsiz;
>
> -       if (experimental_loose_object(map)) {

Perhaps keep this..

> -               /*
> -                * The old experimental format we no longer produce;
> -                * we can still read it.
> -                */
> -               used = unpack_object_header_buffer(map, mapsize, &type, &size);
> -               if (!used || !valid_loose_object_type[type])
> -                       return -1;
> -               map += used;
> -               mapsize -= used;
> -
> -               /* Set up the stream for the rest.. */
> -               stream->next_in = map;
> -               stream->avail_in = mapsize;
> -               git_inflate_init(stream);
> -
> -               /* And generate the fake traditional header */
> -               stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu",
> -                                                typename(type), size);
> -               return 0;

and replace all this with

die("detected an object in obsolete format, please repack the
repository using a version before XXX");

?

> -       }
>         git_inflate_init(stream);
>         return git_inflate(stream, 0);
>  }
-- 
Duy
