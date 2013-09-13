From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] name-hash: refactor polymorphic index_name_exists()
Date: Fri, 13 Sep 2013 17:44:43 -0400
Message-ID: <CAPig+cS4x1h3v2=0T95+g2_08_7qZj7fUsSiLgDtFyRSbFE0bA@mail.gmail.com>
References: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
	<1379070943-36595-2-git-send-email-sunshine@sunshineco.com>
	<xmqq38p8k1kf.fsf@gitster.dls.corp.google.com>
	<CAPig+cQxvHPbxy9YE7qYTVEXy1JCXkmBi48QrkL=bvhKRgryuQ@mail.gmail.com>
	<CAPc5daVtDByrA6yakk_1fq9g5Hv3naNDzEho5G4Ghxc6jzpawg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 23:44:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKbAX-0003Fy-Fd
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 23:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904Ab3IMVop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 17:44:45 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63229 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932Ab3IMVop (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 17:44:45 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so2507937lbh.19
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=L7PPZae3m96UJ3o4Nb87K2BWDzTEBxLqo7wLvidCApE=;
        b=saOk9bPXfgur+QKTVwdGdQ33Vj6cQDB9R6ph5gW0inR5mbLCRBHI0uqFu9C71+AAII
         etFvZe/IccDN8G79Bwi8QpRelVK4BdU5o9bAj/3OFiLN3ui5AcZOCfd3uqALpwB/QYgG
         eny/NflwfJnzNXYnSkMDGj1xceH735csXcjzPzU/LbAzsitXwBQsfInl1RewWKDgH4RZ
         8YIKuiNqQ4Qo4WQZoolVo2cQfh1y0BnSoUFkTcKOoDLSfczaqKHBR2SMPbQ5EU+nnhI4
         gf2IHyS/s+i4tPQUmR7Qg0l+SUTL/xD7dG7EEDTkDHRnksn6QU+xSuSuPJmQOitROaZp
         eOMw==
X-Received: by 10.112.72.229 with SMTP id g5mr13675634lbv.10.1379108683525;
 Fri, 13 Sep 2013 14:44:43 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Fri, 13 Sep 2013 14:44:43 -0700 (PDT)
In-Reply-To: <CAPc5daVtDByrA6yakk_1fq9g5Hv3naNDzEho5G4Ghxc6jzpawg@mail.gmail.com>
X-Google-Sender-Auth: UJ0gcQWVG3F4Z-e5ucs4O3uKbaQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234775>

On Fri, Sep 13, 2013 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Fri, Sep 13, 2013 at 12:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Fri, Sep 13, 2013 at 2:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>
>>>> Since these two modes of operations are disjoint and have no code in
>>>> common (one searches index_state.name_hash; the other dir_hash), they
>>>> can be represented more naturally as distinct functions: one to search
>>>> for a file, and one for a directory.
>>>
>>> Good thinking.  Thanks for working on this; I agree with the general
>>> direction this series is going.
>>>
>>> I however wonder if it would be a good idea to rename the other one
>>> to {cache|index}_file_exists(), and even keep the *_name_exists()
>>> variant that switches between the two based on the trailing slash,
>>> to avoid breaking other topics in flight that may have added new
>>> callsites to *_name_exists().  Otherwise the new callsites will feed
>>> a path with a trailing slash to *_name_exists() and get a false
>>> result, no?
>>
>> An assert("no trailing /") was added to index_name_exists() precisely
>> for the purpose of catching cases of code incorrectly calling
>> index_name_exists() to search for a directory. No existing code in
>> 'master' trips the assertion (at least according to the tests),
>> however, the assertion may be annoying for topics in flight which do.
>>
>> Other than plopping these patches atop 'pu' and seeing if anything
>> breaks, what would be the "git way" of detecting in-flight topics
>> which add callers of index_name_exists()? (Excuse my git ignorance.)
>
> I would do a quick
>
> $ git diff master..pu | grep '^+.*_name_exists'
>
> which would be more conservative (it would also show an invocation
> moved from one place to another).

There appear to be no topics in flight which add new
index_name_exists() callers (which is not to say that no new callers
will be introduced before this topic lands in 'master').

I also plopped the patches atop 'pu' and there are no new tests
failures on Linux or Mac OS X, so the series does not seem to break
anything in flight. (There are a few test failures on 'pu' on Mac OS
X, but they are not related to this series.)

Given the above. How should I proceed? Do you still feel that it is
advisable to keep an index_name_exists() around for compatibility
reasons in case any new callers are introduced? Regardless of that
answer, do you want index_name_exists() renamed to
index_file_exists()?
