From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] pack-objects: do not get distracted by broken symrefs
Date: Wed, 07 Oct 2015 10:45:18 -0700
Message-ID: <xmqq8u7evahd.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
	<cover.1444139796.git.johannes.schindelin@gmx.de>
	<f04229b0881eb7518a306ae07fe11ffc9589b1f1.1444139796.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 07 19:45:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjsmZ-0004pK-1b
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 19:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbbJGRpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 13:45:21 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35808 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbbJGRpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 13:45:19 -0400
Received: by pacfv12 with SMTP id fv12so28044455pac.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=W6U0FP7J+2a8V6+0fjiyLXBHDaR24AdZHV//wheCGUY=;
        b=PYUprlxeFbsHbnvKVXRUXUqUEXnjvv41FOMhyqGQGEBe8qqIDWxQpNFM7vZTqv2cTP
         T2BdZdnD1jP80gIdTegJoO7LuXSriglGSjwRmLTTH3kStbkZTgOrlWG7OpygEYnR59lR
         xOWqS/k2D8QkCcBvUaDXcaWRPOttOTNkOk9zFOFFxNFWryNlZtaAkS0VhWlBBRwIiDhd
         uNCmGlIlx6Hwg0gx34eor3NQ1MCLnxphbHKhna3SqzrHU/Cb1thJdTfk6YDCpj9CY0VQ
         XuKLi1JJgjO+PJm/4y9tvzifANoZWM5yKUD87gGKFoYfrp4cNuQzq61qy/eDZsxZTPxG
         SzaQ==
X-Received: by 10.68.69.40 with SMTP id b8mr2501667pbu.84.1444239919447;
        Wed, 07 Oct 2015 10:45:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c434:fdeb:15ec:325c])
        by smtp.gmail.com with ESMTPSA id tk4sm40919992pab.45.2015.10.07.10.45.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 10:45:18 -0700 (PDT)
In-Reply-To: <f04229b0881eb7518a306ae07fe11ffc9589b1f1.1444139796.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 06 Oct 2015 15:59:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279188>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is quite possible for, say, a remote HEAD to become broken, e.g.
> when the default branch was renamed.
>
> We should still be able to pack our objects when such a thing happens;
> simply ignore broken symrefs (because they cannot matter for the packing
> process anyway).
>
> This fixes https://github.com/git-for-windows/git/issues/423
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

It seems that the result of applying these two patches and log
messages of them are the same with what I queued on 'pu', except
that the first of these two patches adds a test with a wrong name
and then this one does "oops, that was misnamed".  So I'll keep what
is already queued.

Thanks.

>  reachable.c   | 8 +++++++-
>  t/t6500-gc.sh | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/reachable.c b/reachable.c
> index 9cff25b..43616d4 100644
> --- a/reachable.c
> +++ b/reachable.c
> @@ -25,9 +25,15 @@ static void update_progress(struct connectivity_progress *cp)
>  static int add_one_ref(const char *path, const struct object_id *oid,
>  		       int flag, void *cb_data)
>  {
> -	struct object *object = parse_object_or_die(oid->hash, path);
>  	struct rev_info *revs = (struct rev_info *)cb_data;
> +	struct object *object;
>  
> +	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
> +		warning("symbolic ref is dangling: %s", path);
> +		return 0;
> +	}
> +
> +	object = parse_object_or_die(oid->hash, path);
>  	add_pending_object(revs, object, "");
>  
>  	return 0;
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 9a3a285..5d7d414 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -30,7 +30,7 @@ test_expect_success 'gc -h with invalid configuration' '
>  	test_i18ngrep "[Uu]sage" broken/usage
>  '
>  
> -test_expect_failure 'gc removes broken refs/remotes/<name>/HEAD' '
> +test_expect_success 'gc is not aborted due to a stale symref' '
>  	git init remote &&
>  	(
>  		cd remote &&
