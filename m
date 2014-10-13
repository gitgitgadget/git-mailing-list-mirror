From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] t5304: use helper to report failure of "test foo =
 bar"
Date: Mon, 13 Oct 2014 09:10:22 -0700
Message-ID: <20141013161022.GA20520@google.com>
References: <20141010060636.GA15057@peff.net>
 <20141010061114.GB15277@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 18:10:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdiCg-0003ah-Dc
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 18:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387AbaJMQKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 12:10:30 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:51881 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbaJMQK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 12:10:29 -0400
Received: by mail-pa0-f44.google.com with SMTP id et14so6090438pad.17
        for <git@vger.kernel.org>; Mon, 13 Oct 2014 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UYRjIaWeq5LbJUBp+GPwzr7TmuhAZaj739NjmG/ElbE=;
        b=qR5st+mRsif/dC1HDpiTkS33vPzndcqYUcXgLOYKoMHoZWGlSgt8tQ/C6arJdDnsZX
         4t9DeJdZi1PkcSoqXbXvYlMIf700D7p2QzCLEPB1u7r+IW+4ben93bsix+jshJg8ylZ8
         h15Vc/gGE/U79nIEiq3vc++3IhvLwJ2CVHg2zNs0qDUK+Hycdr1hUI1733g9aGgCJxZj
         +rJiR3zo7pHTTK2H+wVwkCWHk9P/fVrhsMTX1RTdLaNJvfYie/JJEAD99beWc/POQYo3
         DHVF7RJy5BLW9iAXE6mlRZgbIETfaTqIk7AEfzV3eYghlfxb3/n4uI1yZDEgm9bQE5mZ
         BLSA==
X-Received: by 10.66.193.4 with SMTP id hk4mr24478535pac.12.1413216629345;
        Mon, 13 Oct 2014 09:10:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:8888:f50:ddbf:ae59])
        by mx.google.com with ESMTPSA id e4sm2902564pdp.37.2014.10.13.09.10.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Oct 2014 09:10:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141010061114.GB15277@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> For small outputs, we sometimes use:
>
>   test "$(some_cmd)" = "something we expect"
>
> instead of a full test_cmp. The downside of this is that
> when it fails, there is no output at all from the script.

There's another downside to that construct: it loses the exit
status from some_cmd.

[...]
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -13,7 +13,7 @@ add_blob() {
>  	before=$(git count-objects | sed "s/ .*//") &&
>  	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
>  	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
> -	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
> +	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&

So ideally this would be something like:

	git count-objects >output &&
	verbose test "$((1 + $before))" = "$(sed "s/ .*//" output)" &&

[...]
> @@ -45,11 +45,11 @@ test_expect_success 'prune --expire' '
>  
>  	add_blob &&
>  	git prune --expire=1.hour.ago &&
> -	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
> +	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&

and likewise elsewhere in the file.

Alternatively, maybe there could be a helper in the same spirit as
test_cmp_rev?

	test_object_count () {
		git count-objects >output &&
		sed "s/ .*//" output >count &&
		printf "%s\n" "$1" >expect &&
		test_cmp expect count
	}

My two cents,
Jonathan
