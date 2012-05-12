From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] pack-objects: use streaming interface for reading large
 loose blobs
Date: Sat, 12 May 2012 12:51:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1205121220070.21030@xanadu.home>
References: <1336818375-16895-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_BKs8xSCPbOx1/XWdCLGjXw)"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 18:51:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STFXp-0000fa-LM
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 18:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349Ab2ELQvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 12:51:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42795 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab2ELQvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 12:51:07 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3X005XE5H531B0@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 12 May 2012 12:51:05 -0400 (EDT)
In-reply-to: <1336818375-16895-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197738>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_BKs8xSCPbOx1/XWdCLGjXw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sat, 12 May 2012, Nguyễn Thái Ngọc Duy wrote:

> git usually streams large blobs directly to packs. But there are cases
> where git can create large loose blobs (unpack-objects or hash-object
> over pipe). Or they can come from other git implementations.
> core.bigfilethreshold can also be lowered down and introduce a new
> wave of large loose blobs.
> 
> Use streaming interface to read these blobs and compress/write at the
> same time.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Comments below.

> ---
>  index-pack's streaming support is on the way. unpack-objects is
>  another story because I'm thinking of merging it back to index-pack
>  first, which may take more than one release cycle.
> 
>  builtin/pack-objects.c |   73 ++++++++++++++++++++++++++++++++++++++++++++----
>  t/t1050-large.sh       |   16 ++++++++++
>  2 files changed, 83 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 1861093..98b51c1 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -259,9 +309,14 @@ static unsigned long write_object(struct sha1file *f,
>  	if (!to_reuse) {
>  		no_reuse:
>  		if (!usable_delta) {
> -			buf = read_sha1_file(entry->idx.sha1, &type, &size);
> -			if (!buf)
> -				die("unable to read %s", sha1_to_hex(entry->idx.sha1));
> +			type = sha1_object_info(entry->idx.sha1, &size);

Please don't use sha1_object_info() lightly.  This is a potentially 
expensive operation, and you really don't want to do it on each objects.

And as a matter of fact, the information you are looking for has already 
been determined earlier.  See the code in check_object() which tries 
hard to avoid sha1_object_info() as much as possible.

Therefore you should have entry->type and entry->size already set for 
you to use.


Nicolas

--Boundary_(ID_BKs8xSCPbOx1/XWdCLGjXw)--
