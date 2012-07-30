From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Mon, 30 Jul 2012 03:29:52 -0500
Message-ID: <20120730082951.GA7702@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1609414.ugUML9Yn73@flomedio>
 <20120728070030.GC4739@burratino>
 <3225988.4e4jhmQGr7@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 10:30:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvlMe-00026F-Iw
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 10:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087Ab2G3IaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 04:30:01 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47906 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab2G3IaA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 04:30:00 -0400
Received: by yenl2 with SMTP id l2so4519427yen.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TBEi97jrgCHaE+PSgsL68aZP/T4ZR97ewcbiEI5+l/I=;
        b=qd08fHe5Zk0ESg4ac23hJBkKcwueWBAWZR/Y+Qmbs1f9iDXdNYOAJbTx1t2kGcyrui
         YJnYl1ft/Y3e+MsjFsj+G6tBIbfSQfayAhONBsIqD2QmmWOZrl+GYz+O/d0bIa4HKayu
         BMN+ZnKhqeHuLk7H5YuE+n56aS9u4llcaL2+VYUMnkMivWO2ZSooP8CtZT9zJgsKROiD
         vGH/CVM+DIN+1Re8V8+yyF5Umgd0KSDA64qzNyTV4T8k6+cvEwWjQYQeNRYoG8vyWdhr
         Xv7PEyswBEVJ/n5H3I8LvTh5TGT2SG2f31rkdJS+xOEBCIb5axorITLvCdzR4HmkUaua
         5VDw==
Received: by 10.50.217.137 with SMTP id oy9mr7714726igc.56.1343636999385;
        Mon, 30 Jul 2012 01:29:59 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id s4sm6021669igb.1.2012.07.30.01.29.58
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 01:29:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3225988.4e4jhmQGr7@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202528>

Florian Achleitner wrote:
> On Saturday 28 July 2012 02:00:31 Jonathan Nieder wrote:

>> a. use --cat-blob-fd, no FIFO
[...]
>>    * Make it conditional --- only do it (1) we are not on Windows and
>>      (2) the remote helper requests backflow by advertising the
>>      import-bidi capability.
>>
>>    * Let the remote helper know what's going on by using
>>      "import-bidi" instead of "import" in the command stream to
>>      initiate the import.
>
> Generally I like your prefered solution.
> I think there's one problem:
> The pipe needs to be created before the fork, so that the fd can be inherited. 

The relevant pipe already exists at that point: the remote helper's
stdin.

In other words, it could work like this (just like the existing demo
code, except adding a conditional based on the "capabilities"
response):

	0. transport-helper.c invokes the remote helper.  This requires
	   a pipe used to send commands to the remote helper
	   (helper->in) and a pipe used to receive responses from the
	   remote helper (helper->out)

	1. transport-helper.c sends the "capabilities" command to decide
	   what to do.  The remote helper replies that it would like
	   some feedback from fast-import.

	2. transport-helper.c forks and execs git fast-import with input
	   redirected from helper->out and the cat-blob fd redirected
	   to helper->in

	3. transport-helper.c tells the remote helper to start the
	   import

	4. wait for fast-import to exit
