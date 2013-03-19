From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 0/8] Improve git-status --ignored
Date: Tue, 19 Mar 2013 11:48:18 +0100
Message-ID: <51484272.5070003@gmail.com>
References: <514778E4.1040607@gmail.com> <7vsj3skp5b.fsf@alter.siamese.dyndns.org> <CACsJy8DShce6bXfyWyHk7pqg4PA-cAn1bKh0hgFYX=s486nwaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:48:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHu63-0004yh-L7
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897Ab3CSKsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 06:48:21 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:53490 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3CSKsU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:48:20 -0400
Received: by mail-ee0-f53.google.com with SMTP id e53so150752eek.26
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=1Ngs4TfSLQE5NLDTOWg8b9X4WmZqbmBWzjeePySuMLs=;
        b=s3X1l3E/9cZyUMANyyJEB6WppvXZAZGJ+seKY44UWKA7KEtxFSQxA0HWorcAyJKt59
         2EwfjxpYMOylyPlMGrQAdwsZsci/tU/B/cfvRdZiGbsw66GC+01dwxU3T0S7toy+vtI/
         n8IyDA/scWOI7YzNeEoUfMbXhfolp+VC0Pj3upltd7i20M2WsEPdzqrHQOChGUU2TZ2F
         iuh/YCizxGYXM4/r0pwxiHxrrUP0yWwVJSSDEROvN3vX5kQru8frmLeM8aYj4L/mSHxi
         2zhmZFOqkju2juRMmB9G6Iqv6L+c68UYiKlW1xPcTxPKCpUBNU4K0hbcjL5giRJEyhpy
         BmHQ==
X-Received: by 10.14.173.196 with SMTP id v44mr58851402eel.29.1363690098762;
        Tue, 19 Mar 2013 03:48:18 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id ca4sm32292901eeb.15.2013.03.19.03.48.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 03:48:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CACsJy8DShce6bXfyWyHk7pqg4PA-cAn1bKh0hgFYX=s486nwaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218502>

Am 19.03.2013 06:20, schrieb Duy Nguyen:
> On Tue, Mar 19, 2013 at 11:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karsten Blees <karsten.blees@gmail.com> writes:
>>
>>> This patch series addresses several bugs and performance issues in
>>> .gitignore processing that came up in the inotify discussion.
>>
>> Thanks.
>>
>> How does this interact with the nd/read-directory-recursive-optim
>> topic that has been cooking for a while?
> 
> I think 8/8 is another version of nd/read-directory-recursive-optim
> 

Yes. When reviewing Duy's patch, I wondered why we would need all those special cases (or: why is treat_file so damn complicated). It turned out that it gets much simpler after fixing some bugs and eliminating the is_excluded / is_path_excluded discrepancy. This variant also optimizes git-status --ignored.

I tried to express my ideas here [1], but I guess this was a bit unstructured, sorry :-)

Note that we could skip excluded checks for tracked directories as well if it weren't for the current notion of ignored tracked directories.

I'd still like to eliminate the second directory scan in git-status --ignored (i.e. don't call fill_directory twice, which would save ~50ms for linux and ~300ms for WebKit), but that's a bit more involved...

[1] http://thread.gmane.org/gmane.comp.version-control.git/217111
