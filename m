From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: problem using jgit
Date: Mon, 21 Jul 2008 14:35:46 +0200
Message-ID: <488482A2.4000601@gmail.com>
References: <p06240809c4a9d887fda4@[192.168.1.106]> <488467E3.7000107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 14:37:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKudL-0006Wc-37
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 14:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbYGUMfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 08:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYGUMfz
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 08:35:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:52133 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbYGUMfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 08:35:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so637013fgg.17
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DTPD+v/s59Hfc8XB3lBJUV6axHUjxhG63TW6YXg1aqE=;
        b=jKOgXiLfk4zFRXEhGH/8YEXYWseWA/4zKV42NQ9piuyrT5RWHK7sCkanqwPs6K19gw
         NgHRHDAvIMs5Hmvfp+yZQD5b+W+aztUxtB5l1RttbG4jwEPap9dzFLiu9cEisnkKZSDP
         s0EVWmfwFfR7N9iALoZ670LsvDAJPpUDErswk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Prrd3TVhcQyEZ4NAY0Azt2L+WkJWzxM+Z5gOOVyxS3rjX+LtmUoIxpGkC8AyOf2GSg
         2p3bLQv52QHln9jXEfYkv22lR6pXM7cQZxVT+QrQx/zZzYbJhIAx5J0cqP/cCb+pJ7cJ
         rRy+AcITkPygRv8LkEHrhy1tdWIAT+ZV9w3EE=
Received: by 10.86.27.19 with SMTP id a19mr4865126fga.56.1216643750572;
        Mon, 21 Jul 2008 05:35:50 -0700 (PDT)
Received: from ?192.168.1.167? ( [150.254.6.130])
        by mx.google.com with ESMTPS id l19sm1959645fgb.7.2008.07.21.05.35.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jul 2008 05:35:49 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <488467E3.7000107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89353>

Marek Zawirski wrote:
> Stephen Bannasch wrote:
>> I've setup a simple test class that integrates jgit to clone a git 
>> repository. However I'm getting a NullPointerError when 
>> RevWalk.parseAny ends up producing a null object id.
>>
>> The code and the stack trace for the error are here:
>>
>>   http://pastie.org/237711
>>
>> This problem occurs using the jgit from the master branch from this 
>> repo:
>>
>>   git://repo.or.cz/egit.git
> Hello Stephen,
>
> I think you've experienced error caused by the same bug as me, during 
> my latest fetch/push GUI works few days ago.
> Your code looks fine, probably  it's actually bug in jgit. I think 
> it's some regression. Thanks for reporting.
It's caused by 14a630c3: Cached modification times for symbolic refs too
Changes introduced by this patch made Repository#getAllRefs() including 
Ref objects with null ObjectId in case of unresolvable (invalid?) HEAD 
symbolic ref, and null Ref for HEAD  when it doesn't exist. Previous 
behavior was just not including such refs in result.

Fix for null Ref is just a matter of simple filtering out null Ref 
object for HEAD, if it doesn't exist (just is it considered to be legal 
state of repository when HEAD doesn't exist?).

To fix null ObjectId issue, we have to either change all clients of this 
method or revert method to previous behavior. Now it's just unspecified 
in javadoc.
Robin, Shawn, what do you think? If we want to have unresolvable refs 
included, IMO it may be sensible to provide argument includeUnresolbable 
for Repository#getAllRefs() to let clients avoid burden of filtering 
them out when they don't need them (most cases, perhaps).
I can prepare fix for it (rather easy one) as you are unavailable now, 
let me now what's your opinion.
