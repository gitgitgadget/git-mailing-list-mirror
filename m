From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFT PATCH 1/2] win32: optimize condition variable implementation
Date: Tue, 08 Jun 2010 18:27:08 +0200
Message-ID: <4C0E6F5C.6050809@gnu.org>
References: <1275917892-16437-1-git-send-email-bonzini@gnu.org> <1275917892-16437-2-git-send-email-bonzini@gnu.org> <4C0E6CC2.1080605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 18:27:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM1eH-0004Nk-D0
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 18:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593Ab0FHQ1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 12:27:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40202 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067Ab0FHQ1N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 12:27:13 -0400
Received: by wyf28 with SMTP id 28so205982wyf.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=9W6GY/MBXhDSffFnKdRkZMwK/BAnNFlzQCDGsfiGvAo=;
        b=oz/J4U79SXUGCkhMuw+m+T0p0D/cuzXK/I9Pq5xnNIWn3qtbY5Llzy+MQOJfepYEoc
         p4XQObtFhJtL0RUTvkCT+TCIo2so7q1P/8GojHBTbuWqBDH85w7UH+ZzHlmNrcGoVlHG
         9tN91kpMQc+zOFG2R3+xx6srZ54XKGfi7WmzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=pUjywzdctzip8LM7SoetkULpEoXDe/LFxtL8UJRBAjvBpNvpubV9R+0itGqXfO+oON
         TGXkJmpTXExDYOGfl27yd6TwBeVuD7L9zEnnYWPLivQ2atz7B2muOdBC2Jf2a6iSdoPt
         smDnRMIBZZkwR8b4XYIOkQbtr8Oj0PGf03nVI=
Received: by 10.227.138.148 with SMTP id a20mr1308907wbu.91.1276014431784;
        Tue, 08 Jun 2010 09:27:11 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id u36sm48019675wbv.6.2010.06.08.09.27.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 09:27:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <4C0E6CC2.1080605@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148685>

On 06/08/2010 06:16 PM, Johannes Sixt wrote:
> This is not correct. While it is not possible that two threads increment
> waiters at the same time due to the external mutex, it is still possible
> that on thread increments, and a different one decrements. You lost all
> provisions to avoid that.

Actually, the patch is only relying more widely on the preexisting 
assumptions of the code:

/*
  * IMPORTANT: This implementation requires that pthread_cond_signal
  * is called while the mutex is held that is used in the corresponding
  * pthread_cond_wait calls!
  */

/*
  * IMPORTANT: This implementation requires that pthread_cond_broadcast
  * is called while the mutex is held that is used in the corresponding
  * pthread_cond_wait calls!
  */

During the locked decrements, but then the external mutex is held by the 
thread executing pthread_cond_signal/pthread_cond_broadcast, so that 
section of the code is still protected against increments.

> Furthermore, waiters_lock not only protects waiters, but also the
> combined state of waiters and was_broadcast.

Concurrent pthread_cond_broadcast are protected by the external mutex, 
and was_broadcast is similarly protected against increments of waiters.

Futhermore, access to was_broadcast is serialized between 
pthread_cond_wait and pthread_cond_broadcast through the semaphore and 
the event.  was_broadcast may change from 0 to 1 while pthread_cond_wait 
is not holding the external mutex, but then pthread_cond_wait is 
sleeping on the semaphore or will go to sleep very soon.  And it can 
change from 1 to 0 only after pthread_cond_wait has signaled the event, 
which means pthread_cond_wait will be waiting to reacquire the external 
mutex.

Paolo
