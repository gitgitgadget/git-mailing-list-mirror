From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] am: do not corrupt the index stat state
Date: Fri, 21 Aug 2015 09:37:22 -0700
Message-ID: <xmqqk2so7g3h.fsf@gitster.dls.corp.google.com>
References: <1440144151-24026-1-git-send-email-davvid@gmail.com>
	<1440144151-24026-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 18:37:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSpJq-0003Dt-57
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 18:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbbHUQhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 12:37:25 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33175 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbbHUQhY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 12:37:24 -0400
Received: by pdrh1 with SMTP id h1so28821835pdr.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bdiUUQj2MmWI1e9XwyqkrNtMQt4YHKUTdOFcKf4N9bM=;
        b=pbC1sD9V8nZDX0+OQxzACiQhdrPIUoBgpZO0IKYxyPRlupEcKs49/ykokl8nIrlvbc
         Fxflxom+ZCvYGdDBSDUN6Kvwyul9UvfA6kFpsacnal4PsTvcUwBUxGyG0z5UTwhkPBzA
         5tF3HjH4tAfw0IJqsuQY2BHIqO4qdd50qRaXBwAdzVnKvteKs3pP/7U2xLt/uOk65prC
         FLEoCqg9QSXPLamAeNJsEBwdCiRpi3DRfaVLTzZAL+4mcXa0Hzg3LUWRLDXVh6iSdlBu
         bLE3ygHrqUFCa8b9yXA3q3+u9uZXQuOPI0YF1nkvQRYI1LXoVZc7bVGIpc/8SyJQM5MN
         KRhQ==
X-Received: by 10.70.103.10 with SMTP id fs10mr18676618pdb.166.1440175044188;
        Fri, 21 Aug 2015 09:37:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id s17sm8403802pdl.2.2015.08.21.09.37.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 09:37:23 -0700 (PDT)
In-Reply-To: <1440144151-24026-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Fri, 21 Aug 2015 01:02:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276310>

David Aguilar <davvid@gmail.com> writes:

> Reported-by: Linus Torvalds
> Signed-off-by: David Aguilar <davvid@gmail.com>
> @@ -1975,10 +1977,20 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
>  
>  	memset(&pathspec, 0, sizeof(pathspec));
>  
> +	memset(&opts, 0, sizeof(opts));
> +	opts.fn = oneway_merge;
> +	opts.pathspec = &pathspec;
> +	opts.src_index = &the_index;
> +	opts.dst_index = &the_index;
> +	opts.head_idx = 1;
> +	opts.merge = 1;
> +	opts.reset = 1;
> +	init_tree_desc(&desc, remote_tree->buffer, remote_tree->size);
> +
>  	lock_file = xcalloc(1, sizeof(struct lock_file));
>  	hold_locked_index(lock_file, 1);
>  
> -	if (read_tree(remote_tree, 0, &pathspec)) {
> +	if (unpack_trees(1, &desc, &opts)) {

I think the same fix was done in 3ecc7040 (am --skip/--abort: merge
HEAD/ORIG_HEAD tree into index, 2015-08-19).
