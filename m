From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reverting a swath of commits consumes all memory and dies.
Date: Tue, 24 Apr 2012 13:02:56 -0700
Message-ID: <xmqqk414gaof.fsf@junio.mtv.corp.google.com>
References: <20120424161403.GA24738@elliptictech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nick Bowler <nbowler@elliptictech.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 22:03:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMlx6-0007ob-Ee
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 22:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371Ab2DXUDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 16:03:03 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:49269 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170Ab2DXUDA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 16:03:00 -0400
Received: by faaa25 with SMTP id a25so21166faa.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 13:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=/ppJin2NPl0+dr+Uu5WZ0Qd4H9wZgHlcqcxWoq1Y6vo=;
        b=Rt3Mfk9Ly1EjXhzOs1JlEy+4fR389/ON5GwCv83rbCnEmK5AGqWtHEhlPxZEbkQEbh
         N9V/wvH/BMXGq+KqIpL/ACwPGQnvu0E41f4TTM0RBwMq5NVxXaBt49G5GylbkXGUMdCV
         pLyKWMvXlYTceuiXDD6QxzlzOEnlIgfIhIySprdJzfsW3P0AwHrV3SYcuV6XPB4XfTo+
         5iNvJz2aEB4r9AJG6sTUnY5GRQENLBmqV/MDwygCOtJsPd1XNTcQHrSU1Oa4AlU/E3n/
         V+2HNV2TA0b/TnBZ6GChk4wOXvVvSVNBGfOlmy+1rhz3/XodB1S2AjICoFjju4MDjqB0
         ZCig==
Received: by 10.14.127.10 with SMTP id c10mr5171446eei.2.1335297779076;
        Tue, 24 Apr 2012 13:02:59 -0700 (PDT)
Received: by 10.14.127.10 with SMTP id c10mr5171395eei.2.1335297777956;
        Tue, 24 Apr 2012 13:02:57 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si18716294een.0.2012.04.24.13.02.57
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 13:02:57 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id BE4F85C0050;
	Tue, 24 Apr 2012 13:02:57 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 1A7B3E125C; Tue, 24 Apr 2012 13:02:57 -0700 (PDT)
In-Reply-To: <20120424161403.GA24738@elliptictech.com> (Nick Bowler's message
	of "Tue, 24 Apr 2012 12:14:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlthk6wwX8BSgbe2sbiGvU1qwl3sXXXTCm0AQ13CBkFV/+mrbMkMgynpV8YK5K5zxjifgj0V8cPloITz50Cs/9yQmHZ4l6eMzBF7+Cfz/tSu5f8jSmUi5cIh3h1/0bQ3fssGGUcPUyDXUTYo60G2vjbD9AsSmSbaajELnQE2EdRV2IOORM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196244>

Nick Bowler <nbowler@elliptictech.com> writes:

> I just noticed that git-revert when given a large batch of commits will
> consume more and more memory as commits are reverted.

[Cc: people who have been involved in builtin/revert.c and sequencer.c]

Unfortunate, but not surprised.

Unlike other sequencing operations like 'rebase' and 'am', multi-commit
cherry-pick/revert were implemented in such a way that it calls into the
infrastructure functions that was meant to be used in "get invoked as a
single command, do that one thing well, and let exit(2) take care of
cleaning up the resources" repeatedly from within a single process.
Probably the series that implemented multi-commit cherry-pick/revert
should have first updated the infrastructure to reduce leaks, but
probably it looked shinier to add features than doing the necessary
legwork ;-)

Perhaps you (or anybody for that matter) can help by running them under
valgrind, which would be a good first step to find and fix the leaks.

Thanks.
