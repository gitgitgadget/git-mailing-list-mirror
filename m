From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 5/5] support writing uncompressed loose object
Date: Tue, 2 Dec 2008 08:07:06 -0800
Message-ID: <20081202160706.GN23984@spearce.org>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org> <4934975E.2010601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:09:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Xnh-0001oO-Th
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 17:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbYLBQHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 11:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbYLBQHJ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 11:07:09 -0500
Received: from george.spearce.org ([209.20.77.23]:42525 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYLBQHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 11:07:07 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C12FA38200; Tue,  2 Dec 2008 16:07:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4934975E.2010601@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102151>

Liu Yubao <yubao.liu@gmail.com> wrote:
> 
> Signed-off-by: Liu Yubao <yubao.liu@gmail.com>

IMHO, this needs more description in the commit message.

> diff --git a/sha1_file.c b/sha1_file.c
> index 05a9fa3..053b564 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2328,7 +2328,7 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
>  }
>  
>  static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
> -			      void *buf, unsigned long len, time_t mtime)
> +			      void *buf, unsigned long len, time_t mtime, int dont_deflate)

Passing this as an argument is pointless.  It should be a repository
wide configuration option in core, so you can declare it a static and
allow git_config to populate it.  Defaulting to 1 (no compression)
like you do elsewhere in the patch isn't good.

I'm still against this file format change.  The series itself isn't
that bad, and the buffer overflow catch in parse_sha1_header()
may be something worthwhile fixing.  But I'm still not sold that
introducing a new loose object format is worth it.

I'd rather use a binary header encoding like the new-style/in-pack
format rather than the older style text headers.  Its faster to
parse for one thing.

Your changes in the reading code cause a copy of the buffer we
mmap()'d.  That sort of ruins your argument that this change is
worthwhile because concurrent processes on the same host can mmap the
same buffer and save memory.  We're still copying the buffer anyway.
I probably should have commented on that in patch 4/5, but I just
realized it, so I'm saying it here.

-- 
Shawn.
