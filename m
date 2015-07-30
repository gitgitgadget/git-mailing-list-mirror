From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] clone: fix hostname parsing when guessing dir
Date: Thu, 30 Jul 2015 09:30:05 -0700
Message-ID: <xmqqk2th7gmq.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438185076-28870-1-git-send-email-ps@pks.im>
	<1438185076-28870-6-git-send-email-ps@pks.im>
	<xmqq7fpiamiq.fsf@gitster.dls.corp.google.com>
	<20150730121811.GA24635@pks-pc.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Thu Jul 30 18:30:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKqim-0002ks-7L
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 18:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbbG3QaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 12:30:09 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33835 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbbG3QaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 12:30:07 -0400
Received: by pachj5 with SMTP id hj5so2206423pac.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mxHr9mq2rKfwi3JRvqRXe5ix12su/xpw1DyupKvowhc=;
        b=If/HBXwww+8AryjQ1fC7LTC/KZjOWLiaAofkumHyGYCbmWKXUFvggvFnIoIVBX+W05
         FA+xPr1SWo4BwjhxUV/0i5f61r7MmWyqPsV02lWrUh3lSvSODuX4fIEQm7pAi5Z6yiPW
         Cy6CkPDsZBLDh9ZRR/fVKP8639jJzJpscEYRHZttI0rAFHVd0Vc03q4BB+8a+yET2vTn
         vhQkvGwJ1aQuzPSq2fDzSSjpkCinvUjlQ88QEml6hFMmTqs1/++/hOUNmIftjKq9RK/m
         uV6cysbQtCXO27D5pxVpS8EpfpBkZdbA0B9nbKUdUG243H2vkXzoxsEL8VwbxZVlg2yv
         Gl3Q==
X-Received: by 10.66.62.229 with SMTP id b5mr106306996pas.81.1438273807414;
        Thu, 30 Jul 2015 09:30:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:106d:d8d6:d21e:17fe])
        by smtp.gmail.com with ESMTPSA id kk6sm2966992pdb.94.2015.07.30.09.30.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jul 2015 09:30:06 -0700 (PDT)
In-Reply-To: <20150730121811.GA24635@pks-pc.localdomain> (Patrick Steinhardt's
	message of "Thu, 30 Jul 2015 14:18:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275019>

Patrick Steinhardt <ps@pks.im> writes:

>> Regardless of the issue you are trying to address, we may want to
>> limit that "be prepared for and careful with ':'" logic in the
>> existing code to the case where the "last component" does not have
>> any other component before it.  That is:
>> 
>> 	http://example.com/foo:bar.git/
>> 
>> would be stripped to
>> 
>> 	http://example.com/foo:bar
>> 
>> and then we scan backwards for ':' or '/' and declare that "bar" is
>> the name of the repository, but we would probably want "foo:bar"
>> instead (or we may not, as some filesystems do not want to have a
>> colon in its path components).
>
> This case is exactly why I did include patches 3 and 4.

Well, but there is the above "or we may not" ;-)

> But actually you are right, currently I still have the old logic
> in place that splits on colons in the path component. 

Yes.  The reason why I suggested the simple route was exactly
because I noticed that you didn't seem to care about the above
"$site/foo:bar.git/" => "$site/foo:bar" => "bar" transform.

And I think people might depend on that behaviour.  "Fixing" that
may even be seen as a regression.

When was the last time you created a foo@bar.git repository?  Is it
really worth the code churn to do patches 3/4?
