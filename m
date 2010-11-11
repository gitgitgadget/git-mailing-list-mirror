From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 12:48:29 -0600
Message-ID: <20101111184829.GG16972@burratino>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
 <20101111103742.GA16422@burratino>
 <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
 <20101111173253.GC16972@burratino>
 <alpine.LNX.2.00.1011111241360.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Carl Worth <cworth@cworth.org>, Jeff King <peff@peff.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Nov 11 19:49:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGcCn-0001tG-Oo
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 19:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab0KKSsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 13:48:55 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36486 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925Ab0KKSsy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 13:48:54 -0500
Received: by ywc21 with SMTP id 21so147875ywc.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 10:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Vs0UrW+zz+RQxe1Pjf6NcRSeBDW/7wE+uixzvp5ivvo=;
        b=NmxfSK7uzqVW2O4EXHIzdo5/3KD2Dpue88ojHzrvLz/PnBr3YKV2bPO2Ne3Hrb3gxn
         uJdsIIX/WUiNPoA8SbvbOPekJssgVN7Adb3HCShY1EDO6tPKOZwdeW2TrFNbn7WzdO6u
         TPU1MlM1y263np1Jdh0j3twkC61IcPyZdffBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KHvpvcFQoK4qdGwfsTFjRdijbg6ms7z3/YbA2e42XO9OJRr1cbMq0JicH+FNS+YlJB
         zfAGynf4JYSAtWp0tqFthR6uuLi9yYQX07KfWSwGgeGpeqqlG1WvEAzdPeap3OW1CSve
         QTNrdmy2MYIQeBLPc20DTUC3LujhkkAfCP6no=
Received: by 10.223.101.196 with SMTP id d4mr517436fao.23.1289501333617;
        Thu, 11 Nov 2010 10:48:53 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id k21sm1084186faa.25.2010.11.11.10.48.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 10:48:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1011111241360.14365@iabervon.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161289>

On Thu, Nov 11, 2010 at 12:55:48PM -0500, Daniel Barkalow wrote:
> On Thu, 11 Nov 2010, Jonathan Nieder wrote:

>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -667,6 +667,5 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>  	strbuf_release(&branch_top);
>>  	strbuf_release(&key);
>>  	strbuf_release(&value);
>> -	junk_pid = 0;
>>  	return err;
>>  }
>
> I believe that would cause it to remove the repository when it terminates, 
> regardless of whether it completed or not.

Ah, right, the second remove_junk() call is because of atexit().

So why does git clone keep running after the first remove_junk() call?
It seems that the signal is initially set up (by Python's popen()?) as
SIG_IGN.  I guess "git clone" should explicitly override that to be
SIG_DFL?

Here's a proof of concept.  It is not very good because it overrides
any previously set sigchain handlers (in case the "git" wrappers
start to use one) and because using SIG_DFL as a sigchain_fun feels
like violating an abstraction.

diff --git a/builtin/clone.c b/builtin/clone.c
index 19ed640..2f21a91 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -458,6 +458,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 	junk_git_dir = git_dir;
 	atexit(remove_junk);
+	sigchain_push_common(SIG_DFL);
 	sigchain_push_common(remove_junk_on_signal);
 
 	setenv(CONFIG_ENVIRONMENT, mkpath("%s/config", git_dir), 1);
