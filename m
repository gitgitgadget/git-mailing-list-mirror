From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 09/19] fsck: Handle multiple authors in commits specially
Date: Fri, 19 Jun 2015 13:16:22 -0700
Message-ID: <xmqqioaj78tl.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<eb82bbfc658e8af1db03f7197b38aaaec33fd4ad.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:16:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z62iD-0006ol-Iz
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbbFSUQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:16:25 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37825 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbbFSUQY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:16:24 -0400
Received: by igblr2 with SMTP id lr2so20637395igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sjlO8n9xe5l9cQ/ry38xxJICnzUKx/vnpz/+35CjsNc=;
        b=SZHRIzA1gOggIc5PRXgYRgaMo8wU4MQA8FHf/ymi0mA0pfV0kH1C0KQSvU9Uus6kBN
         eEzTXLJcyzhmQqwLTdelahujI0LnC8zHAIhFn8XXZtvsVRVhOFD296d1UOibiTRgeVcB
         lc+mOXiUv7EYSvMKgesrjVF7kvBqo+6it6wsduvDvM5LmJ+h0WoME8Bzit30+RmCpv7X
         ZqhPruxi2CysBhNfKBzGgEjZJYnGQWxdjZbukxWWAZdZt29ZwWfMTl7j33uO+eGG4jYQ
         njAuo6T0Njx1jKZGO7D3Hz7IeDKXUaup6qW+yXDa+rJa/8cbLGfrzW7UGffU79Ok3c1N
         13ew==
X-Received: by 10.107.130.101 with SMTP id e98mr22940438iod.38.1434744983741;
        Fri, 19 Jun 2015 13:16:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id d4sm2367669igl.1.2015.06.19.13.16.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 13:16:23 -0700 (PDT)
In-Reply-To: <eb82bbfc658e8af1db03f7197b38aaaec33fd4ad.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:34:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272194>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  	err = fsck_ident(&buffer, &commit->object, options);
>  	if (err)
>  		return err;
> +	while (skip_prefix(buffer, "author ", &buffer)) {
> +		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
> +		if (err)
> +			return err;
> +		err = fsck_ident(&buffer, &commit->object, options);
> +		if (err)
> +			return err;
> +	}

Hmph, naively I would have expected that you wouldn't need an
extra call to fsck_ident() here, and instead would see something
like this:

	author_count = 0;
	while (skip_prefix("author ")) {
        	author_count++;
                ... do the existing check as-is ...
	}
        if (author_count < 1)
        	err |= report(missing author);
	else if (author_count > 1)
        	err |= report(multiple authors);
