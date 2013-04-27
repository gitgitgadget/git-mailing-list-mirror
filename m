From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2] merge-tree: don't print entries that match "local"
Date: Sat, 27 Apr 2013 13:35:57 +0200
Message-ID: <517BB81D.10909@lsrfire.ath.cx>
References: <0a6a0c978569906b8c8d9209a85338554e503236.1364419952.git.john@keeping.me.uk> <7vk3osjwgv.fsf@alter.siamese.dyndns.org> <20130327225739.GT2286@serenity.lan> <20130328093458.GV2286@serenity.lan> <7vk3oe2j85.fsf@alter.siamese.dyndns.org> <20130407210751.GM2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Apr 27 13:36:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW3QF-0002LS-Sv
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 13:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab3D0LgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 07:36:03 -0400
Received: from india601.server4you.de ([85.25.151.105]:49278 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab3D0LgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 07:36:01 -0400
Received: from [192.168.2.105] (p579BE62C.dip0.t-ipconnect.de [87.155.230.44])
	by india601.server4you.de (Postfix) with ESMTPSA id A5CB0324;
	Sat, 27 Apr 2013 13:35:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130407210751.GM2222@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222639>

Am 07.04.2013 23:07, schrieb John Keeping:
> The documentation says:
>
> 	the output from the command omits entries that match the
> 	<branch1> tree.
>
> But currently "added in branch1" and "removed in branch1" (both while
> unchanged in branch2) do print output.  Change this so that the
> behaviour matches the documentation.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>   builtin/merge-tree.c  | 26 +++++++++++++-------------
>   t/t4300-merge-tree.sh | 10 ----------
>   2 files changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index bc912e3..ed25d81 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -155,6 +155,11 @@ static int same_entry(struct name_entry *a, struct name_entry *b)
>   		a->mode == b->mode;
>   }
>
> +static int both_empty(struct name_entry *a, struct name_entry *b)
> +{
> +	return !(a->sha1 || b->sha1);
> +}
> +
>   static struct merge_list *create_entry(unsigned stage, unsigned mode, const unsigned char *sha1, const char *path)
>   {
>   	struct merge_list *res = xcalloc(1, sizeof(*res));
> @@ -297,13 +302,10 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
>   static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *info)
>   {
>   	/* Same in both? */
> -	if (same_entry(entry+1, entry+2)) {
> -		if (entry[0].sha1) {
> -			/* Modified identically */
> -			resolve(info, NULL, entry+1);
> -			return mask;
> -		}
> -		/* "Both added the same" is left unresolved */
> +	if (same_entry(entry+1, entry+2) || both_empty(entry+0, entry+2)) {

Shouldn't this zero be a one instead?

> +		/* Modified, added or removed identically */
> +		resolve(info, NULL, entry+1);
> +		return mask;
>   	}
>
>   	if (same_entry(entry+0, entry+1)) {
> @@ -319,12 +321,10 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
>   		 */
>   	}
>
> -	if (same_entry(entry+0, entry+2)) {
> -		if (entry[1].sha1 && !S_ISDIR(entry[1].mode)) {
> -			/* We modified, they did not touch -- take ours */
> -			resolve(info, NULL, entry+1);
> -			return mask;
> -		}
> +	if (same_entry(entry+0, entry+2) || both_empty(entry+0, entry+2)) {

Otherwise the both_empty check here can be removed because we'd have 
already returned above if it was true.

But do we actually want to resolve the removal of a file on both sides 
silently?  The added comment above says so, but the commit message 
doesn't mention it.

> +		/* We added, modified or removed, they did not touch -- take ours */
> +		resolve(info, NULL, entry+1);
> +		return mask;
>   	}
>
>   	unresolved(info, entry);
> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> index d0b2a45..bd43b3d 100755
> --- a/t/t4300-merge-tree.sh
> +++ b/t/t4300-merge-tree.sh
> @@ -26,8 +26,6 @@ EXPECTED
>
>   test_expect_success 'file add !A, B' '
>   	cat >expected <<\EXPECTED &&
> -added in local
> -  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
>   EXPECTED
>
>   	git reset --hard initial &&
> @@ -38,9 +36,6 @@ EXPECTED
>
>   test_expect_success 'file add A, B (same)' '
>   	cat >expected <<\EXPECTED &&
> -added in both
> -  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
> -  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
>   EXPECTED
>
>   	git reset --hard initial &&
> @@ -181,9 +176,6 @@ AAA" &&
>
>   test_expect_success 'file remove A, !B' '
>   	cat >expected <<\EXPECTED &&
> -removed in local
> -  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
> -  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
>   EXPECTED
>
>   	git reset --hard initial &&
> @@ -283,8 +275,6 @@ test_expect_success 'turn tree to file' '
>   	test_commit "make-file" "dir" "CCC" &&
>   	git merge-tree add-tree add-another-tree make-file >actual &&
>   	cat >expect <<-\EOF &&
> -	added in local
> -	  our    100644 ba629238ca89489f2b350e196ca445e09d8bb834 dir/another
>   	removed in remote
>   	  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d dir/path
>   	  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d dir/path
>
