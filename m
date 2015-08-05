From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] remote: add get-url subcommand
Date: Wed, 05 Aug 2015 14:39:23 -0700
Message-ID: <xmqq1tfh2z5g.fsf@gitster.dls.corp.google.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
	<1438700198-4942-1-git-send-email-mathstuf@gmail.com>
	<xmqqio8t325x.fsf@gitster.dls.corp.google.com>
	<20150805213358.GA2592@megas.kitware.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Boeckel <mathstuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:39:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN6PK-0008Ra-2X
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 23:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbbHEVj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 17:39:26 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32785 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbbHEVjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 17:39:25 -0400
Received: by pabyb7 with SMTP id yb7so13392861pab.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sStMyNQOkONB9QRMy5cdJ+VKR2cap4vTTTehYLEI7nY=;
        b=pfAyyOdbNfvLAJxsA264dt2rSjHo9QYzyqsE7T9sSALlTeIn8l2L2DXoDx5CWwTDU5
         whSkCdOXcEG+APkD3Qa6Ix6lMG1peVyVzBrFVyOsh40iaqxWMAnN4Va65mxp1Am62njt
         /K83atR+KQN3lPjFWqlnRgCenNUWbB+fcSqeq2dMEAu6XaNXbfHURMyUUgyHoRYuMTJ/
         9oGtwxidcxqaK6q6D3sRgOYFhN2JrXrRukQRRWVrNxV83fCDiOKUNIZ0R3tJb3x1EhIk
         lh+asgD+BgeXGY8Cs4FjTTJMYNKxQjG4EwA/9n69Tdl38WLSeJeuLoQg7MSBqJUdLvqy
         eFew==
X-Received: by 10.66.218.130 with SMTP id pg2mr23756025pac.53.1438810764921;
        Wed, 05 Aug 2015 14:39:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id nm8sm66972pbc.20.2015.08.05.14.39.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 14:39:24 -0700 (PDT)
In-Reply-To: <20150805213358.GA2592@megas.kitware.com> (Ben Boeckel's message
	of "Wed, 5 Aug 2015 17:33:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275403>

Ben Boeckel <mathstuf@gmail.com> writes:

> On Wed, Aug 05, 2015 at 13:34:18 -0700, Junio C Hamano wrote:
>> Changes to these two files look reasonable.
>> 
>> Don't you want to protect this feature from future breakage by
>> others by adding a couple of tests, though, to t/t5505?
>
> Thanks, I've done so locally. It actually brings up this case:
>
>     $ git remote add someremote foo
>     $ git remote get-url --push someremote
>     fatal: no URLs configured for remote 'someremote'
>
> Is it better to use:
>
>     remote = remote_get(remotename);
>     remote->pushurl;
>
>     if (remote->pushurl_nr)
>         remote->pushurl;
>     else
>         remote->url;
>
> or:
>
>     remote = pushremote_get(remotename);
>     remote->pushurl;
>
> ? What is the actual difference between the two?

You tell me ;-)

The default remote based on the current branch is computed
differently based on the direction of the transfer, I think.

        struct remote *remote_get(const char *name)
        {
                return remote_get_1(name, remote_for_branch);
        }

        struct remote *pushremote_get(const char *name)
        {
                return remote_get_1(name, pushremote_for_branch);
        }

When you are not giving name explicitly, the second parameter to _1 
function is used to determine the name.
