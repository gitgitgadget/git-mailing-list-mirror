From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 04 Nov 2009 12:14:08 +0100
Message-ID: <hcrnm0$dh6$1@ger.gmane.org>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>	 <1257331059-26344-1-git-send-email-ahaczewski@gmail.com> <40aa078e0911040250k55fa1920g6eee5657c6e35345@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 12:14:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5dp1-0005Im-Kv
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 12:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbZKDLO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 06:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbZKDLO2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 06:14:28 -0500
Received: from lo.gmane.org ([80.91.229.12]:39811 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755195AbZKDLO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 06:14:27 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N5dot-0005H1-Ga
	for git@vger.kernel.org; Wed, 04 Nov 2009 12:14:31 +0100
Received: from nat-pool-brq-t.redhat.com ([209.132.186.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 12:14:31 +0100
Received: from bonzini by nat-pool-brq-t.redhat.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 12:14:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-pool-brq-t.redhat.com
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <40aa078e0911040250k55fa1920g6eee5657c6e35345@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132078>

On 11/04/2009 11:50 AM, Erik Faye-Lund wrote:
> On Wed, Nov 4, 2009 at 11:37 AM, Andrzej K. Haczewski
> <ahaczewski@gmail.com>  wrote:
>> +/*
>> + * Properly defines thread routine for Windows and POSIX
>> + */
>> +#ifndef NO_PTHREADS
>> +# ifndef _WIN32
>> +#  define THREAD_FUNC(f, a) void *f(void *a)
>> +#  define THREAD_RETURN(x) return (x)
>> +# else
>> +#  define THREAD_FUNC(f, a) DWORD __stdcall f(LPVOID a)
>> +#  define THREAD_RETURN(x) return (DWORD)(x);
>> +# endif
>> +#endif
>> +
>
> Seeing how THREAD_RETURN is only called with NULL-parameter, perhaps
> it would be better to do this?
>
> +/*
> + * Properly defines thread routine for Windows and POSIX
> + */
> +#ifndef NO_PTHREADS
> +# ifndef _WIN32
> +#  define THREAD_FUNC(f, a) void *f(void *a)
> +#  define THREAD_RETURN() return NULL;
> +# else
> +#  define THREAD_FUNC(f, a) DWORD __stdcall f(LPVOID a)
> +#  define THREAD_RETURN() return 0;
> +# endif
> +#endif
>> +

Even better, "return 0" is good under either platform (0 converts to 
void *), and LPVOID is the same thing as void*, so you can just do

#ifndef _WIN32
# define THREAD_RET_TYPE DWORD __stdcall
#else
# define THREAD_RET_TYPE void *
#endif

Paolo
