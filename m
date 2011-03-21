From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: PATH_MAX (Re: [PATCH] system_path: use a static buffer)
Date: Mon, 21 Mar 2011 10:47:52 +0100
Message-ID: <1300700875.2583.8.camel@bee.lab.cmartin.tk>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
	 <1300371853-8965-1-git-send-email-cmn@elego.de>
	 <AANLkTikms3Ek1CgQHg+gT8Eqs2K6PCvOB-kWZ-aqGawg@mail.gmail.com>
	 <20110318113818.GA6049@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 10:48:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1bid-0004hD-9Q
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 10:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536Ab1CUJsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 05:48:05 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:33850 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab1CUJsD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 05:48:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 9262E1B4BA9;
	Mon, 21 Mar 2011 10:48:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8g3anWusyeVY; Mon, 21 Mar 2011 10:47:55 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 861191B4B78;
	Mon, 21 Mar 2011 10:47:55 +0100 (CET)
In-Reply-To: <20110318113818.GA6049@elie>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169570>

On vie, 2011-03-18 at 06:38 -0500, Jonathan Nieder wrote:
> Hi,
> 
> Nguyen Thai Ngoc Duy wrote:
> 
> > It was pointed out elsewhere [1] that PATH_MAX only specifies max
> > length of a path element, not full path. I think we'd need to stay
> > away from preallocated PATH_MAX-sized arrays.
> 
> No, PATH_MAX is actually the maximum length of a path, and when you
> use, say, open(2), it will fail if your path is longer than that.  The
> maximum length of a path component on most filesytems is 255 or 256;
> PATH_MAX on Linux is 4096.
> 
> It is indeed possible to have paths with length longer than that.  The
> way to support that is to use relative paths wherever possible, which

 So what PATH_MAX describes is the maximum length of a string
representing a path, but not necessarily the length of the path itself.

> does sound to me like an interesting long-term goal (mostly because I
> suspect the result would be easier to read and, especially, to reason
> about with respect to race conditions).

 There is also the following effect with git

   carlos@bee:~/apps$ mkdir one
   carlos@bee:~/apps$ ln -s one two
   carlos@bee:~/apps$ ln -s two three
   carlos@bee:~/apps$ cd three
   carlos@bee:~/apps/three$ git init
   Initialized empty Git repository in /home/carlos/apps/one/.git/

 which is at best a bit annoying. Many instances of real_path (formerly
make_absolute_path) could be skipped and is_inside_dir could do the
transformation to physical path if it needs to.

 There may be a few edge cases, but most of the transformation should be
fairly straightforward (he says as he steps off the cliff...)

   cmn
