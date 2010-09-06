From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Mon, 6 Sep 2010 07:56:06 -0700
Message-ID: <20100906145606.GM32601@spearce.org>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi> <AANLkTikGiekZGNffaraHK-waBt7wH84jujM_uh3cw46y@mail.gmail.com> <AANLkTinTFWHWU1vCnDa-c3p5g+y7wnH9A8fieowQHU5z@mail.gmail.com> <201009061049.38546.jnareb@gmail.com> <EC704F6E-3075-459C-9210-10C234523D80@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 16:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osd7I-00088F-S3
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 16:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab0IFO4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 10:56:11 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60284 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab0IFO4J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 10:56:09 -0400
Received: by pvg2 with SMTP id 2so1454790pvg.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 07:56:08 -0700 (PDT)
Received: by 10.114.36.1 with SMTP id j1mr598448waj.141.1283784968698;
        Mon, 06 Sep 2010 07:56:08 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id d39sm11391586wam.16.2010.09.06.07.56.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 07:56:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <EC704F6E-3075-459C-9210-10C234523D80@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155573>

Joshua Juran <jjuran@gmail.com> wrote:
> On Sep 6, 2010, at 1:49 AM, Jakub Narebski wrote:
>>
>> From what I remember from smart HTTP discussion (during fleshing-out
>> the protocol/exchange details), the fact that errors from git are send
>> with "200 OK" HTTP status are very much conscious decision.  But I  
>> don't
>> remember *why* it was chosen this way.  If I remember correctly it was
>> something about transparent proxies and caches...  Is it documented
>> anywhere?  Can anyone explain it?
>
> I wasn't involved in the decision process, but I suspect it's because  
> HTTP is the transport layer to the Git application.  It's the same logic 
> as trying to log in to a Web application with bogus credentials and 
> getting back a page (HTTP 200 OK) stating that the login failed.  As far 
> as HTTP is concerned, the transaction succeeded.

Exactly correct.

FWIW, I meant for the standard git:// ERR type error to be used
here under smart-HTTP.  I'm not sure why we need Ilari's original
patch at all.

That is, the following will trigger a correct error on the client:

  200 OK
  Content-Type: application/x-git-upload-pack-advertisement

  001e# service=git-upload-pack
  0022ERR You shall not do this

Likewise if you wanted to do this with receive-pack, replace upload
with receive above and adjust the pkt-line lengths.

The initial # service= packet is as much part of the "transport
layer" as the HTTP 200 OK response is.  Its the server saying "Yup,
I understood your request correctly.  Now here is your error."

Translation is, gitolite (or GitHub, or ...) should be sending back
two pkt-lines under smart HTTP, not one.

-- 
Shawn.
