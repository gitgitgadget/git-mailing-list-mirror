From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 07 Aug 2015 17:21:30 -0700
Message-ID: <xmqqlhdmwrxx.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
	<xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
	<xmqqpp2ywwj1.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaGe59=z4Eeuno8DRuWWRD12OyLETi7NA+utfoLsJ4+=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 02:21:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNrtQ-0004QE-RM
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 02:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946484AbbHHAVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 20:21:34 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34379 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946426AbbHHAVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 20:21:33 -0400
Received: by pawu10 with SMTP id u10so98863959paw.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 17:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=41k0lBnz+LXMqb8WlFQv/4wezwq2Pe/O8wzCL2dtxqU=;
        b=KhW9yQxq122Dda8mLQSLrUkJ3CK0qT09b8XIselEZzCsomVc7bDQ9tDtG9frYvbWvR
         +ho8dZWXWvJZ7/CC8y05iBpqdh1QnrceTXTs20vLu3PnwzikV08AfUo/eIPr2YR0CW/W
         VBx9N7dLejRLyJ/TM3/HHxSgkJEDdEeOMQke+0ZfSFLPu0z37JAffM1XskOYHbiWVRS1
         4TxntDhFmol9M/bRrNMP5Yh3SUeqPVlH9QwXJhKg1vOdb3mob0DuTVLgWPBAAlLHPo7H
         mNdsohYZEMRIcEKnfz+Em6AZ55EcExJrhc+fCvL6KDubMIvoL0vGiSE4tu0GFNZoJxbm
         guMQ==
X-Received: by 10.66.131.6 with SMTP id oi6mr20050315pab.121.1438993293039;
        Fri, 07 Aug 2015 17:21:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id y2sm11413225pdi.80.2015.08.07.17.21.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 17:21:31 -0700 (PDT)
In-Reply-To: <CAGZ79kaGe59=z4Eeuno8DRuWWRD12OyLETi7NA+utfoLsJ4+=A@mail.gmail.com>
	(Stefan Beller's message of "Fri, 7 Aug 2015 16:19:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275501>

Stefan Beller <sbeller@google.com> writes:

>> One more thing, as I didn't notice that you kept repeating "thread"
>> pool API.
>
> Yeah I intended to use both threads and processes for the heavy submodule
> operations.

OK.  I somehow had an impression that it might be more tricky than
it is worth to spawn/run_command out of a thread/run_async, but if
it makes it easier and more generic to correctly arrange the
thread-pool API to allow the per-thread functions to run_command(),
I wouldn't object to that approach at all.

Then for-each-parallel would truly become a trivial application of
that API.  Your per-thread function happens to be a one that
prepares appropriate "struct child_process" and calls run_command()
to interact with that single child, receiving its output and culling
it when it is done.

>> ... if
>> you really want to go the "thread" route, the first thing to try
>> would be to see if a few places we already use threads for
>> parallelism (namely, "grep", "pack-objects", "preload-index" and
>> "index-pack") can be factored out and model your new API around the
>> commonality among them.

And obviously, doing your pool API around threads will allow you to
throw future per-thread function that do not involve run_command()
at all at your API, and it will make it easy to adapt the current
threaded parts of the system to the API.

Perfect.

;-)
