From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/16] object_array: factor out slopbuf-freeing logic
Date: Tue, 07 Oct 2014 13:25:54 +0200
Message-ID: <5433CDC2.6000908@alum.mit.edu>
References: <20141003202045.GA15205@peff.net> <20141003202222.GC16293@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 13:26:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbSu6-0006vY-M3
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 13:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbaJGL0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 07:26:01 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63568 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753152AbaJGLZ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2014 07:25:59 -0400
X-AuditID: 1207440d-f797f6d000000a4a-f0-5433cdc4ed97
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4F.3F.02634.4CDC3345; Tue,  7 Oct 2014 07:25:56 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C4D.dip0.t-ipconnect.de [93.219.28.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s97BPsuN005645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 7 Oct 2014 07:25:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20141003202222.GC16293@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42IRYndR1D1y1jjEYMJ8CYuuK91MFj9aepgd
	mDye9e5h9Pi8SS6AKYrbJimxpCw4Mz1P3y6BO6PpzAG2gkfsFUdO3WRqYJzN1sXIySEhYCKx
	+MEdKFtM4sK99UA2F4eQwGVGia17f0I5Z5kkVrdMZgKp4hXQljh99w0LiM0ioCrxbOJFMJtN
	QFdiUU8zWI2oQIDEh84HjBD1ghInZz4BqxERMJK48eEb0FAODmEBT4kDkyxAwkIC/hK/JzWz
	gticAnoS846sBBvDLKAu8WfeJWYIW15i+9s5zBMY+WchmToLSdksJGULGJlXMcol5pTm6uYm
	ZuYUpybrFicn5uWlFuka6eVmluilppRuYoQEJO8Oxv/rZA4xCnAwKvHwrtAyDhFiTSwrrsw9
	xCjJwaQkyjvnFFCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO+i00A53pTEyqrUonyYlDQHi5I4
	r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE79UzQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmp
	RYmlJRnxoIiMLwbGJEiKB2jvP5B23uKCxFygKETrKUZdjpamt71MQix5+XmpUuK8RiBFAiBF
	GaV5cCtg6ecVozjQx8K8d0GqeICpC27SK6AlTEBLVvWDLSlJREhJNTBazxWeVcj9kJHh5pxT
	cUs9Fyvu/l91R+rhrFmmpRY3CgMnbv+0/b2p9WnNAIGootvnPzLNWMajdUa/2u96UkHdix6b
	CLsD/Rlvjn7Qbksss1SRT77zYUu+4rKmhRw/zRJsvsZb1TcxTGb8f6HtvoR15ekb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257922>

On 10/03/2014 10:22 PM, Jeff King wrote:
> This is not a lot of code, but it's a logical construct that
> should not need to be repeated (and we are about to add a
> third repetition).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/object.c b/object.c
> index ca9d790..14238dc 100644
> --- a/object.c
> +++ b/object.c
> @@ -355,6 +355,12 @@ void add_object_array_with_context(struct object *obj, const char *name, struct
>  		add_object_array_with_mode_context(obj, name, array, S_IFINVALID, context);
>  }
>  
> +static void object_array_release_entry(struct object_array_entry *ent)
> +{
> +	if (ent->name != object_array_slopbuf)
> +		free(ent->name);
> +}
> +

Would it be a little safer to set ent->name to NULL or to
object_array_slopbuf after freeing the memory, to prevent accidents?

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
