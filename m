From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH] fix sha1_pack_index_name()
Date: Wed, 28 May 2008 18:59:15 +0200
Message-ID: <483D8F63.2000007@isy.liu.se>
References: <483D7E27.7030809@isy.liu.se> <7v1w3mwffq.fsf@gitster.siamese.dyndns.org> <7vskw2v0i8.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Heikki Orsila <heikki.orsila@iki.fi>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 19:00:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1P0a-0003bl-HT
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 19:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbYE1Q7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 12:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbYE1Q7T
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 12:59:19 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:52746 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbYE1Q7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 12:59:18 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 42F5025953;
	Wed, 28 May 2008 18:59:17 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 16528-06; Mon, 26 May 2008 19:01:50 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 87AED2594C;
	Wed, 28 May 2008 18:59:16 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <7vskw2v0i8.fsf_-_@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83111>

On 05/28/2008 06:47 PM, Junio C Hamano wrote:
> An earlier commit 633f43e (Remove redundant code, eliminate one static
> variable, 2008-05-24) had a thinko (perhaps an eyeno) that broke
> sha1_pack_index_name() function.  One symptom of this was that the http
> walker is now completely broken.
> 
> This should fix it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This did - applied on top of next - not fix my problem but changed the 
error message somewhat:

$ git version
git version 1.5.6.rc0.141.g55e0e
$ git fetch origin
Getting alternates list for http://repo.or.cz/r/git-homepage.git
Getting pack list for http://repo.or.cz/r/git-homepage.git
error: Unable to find 50819d376acb03429ab2628ef3d07893c7f0e22c under 
http://repo.or.cz/r/git-homepage.git
Cannot obtain needed object 50819d376acb03429ab2628ef3d07893c7f0e22c
fatal: Fetch failed.

/Gustaf

> ---
>  sha1_file.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 9679040..adcf37c 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -177,7 +177,7 @@ char *sha1_file_name(const unsigned char *sha1)
>  }
>  
>  static char *sha1_get_pack_name(const unsigned char *sha1,
> -				char **name, char **base)
> +				char **name, char **base, const char *which)
>  {
>  	static const char hex[] = "0123456789abcdef";
>  	char *buf;
> @@ -187,7 +187,8 @@ static char *sha1_get_pack_name(const unsigned char *sha1,
>  		const char *sha1_file_directory = get_object_directory();
>  		int len = strlen(sha1_file_directory);
>  		*base = xmalloc(len + 60);
> -		sprintf(*base, "%s/pack/pack-1234567890123456789012345678901234567890.pack", sha1_file_directory);
> +		sprintf(*base, "%s/pack/pack-1234567890123456789012345678901234567890.%s",
> +			sha1_file_directory, which);
>  		*name = *base + len + 11;
>  	}
>  
> @@ -206,14 +207,14 @@ char *sha1_pack_name(const unsigned char *sha1)
>  {
>  	static char *name, *base;
>  
> -	return sha1_get_pack_name(sha1, &name, &base);
> +	return sha1_get_pack_name(sha1, &name, &base, "pack");
>  }
>  
>  char *sha1_pack_index_name(const unsigned char *sha1)
>  {
>  	static char *name, *base;
>  
> -	return sha1_get_pack_name(sha1, &name, &base);
> +	return sha1_get_pack_name(sha1, &name, &base, "idx");
>  }
>  
>  struct alternate_object_database *alt_odb_list;
