From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 03/14] upload-pack-2: Implement the version 2 of upload-pack
Date: Mon, 2 May 2016 10:51:36 -0700
Message-ID: <CAGZ79kavBUohoMcC3iEws5mVBQ6HZsR=HyBoxM1jxUVJ6Z1jkA@mail.gmail.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	<1461972887-22100-4-git-send-email-sbeller@google.com>
	<1462210997.4123.49.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 02 19:51:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axI0T-0005GQ-Q9
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693AbcEBRvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 13:51:38 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:32785 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678AbcEBRvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 13:51:37 -0400
Received: by mail-io0-f174.google.com with SMTP id f89so175004584ioi.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=25/3uREYnuvKI6ofJs2faXm/GW3itPh3BFlcF3RHiPQ=;
        b=ZDEoX8EKDZAwCWO52EQltfL+rnWKe7s7BS6RaBx2qKUfGiQ02pfoXBvkMRXwRR7SKK
         2fTzm7EHIOzx3dTi1LbXb04f2D5kCCzbsw74NORvzuTPrFAw+IpzOY9jqXS9CSsCxffp
         xinuqp72hBe9D04SvxAFUXrEMvPRFxCHdznRqTzeD6FyfWTnrxjn6W70TnzxdCJ0fSHP
         KouRr/HbSE/u7PJJjheFhrY0G3q+b444t940wthKriMv+/aipts44aQDILQ/Nga1Dbh1
         1lbW0qvG9KTMASb+8Cat0kBTa/rxx2s3Klc1jQSdaXOPaRwU/95vwCkvPxzXucYy9ZTH
         JOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=25/3uREYnuvKI6ofJs2faXm/GW3itPh3BFlcF3RHiPQ=;
        b=jbRo3XgleEqXOmqWBZ8HGuPXdcGDYZENdaGi/IL3RCPCu8g+X9fvTU7IRshi144nyW
         m8NosixeI6j+lRhJQTRHU3FQEDXpo5gifBitqRSx7QYQI8a+QRSD4+f2FKMlJek196Lv
         ElsMt659g9YUl31H3gaYLRQWQwQmKbd9xIaaqFSbyI/xfsymPLlQvrDhGW+vX0rb3Bg2
         2Ifb4/pglO4Wa285t4gkNrvy0aRt0hFObnJpCJiN+wv7X9g44BtSRsQldoJ4R/1UgKoW
         zVKsyuFUn8c88+sN3Fn0Tr/dHxhnUyz4bnTBnRKv0OTIv5D4ZRplvFyiDelFQg3LoTCb
         oFZg==
X-Gm-Message-State: AOPr4FUBhhD79vMrnn1QlszNdKYiQH3F0ahbQJZqQCs4XWI1LFeF991ATCut1db9Q5Mdwq5IM6+v+dJhJHUL87OG
X-Received: by 10.107.53.204 with SMTP id k73mr5893719ioo.174.1462211496266;
 Mon, 02 May 2016 10:51:36 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 2 May 2016 10:51:36 -0700 (PDT)
In-Reply-To: <1462210997.4123.49.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293251>

On Mon, May 2, 2016 at 10:43 AM, David Turner <dturner@twopensource.com> wrote:
> On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
>> In upload-pack-2 we send each capability in its own packet buffer.
>> The construction of upload-pack-2 is a bit unfortunate as I would
>> like
>> it to not be depending on a symlink linking to upload-pack.c, but I
>> did
>> not find another easy way to do it. I would like it to generate
>> upload-pack-2.o from upload-pack.c but with '-DTRANSPORT_VERSION=2'
>> set.
>
> Couldn't we check argv[0] and use that to determine protocol?  Then we
> could symlink executables rather than source code.

IIRC I proposed a similar thing earlier, i.e.

    if (argv[0] ends with 2)
        do_protocol_v_2(...)

but that may break (and confuse a lot!) some use cases.
`git fetch` has the documented --upload-pack switch, so as a server-admin
you are free to have git-upload-pack linking to
"git-upload-pack-2.8" but additionally you still have
"git-upload-pack-1.7" or "git-upload-pack-custom-2".

so I think we should not do that :(
I do like to symlink the executables though.
