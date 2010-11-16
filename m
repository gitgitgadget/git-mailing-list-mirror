From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] [RFC] Detect attempts at calling git init specifying
 a remote repository.
Date: Tue, 16 Nov 2010 09:57:13 -0800
Message-ID: <7vfwv1i22u.fsf@alter.siamese.dyndns.org>
References: <cover.1289561504.git.peter@softwolves.pp.se>
 <3f7d07a2b3a02c1d3f864d2a17f3b8808890a4d1.1289561504.git.peter@softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Nov 16 18:57:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIPmY-0004wQ-U7
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 18:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996Ab0KPR5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 12:57:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab0KPR5V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 12:57:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B840C3F07;
	Tue, 16 Nov 2010 12:57:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=stnB9GuPsd+aRlj6lMxQ/xc/uK8=; b=wqGD6q
	av/E39tCBVpRBNFaIpQQPrEbR4IYntwSMP/mWUshIPYi77Hk3wZNvAohHNcFehZG
	6F4Zhqd9s0Xo5R/S30/kj9wXM6udqHCwBjU6LfpB6mJEo5d3iocdzaJTXd5QS66v
	yiKy1NM9wKSzEPGjJEOEZ2N3tKQOcbULtOPO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F0rtVovIIARDK64buzW6LpQzeYQqY0qp
	qHkS2a2IJYaEBRY8v8SnrRmImInFzQmdtLwI2LyOcrlOTsdrvGkFTwZLnfj7Xbc1
	1fF7zacIb78RWD4WJIWJZR40lCDNz0BmWtOnif7dFWvMOoxN9SO4sL0PRlyYs+bj
	uwrVB0hK2rs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 96F273F06;
	Tue, 16 Nov 2010 12:57:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7EA973F02; Tue, 16 Nov 2010
 12:57:25 -0500 (EST)
In-Reply-To: <3f7d07a2b3a02c1d3f864d2a17f3b8808890a4d1.1289561504.git.peter@softwolves.pp.se> (Peter Krefting's message of "Fri\, 12 Nov 2010 12\:27\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FA03E986-F1AA-11DF-B08B-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161570>

Peter Krefting <peter@softwolves.pp.se> writes:

> We can only initialize local repositories, so bail out immediately if the
> user tries to specify a remote repository.
> ---
>  builtin/init-db.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 9d4886c..f80ff08 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -435,7 +435,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		int mkdir_tried = 0;
>  	retry:
>  		if (chdir(argv[0]) < 0) {
> -			if (!mkdir_tried) {
> +			if (is_url(argv[0]) || strchr(argv[0], '@') != NULL || (strchr(argv[0], ':') != NULL && !has_dos_drive_prefix(argv[0]))) {
> +				/*
> +				 * We were passed a remote repository specification.

Or a directory with ':' in its pathname, no?
