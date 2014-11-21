From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] Introduce a hook to run after formatting patches
Date: Fri, 21 Nov 2014 05:31:57 +0100
Message-ID: <CAP8UFD3kaFNoPdGVFwfBVZasdUJSn=04bmWoXbmRva0aiA-kyw@mail.gmail.com>
References: <1416012460-4459-1-git-send-email-sbeller@google.com>
	<xmqqzjbryonp.fsf@gitster.dls.corp.google.com>
	<xmqqlhn9y7dn.fsf@gitster.dls.corp.google.com>
	<xmqqd28ly6p1.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3m9aouYKXfk-vE4AGbTxdyH6=k8ey5n-kF1OLux2Ah0g@mail.gmail.com>
	<20141120232628.GA30554@google.com>
	<xmqqioi91m7t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 05:32:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrft5-0007u4-Ce
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 05:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947AbaKUEb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 23:31:59 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:38238 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaKUEb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 23:31:58 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so4067161ieb.26
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 20:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=txRg3PH6u7T6sgDqbJYNxJZB41Dqq6gHCLv8hnjWWYQ=;
        b=U14YPtMT78KC+e6HZPFqCUis1UM0ZZePjP1CavHKwKA2oGzs4oUf/X6SnHZKV8JSkr
         IAaojTjvZxIt3gIEMPM90DHmGY2Ry1JTwGFVl3dxViEWNyDbbb1rpwXYjxQiZOQwPLPr
         RiLQGbkLkFVbdcw94uLbsTnvMKuCg6Ad7Aw+U3MUF1x1Jn0aAZE2tsQcOJFB4SbO6IND
         o2eMPwPbZ1WLx3qJBvWsy+k2sevoJR2DaO3TOJzOdGsFUSa1WLBauGTeq8ZdD3hV23pE
         M90Wz9EvsXzGZTgw9C+23b6hiI96RSvT4MCgZe+evwYJxH9vzsc7cvKL4HdXIMk5ADAO
         ef0A==
X-Received: by 10.50.118.35 with SMTP id kj3mr13234094igb.30.1416544317807;
 Thu, 20 Nov 2014 20:31:57 -0800 (PST)
Received: by 10.50.250.179 with HTTP; Thu, 20 Nov 2014 20:31:57 -0800 (PST)
In-Reply-To: <xmqqioi91m7t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 21, 2014 at 12:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So I have read the man page on the trailers and it seems like the solution
>> to my problem in removing parts from the commit message.
>> However I did not find out, if it can be run automatically, whenever
>> calling format-patch
>>
>> Maybe all that is missing here is an option
>>
>>       git config format.enable_trailers
>> ?

Yeah, we could use config variables or command options or both to make
it easier to enable it and pass it arguments.

For example we could add:

1) an "--interpret-trailers" option to "git commit", "git
format-patch", "git am" and maybe others too, so that "git
interpret-trailers" is called (without arguments),
2) an "--trailer <trailer>" option (that can be repeated) to the same
commands, so that "git interpret-trailers" is called with the
"--trailer <trailer>" arguments,
3) a "trailer.enable_commands =  'format-patch, commit'" config
variable, so that "git interpret-trailers" is called (without
arguments) every time one of the specified command is used,
4) your suggested "format.enable_trailers" and maybe
"commit.enable_trailers" and others like that,
5) a "trailer" command for rebase -i todo lists.

My preference would be for 1), 2), 3) and 5).

> The idea has been to first give a standalone text transmonger as a
> filter for let people to try out, so that we know what kind of
> changes are useful (e.g. "insert s-o-b at the very end") and make
> sure the configuration language to specify the changes is easy and
> expressive enough, which is more or less what we have in 'master'.
>
> Once we gain experience (and that may result in updates to what is
> in 'master'), in the second phase, we would figure out what code
> paths can make use of this text transmonger (e.g. your configuration
> variable "format.trailers" to affect the format-patch code path) and
> integrate it more tightly to the codebase.
>
> We are not there yet.

Yeah, "interpret-trailers" will be in Git 2.2 without the above
suggested features, but maybe, if we can get  some feedback from users
about which features they would use, we can aim to have some in Git
2.3.

Thanks,
Christian.
