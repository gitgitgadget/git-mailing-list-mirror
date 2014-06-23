From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/16] refactor skip_prefix to return a boolean
Date: Mon, 23 Jun 2014 11:50:06 -0700
Message-ID: <xmqq1tufcvfl.fsf@gitster.dls.corp.google.com>
References: <20140618194117.GA22269@sigill.intra.peff.net>
	<20140618194417.GD22622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 20:50:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz9K0-0002BR-AL
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 20:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072AbaFWSuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 14:50:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60624 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924AbaFWSuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 14:50:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8CEFE22828;
	Mon, 23 Jun 2014 14:50:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gjKs9EpKvVYepDMhtyxfOs2ZUmU=; b=mvdCkg
	5t102M+72XiCKCDGsYJN5bCKcsRNyjvspAIFyaiPxgKLgqssphecrw0xxw8SaYhM
	3y9Swi1CVM8EexLYfKRpFbiqFCzMqt6TDy9tL1rYLSntiwtSn92U3rIZOgh6BuIB
	UphXSoohCEuRbbu2brUSfOzUkoHlCxurJ4Qgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HJtQUHhtBSPTStRP47gCfXrYNbKjTLdZ
	ltt/JFPYacgzwrnKlNv4Oj1yby4iZsRRtNsi6VA6dlScHzQcvLD6f2SCI6m9wmCl
	4rrPH2xawC/UGxM6xnd86iQyQFOz3t2pOQtLulC6Co/XdwQVqxPHvnzh1VikE23o
	e8WwR525/ss=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7AC7622826;
	Mon, 23 Jun 2014 14:50:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D5EB22821;
	Mon, 23 Jun 2014 14:50:06 -0400 (EDT)
In-Reply-To: <20140618194417.GD22622@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Jun 2014 15:44:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 317C8800-FB07-11E3-A83A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252364>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index b12989d..a5b2d9d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -703,9 +703,12 @@ static void write_refspec_config(const char* src_ref_prefix,
>  					strbuf_addf(&value, "+%s:%s%s", our_head_points_at->name,
>  						branch_top->buf, option_branch);
>  			} else if (remote_head_points_at) {
> +				const char *head = remote_head_points_at->name;
> +				if (!skip_prefix(head, "refs/heads/", &head))
> +					die("BUG: remote HEAD points at non-head?");
> +
>  				strbuf_addf(&value, "+%s:%s%s", remote_head_points_at->name,
> -						branch_top->buf,
> -						skip_prefix(remote_head_points_at->name, "refs/heads/"));
> +						branch_top->buf, head);
>  			}
>  			/*
>  			 * otherwise, the next "git fetch" will

I was re-reading this and noticed another possible bug.

 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b12989d..df659dd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -696,7 +696,7 @@ static void write_refspec_config(const char* src_ref_prefix,
 	if (option_mirror || !option_bare) {
 		if (option_single_branch && !option_mirror) {
 			if (option_branch) {
-				if (strstr(our_head_points_at->name, "refs/tags/"))
+				if (starts_with(our_head_points_at->name, "refs/tags/"))
 					strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
 						our_head_points_at->name);
 				else

Because the pattern is not anchored to the left with a slash, it is
clear that the original cannot even claim that it was trying to
munge "foo/refs/tags/" as well.

Which means this is trivially correct, but at the same time I wonder
what it means for our-head to point at a ref in refs/tags/ hierarchy.
