From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFT PATCH 2/2] win32: optimize pthread_cond_broadcast
Date: Tue, 08 Jun 2010 18:30:13 +0200
Message-ID: <4C0E7015.8030504@viscovery.net>
References: <1275917892-16437-1-git-send-email-bonzini@gnu.org> <1275917892-16437-3-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 18:30:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM1h0-0006Al-IL
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 18:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391Ab0FHQaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 12:30:15 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:20372 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755187Ab0FHQaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 12:30:14 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 762482C4020;
	Tue,  8 Jun 2010 18:30:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <1275917892-16437-3-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148687>

Am 07.06.2010 15:38, schrieb Paolo Bonzini:
> @@ -172,9 +172,10 @@ int pthread_cond_broadcast(pthread_cond_t *cond)
>   	 * As in pthread_cond_signal, access to cond->waiters and
>   	 * cond->was_broadcast is locked via the external mutex.
>   	 */
> -
> -	if ((cond->was_broadcast = cond->waiters>  0)) {
> +	if (cond->waiters>  0) {
>   		BOOLEAN result;
> +		cond->was_broadcast = cond->waiters>  1;
> +

It is possible that you set was_broadcast to 1 here, while another thread 
still sees was_broadcast == 0 in cond_wait. As a consequence, this thread 
WaitsForSingleObject(), which will never arrive because the other thread 
does not call SetEvent(). But this is more a problem of your first patch, 
not of this one, so you better fix the first one first before you go 
further into this one.

That said, as long as this series buys performance only at the expense of 
clarity, I'm rather opposed to it because we do not call cond_wait and 
cond_broadcast in time-critical paths.

-- Hannes
