From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] name-hash: refactor polymorphic index_name_exists()
Date: Fri, 13 Sep 2013 15:29:20 -0400
Message-ID: <CAPig+cQxvHPbxy9YE7qYTVEXy1JCXkmBi48QrkL=bvhKRgryuQ@mail.gmail.com>
References: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
	<1379070943-36595-2-git-send-email-sunshine@sunshineco.com>
	<xmqq38p8k1kf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 21:29:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKZ3Z-0006dB-32
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 21:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821Ab3IMT3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 15:29:23 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:41590 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab3IMT3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 15:29:22 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so1404396lab.30
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=to7dVya3ErtD8M50zhbEoaxo8FDchcLEFE7UCm5EyeU=;
        b=WRQfYZh2RHW40WbctXjVk7pLrCRlUMbYupAsrNV7L9V2Y6YuAqRe0sz5sEvvqzefoV
         xhK+L7JAOmFvcT4TU9JvtnBJTCVDXDL1cIwhGnm31bGmR2rnCNTghKDjifNT4ESfo8EI
         rWcrkVy9ejg33TfTdPk7EonvA+8GmhW8r5r0cmCcAjcxdRWbZ2F3/Lnep/kPQN7G1qAV
         fWdK1VqaKwi4ulS/xDO0oEr8EMCLjTXSMK1CMVmI3ThO1nyUmZ7te5sMWT5IpGP7m7wX
         I3ydSYrX2iyhRHJb8424qoM5ikZ6+adQYGx2DxJC8yxt20JrCnBfPhSvm9Fu9eT0peJj
         QWRQ==
X-Received: by 10.152.3.42 with SMTP id 10mr12429036laz.22.1379100560886; Fri,
 13 Sep 2013 12:29:20 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Fri, 13 Sep 2013 12:29:20 -0700 (PDT)
In-Reply-To: <xmqq38p8k1kf.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: WJAil7J3b7ewKgY5wqw8SlGYibc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234762>

On Fri, Sep 13, 2013 at 2:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Depending upon the absence or presence of a trailing '/' on the incoming
>> pathname, index_name_exists() checks either if a file is present in the
>> index or if a directory is represented within the index.  Each caller
>> explicitly chooses the mode of operation by adding or removing a
>> trailing '/' before invoking index_name_exists().
>>
>> Since these two modes of operations are disjoint and have no code in
>> common (one searches index_state.name_hash; the other dir_hash), they
>> can be represented more naturally as distinct functions: one to search
>> for a file, and one for a directory.
>>
>> Splitting index searching into two functions relieves callers of the
>> artificial burden of having to add or remove a slash to select the mode
>> of operation; instead they just call the desired function. A subsequent
>> patch will take advantage of this benefit in order to eliminate the
>> requirement that the incoming pathname for a directory search must have
>> a trailing slash.
>
> Good thinking.  Thanks for working on this; I agree with the general
> direction this series is going.
>
> I however wonder if it would be a good idea to rename the other one
> to {cache|index}_file_exists(), and even keep the *_name_exists()
> variant that switches between the two based on the trailing slash,
> to avoid breaking other topics in flight that may have added new
> callsites to *_name_exists().  Otherwise the new callsites will feed
> a path with a trailing slash to *_name_exists() and get a false
> result, no?

An assert("no trailing /") was added to index_name_exists() precisely
for the purpose of catching cases of code incorrectly calling
index_name_exists() to search for a directory. No existing code in
'master' trips the assertion (at least according to the tests),
however, the assertion may be annoying for topics in flight which do.

Other than plopping these patches atop 'pu' and seeing if anything
breaks, what would be the "git way" of detecting in-flight topics
which add callers of index_name_exists()? (Excuse my git ignorance.)
