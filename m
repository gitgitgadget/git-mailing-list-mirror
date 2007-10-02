From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: mirror pushing
Date: Tue, 2 Oct 2007 12:59:03 +0100
Message-ID: <20071002115903.GB30636@shadowen.org>
References: <7vhclalzlq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 13:59:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcgPO-0003ka-NF
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 13:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbXJBL7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 07:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbXJBL7R
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 07:59:17 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:3718 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbXJBL7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 07:59:16 -0400
Received: from 81-179-148-120.dsl.pipex.com ([81.179.148.120] helo=localhost.localdomain)
	by hellhawk.shadowen.org with esmtpa (Exim 4.50)
	id 1IcgP5-0007Um-V0; Tue, 02 Oct 2007 12:59:08 +0100
Received: from localhost ([127.0.0.1] helo=pinky)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IcgP1-00010R-C2; Tue, 02 Oct 2007 12:59:03 +0100
Content-Disposition: inline
In-Reply-To: <7vhclalzlq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Received-SPF: none
X-SPF-Guess: neutral
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59685>

On Tue, Oct 02, 2007 at 12:55:45AM -0700, Junio C Hamano wrote:
> Existing "git push --all" is almost perfect for backing up to
> another repository, except that "--all" only means "all
> branches" in modern git, and it does not delete old branches and
> tags that exist at the back-up repository that you have removed
> from your local repository.
> 
> This teaches "git-send-pack" a new "--mirror" option.  The
> difference from the "--all" option are that (1) it sends all
> refs, not just branches, and (2) it deletes old refs you no
> longer have on the local side from the remote side.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * This even applies to "maint", but it probably should be done
>    on top of Daniel's remote.c changes.  Teaching this to "git
>    push" wrapper is left as an exercise to the reader.
> 
>  remote.c    |   15 ++++++++++-----
>  send-pack.c |   35 ++++++++++++++++++++++++-----------
>  2 files changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/remote.c b/remote.c
> index bb774d0..a3aa5ad 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -574,10 +574,12 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
>   * without thinking.
>   */
>  int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
> -	       int nr_refspec, char **refspec, int all)
> +	       int nr_refspec, char **refspec, int flags)
>  {
>  	struct refspec *rs =
>  		parse_ref_spec(nr_refspec, (const char **) refspec);
> +	int send_all = flags & 01;
> +	int send_mirror = flags & 02;
>  
>  	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
>  		return -1;
> @@ -594,7 +596,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
>  			if (!pat)
>  				continue;
>  		}
> -		else if (prefixcmp(src->name, "refs/heads/"))
> +		else if (!send_mirror && prefixcmp(src->name, "refs/heads/"))
>  			/*
>  			 * "matching refs"; traditionally we pushed everything
>  			 * including refs outside refs/heads/ hierarchy, but
> @@ -615,10 +617,13 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
>  		if (dst_peer && dst_peer->peer_ref)
>  			/* We're already sending something to this ref. */
>  			goto free_name;
> -		if (!dst_peer && !nr_refspec && !all)
> -			/* Remote doesn't have it, and we have no
> +
> +		if (!dst_peer && !nr_refspec && !(send_all || send_mirror))
> +			/*
> +			 * Remote doesn't have it, and we have no
>  			 * explicit pattern, and we don't have
> -			 * --all. */
> +			 * --all nor --mirror.
> +			 */
>  			goto free_name;
>  		if (!dst_peer) {
>  			/* Create a new one and link it */
> diff --git a/send-pack.c b/send-pack.c
> index 9fc8a81..39b4b17 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -7,11 +7,12 @@
>  #include "remote.h"
>  
>  static const char send_pack_usage[] =
> -"git-send-pack [--all] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
> +"git-send-pack [--all | --mirror] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
>  "  --all and explicit <ref> specification are mutually exclusive.";
>  static const char *receivepack = "git-receive-pack";
>  static int verbose;
>  static int send_all;
> +static int send_mirror;
>  static int force_update;
>  static int use_thin_pack;
>  
> @@ -200,7 +201,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
>  	if (!remote_tail)
>  		remote_tail = &remote_refs;
>  	if (match_refs(local_refs, remote_refs, &remote_tail,
> -		       nr_refspec, refspec, send_all))
> +		       nr_refspec, refspec, (send_all | (send_mirror << 1))))
>  		return -1;
>  
>  	if (!remote_refs) {
> @@ -215,19 +216,24 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
>  	for (ref = remote_refs; ref; ref = ref->next) {
>  		char old_hex[60], *new_hex;
>  		int will_delete_ref;
> +		const unsigned char *new_sha1;
>  
> -		if (!ref->peer_ref)
> -			continue;
> -
> +		if (!ref->peer_ref) {
> +			if (!send_mirror)
> +				continue;
> +			new_sha1 = null_sha1;
> +		}
> +		else
> +			new_sha1 = ref->peer_ref->new_sha1;
>  
> -		will_delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
> +		will_delete_ref = is_null_sha1(new_sha1);
>  		if (will_delete_ref && !allow_deleting_refs) {
>  			error("remote does not support deleting refs");
>  			ret = -2;
>  			continue;
>  		}
>  		if (!will_delete_ref &&
> -		    !hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
> +		    !hashcmp(ref->old_sha1, new_sha1)) {
>  			if (verbose)
>  				fprintf(stderr, "'%s': up-to-date\n", ref->name);
>  			continue;
> @@ -257,8 +263,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
>  		    !is_null_sha1(ref->old_sha1) &&
>  		    !ref->force) {
>  			if (!has_sha1_file(ref->old_sha1) ||
> -			    !ref_newer(ref->peer_ref->new_sha1,
> -				       ref->old_sha1)) {
> +			    !ref_newer(new_sha1, ref->old_sha1)) {
>  				/* We do not have the remote ref, or
>  				 * we know that the remote ref is not
>  				 * an ancestor of what we are trying to
> @@ -276,7 +281,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
>  				continue;
>  			}
>  		}
> -		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
> +		hashcpy(ref->new_sha1, new_sha1);
>  		if (!will_delete_ref)
>  			new_refs++;
>  		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
> @@ -396,6 +401,10 @@ int main(int argc, char **argv)
>  				send_all = 1;
>  				continue;
>  			}
> +			if (!strcmp(arg, "--mirror")) {
> +				send_mirror = 1;
> +				continue;
> +			}
>  			if (!strcmp(arg, "--force")) {
>  				force_update = 1;
>  				continue;
> @@ -420,7 +429,11 @@ int main(int argc, char **argv)
>  	}
>  	if (!dest)
>  		usage(send_pack_usage);
> -	if (heads && send_all)
> +	/*
> +	 * --all and --mirror are incompatible; neither makes sense
> +	 * with any refspecs.
> +	 */
> +	if ((heads && (send_all || send_mirror)) || (send_all && send_mirror))
>  		usage(send_pack_usage);
>  	verify_remote_names(nr_heads, heads);

Ok, I put together a patch to tie this in (will post that following this
email).  However this mirror mode seems to do something odd.  With
matching repo's it reports all the tags as missing on the remote end,
and attempts to resend them:

$ git push --mirror ssh://.../~apw/git/git 
updating 'junio-gpg-pub'
  from 0000000000000000000000000000000000000000
  to   a0e7d36193b96f552073558acf5fcc1f10528917
updating 'v0.99'
  from 0000000000000000000000000000000000000000
  to   d6602ec5194c87b0fc87103ca4d67251c76f233a
[...]
Generating pack...
Done counting 0 objects.
Writing 0 objects...
Total 0 (delta 0), reused 0 (delta 0)
error: Ref junio-gpg-pub is at a0e7d36193b96f552073558acf5fcc1f10528917 but expected 0000000000000000000000000000000000000000
error: failed to lock junio-gpg-pub
error: Ref v0.99 is at d6602ec5194c87b0fc87103ca4d67251c76f233a but expected 0000000000000000000000000000000000000000
error: failed to lock v0.99
[...]

It appears that they are ending up in the wrong place:

apw@kernel:~/git/git$ ls .git
branches       v0.99.5   v0.99.9a  v1.0.0b  v1.0rc5  v1.3.0      v1.4.2.1
config         v0.99.6   v0.99.9b  v1.0.10  v1.0rc6  v1.3.0-rc1  v1.4.2.2
description    v0.99.7   v0.99.9c  v1.0.11  v1.1.0   v1.3.0-rc2  v1.4.2.3
HEAD           v0.99.7a  v0.99.9d  v1.0.12  v1.1.1   v1.3.0-rc3  v1.4.2.4
hooks          v0.99.7b  v0.99.9e  v1.0.13  v1.1.2   v1.3.0-rc4  v1.4.2-rc1
index          v0.99.7c  v0.99.9f  v1.0.3   v1.1.3   v1.3.1      v1.4.2-rc2
info           v0.99.7d  v0.99.9g  v1.0.4   v1.1.4   v1.3.2      v1.4.2-rc3
junio-gpg-pub  v0.99.8   v0.99.9h  v1.0.5   v1.1.5   v1.3.3      v1.4.2-rc4
logs           v0.99.8a  v0.99.9i  v1.0.6   v1.1.6   v1.4.0      v1.4.3
objects        v0.99.8b  v0.99.9j  v1.0.7   v1.2.0   v1.4.0-rc1  v1.4.3.1
refs           v0.99.8c  v0.99.9k  v1.0.8   v1.2.1   v1.4.0-rc2  v1.4.3.2
v0.99          v0.99.8d  v0.99.9l  v1.0.9   v1.2.2   v1.4.1      v1.4.3-rc1
v0.99.1        v0.99.8e  v0.99.9m  v1.0rc1  v1.2.3   v1.4.1.1    v1.4.3-rc2
v0.99.2        v0.99.8f  v0.99.9n  v1.0rc2  v1.2.4   v1.4.1-rc1  v1.4.3-rc3
v0.99.3        v0.99.8g  v1.0.0    v1.0rc3  v1.2.5   v1.4.1-rc2
v0.99.4        v0.99.9   v1.0.0a   v1.0rc4  v1.2.6   v1.4.2

-apw
