From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] force_object_loose: Fix memory leak
Date: Fri, 17 Oct 2008 21:25:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810172105030.26244@xanadu.home>
References: <20081018003731.GA17290@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_gkH2jypdpqTtaggococruA)"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 18 03:26:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr0ac-0003ak-4R
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 03:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbYJRBZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 21:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbYJRBZd
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 21:25:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42963 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbYJRBZc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 21:25:32 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8W00IN6ULC1LU0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 17 Oct 2008 21:24:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081018003731.GA17290@atjola.homenet>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98512>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_gkH2jypdpqTtaggococruA)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Sat, 18 Oct 2008, Björn Steinbrink wrote:

> read_packed_sha1 expectes its caller to free the buffer it returns, which
> force_object_loose didn't do.
> 
> This leak is eventually triggered by "git gc", when it is manually invoked
> or there are too many packs around, making gc totally unusable when there
> are lots of unreachable objects.
> 
> Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>

Good catch.

Acked-by: Nicolas Pitre <nico@cam.org>


> ---
> Tested with a somewhat recent clone of linux-2.6.git:
> 
> git clone linux-2.6 test
> cd test
> git remote rm origin
> git reset --hard v2.6.16
> git for-each-ref --format='%(refname)' refs/tags | \
> 	xargs -i git update-ref -d {}
> git reflog expire --expire=0 --all
> git repack -Ad
> 
> Without the fix, I killed repack when its memory usage got past 3 _GB_.
> With the fix, it stays at around 300MB until it starts writing the
> new pack, then it goes up to about 550MB or so.
> 
>  sha1_file.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 3fbb082..70bb453 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2333,6 +2333,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
>  	enum object_type type;
>  	char hdr[32];
>  	int hdrlen;
> +	int ret;
>  
>  	if (has_loose_object(sha1))
>  		return 0;
> @@ -2340,7 +2341,10 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
>  	if (!buf)
>  		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
>  	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
> -	return write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
> +	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
> +	free(buf);
> +
> +	return ret;
>  }
>  
>  int has_pack_index(const unsigned char *sha1)
> -- 
> 1.6.0.2.541.g46dc1.dirty
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Nicolas

--Boundary_(ID_gkH2jypdpqTtaggococruA)--
