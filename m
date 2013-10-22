From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: unquote C-style paths when exporting
Date: Tue, 22 Oct 2013 22:49:23 +0200
Message-ID: <CALWbr2zsOYNN45d+qHDQ88eLj82iV4QxJ_9ro+RGk7upBJVATA@mail.gmail.com>
References: <1382115821-12586-1-git-send-email-apelisse@gmail.com>
	<xmqq4n89t8yw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 22:49:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYitN-0000Y7-Hf
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 22:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140Ab3JVUt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 16:49:26 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:45495 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093Ab3JVUtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 16:49:25 -0400
Received: by mail-lb0-f177.google.com with SMTP id u14so15348lbd.22
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7ETrpVeiSV/CvLjChIQKNXOIIgEiKgUsZbZoQCFNxZU=;
        b=mO0Mep7gV97K5yHUOe4OWXx7FsCFbEQYHR3wVDIHIQramiarR6vq5q/l2SL3JbaxBI
         Y5PFgCQlROPS4RdWAmZH5r+q19oaIp+rrfJ/QKv2sc+++1CIKKKni255UVGwjijxEAGl
         cItrRmIGELJ9tL02maJ4BSjFlGa/unGOHsuUripnCZdqssLGjT4so7KswkfBA1O1zIfN
         NPffNwVzm75fB730exFbt2tFgCkvxf+MWgFz50pm7Bw6HmYjsnnPm9OEcocpctsOZWoy
         OYfLqqRfoofsb91d4V8lFrb6bn3JqFHQRXHnwbA97hd2v4IWaipAQ4t7V8+29G8x7+GI
         LrwA==
X-Received: by 10.152.29.38 with SMTP id g6mr13638258lah.25.1382474963266;
 Tue, 22 Oct 2013 13:49:23 -0700 (PDT)
Received: by 10.112.50.240 with HTTP; Tue, 22 Oct 2013 13:49:23 -0700 (PDT)
In-Reply-To: <xmqq4n89t8yw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236490>

On Tue, Oct 22, 2013 at 9:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> git-fast-import documentation says that paths can be C-style quoted.
>> Unfortunately, the current remote-hg helper doesn't unquote quoted
>> path and pass them as-is to Mercurial when the commit is created.
>>
>> This result in the following situation:
>>
>> - clone a mercurial repository with git
>> - Add a file with space: `mkdir dir/foo\ bar`

Note to myself, mkdir doesn't create a "file"

>> - Commit that new file, and push the change to mercurial
>> - The mercurial repository as now a new directory named '"dir', which
>> contains a file named 'foo bar"'
>>
>> Use python ast.literal_eval to unquote the string if it starts with ".
>> It has been tested with quotes, spaces, and utf-8 encoded file-names.
>>
>> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
>> ---
>
> A path you read in fast-import input indeed needs to be unquoted
> when it begins with a dq, and I _think_ by using ast.literal_eval(),
> you probably can correctly unquote any valid C-quoted string.
>
> But it bothers me somewhat that what the patch does seems to be
> overly broad.  Doesn't ast.literal_eval() take a lot more than just
> strings?

Good point

>     ast.literal_eval(node_or_string)
>
>         Safely evaluate an expression node or a Unicode or Latin-1
>         encoded string containing a Python expression. The string or
>         node provided may only consist of the following Python literal
>         structures: strings, numbers, tuples, lists, dicts, booleans,
>         and None.

Fortunately, I don't believe any of the other type can start with a
dq. So currently, I don't believe we can end-up with anything else but
a string. We could certainly check that this is always true though.

> Also doesn't Python's double-quoted string have a lot more magic
> than C-quoted string, e.g.
>
>         $ python -i
>         >>> import ast
>         >>> not_cq_path = '"abc" "def"'
>         >>> ast.literal_eval(not_cq_path)
>         'abcdef'

It is true that I have expected "valid output" from git-fast-export.
And I don't have in mind any easy solution to detect that the output
is broken, yet still accepted as a valid string by python. We could
obviously write a unquote_c_style() equivalent in python if needed.

Thanks,
