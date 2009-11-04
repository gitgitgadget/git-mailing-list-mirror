From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 04 Nov 2009 15:34:25 +0100
Message-ID: <4AF190F1.3020607@viscovery.net>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>	 <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>	 <4AF175E8.7020400@viscovery.net> <16cee31f0911040547m69e5b9cbi30e20d2a7790bd6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 15:34:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5gwT-0001Zp-Pe
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 15:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600AbZKDOeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 09:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756592AbZKDOeX
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 09:34:23 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:51760 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756510AbZKDOeW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 09:34:22 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5gwM-00070L-Da; Wed, 04 Nov 2009 15:34:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 26000BC81; Wed,  4 Nov 2009 15:34:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <16cee31f0911040547m69e5b9cbi30e20d2a7790bd6f@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132089>

Andrzej K. Haczewski schrieb:
> 2009/11/4 Johannes Sixt <j.sixt@viscovery.net>:
>> After staring some time on the code, I have convinced myself that the
>> pthread_cond_wait and pthread_cond_signal implementation will work *in our
>> usage scenario* that has these preconditions:
> 
> But it is not impossible with that implementation.

Read again what I wrote: We are in agreement.

> On resubmit I'll give more credit to ACE.

Perhaps also a link to the source and, even better, to a discussion of the
implementation.

>> - pthread_cond_signal is called while the mutex is held.
> 
> AFAIK that is a requirement for condition variable to be signaled
> while holding the same mutex that other threads cond_wait on. I just
> don't check that it is true, because Git is locking mutex.

It is not a requirement, but, yes, we do hold the mutex.

>> - We retest the condition after pthread_cond_wait returns.
>>
>> These conditions should be attached in BIG BOLD letters to this
>> implementation; particularly, the last one.
> 
> That's also a known requirement for working with cond vars.

Indeed.

>> I think it would be OK to drop '= PTHREAD_{MUTEX,COND}_INITIALIZER' and
>> use *_init function calls without the #ifdef. Likewise for *_destroy.
> 
> Actually it won't save us many #ifdefs. There's one #ifdef for
> initialization that could be saved, but then comes #ifdef for cleanup:
> #if defined(THREADED_DELTA_SEARCH) && defined(_WIN32)
> 
> What you propose will remove one #ifdef _WIN32 for initialization, but
> the cleanup will look almost the same:
> #ifdef THREADED_DELTA_SEARCH

You are right. But #ifdef THREADED_DELTA_SEARCH is about a "generic"
property of the code and is already used elsewhere in the file, whereas
#ifdef WIN32 would be new and is is about platform differences.

Anyway, we would have to see what Junio says about the new function calls,
because he's usually quite anal when it comes to added code vs. static
initialization. ;)

-- Hannes
