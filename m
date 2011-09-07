From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Re* Git without morning coffee
Date: Wed, 07 Sep 2011 20:25:47 +0200
Message-ID: <4E67B72B.4090504@drmicha.warpmail.net>
References: <4E6721E3.7000207@drmicha.warpmail.net> <7vehzs47we.fsf@alter.siamese.dyndns.org> <7v62l445nw.fsf@alter.siamese.dyndns.org> <7vty8o2p7g.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 20:26:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Mow-00082I-2X
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 20:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411Ab1IGSZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 14:25:52 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:50488 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756343Ab1IGSZv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 14:25:51 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9ECBD2A154;
	Wed,  7 Sep 2011 14:25:49 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 07 Sep 2011 14:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=dz+I0IuAYXB7GhO5VNfA6/
	4ahsA=; b=gkr05Q2UfLZGl9Y6MmTCd/4KDcTDY/t+OY20imwMi5E5yqo3i1HOML
	mhzC0NRpUac3EBoYIe8asPrYCmuUfVAg22OKqo8YZmnR7QU/kOt7s3s8LWW8e4hN
	Cl3ujPKWJ5MGXPikG0KJ0bnIFxJy2pem2iq92P4cmWMxTKgaR9Nbw=
X-Sasl-enc: Cu49xWMvU0kuvlMk54AIWIiMMff2mMzI/aLwnOl56/Bf 1315419949
Received: from localhost.localdomain (p548594B5.dip0.t-ipconnect.de [84.133.148.181])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E81FBB619E1;
	Wed,  7 Sep 2011 14:25:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vty8o2p7g.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180894>

Junio C Hamano venit, vidit, dixit 07.09.2011 20:16:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>
>>>> git merge ":/Merge branch 'jk/generation-numbers' into pu"
>>>> fatal: ':/Merge branch 'jk/generation-numbers' into pu' does not point
>>>> to a commit
>>>> # Huh?
>>>
>>> Interesting.
>>
>> This is because 1c7b76b (Build in merge, 2008-07-07) grabs the name of the
>> commit to be merged using peel_to_type(), which was defined in 8177631
>> (expose a helper function peel_to_type()., 2007-12-24) in terms of
>> get_sha1_1(). It understands $commit~$n, $commit^$n and $ref@{$nth}, but
>> does not understand :/$str, $treeish:$path, and :$stage:$path.
> 
> -- >8 --
> Subject: Allow git merge ":/<pattern>"
> 
> It probably is not such a good idea to use ":/<pattern>" to specify which
> commit to merge, as ":/<pattern>" can often hit unexpected commits, but
> somebody tried it and got a nonsense error message:
> 
> 	fatal: ':/Foo bar' does not point to a commit
> 
> So here is a for-the-sake-of-consistency update that is fairly useless
> that allows users to carefully try not shooting in the foot.

Shooting in the foot can be a good thing, depending on the feet...

My concern is: If a command expects a commit(tish), a user expects to be
able to specify it in any way which git rev-parse can parse. I had no
idea we distinguish even further then what the command itself requires
("branch" needs a branch refname, diff-tree a treeish etc.).

So, for systematic reasons I think the below is an improvement.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/merge.c |   19 ++++++++++++++-----
>  sha1_name.c     |    6 ------
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index ab4077f..ee56974 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -403,6 +403,16 @@ static void finish(const unsigned char *new_head, const char *msg)
>  	strbuf_release(&reflog_message);
>  }
>  
> +static struct object *want_commit(const char *name)
> +{
> +	struct object *obj;
> +	unsigned char sha1[20];
> +	if (get_sha1(name, sha1))
> +		return NULL;
> +	obj = parse_object(sha1);
> +	return peel_to_type(name, 0, obj, OBJ_COMMIT);
> +}
> +
>  /* Get the name for the merge commit's message. */
>  static void merge_name(const char *remote, struct strbuf *msg)
>  {
> @@ -418,7 +428,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
>  	remote = bname.buf;
>  
>  	memset(branch_head, 0, sizeof(branch_head));
> -	remote_head = peel_to_type(remote, 0, NULL, OBJ_COMMIT);
> +	remote_head = want_commit(remote);
>  	if (!remote_head)
>  		die(_("'%s' does not point to a commit"), remote);
>  
> @@ -1124,7 +1134,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		if (!allow_fast_forward)
>  			die(_("Non-fast-forward commit does not make sense into "
>  			    "an empty head"));
> -		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
> +		remote_head = want_commit(argv[0]);
>  		if (!remote_head)
>  			die(_("%s - not something we can merge"), argv[0]);
>  		read_empty(remote_head->sha1, 0);
> @@ -1170,7 +1180,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		struct object *o;
>  		struct commit *commit;
>  
> -		o = peel_to_type(argv[i], 0, NULL, OBJ_COMMIT);
> +		o = want_commit(argv[i]);
>  		if (!o)
>  			die(_("%s - not something we can merge"), argv[i]);
>  		commit = lookup_commit(o->sha1);
> @@ -1238,8 +1248,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		if (have_message)
>  			strbuf_addstr(&msg,
>  				" (no commit created; -m option ignored)");
> -		o = peel_to_type(sha1_to_hex(remoteheads->item->object.sha1),
> -			0, NULL, OBJ_COMMIT);
> +		o = want_commit(sha1_to_hex(remoteheads->item->object.sha1));
>  		if (!o)
>  			return 1;
>  
> diff --git a/sha1_name.c b/sha1_name.c
> index ff5992a..653b065 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -501,12 +501,6 @@ struct object *peel_to_type(const char *name, int namelen,
>  {
>  	if (name && !namelen)
>  		namelen = strlen(name);
> -	if (!o) {
> -		unsigned char sha1[20];
> -		if (get_sha1_1(name, namelen, sha1))
> -			return NULL;
> -		o = parse_object(sha1);
> -	}
>  	while (1) {
>  		if (!o || (!o->parsed && !parse_object(o->sha1)))
>  			return NULL;
