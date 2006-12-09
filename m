X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 9 Dec 2006 12:51:15 +0100
Message-ID: <200612091251.16460.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org> <46a038f90612081756w1ab4609epcb4a2cbd9f4d8205@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 11:49:15 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Jeff Garzik" <jeff@garzik.org>, "H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oReWdqe/fGM5ZNoEQQIw15VpcLKuPGOUnGxE7JJeFFpJTxQE4rkGJiV4bBxtvW1GlhrhEpxNPiEHy6HrN3ve3t9vgVjRPm7p2Y2DEHWs9njfb/ww+jyg/Csb4BVyif2FprmjFwwGbWLI26RmXoB1+O8s4Or5qiLQoF6uHGcrHNc=
User-Agent: KMail/1.9.3
In-Reply-To: <46a038f90612081756w1ab4609epcb4a2cbd9f4d8205@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33810>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt0hZ-0008ON-84 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 12:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759876AbWLILtG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 06:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760466AbWLILtF
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 06:49:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34237 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1759876AbWLILtC (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 06:49:02 -0500
Received: by ug-out-1314.google.com with SMTP id 44so947394uga for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 03:49:01 -0800 (PST)
Received: by 10.67.106.3 with SMTP id i3mr6743885ugm.1165664941318; Sat, 09
 Dec 2006 03:49:01 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id e33sm4301786ugd.2006.12.09.03.49.00; Sat, 09 Dec
 2006 03:49:00 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>, "Git Mailing List"
 <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Martin Langhoff wrote:

> We can make gitweb to detect mod_perl and a few smarter things if it
> is running inside of it. In fact, we can (ab)use mod_perl and perl
> facilities a bit to do some serialization which will be a big win for
> some pages. What we need for that is to set a sensible the ETag and
> use some IPC to announce/check if other apache/modperl processes are
> preparing content for the same ETag. The first-process-to-announce a
> given ETag can then write it to a common temp directory (atomically -
> write to a temp-name and move to the expected name) while other
> processes wait, polling for the file. Once the file is in place the
> latecomers can just serve the content of the file and exit.

First, it would (and could) work only for serving gitweb over mod_perl.
I'm not sure if overhead with IPC and complications implementing are
worth it: this perhaps be better solved by caching engine.

But let us put aside for a while actual caching (writing HTML version
of the page to a common temp directory, and serving this static page
if possible), and talk a bit what gitweb can do with respect to
cache validation.

In addition to setting either Expires: header or Cache-Control: max-age
gitweb should also set Last-Modified: and ETag headers, and also 
probably respond to If-Modified-Since: and If-None-Match: requests.

Would be worth implementing this?
 
> (I am calling the "state we are serving" identifier ETag because I
> think we should also set it as the ETag in the HTTP headers, so well
> be able to check the ETag of future requests for staleness - all we
> need is a ref lookup, and if the SHA1 matches, we are sorted). So
> having this 'unique request identifier' doubles up nicely...

For some pages ETag is natural; for other Last-Modified: would be more
natural.

> The ETag should probably be:
>  - SHA1+displaytype+args for pages that display an object identified
>    by SHA1

What uniquely identifies contents in "object" views ("commit", "tag",
"tree", "blob") is either h=SHA1, or hb=SHA1;f=FILENAME (with absence
of h=SHA1). If both h=SHA1 and hb=SHA1 is present, hb=SHA1 serves as
backlink. The "diff" views ("commitdiff", "blobdiff") are uniquely
identified by pair of object identifiers (pairs of SHA1, or pairs of
hb SHA1 + FILENAME).

Three of those views ("blob", "commitdiff", "blobdiff") have their 
"plain" version; so ETag should include displaytype (action, 'a' 
parameter).

The hb=SHA1;f=FILENAME indentifier can be converted at cost of one
call to git command (but which is a bit expensive as it recurses
trees), namely to git-ls-tree.

ETag can be simply args (query), if all h/hb/hbp parameters are SHA1.
Or ETag can be SHA1 of an object (or pair of SHA1 in the case of diff),
but this is little more costly to verify. Although we usually (always?) 
convert hb=SHA1;f=FILENAME to h=SHA1 anyway when displaying/generating 
page.

Usualy you can compare ETags base on URL alone.
   
>  - refname+SHA!+displaytype+args for pages that display something
>    identified by a ref

For objects views we can simply convert refname to SHA1. I'm not sure if 
it is worth it. In the cases when for view we have to calculate SHA1 of 
object anyway, we can return (and validate) ETag with SHA1 as above.

- ETag and/or Last-Modified headers for "log" views: "log", 
"shortlog" (is part of summary view), "history", "rss"/"atom" views.

On one hand all log views (at least now) are identified by their 
parameters (action/view name, and filename in the case of history view) 
and SHA1 of top commit. On the other hand it might be easier to use 
Last-Modified with date of top commit... Verifying SHA1 based ETag 
could add some overhead in the case of miss.

>  - SHA1(names and sha1s of all refs) for the summary page

Wouldn't it be simplier to just set Last-Modified: header (and check
it?)


P.S. Can anyone post some benchmark comparing gitweb deployed under 
mod_perl as compared to deployed as CGI script? Does kernel.org use 
mod_perl, or CGI version of gitweb?

-- 
Jakub Narebski
