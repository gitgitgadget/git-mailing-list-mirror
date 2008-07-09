From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] cached-sha1-map: refactoring hash traversal code
Date: Tue, 08 Jul 2008 22:27:46 -0700
Message-ID: <7vabgrmxt9.fsf@gitster.siamese.dyndns.org>
References: <7f9d599f0807082056o666fced9nf87cc81447e16e05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Geoffrey Irving" <irving@naml.us>
X-From: git-owner@vger.kernel.org Wed Jul 09 07:29:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGSEk-0001KT-GC
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 07:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbYGIF2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 01:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbYGIF2I
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 01:28:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbYGIF2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 01:28:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B1CF188D2;
	Wed,  9 Jul 2008 01:28:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2A3DD188D1; Wed,  9 Jul 2008 01:27:55 -0400 (EDT)
In-Reply-To: <7f9d599f0807082056o666fced9nf87cc81447e16e05@mail.gmail.com>
 (Geoffrey Irving's message of "Tue, 8 Jul 2008 20:56:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CDE33408-4D77-11DD-B72C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87848>

"Geoffrey Irving" <irving@naml.us> writes:

> From c4e60c28fe66985ac8224da832589c982010744e Mon Sep 17 00:00:00 2001
> From: Geoffrey Irving <irving@naml.us>
> Date: Tue, 8 Jul 2008 19:47:22 -0700
> Subject: [PATCH 2/3] cached-sha1-map: refactoring hash traversal code
>
> Pulling common code from get_cached_sha1_entry and set_cached_sha1_entry
> into static find_helper function.
> ---

Sign-off?

>  cached-sha1-map.c |   68 +++++++++++++++++++++++++++++-----------------------
>  1 files changed, 38 insertions(+), 30 deletions(-)

The refactoring is good, and it should have been that way from the
beginning.  Please don't send in "introduce foo.c [1/N]", "oops, initial
version of foo.c was crap, here is a fixup [2/N]".

> diff --git a/cached-sha1-map.c b/cached-sha1-map.c
> index e363745..147c7a2 100644
> --- a/cached-sha1-map.c
> +++ b/cached-sha1-map.c
> @@ -140,43 +144,47 @@ int get_cached_sha1_entry(struct cached_sha1_map *cache,
>  	mask = cache->size - 1;
>
>  	for (i = get_hash_index(key) & mask; ; i = (i+1) & mask) {
> -		if (!hashcmp(key, cache->entries[i].key)) {
> -			hashcpy(value, cache->entries[i].value);
> -			return 0;
> -		} else if (is_null_sha1(cache->entries[i].key))
> -			return -1;
> +		if (!hashcmp(key, cache->entries[i].key))
> +			return i;
> +		else if (is_null_sha1(cache->entries[i].key))
> +			return ~i;
>  	}
>  }
>
> +int get_cached_sha1_entry(struct cached_sha1_map *cache,
> +	const unsigned char *key, unsigned char *value)
> +{
> +	long i = find_helper(cache, key);
> +	if(i < 0)
> +		return -1;

Does this have to be extern?

If you are designing an API from scratch, and if you want a long, use it
consistently.  Do not demote an int to shorter int in a callchain
unnecessarily.
